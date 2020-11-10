`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
fc_buffer_writer_with_pooling 
1. 状态机控制两行输入完成，并启动pooling，最终写入fc data buffer
2. 连接 ram_wr 连线
3. 进行pooling取值，计算，赋值
4. 实例化 row_buffer_writer基本单元。

*/
//////////////////////////////////////////////////////////////////////////////////
module fc_buffer_writer_with_pooling#(
	parameter AF=3,
  parameter BATCH=9,
  
	parameter DATA_WIDTH=8,
	parameter REAL_HINT=14,       // 被 ctrl 连接时注意 大小
	parameter REAL_HOUT=7,	  
	parameter K=3,
	parameter S=1,
	
	//last conv configuration
	parameter LAST_N=512,
	parameter LAST_Wh=6,
	parameter LAST_Ww=17,
	parameter LAST_Ih=17,
	parameter LAST_Iw=1,
	parameter LAST_Bi=4,
	
	//next conv interface configuration 
	
	parameter HINT=ceil(REAL_HINT,LAST_Iw),
	parameter BUffER_RAM_COUNT=HINT/LAST_Iw,
	//parameter BUffER_RAM_COUNT_POOLING=int'($ceil(real'(REAL_HOUT)/LAST_Iw)), // pooling let hout reshape with LAST_Iw, for row_buffer_ctrl use hint(=hout) and last config in code
	parameter ADDR_WIDTH=32,
	parameter RCC_WIDTH=10+10+10,   // row , col , channel 
  parameter ROW_WIDTH=10

)
(
  input  logic clk,
  input  logic rstn,
  // row buffer ram  write
  output logic  [AF-1:0]RAM_writer_byte_en[BATCH], // ceil(hout /IW)
  output logic  [ADDR_WIDTH-1:0] RAM_writer_wr_ADDR[BATCH],
  output logic  [AF-1:0][DATA_WIDTH-1:0] RAM_writer_wr_data[BATCH],
  
  output logic buffer_writer_done,
  input  logic buffer_writer_en,
  // pe_out connect 
  output logic [LAST_Wh-1:0]pe2row_fifo_array1_rden, 
  output logic pe2row_ready,                                    
  input  logic [LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0]fifo_array1_dataout,             
  input  logic pe2row_data_valid,
  //pooling ram read
  output logic [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] pooling_rd_addr[2] ,                  
  input  logic [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] pooling_rd_data[2] , 
                                                                                 
  //pooling ram write                                                            
  output logic [BUffER_RAM_COUNT-1:0]pooling_wren[2] ,                                      
  output logic [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] pooling_wr_addr[2] ,                  
  output logic [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] pooling_wr_data[2]    
    
);

  localparam NEXT_C_AF=ceil(LAST_N,AF);
  logic  [BUffER_RAM_COUNT-1:0]writer_ram_wren ; // ceil(hout /IW)                
  logic  [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] writer_ram_wr_addr ;              
  logic  [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] writer_ram_wr_data ; 
                                                                                    
  logic writer_done ;                                                         
  logic writer_en ;                                                           

//  
  logic ram_select;
  

  
  logic [HINT-1:0][DATA_WIDTH-1:0] pooling_data[AF][2];
  logic [AF-1:0][REAL_HOUT-1:0][DATA_WIDTH-1:0] pooling_data_out;
  logic [REAL_HOUT-1:0][AF-1:0][DATA_WIDTH-1:0] pooling_data_out_r;  
  
  localparam STATE1=4'd1,
	          STATE2=4'd2,
	          STATE3=4'd3,
	          STATE4=4'd4,
	          STATE5=4'd5,
	          STATE6=4'd6,
	          STATE7=4'd7,
	          STATE8=4'd8,
	          
	          STATE9=4'd9,
	          STATE10=4'd10;  
   
  logic [3:0] current_state,next_state;
  logic[9:0] pooling_ram_rd_counter;
  integer i,j,k;
  
  logic wren_temp;
  logic wren;
 (* max_fanout = "5" *) logic [log2(NEXT_C_AF/AF*REAL_HOUT*REAL_HOUT):0]wr_addr;
 (* max_fanout = "5" *) logic [log2(REAL_HOUT):0]wr_addr_REAL_HOUT;
  logic buffer_writer_en_t;
  logic writer_done_t;
  integer batch_count;
  
   always_ff@(posedge clk or negedge rstn)
	begin 
		if(rstn==0)
			current_state<=STATE1;
		else 
			current_state<=next_state;          
	end 
	
	always_comb
	begin 
		if(rstn==0)
			next_state=STATE1;
		else 
			case(current_state)
				  STATE1:begin 
				  		next_state=STATE2;
					end
					STATE2:begin 	//等待启动						
							if(buffer_writer_en_t==1)
								next_state=STATE3;   
							else 
							  next_state=STATE2;
					end
					STATE3:begin //等待writer 写入第一行
						  if(writer_done_t==1)
						  	next_state=STATE4;
						  else
						  	next_state=STATE3;
					end

					STATE4:begin  //等待writer 写入第二行
						  if(writer_done==1)
						  	next_state=STATE5;
						  else 
						  	next_state=STATE4;
					end
					STATE5:begin  // 从pooling buffer中读入 AF行 做pooling计算
							 if(pooling_ram_rd_counter%AF==0) 
							 	next_state=STATE6;
							 else 
							 	next_state=STATE5;
					end
//					STATE6:begin // 对fc buffer写入 real_hout 行数据（每行af个） 
//								if(wr_addr%REAL_HOUT==REAL_HOUT-1 && (wr_addr+1)%(NEXT_C_AF/AF*REAL_HOUT)!=0)
//									next_state=STATE5; // 写入完成，继续读数据（同一行）
//								else if((wr_addr+1)%(NEXT_C_AF/AF*REAL_HOUT)==0 && wr_addr+1 ==NEXT_C_AF/AF*REAL_HOUT*REAL_HOUT)
//									next_state=STATE8; // 成功写入 1/batch 的数据
//								else if ((wr_addr+1)%(NEXT_C_AF/AF*REAL_HOUT)==0 && wr_addr+1 <NEXT_C_AF/AF*REAL_HOUT*REAL_HOUT)
//									next_state=STATE7;// 成功写入 1 行的所有数据，再次启动writer
//							 else                 
//							 		next_state=STATE6; // 写入中

          STATE6: begin 
          		if(wr_addr%REAL_HOUT==REAL_HOUT-1)
          			next_state=STATE9;
          		else 
          			next_state=STATE6;
						 
					end
					
					STATE9:begin 
					if((wr_addr)%(NEXT_C_AF/AF*REAL_HOUT)!=0)
						next_state=STATE5;
					else 
						next_state=STATE10;
					end 
					
					STATE10:begin 
						if(wr_addr <NEXT_C_AF/AF*REAL_HOUT*REAL_HOUT)
							next_state=STATE7;
						else 
							next_state=STATE8;
					end 
					
					STATE7:begin 
						    next_state=STATE3; // 等待写入完成
					
							 
					end
					
					STATE8:begin
						    if(batch_count==BATCH-1) //写入了batch组数据 完成 fc_switch数据
								  next_state=STATE2;
								else                  
									next_state=STATE7;  //写入 1/batch数据，启动writer，初始化 wr_addr
					end 
					
					 
					default: next_state=STATE1;
			endcase
	end 
 logic[1:0]	pooling_data_switch;
	always_ff@(posedge clk or negedge rstn)
	begin 
		if(rstn==0)
			begin 
				writer_done_t<=0;
		end 
	  else
	  	case(current_state)
	  		  STATE1:begin 
	  		  	buffer_writer_done<=0;
	  		  	ram_select<=0;
	  		  	writer_en<=0;
	  		  	pooling_ram_rd_counter<=0;
	  		  	wren_temp<=0;
	  		  	wr_addr<=0;
	  		  	wr_addr_REAL_HOUT<=0;
	  		  	batch_count<=0;
	  		  	
	  		  	foreach(pooling_data[i,j])
	  		  		pooling_data[i][j]<='0;
				  		 				  		 
					end
					STATE2:begin  
						ram_select<=0;
						if(buffer_writer_en==1)
							begin 
								writer_en<=1;
								buffer_writer_done<=0;
								ram_select<=0;
								buffer_writer_en_t<=1;
								wr_addr<=0;
								wr_addr_REAL_HOUT<=0;
								batch_count<=0;  
								pooling_ram_rd_counter<=0;
							end 
						
					end
					STATE3:begin  
						writer_en<=0;
						buffer_writer_en_t<=0;
						pooling_ram_rd_counter<=0;
						if(writer_done==1)
							begin 
								writer_en<=1;
								ram_select<=1; 
								writer_done_t<=1; //延迟多一个周期再下一状态
								
							end 
					
						
					end				
				
					STATE4:begin 
						writer_en<=0;
						writer_done_t<=0;
						pooling_ram_rd_counter<=0;
						if(writer_done==1)
							begin 
								ram_select<=0; 
								pooling_ram_rd_counter<=1;
								pooling_data_switch<=(pooling_ram_rd_counter)%AF;// 0
							end 						
					end
					STATE5:begin   
						 // ram read data 
						 	pooling_ram_rd_counter<=pooling_ram_rd_counter+1;
						 	pooling_data_switch<=(pooling_ram_rd_counter)%AF;//1 // *********timing optimized
						 	pooling_data[pooling_data_switch]<=pooling_rd_data;
						 	if(pooling_ram_rd_counter%AF==0)
						 	begin 
					      pooling_ram_rd_counter<=pooling_ram_rd_counter;
					      wren_temp<=1;
					    end 
					end
//					STATE6:begin  
//						  wr_addr<=wr_addr+1;
//						  
//						  if(next_state==STATE6)
//						  	wren_temp<=1;
//						  else 
//						    begin 
//						  	wren_temp<=0;
//						  	pooling_ram_rd_counter<=pooling_ram_rd_counter+1;
//						    end 
//						  
//						  if ((wr_addr+1)%(NEXT_C_AF/AF*REAL_HOUT)==0 && wr_addr+1 <NEXT_C_AF/AF*REAL_HOUT*REAL_HOUT)
//						  	writer_en<=1;
//					   end
		// timing optimized***************			
							STATE6:begin  
						  wr_addr<=wr_addr+1;
						  wr_addr_REAL_HOUT<=(wr_addr+1)%REAL_HOUT;
						  if(wr_addr%REAL_HOUT!=REAL_HOUT-1)
						  	wren_temp<=1;
						  else 
						    begin 
						  	wren_temp<=0;
						  	
						    end 
					    end 
					    
					    STATE9:begin 
					    	pooling_ram_rd_counter<=pooling_ram_rd_counter+1;//*************
					    end 
					    
					    STATE10:begin 
					    	if(wr_addr <NEXT_C_AF/AF*REAL_HOUT*REAL_HOUT)
					    	writer_en<=1;
					  end 
					
			//****************************		
					
					STATE7:begin  					
						  writer_en<=0;   
						  pooling_ram_rd_counter<=0;
						  
					end
					
					STATE8:begin 
					   
					   if(batch_count==BATCH-1)
					     begin 
					     	buffer_writer_done<=1;
					   	  batch_count<=0;
					   	 end 
					   else 
					   	 begin 
					   	 	batch_count<=batch_count+1;
					   	  writer_en<=1;
					   	  wr_addr<=0;
					   	  wr_addr_REAL_HOUT<=0;
					   	 end 
					   	
				  end 
					
					
					default:   begin                  
                    
                     end 
      endcase
  end 
  
  
  
/*************************************************************************/
 //pooling with buffer_ram wr_interface  
  always_comb  //选通data buffer 写入总线（基于几个batch）
  begin 
   foreach(RAM_writer_byte_en[i])
   	if(i==batch_count)
   	begin 
   		RAM_writer_byte_en[i]={AF{wren_temp}};   
      RAM_writer_wr_ADDR[i]={'0,wr_addr};
    end 
    else 
    	begin 
   		RAM_writer_byte_en[i]='0;   
      RAM_writer_wr_ADDR[i]='0;
    end 
  end 
   
  genvar m,n;
 
 // pooling 计算，并赋值到 fc data buffer 的写入总线上 
  generate  // row buffer writer  wr data 
  	for(n=0;n<AF;n=n+1)
  	for(m=0;m<REAL_HOUT;m=m+1)
  		begin :max_pooling 
  			
  			logic [DATA_WIDTH-1:0] temp1,temp2,temp3;
  			always_comb
  			begin 
  			 if($signed(pooling_data[n][0][m*2])>$signed(pooling_data[n][0][m*2+1]))
  			 	temp1=pooling_data[n][0][m*2];
  			 else 
  			  temp1=pooling_data[n][0][m*2+1];
  			  
  			 if($signed(pooling_data[n][1][m*2])>$signed(pooling_data[n][1][m*2+1]))
  			 	temp2=pooling_data[n][1][m*2];
  			 else 
  			  temp2=pooling_data[n][1][m*2+1];
  			  
  			 if($signed(temp1)>$signed(temp2))
  			 	temp3=temp1;
  			 else 
  			  temp3=temp2;
  			end 
  			
  			always_ff@(posedge clk or negedge rstn)
  			begin 
  				if(rstn==0)
  					pooling_data_out[n][m]<=0;
  				else 
    				pooling_data_out[n][m]<=temp3;
    		end 
    		
  			     			
  		end 	
  endgenerate
  
  always_comb // row buffer writer  wr data
  begin 
  			pooling_data_out_r=pooling_data_out;
  			foreach(RAM_writer_wr_data[i])
  			if(i==batch_count)
  				 RAM_writer_wr_data[i]=pooling_data_out_r[wr_addr_REAL_HOUT];
  			else 
  			   RAM_writer_wr_data[i]=0;
  end
  //pooling with buffer_ram wr_interface 
 /*************************************************************************/
   
  
   
 /*************************************************************************/
 //writer with ram interface 
 //原始的最底层的writer 连接conv输出，写入数据到pooling 缓存的临时存储单元中。
 //若是不带pooling功能的时候，这个writer是会直接写入到最终的data buffer 中
  always_comb  // pooling ram read addr 
  begin 
  	foreach(pooling_rd_addr[i,j])
  	pooling_rd_addr[i][j]={'0,pooling_ram_rd_counter};
  end
  
  always_comb // writer with pooling ram 
  begin 
  	foreach(pooling_wren[i,j])
  		pooling_wren[i][j]=0;
  	foreach(pooling_wr_addr[i,j])
  	  pooling_wr_addr[i][j]=0;
  	foreach(pooling_wr_data[i,j,k])
  	 pooling_wr_data[i][j][k]=0;
  	
  	if(ram_select==0)
  		begin 
  			pooling_wren[0]=writer_ram_wren; //原始的最底层的writer 连接conv输出，写入数据到pooling 缓存的临时存储单元中。
  			pooling_wr_addr[0]=writer_ram_wr_addr;
  			pooling_wr_data[0]=writer_ram_wr_data;
  		end 
  	else 
  		begin 
  			pooling_wren[1]=writer_ram_wren;
  			pooling_wr_addr[1]=writer_ram_wr_addr;
  			pooling_wr_data[1]=writer_ram_wr_data;
      end 
  end 
//writer with ram interface 
/******************************************************/  		  
  		  
  row_buffer_writer#( 
    .DATA_WIDTH       ( DATA_WIDTH       ),
    .REAL_HINT        ( REAL_HINT        ),
    .REAL_HOUT        ( REAL_HOUT        ),
    .K                ( K                ),
    .S                ( S                ),
    .LAST_N           ( LAST_N           ),
    .LAST_Wh          ( LAST_Wh          ),
    .LAST_Ww          ( LAST_Ww          ),
    .LAST_Ih          ( LAST_Ih          ),
    .LAST_Iw          ( LAST_Iw          ),
    .LAST_Bi          ( LAST_Bi          ),
    .ADDR_WIDTH       ( ADDR_WIDTH       ))
    writer_in_pooling
  (
  	.clk(clk),                                                                        
  	.rstn(rstn),                                                                       
  	                                                                             
  	 .buffer_writer_ram_wren(writer_ram_wren), // ceil(hout /IW)                
  	 .buffer_writer_ram_wr_addr(writer_ram_wr_addr),     //原始的最底层的writer 连接conv输出，写入数据到pooling 缓存的临时存储单元中。          
  	 .buffer_writer_ram_wr_data(writer_ram_wr_data), 
  	                                                                             
     .buffer_writer_done(writer_done),                                                         
     .buffer_writer_en(writer_en),                                                           
                                                                                 
     .pe2row_fifo_array1_rden(pe2row_fifo_array1_rden),                                       
     .pe2row_ready(pe2row_ready),                                                               
     .fifo_array1_dataout(fifo_array1_dataout),                  
     .pe2row_data_valid(pe2row_data_valid)                                                           
  );  

	  function integer log2(input integer x);
        integer i;
        begin
            log2 = 1;
            for (i = 0; 2**i < x; i = i + 1)
            begin
                log2 = i + 1;
            end
        end
    endfunction
 function integer ceil(input integer x,input integer y);
        integer i;
        begin
            i=x/y;
            if(i*y<x)
            	ceil=(i+1)*y;
            else 
            	ceil=i*y;
        end
    endfunction    
    
	
  
endmodule  