`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/16 20:02:18
// Design Name: 
// Module Name: tb_FC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_FC(

    );
    // vgg16_fc_top Parameters
import fc_parameter_package::*;
parameter PERIOD        = 10        ;


// vgg16_fc_top Inputs
   logic clk                            = 0 ;
   logic rstn                           = 0 ;
   logic [LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0]fifo_array1_dataout  ;
   logic pe2row_data_valid               ;
   logic [ADDR_WIDTH-1:0] result_rd_ADDR = 0 ;
   logic result_ready                   = 0 ;
   logic weight_fifo_wren               = 0 ;
   logic [AF-1:0][DATA_WIDTH-1:0] weight_fifo_din = 0 ;

// vgg16_fc_top Outputs
  logic [LAST_Wh-1:0]pe2row_fifo_array1_rden ;
  logic pe2row_ready                   ;
  logic [AF-1:0][DATA_WIDTH-1:0] result_data[BATCH] ;
  logic result_valid                   ;
  logic weight_fifo_full               ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

vgg16_fc_top #(
    .AF           ( AF           ),
    .BATCH        ( BATCH        ),
    .FOUT1        ( FC_FOUT[1]      ),
    .FOUT2        ( FC_FOUT[2]      ),
    .FOUT3        ( FC_FOUT[3]      ),
    .FIN1         ( FC_FIN[1]         ),
    .FIN2         ( FC_FIN[2]         ),
    .FIN3         ( FC_FIN[3]         ),
    .FIN4         ( FC_FIN[4]         ),
    .WEIGHT_WIDTH ( WEIGHT_WIDTH ),
    .DATA_WIDTH   ( DATA_WIDTH   ),
    .PRECISION    ( PRECISION    ),
    .ADDR_WIDTH   ( ADDR_WIDTH   ),
    .REAL_HINT    ( FC_REAL_HINT    ),
    .REAL_HOUT    ( FC_REAL_HOUT    ),
    .LAST_N       ( LAST_N       ),
    .LAST_Wh      ( LAST_Wh      ),
    .LAST_Iw      ( LAST_Iw      ))
 u_vgg16_fc_top (
   .clkin(clk),
   .*);

// weight push
	
   bit [FC_FIN[1]-1: 0][2:0][DATA_WIDTH-1:0]fc_weight_1;  //4096 row 
   bit [FC_FIN[2]-1: 0][2:0][DATA_WIDTH-1:0]fc_weight_2;  //4096 row 
   bit [FC_FIN[3]-1: 0][2:0][DATA_WIDTH-1:0]fc_weight_3;  //4096 row 
  
  integer fc_fid;
  integer fc_weight_addr;
  integer fc_weight_end;
  integer w_dataflow;
  logic flag;
  
 integer tell;
 
 initial 
 begin 
 	#(10*PERIOD);
 	forever
 	 begin
 	 get_weight1;
 	 get_weight2;
 	 
 	 
 	 get_weight3;
 	 end 
 end 
 
 task get_weight1;
 		begin : weight_1_task  // 用于disable终止forever （需要在forever外部的begin，内部的话，类似 与 continue
  		fc_fid = $fopen("E:/code/cnn_structure/FC_Structure/matlab_data/fc_weight_0.bin","rb"); 
  		if(fc_fid<0)
  		  begin 
  		  $display("weight mem read fail");
  		//	$finish;
  		end 
  		 w_dataflow=FC_FIN[1];
       fc_weight_addr=0;
       fc_weight_end=0;          
			  $fseek(fc_fid,0,2);       
			 fc_weight_end=$ftell(fc_fid);
			  $fseek(fc_fid,0,0);       
  		$fread(fc_weight_1,fc_fid);
	  	 forever 
	  	 begin 
	  	 		push_weight_1_fifo;
	  	 		if(flag==1)
	  	 			begin 
	  	 				flag=0;
	  	 		   disable weight_1_task;
	  	 		  end 
	  	 end 
   end 
 endtask
 
 
  		
  		 task push_weight_1_fifo; // input weight data     
  		                              
				 @(negedge clk )                                                                
				 	  	if(weight_fifo_full==0 && fc_weight_addr<=w_dataflow-1)
				 	  		begin                                                                   
				 	  		weight_fifo_wren='1;                               
				 	  		weight_fifo_din=fc_weight_1[fc_weight_addr];      
				 	  		fc_weight_addr=fc_weight_addr+1; 	  		                                      
				 	  	 end                                                                       
				 	    else if(fc_weight_addr==w_dataflow)                                            
				 	    	begin   
						 	    	weight_fifo_wren='0;                               
						 	  		weight_fifo_din=0;                               
						 	  		fc_weight_addr=0; 
						 	  		tell=$ftell(fc_fid);
						 	  		if(tell==fc_weight_end)
						 	  			begin 
									 	      	$fclose(fc_fid)  ;
									 	      	flag=1;
									 	      	
									 	  end 
									 	else 	                                                                    
						           $fread(fc_weight_1,fc_fid);  			 	  			  		                                                                
				 	      end                                                                       
				 	    else                                                                      
				 	    	begin                                                                   
								weight_fifo_wren='0;                               
				 	  		weight_fifo_din=0;                               
				 	  		fc_weight_addr=fc_weight_addr; 	                                              
				 	  		end                                                                     
 			endtask   
 			
 	task get_weight2;
 		begin : weight_2_task
  		fc_fid = $fopen("E:/code/cnn_structure/FC_Structure/matlab_data/fc_weight_1.bin","rb"); 
  		if(fc_fid<0)
  		  begin 
  		  $display("weight mem read fail");
  			//$finish;
  		end 
  		 w_dataflow=FC_FIN[2];
       fc_weight_addr=0;
       fc_weight_end=0;          
			  $fseek(fc_fid,0,2);       
			 fc_weight_end=$ftell(fc_fid);
			  $fseek(fc_fid,0,0);       
  		$fread(fc_weight_2,fc_fid);
	  	 forever 
	  	 begin 
	  	 		push_weight_2_fifo;
	  	 		if(flag==1)
	  	 			begin 
	  	 				flag=0;
	  	 		   disable weight_2_task;
	  	 		  end 
	  	 end 
   end 
 endtask
 
 
 
  		
  		 task push_weight_2_fifo; // input weight data                                  
				 @(negedge clk )                                                                
				 	  	if(weight_fifo_full==0 && fc_weight_addr<=w_dataflow-1)
				 	  		begin                                                                   
				 	  		weight_fifo_wren='1;                               
				 	  		weight_fifo_din=fc_weight_2[fc_weight_addr];      
				 	  		fc_weight_addr=fc_weight_addr+1; 	  		                                      
				 	  	 end                                                                       
				 	    else if(fc_weight_addr==w_dataflow)                                            
				 	    	begin   
						 	    	weight_fifo_wren='0;                               
						 	  		weight_fifo_din=0;                               
						 	  		fc_weight_addr=0; 
						 	  		if($ftell(fc_fid)==fc_weight_end)
						 	  			begin 
									 	      	$fclose(fc_fid)  ;
									 	      	flag=1;
									 	  end 
									 	else 	                                                                    
						           $fread(fc_weight_2,fc_fid);  			 	  			  		                                                                
				 	      end                                                                       
				 	    else                                                                      
				 	    	begin                                                                   
								weight_fifo_wren='0;                               
				 	  		weight_fifo_din=0;                               
				 	  		fc_weight_addr=fc_weight_addr; 	                                              
				 	  		end                                                                     
 			endtask 
 			  
 			task get_weight3;
 		begin : weight_3_task  // 
  		fc_fid = $fopen("E:/code/cnn_structure/FC_Structure/matlab_data/fc_weight_2.bin","rb"); 
  		if(fc_fid<0)
  		  begin 
  		  $display("weight mem read fail");
  			//$finish;
  		end 
  		 w_dataflow=FC_FIN[3];
       fc_weight_addr=0;
       fc_weight_end=0;          
			  $fseek(fc_fid,0,2);       
			 fc_weight_end=$ftell(fc_fid);
			  $fseek(fc_fid,0,0);       
  		$fread(fc_weight_3,fc_fid);
	  	 forever 
	  	 begin 
	  	 		push_weight_3_fifo;
	  	 		if(flag==1)
	  	 			begin 
	  	 				flag=0;
	  	 		   disable weight_3_task;
	  	 		  end 
	  	 end 
   end 
 endtask
 
 
 
  		
  		 task push_weight_3_fifo; // input weight data                                  
				 @(negedge clk )                                                                
				 	  	if(weight_fifo_full==0 && fc_weight_addr<=w_dataflow-1)
				 	  		begin                                                                   
				 	  		weight_fifo_wren='1;                               
				 	  		weight_fifo_din=fc_weight_3[fc_weight_addr];      
				 	  		fc_weight_addr=fc_weight_addr+1; 	  		                                      
				 	  	 end                                                                       
				 	    else if(fc_weight_addr==w_dataflow)                                            
				 	    	begin   
						 	    	weight_fifo_wren='0;                               
						 	  		weight_fifo_din=0;                               
						 	  		fc_weight_addr=0; 
						 	  		if($ftell(fc_fid)==fc_weight_end)
						 	  			begin 
									 	      	$fclose(fc_fid)  ;
									 	      	flag=1;
									 	  end 
									 	else 	                                                                    
						           $fread(fc_weight_3,fc_fid);  			 	  			  		                                                                
				 	      end                                                                       
				 	    else                                                                      
				 	    	begin                                                                   
								weight_fifo_wren='0;                               
				 	  		weight_fifo_din=0;                               
				 	  		fc_weight_addr=fc_weight_addr; 	                                              
				 	  		end                                                                     
 			endtask   		
 			
// fin 

 parameter FC_FM_IN_ADDRESS=(ceil(LAST_N,LAST_Wh)*FC_REAL_HINT)/(LAST_Wh*LAST_Iw);
 bit [FC_REAL_HINT*FC_FM_IN_ADDRESS-1:0][LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] fin_data;
 integer fc_fin_addr; 
 integer fc_fid_fin;
 logic   [LAST_Wh-1:0]fin_fifo_wren;
   logic [LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0]fin_fifo_din;
   logic [LAST_Wh-1:0]fin_fifo_full;   
   logic [LAST_Wh-1:0]prog_empty;  	
   
  assign pe2row_data_valid=~(|prog_empty);
 	initial  // input row data 
 begin 
 	   // get data from bin 
 	   fc_fid_fin = $fopen("E:/code/cnn_structure/FC_Structure/matlab_data/fc_fm_in.bin","rb");
	   read_fm_in_reshape1(1,fc_fid_fin,fin_data);
	   $fclose(fc_fid_fin);
 	   // push to fifo 
 	   #(10*PERIOD) ;
 	   fc_fin_addr=0;
 	    forever push_2_fifo;
 	    	
 end 

  task read_fm_in_reshape1; // input row data 
	input integer which_batch;
	input  integer fid;
	output [FC_REAL_HINT*FC_FM_IN_ADDRESS-1:0][LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] fm;
	integer n=BATCH;
	for(n=BATCH;n>=which_batch;n=n-1)
		$fread(fm, fid);
	$fclose(fid);
endtask

task push_2_fifo ; // input fin fifo 
 	@(negedge clk )
 	  	if((|fin_fifo_full)==0 && fc_fin_addr<=FC_REAL_HINT*FC_FM_IN_ADDRESS-1)
 	  		begin 
 	  		fin_fifo_wren='1;
 	  		fin_fifo_din=fin_data[fc_fin_addr];
 	  		fc_fin_addr=fc_fin_addr+1; 	  		
 	  	end 
 	    else if(fc_fin_addr==FC_REAL_HINT*FC_FM_IN_ADDRESS)
 	    begin 
 	    	fin_fifo_wren=0;
 	  		  fin_fifo_din=0;
 	  		  fc_fin_addr=0;
 	    end 
 	    else 
 	    	begin 
 	    		fin_fifo_wren=0;
 	  		  fin_fifo_din=0;
 	  		  fc_fin_addr=fc_fin_addr;
 	  		end 
endtask


genvar n;

  generate
  	for(n=0;n<LAST_Wh;n=n+1)
  	begin : fin_fifo_loop
   user_fifo#(
   .FIFO_WIDTH(LAST_Iw*DATA_WIDTH),
   .FIFO_DEPTH(2**14),
   .FIFO_PROG_EMPTY_THRESH(20)
   ) fin_fifo_f
   (
   .clk(clk),
   .rstn(rstn),
   
   .wr_en(fin_fifo_wren[n]),
   .din(fin_fifo_din[n]),
   .prog_full(fin_fifo_full[n]),
   .rd_en(pe2row_fifo_array1_rden[n]),
   .dout(fifo_array1_dataout[n]),
   .prog_empty(prog_empty[n])   
   );
 end
  endgenerate 
  
//logic   [AF-1:0][DATA_WIDTH-1:0]  dut_result[FIN4] [BATCH];     // hardware module output    
integer fin;	
initial                                                                                                              
begin                                                                                                                
	forever                                                                                                            
	begin                                                                                                              
		                                                                                                                 
	result_ready=0;                                                                                                    
	result_rd_ADDR=0;                                                                                               
	#(100*PERIOD)                                                                                                      
	wait(result_valid==1)                                                                                              
		begin                                                                                                            
			#(PERIOD);                                                                                                     
			#(PERIOD/2)                                                                                                    
			result_ready=1;                                                                                                
			result_rd_ADDR=0;                                                                                              
			                                                                                                               
			//读取result		                                                                                               
			for(fin=0;fin<FC_FIN[4];fin=fin+1)                                                                                  
      begin                                                                                                          
      	#(PERIOD)     	                                                                                             
      //	dut_result[fin]=result_data;                                                                                 
        result_rd_ADDR=fin+1;                                                                                        
      end                                                                                                            
                                                                                                                     
     result_ready=0;                                                                                                 
    end                                                                                                              
 // $display("batch_count: %d dut_result %s test_result",batch_count,(dut_result==test_data_mem4)?"==":"!=");          
 // batch_count=batch_count+1;                                                                                         
 end                                                                                                                 
end                                                                                                                  
		
 			
 			
 			
 			                                                                     
endmodule