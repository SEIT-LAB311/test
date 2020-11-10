module row_buffer_writer_with_pooling#(
	
	parameter DATA_WIDTH=8,
	parameter REAL_HINT=56,       // 被 ctrl 连接时注意 大小
	parameter REAL_HOUT=28,	  
	
	parameter K=3,
	parameter S=1,
	
	//last conv configuration
	parameter LAST_PK=2,
	parameter LAST_C=256,
	parameter LAST_N=256,
	parameter LAST_Wh=2,
	parameter LAST_Ww=29,
	parameter LAST_Ih=29,
	parameter LAST_Iw=7,
	parameter LAST_Bi=4,
	parameter LAST_CKK=LAST_C*K*K,
	
	//next conv interface configuration 
      
	parameter NEXT_PK=2,     
	parameter NEXT_C=256,    
	parameter NEXT_N=256,         
	parameter NEXT_Wh=2,     
	parameter NEXT_Ww=29,    
	parameter NEXT_Ih=29,    
	parameter NEXT_Iw=7,     
	parameter NEXT_Bi=4,     
	parameter NEXT_CKK=NEXT_C*K*K,
	
	
	parameter HOUT=ceil(REAL_HOUT,NEXT_Iw),  // hout is not divisible , need adding 0  // must use real'  ,or that int'/int'=int', ceil is useless
	parameter HINT=ceil(REAL_HINT,LAST_Iw),
	parameter BUffER_RAM_COUNT=HINT/LAST_Iw,
	parameter BUffER_RAM_COUNT_POOLING=ceil(REAL_HOUT,LAST_Iw)/LAST_Iw, // pooling let hout reshape with LAST_Iw, for row_buffer_ctrl use hint(=hout) and last config in code
	parameter ADDR_WIDTH=32,
	parameter RCC_WIDTH=10+10+10,   // row , col , channel 
  parameter ROW_WIDTH=10

)
(
  input  logic clk,
  input  logic rstn,
  // row buffer ram  write
  output logic  [BUffER_RAM_COUNT_POOLING-1:0]buffer_writer_ram_wren, // ceil(hout /IW)
  output logic  [BUffER_RAM_COUNT_POOLING-1:0][ADDR_WIDTH-1:0] buffer_writer_ram_wr_addr,
  output logic  [BUffER_RAM_COUNT_POOLING-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] buffer_writer_ram_wr_data,
  
  output logic buffer_writer_done,
  input  logic buffer_writer_en,
  // pe_out connect 
  output logic [LAST_Wh-1:0]pe2row_fifo_array1_rden, 
  output logic pe2row_ready,                                    
  input  logic [LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0]fifo_array1_dataout,             
  input  logic pe2row_data_valid
 
  
  
);

  
  logic  [BUffER_RAM_COUNT-1:0]writer_ram_wren ; // ceil(hout /IW)                
  logic  [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] writer_ram_wr_addr ;              
  logic  [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] writer_ram_wr_data ; 
                                                                                    
  logic writer_done ;                                                         
  logic writer_en ;                                                           
 //pooling ram read
   logic [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] pooling_rd_addr[2] ;                  
    logic [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] pooling_rd_data[2] ; 
                                                                                 
  //pooling ram write                                                            
   logic [BUffER_RAM_COUNT-1:0]pooling_wren[2] ;                                      
   logic [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] pooling_wr_addr[2] ;                  
   logic [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] pooling_wr_data[2] ;  
  
  logic ram_select;
  
 // RAM0 (.*);
 // RAM1 (.*);
  
  logic [HINT-1:0][DATA_WIDTH-1:0] pooling_data[2];
  logic [REAL_HOUT-1:0][DATA_WIDTH-1:0] pooling_data_out;
  
   localparam STATE1=4'd1,
	          STATE2=4'd2,
	          STATE3=4'd3,
	          STATE4=4'd4,
	          STATE5=4'd5,
	          STATE6=4'd6,
	          STATE7=4'd7,
	          STATE8=4'd8;    
   
 (* MAX_FANOUT = 30 *) logic [3:0] current_state,next_state;
  logic [log2(LAST_N):0] counter;
  integer i,j,k;
  
  logic wren_temp;
  logic wren;
  logic [log2(LAST_N):0]wr_addr;
  logic buffer_writer_en_t;
  logic writer_done_t;
  
  
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
					STATE2:begin 							
							if(buffer_writer_en_t==1)
								next_state=STATE3;   
							else 
							  next_state=STATE2;
					end
					STATE3:begin 
						  if(writer_done_t==1)
						  	next_state=STATE4;
						  else
						  	next_state=STATE3;
					end

					STATE4:begin 
						  if(writer_done==1)
						  	next_state=STATE5;
						  else 
						  	next_state=STATE4;
					end
					STATE5:begin 
							 if(counter==LAST_N) 
							 	next_state=STATE6;
							 else 
							 	next_state=STATE5;
					end
					STATE6:begin 
								next_state=STATE7;
						 
					end
					STATE7:begin 
						    next_state=STATE2;
							 
					end
					
					 
					default: next_state=STATE1;
			endcase
	end 
	
	always_ff@(posedge clk or negedge rstn)
	begin 
		if(rstn==0)
			begin
					buffer_writer_done<=0;
	  		  	ram_select<=0;
	  		  	writer_en<=0;
	  		  	counter<=0;
	  		  	wren_temp<=0;
	  		  	foreach(pooling_data[i])
	  		  		pooling_data[i]<='0; 
		end 
	  else
	  	case(current_state)
	  		  STATE1:begin 
	  		  	buffer_writer_done<=0;
	  		  	ram_select<=0;
	  		  	writer_en<=0;
	  		  	counter<=0;
	  		  	wren_temp<=0;
	  		  	foreach(pooling_data[i])
	  		  		pooling_data[i]<='0;
				  		 				  		 
					end
					STATE2:begin  
						ram_select<=0;
						if(buffer_writer_en==1)
							begin 
								writer_en<=1;
								buffer_writer_done<=0;
								ram_select<=0;
								buffer_writer_en_t<=1;
							end 
						
					end
					STATE3:begin  
						writer_en<=0;
						buffer_writer_en_t<=0;
						if(writer_done==1)
							begin 
								writer_en<=1;
								ram_select<=1;
								writer_done_t<=1;
								
							end 
					
						
					end
					

					
					STATE4:begin 
						writer_en<=0;
						writer_done_t<=0;
						if(writer_done==1)
							begin 
								counter<=1;
							end 						
					end
					STATE5:begin   
						 // ram read data 
						 	
						 		pooling_data<=pooling_rd_data;
					    counter<=counter+1;
					    wren_temp<=1;
					    if(counter==LAST_N)  // 后面默认补0 数据不要了
					    	counter<=0;
					end
					STATE6:begin  
						  wren_temp<=0;
					end
					STATE7:begin  					
						  buffer_writer_done<=1;
					end
					
					
					default:   begin                  
                    	buffer_writer_done<=0;
	  		  	ram_select<=0;
	  		  	writer_en<=0;
	  		  	counter<=0;
	  		  	wren_temp<=0;
	  		  	foreach(pooling_data[i])
	  		  		pooling_data[i]<='0;
                     end 
      endcase
  end 
  
  
  
  always_ff@(posedge clk or negedge rstn )  // row buffer  writer addr / wren 
  begin 
  	if(rstn==0)
  		begin 
  			wr_addr<=0;
  			wren<=0;
  	end 
  	else 
  		begin 
  			if(wren==1)
  				wr_addr<=wr_addr+1;
  			else 
  				wr_addr<=0;
  		 
  		  wren<=wren_temp;
  		end 
  end 
  
  always_comb
  begin 
   foreach(buffer_writer_ram_wren[i])
   		buffer_writer_ram_wren[i]=wren;
   foreach(buffer_writer_ram_wr_addr[i])
      buffer_writer_ram_wr_addr[i]={'0,wr_addr};
  end 
  
  
  
  genvar m,n;
  generate  // row buffer writer  wr data 
  	for(m=0;m<REAL_HOUT;m=m+1)
  		begin :max_pooling 
  			
  			logic [DATA_WIDTH-1:0] temp1,temp2,temp3;
  			always_comb
  			begin 
  			 if($signed(pooling_data[0][m*2])>$signed(pooling_data[0][m*2+1]))
  			 	temp1=pooling_data[0][m*2];
  			 else 
  			  temp1=pooling_data[0][m*2+1];
  			  
  			 if($signed(pooling_data[1][m*2])>$signed(pooling_data[1][m*2+1]))
  			 	temp2=pooling_data[1][m*2];
  			 else 
  			  temp2=pooling_data[1][m*2+1];
  			  
  			 if($signed(temp1)>$signed(temp2))
  			 	temp3=temp1;
  			 else 
  			  temp3=temp2;
  			end 
  			
  			always_ff@(posedge clk or negedge rstn)
  			begin 
  				if(rstn==0)
  					pooling_data_out[m]<=0;
  				else 
    				pooling_data_out[m]<=temp3;
    		end 
    		
  			     			
  		end 	
  endgenerate
  
  always_comb // row buffer writer  wr data
  begin 
  	foreach(buffer_writer_ram_wr_data[i,j])
  		if(i*LAST_Iw+j>REAL_HOUT-1)
  			buffer_writer_ram_wr_data[i][j]=0;
  		else 
  			buffer_writer_ram_wr_data[i][j]=pooling_data_out[i*LAST_Iw+j];
  end 
  
  always_comb  // pooling ram read addr 
  begin 
  	foreach(pooling_rd_addr[i,j])
  	pooling_rd_addr[i][j]=counter;
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
  			pooling_wren[0]=writer_ram_wren;
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
  		  
  localparam LAST_N_UP=ceil(LAST_N,LAST_Wh);		  
  row_buffer_writer#( 
    .DATA_WIDTH       ( DATA_WIDTH       ),
    .REAL_HINT        ( REAL_HINT        ),
    .REAL_HOUT        ( REAL_HOUT        ),
    .K                ( K                ),
    .S                ( S                ),
    .LAST_PK          ( LAST_PK          ),
    .LAST_C           ( LAST_C           ),
    .LAST_N           ( LAST_N_UP        ),
    .LAST_Wh          ( LAST_Wh          ),
    .LAST_Ww          ( LAST_Ww          ),
    .LAST_Ih          ( LAST_Ih          ),
    .LAST_Iw          ( LAST_Iw          ),
    .LAST_Bi          ( LAST_Bi          ),
    .LAST_CKK         ( LAST_CKK         ),
    .NEXT_PK          ( NEXT_PK          ),
    .NEXT_C           ( NEXT_C           ),
    .NEXT_N           ( NEXT_N           ),
    .NEXT_Wh          ( NEXT_Wh          ),
    .NEXT_Ww          ( NEXT_Ww          ),
    .NEXT_Ih          ( NEXT_Ih          ),
    .NEXT_Iw          ( NEXT_Iw          ),
    .NEXT_Bi          ( NEXT_Bi          ),
    .NEXT_CKK         ( NEXT_CKK         ), 
    .HOUT             ( HOUT             ),
    .HINT             ( HINT             ),
    .BUffER_RAM_COUNT ( BUffER_RAM_COUNT ),   
    .ADDR_WIDTH       ( ADDR_WIDTH       ),
    .RCC_WIDTH        ( RCC_WIDTH        ),
    .ROW_WIDTH        ( ROW_WIDTH        ))
    writer_in_pooling
  (
  	.clk(clk),                                                                        
  	.rstn(rstn),                                                                       
  	                                                                             
  	 .buffer_writer_ram_wren(writer_ram_wren), // ceil(hout /IW)                
  	 .buffer_writer_ram_wr_addr(writer_ram_wr_addr),              
  	 .buffer_writer_ram_wr_data(writer_ram_wr_data), 
  	                                                                             
     .buffer_writer_done(writer_done),                                                         
     .buffer_writer_en(writer_en),                                                           
                                                                                 
     .pe2row_fifo_array1_rden(pe2row_fifo_array1_rden),                                       
     .pe2row_ready(pe2row_ready),                                                               
     .fifo_array1_dataout(fifo_array1_dataout),                  
     .pe2row_data_valid(pe2row_data_valid)                                                           
  );  
   
 // pooling 层外挂ram ，个数取决于pooling 对接的hint =2*hout         
 
  generate  // RAM width = LAST_Iw*8  Depth= LAST_N (writer中考虑向上取整)                   
  	for(m=0;m<2;m=m+1)                            
  		for(n=0;n<BUffER_RAM_COUNT ;n=n+1)           
  		begin :pooling_mem_loop   
  			user_ram #(
  			.RAM_DEPTH(LAST_N+20),
  			.RAM_WIDTH(LAST_Iw*DATA_WIDTH)
  			)  pooling_ram_temp 
  			(
  			.clk(clk), 
  			.rstn(rstn),                              
 			  .wea(pooling_wren[m][n]),                 
 			  .addra(pooling_wr_addr[m][n]),            
 			  .dina(pooling_wr_data[m][n]),             
 			                              
 			  .addrb(pooling_rd_addr[m][n]),            
 			  .doutb(pooling_rd_data[m][n])				      
 			  );                              
  	                          
 		end   
 		
 	endgenerate	                                    
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