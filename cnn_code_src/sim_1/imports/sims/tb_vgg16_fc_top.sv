`timescale  1ns / 1ps

module tb_vgg16_fc_top;

// vgg16_fc_top Parameters
parameter PERIOD           = 10              ;
parameter AF               = 3               ;
parameter BATCH            = 9               ;
parameter FOUT1            = 15            ;
parameter FOUT2            = 15            ;
parameter FOUT3            = 12            ;  
parameter FIN1=int($ceil(real(100)/AF));          // 注意，这里的FOUT不能整除AF     
parameter FIN2=int($ceil(real(FOUT1)/AF));        // 如FOUT1，在fin2中会被补全，计算的数据会多出几个
parameter FIN3=int($ceil(real(FOUT2)/AF)) ;       // 所以weight也要做类似的处理，最后AF组数据用0补全
parameter FIN4=int($ceil(real(FOUT3 )/AF)) ;      // 这样，就算计算数据多几个，因为weight=0，不影响结果
                                                  // **这里为了省事，设置参数为3的倍数，省去在weight矩阵生成时的补全0操作

parameter WEIGHT_WIDTH     = 8               ;
parameter DATA_WIDTH       = 8               ;
parameter PRECISION        = 4               ;
parameter ADDR_WIDTH=32        ;


// vgg16_fc_top Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;
reg   [ADDR_WIDTH-1:0]  result_rd_ADDR = 0;
reg   result_ready                         = 0 ;
reg   weight_fifo_wren                     = 0 ;
reg   [AF-1:0][DATA_WIDTH-1:0]  weight_fifo_din ;




reg   [AF-1:0][DATA_WIDTH-1:0]  test_data_mem1[FIN1] [BATCH]; // layer 1 in
reg   [AF-1:0][DATA_WIDTH-1:0]  test_data_mem2[FIN2] [BATCH]; // layer 2 in
reg   [AF-1:0][DATA_WIDTH-1:0]  test_data_mem3[FIN3] [BATCH]; // layer 3 in
reg   [AF-1:0][DATA_WIDTH-1:0]  test_data_mem4[FIN4] [BATCH]; // FC layer output
reg   [AF-1:0][DATA_WIDTH-1:0]  dut_result[FIN4] [BATCH];     // hardware module output 


reg   [AF-1:0][DATA_WIDTH-1:0]  test_weight_mem1[FOUT1][FIN1]; // layer 1 weight  
reg   [AF-1:0][DATA_WIDTH-1:0]  test_weight_mem2[FOUT2][FIN2]; // layer 2 weight
reg   [AF-1:0][DATA_WIDTH-1:0]  test_weight_mem3[FOUT3][FIN3]; // layer 3 weight

reg signed  [DATA_WIDTH*2-1:0]  mul[BATCH];           

reg [ADDR_WIDTH-1:0] RAM_writer_wr_ADDR[BATCH];         
reg [AF-1:0]RAM_writer_byte_en[BATCH];   // 写入时是一个      
reg [AF-1:0][DATA_WIDTH-1:0] RAM_writer_wr_data[BATCH];

reg writer_done;

wire writer_en; 


integer batch_count=0;


// vgg16_fc_top Outputs
wire  [AF-1:0][DATA_WIDTH-1:0]  result_data[BATCH] ;           
wire  result_valid                         ;
wire  weight_fifo_full                     ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

vgg16_fc_top #(
    .AF              ( AF              ),
    .BATCH           ( BATCH           ),
    .FIN1            ( FIN1            ),
    .FIN2            ( FIN2            ),
    .FIN3            ( FIN3            ),
    .FOUT1           ( FOUT1           ),
    .FOUT2           ( FOUT2           ),
    .FOUT3           ( FOUT3           ),
    .WEIGHT_WIDTH    ( WEIGHT_WIDTH    ),
    .DATA_WIDTH      ( DATA_WIDTH      ),
    .PRECISION       ( PRECISION       ),
    .ADDR_WIDTH ( ADDR_WIDTH ))
    
 u_vgg16_fc_top (
    .clk                     ( clk                                       ),
    .rstn                    ( rstn                                      ),
    .result_rd_ADDR          ( result_rd_ADDR                            ),
    .result_ready            ( result_ready                              ),
    .weight_fifo_wren        ( weight_fifo_wren                          ),
    .weight_fifo_din         ( weight_fifo_din                           ),
    //.test_wea                ( test_wea                                  ),
    //.test_addra              ( test_addra                                ),
    //.test_dina               ( test_dina                             ),
    //.test_buffer_switch      ( test_buffer_switch                        ),
    //.FC_data_valid           ( FC_data_valid                             ),
                                                                        
    .result_data             ( result_data                         ),
    .result_valid            ( result_valid                              ),
    .weight_fifo_full        ( weight_fifo_full                          ),
    
    .RAM_writer_wr_ADDR      (RAM_writer_wr_ADDR),
    .RAM_writer_byte_en       (RAM_writer_byte_en),
    .RAM_writer_wr_data       (RAM_writer_wr_data),
    
    .writer_done(writer_done),
    .writer_en(writer_en)
       
    
);
/*************************************************************/
// 输入 FC data
/*************************************************************/
integer i,j,k,m;
integer batch,fin,fout,aj;
integer ran=-25;
initial
begin
 
 	batch_count=batch_count+1;
 	foreach(test_data_mem1[i,j,k])
  //	test_data_mem1[i][j][k]=i*AF*BATCH+j*AF+k;   
  test_data_mem1[i][j][k]=$random%(50+ran);   // 随机初始化  FC data
  
  // 输入 FCdata 到ram1，通过test ram接口
  forever  // 循环将相同的ram矩阵值，输入到不同的ram（通过fc—switch切换RAM0，RAM1）
  begin  
  writer_done=0;
  #(10*PERIOD);
  
  i=0;
  foreach(RAM_writer_byte_en[batch])
  	RAM_writer_byte_en[batch]={AF{1'b1}};
  repeat(FIN1)
  begin
  	foreach(RAM_writer_wr_ADDR[batch])
  		RAM_writer_wr_ADDR[batch]=i;
  	 	
  	RAM_writer_wr_data=test_data_mem1[i];
    #(PERIOD);
    i=i+1;
    
  end 	
  foreach(RAM_writer_byte_en[batch])
  	RAM_writer_byte_en[batch]={AF{1'b0}};
  	
  
  
  writer_done=1;      // 告知传输完成
  wait(writer_en==1); // 等待FC——switch再一次启动传输
  #(PERIOD/2);
  writer_done=0;
 
  
 end    
end

/*************************************************************/
//输入 weight
/*************************************************************/


 reg signed [DATA_WIDTH:0] data_temp;   
 localparam  PRECISION_MAX=(2**(DATA_WIDTH-1)-1)*(2**PRECISION);//32bit
 localparam  PRECISION_MIN=-PRECISION_MAX-1;                              
                                                                                     
 // 初始化weight 软件模拟计算过程并算出结果                    

initial
 begin 
 	     // 初始化weight数组
 	     // **这里为了省事，设置参数为3的倍数，省去在weight矩阵生成时的补全0操作
			 foreach(test_weight_mem1[i,j,k])
			 	test_weight_mem1[i][j][k]=$random%(55+ran);
			 foreach(test_weight_mem2[i,j,k])
			 	test_weight_mem2[i][j][k]=$random%(60+ran);  	
			 foreach(test_weight_mem3[i,j,k])	
			 	test_weight_mem3[i][j][k]=$random%(50+ran); 
			 	 
			 foreach(mul[i])
			 	mul[i]=0;			 	 
			 	
			#(PERIOD); 	
			// 计算FC layer1  	
			for(fout=0;fout<FOUT1;fout=fout+1)
			 begin 	
			      for(fin=0;fin<FIN1;fin=fin+1)
			         for(aj=0;aj<AF;aj=aj+1)
					         begin 
					          for(batch=0;batch<BATCH;batch=batch+1)
		                    //累加部分和
							 	       	mul[batch]=mul[batch]+$signed(test_weight_mem1[fout][fin][aj])*$signed(test_data_mem1[fin][batch][aj]);
						
					         end 	
					  // 输出一个点（1x batch）		 
				    for(batch=0;batch<BATCH;batch=batch+1) 
					 		begin
					 			//量化  16bit -8bit
					 		 if($signed(mul[batch])>PRECISION_MAX)          
				           begin                                                                     
				           data_temp=2**(DATA_WIDTH-1)-1;                                              
				           end                                                                       
				       else if ($signed(mul[batch])<PRECISION_MIN)    
				           begin                                                                     
				           data_temp=-2**(DATA_WIDTH);                                          
				           end                                                                       
				       else                                                                          
				       	  begin                                                                       
				       		data_temp=$signed(mul[batch])>>4;                   
				      		end                                                                         
				    	   //输出到下一层存储                                                                        		                                                                                     		                                                 
					 		  test_data_mem2[fout/AF][batch][fout%AF]=data_temp; 
					 		  mul[batch]=0;   	 	
					    end                                                    
		   end
		   // 计算FC layer2  
	 	  for(fout=0;fout<FOUT2;fout=fout+1)
			 begin 	
			        for(fin=0;fin<FIN2;fin=fin+1)
			         for(aj=0;aj<AF;aj=aj+1)
			         begin 
			       //  #(PERIOD);
			          for(batch=0;batch<BATCH;batch=batch+1)

					 		mul[batch]=mul[batch]+$signed(test_weight_mem2[fout][fin][aj])*$signed(test_data_mem2[fin][batch][aj]);
				
					 end 			 
					 // #(PERIOD);
				   for(batch=0;batch<BATCH;batch=batch+1) 
					 		begin
					 			//量化  16bit -8bit
					 		 if($signed(mul[batch])>PRECISION_MAX)          
				           begin                                                                     
				           data_temp=2**(DATA_WIDTH-1)-1;                                              
				           end                                                                       
				       else if ($signed(mul[batch])<PRECISION_MIN)    
				           begin                                                                     
				           data_temp=-2**(DATA_WIDTH);                                          
				           end                                                                       
				       else                                                                          
				       	  begin                                                                       
				       		data_temp=$signed(mul[batch])>>4;                   
				      		end                                                                         
				    	   //输出到下一层存储                                                                        		                                                                                     		                                                 
					 		  test_data_mem3[fout/AF][batch][fout%AF]=data_temp; 
					 		  mul[batch]=0;   	 	
					    end                                                      
		   end 
		   // 计算FC layer3 
		   for(fout=0;fout<FOUT3;fout=fout+1)
			 begin 	
			        for(fin=0;fin<FIN3;fin=fin+1)
			         for(aj=0;aj<AF;aj=aj+1)
			         begin 
			       //  #(PERIOD);
			          for(batch=0;batch<BATCH;batch=batch+1)

					 		mul[batch]=mul[batch]+$signed(test_weight_mem3[fout][fin][aj])*$signed(test_data_mem3[fin][batch][aj]);
				
					 end 			 
					 // #(PERIOD);
				    for(batch=0;batch<BATCH;batch=batch+1) 
					 		begin
					 			//量化  16bit -8bit
					 		 if($signed(mul[batch])>PRECISION_MAX)          
				           begin                                                                     
				           data_temp=2**(DATA_WIDTH-1)-1;                                              
				           end                                                                       
				       else if ($signed(mul[batch])<PRECISION_MIN)    
				           begin                                                                     
				           data_temp=-2**(DATA_WIDTH);                                          
				           end                                                                       
				       else                                                                          
				       	  begin                                                                       
				       		data_temp=$signed(mul[batch])>>4;                   
				      		end                                                                         
				    	   //输出到下一层存储                                                                        		                                                                                     		                                                 
					 		  test_data_mem4[fout/AF][batch][fout%AF]=data_temp; 
					 		  mul[batch]=0;   	 	
					    end                                                    
		   end  	 	 
 end 
  
  
 // 向fifo输入weight数据	
initial
 begin 	
 forever
 begin 	
    #(10*PERIOD);
   //layer1 
  foreach (test_weight_mem1[fout,fin])
   begin 
   	  #(PERIOD);
   	  if(weight_fifo_full==1)
   	  	weight_fifo_wren=0; 
   	  	
	   	wait(weight_fifo_full==0)
	   	begin 			   	 
			   	weight_fifo_din=test_weight_mem1[fout][fin];  	                    
			   	weight_fifo_wren=1;   			   		     
	    end    
   end 
  //layer2 
   foreach (test_weight_mem2[fout,fin])
   begin 
   	  #(PERIOD);
   	  if(weight_fifo_full==1)
   	  	weight_fifo_wren=0; 
   	  	
	   	wait(weight_fifo_full==0)
	   	begin 			   	 
			   	weight_fifo_din=test_weight_mem2[fout][fin];  	                    
			   	weight_fifo_wren=1;   			   		     
	    end    
   end 
   //layer3 
    foreach (test_weight_mem3[fout,fin])
   begin 
   	  #(PERIOD);
   	  if(weight_fifo_full==1)
   	  	weight_fifo_wren=0; 
   	  	
	   	wait(weight_fifo_full==0)
	   	begin 			   	 
			   	weight_fifo_din=test_weight_mem3[fout][fin];  	                    
			   	weight_fifo_wren=1;   			   		     
	    end    
   end 
   #(PERIOD);
  weight_fifo_wren=0; 
  #(100*PERIOD);
 end 
 end 
 
/*************************************************************/
//结果验证
/*************************************************************/
 
initial 
begin 
	forever
	begin 
		
	result_ready=0;
	result_rd_ADDR=1399;
	#(100*PERIOD)
	wait(result_valid==1) 
		begin 
			#(PERIOD);
			#(PERIOD/2)
			result_ready=1;
			result_rd_ADDR=0;
			
			//读取result		
			for(fin=0;fin<FIN4;fin=fin+1)
      begin 
      	#(PERIOD)     	
      	dut_result[fin]=result_data;
        result_rd_ADDR=fin+1;
      end 
      
     result_ready=0;
    end 
  $display("batch_count: %d dut_result %s test_result",batch_count,(dut_result==test_data_mem4)?"==":"!=");
  batch_count=batch_count+1;
 end  
end                  


                                                 
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
 endmodule