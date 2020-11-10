`timescale  1ns / 100ps
// 2019��12��23��20:42:55



module tb_vgg_conv;
parameter PERIOD            = 10                      ;

// conv Parameters
import parameter_package::*;




parameter HOUT=ceil(CONV_REAL_HOUT[TEST_LAYER_COUNT],CONV_Iw[TEST_LAYER_COUNT]);  //layer TEST_LAYER_COUNT
parameter HINT=ceil(CONV_REAL_HOUT[0],CONV_Iw[0]); //layer 0


parameter LAST_N_UP= ceil(CONV_N[0],CONV_Wh[0]);
parameter NEXT_N_UP= ceil(CONV_N[TEST_LAYER_COUNT],CONV_Wh[TEST_LAYER_COUNT]);

parameter FM_IN_ADDRESS=(LAST_N_UP*HINT)/(CONV_Wh[0]*CONV_Iw[0]);

parameter FM_OUT_ADDRESS = int'(real'(NEXT_N_UP*HOUT)/(CONV_Wh[TEST_LAYER_COUNT]*CONV_Iw[TEST_LAYER_COUNT]));

genvar n,m; 
logic clk =0;
logic rstn=0;
generate 
	for(m=0;m<=TEST_LAYER_COUNT;m=m+1)
  begin : if_loop
  	 conv_top #            
  	 (                     
  	 .Wh(CONV_Wh[m]),     
  	 .Iw(CONV_Iw[m]),     
     .Ww(CONV_Ww[m])      
     )                     
      conv_if (  
         
     );                    

  end 
endgenerate

// conv Inputs


// conv Outputs



initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

 

/*******************************************************************/
//................................................................../
 

generate 
	for(n=1;n<=TEST_LAYER_COUNT;n=n+1)
	begin : weight_loop
			 integer dataflow=ceil(CONV_N[n],CONV_Wh[n])/CONV_Wh[n];
			 integer weight_addr;
			 integer weight_end;
			 integer fid;
			 bit [0:ceil(CONV_N[n],CONV_Wh[n])/CONV_Wh[n]-1][CONV_Wh[n]-1:0][CONV_Ww[n]-1:0][DATA_WIDTH-1:0] weight_reshape2;
			 string nnh;
			 string nn;			 
			 string weight_file_name; 			 
			 initial  // input weight data 
			 begin
			 #(PERIOD*50);	
			 nn.itoa(n%10);   
	     nnh.itoa(n/10); 
	     weight_file_name={"/home/luoconghui/work/matlab_data/conv_",nnh,nn,"_weight_reshape2.bin"};     
	
			 	if_loop[n].conv_if.weight_buffer_wren=0;
			 	if_loop[n].conv_if.weight_buffer_din=0;
			  fid = $fopen(weight_file_name,"rb");
			  if(fid==0)
			 		begin 
			 		$display("read file fail");
			 		$finish;
			 	 end 
			  weight_addr=0;         
			  weight_end=0;          
			  $fseek(fid,0,2);       
			  weight_end=$ftell(fid);
			  $fseek(fid,0,0);       

				$fread(weight_reshape2,fid);
				//$fclose(fid);
				#(10*PERIOD)	
					
					forever push_2_weight_fifo;				
			 end  

			 task push_2_weight_fifo; // input weight data 
			 @(negedge clk )
			 	  	if((|if_loop[n].conv_if.weight_buffer_full)==0 && weight_addr<=dataflow-1)
			 	  		begin 
			 	  		if_loop[n].conv_if.weight_buffer_wren='1;
			 	  		if_loop[n].conv_if.weight_buffer_din=weight_reshape2[weight_addr];
			 	  		weight_addr=weight_addr+1; 	  		
			 	  	end 
			 	    else if(weight_addr==dataflow)
			 	    	begin
			 	    	if_loop[n].conv_if.weight_buffer_wren=0;
			 	  		if_loop[n].conv_if.weight_buffer_din=0;
			 	  		weight_addr=0; 
			 	  		$fread(weight_reshape2,fid);
			 	      if($ftell(fid)==weight_end)
			 	      	$fseek(fid,0,0);
			 	  			  		
			 	    end 
			 	    else 
			 	    	begin 
			 	    	if_loop[n].conv_if.weight_buffer_wren=0;
			 	  		if_loop[n].conv_if.weight_buffer_din=0;
			 	  		weight_addr=weight_addr; 	  
			 	  		end 
			 endtask
		end 
endgenerate
//.................................................................../
//*******************************************************************/ 


/*******************************************************************/
//................................................................../
   logic [CONV_Wh[0]-1:0]fin_fifo_wren;
   logic [CONV_Wh[0]-1:0][CONV_Iw[0]-1:0][DATA_WIDTH-1:0]fin_fifo_din;
   logic [CONV_Wh[0]-1:0]fin_fifo_full;   
   logic [CONV_Wh[0]-1:0]prog_empty; 
   bit [CONV_REAL_HINT[1]*FM_IN_ADDRESS-1:0][CONV_Wh[0]-1:0][CONV_Iw[0]-1:0][DATA_WIDTH-1:0] fin_data; 
   integer fin_addr; 
   integer fid_fm_in_reshape1;
   
assign if_loop[0].conv_if.pe2row_data_valid=~(|prog_empty);

 initial  // input row data 
 begin 
 	   // get data from bin 
 	   #(PERIOD*50);	
 	   fid_fm_in_reshape1 = $fopen("/home/luoconghui/work/matlab_data/conv_01_fm_in_reshape1.bin","rb");
	   read_fm_in_reshape1(1,fid_fm_in_reshape1,fin_data);
	   $fclose(fid_fm_in_reshape1);
 	   // push to fifo 
 	   #(10*PERIOD) ;
 	   fin_addr=0;
 	    forever push_2_fifo;
 	    	
 end 

  task read_fm_in_reshape1; // input row data 
	input integer which_batch;
	input  integer fid;
	output [CONV_REAL_HINT[1]-1:0][FM_IN_ADDRESS-1:0][CONV_Wh[0]-1:0][CONV_Iw[0]-1:0][7:0] fm;
	integer n=BATCH;
	for(n=BATCH;n>=which_batch;n=n-1)
		$fread(fm, fid);
	$fclose(fid);
endtask

task push_2_fifo ; // input fin fifo 
 	@(negedge clk )
 	  	if((|fin_fifo_full)==0 && fin_addr<=CONV_REAL_HINT[1]*FM_IN_ADDRESS-1)
 	  		begin 
 	  		fin_fifo_wren='1;
 	  		fin_fifo_din=fin_data[fin_addr];
 	  		fin_addr=fin_addr+1; 	  		
 	  	end 
 	    else if(fin_addr==CONV_REAL_HINT[1]*FM_IN_ADDRESS)
 	    begin 
 	    	fin_fifo_wren=0;
 	  		  fin_fifo_din=0;
 	  		  fin_addr=0;
 	    end 
 	    else 
 	    	begin 
 	    		fin_fifo_wren=0;
 	  		  fin_fifo_din=0;
 	  		  fin_addr=fin_addr;
 	  		end 
endtask



  generate
  	for(n=0;n<CONV_Wh[0];n=n+1)
  	begin : fin_fifo_loop
   user_fifo#(
   .FIFO_WIDTH(CONV_Iw[0]*DATA_WIDTH),
   .FIFO_DEPTH(2**14),
   .FIFO_PROG_EMPTY_THRESH(20)
   ) fin_fifo_f
   (
   .clk(clk),
   .rstn(rstn),
   
   .wr_en(fin_fifo_wren[n]),
   .din(fin_fifo_din[n]),
   .prog_full(fin_fifo_full[n]),
   .rd_en(if_loop[0].conv_if.pe2row_fifo_array1_rden[n]),
   .dout(if_loop[0].conv_if.fifo_array1_dataout[n]),
   .prog_empty(prog_empty[n])   
   );
 end
  endgenerate 
//.................................................................../
//*******************************************************************/ 

/*******************************************************************/
//................................................................../
integer output_row_counter;
task pe_data_out;
begin 
	
	wait(if_loop[TEST_LAYER_COUNT].conv_if.pe2row_data_valid==1);
		#(PERIOD*3/2);
		if_loop[TEST_LAYER_COUNT].conv_if.pe2row_fifo_array1_rden='1;
		if_loop[TEST_LAYER_COUNT].conv_if.pe2row_ready=1;
		#(PERIOD*FM_OUT_ADDRESS)
		if_loop[TEST_LAYER_COUNT].conv_if.pe2row_fifo_array1_rden=0;
		if_loop[TEST_LAYER_COUNT].conv_if.pe2row_ready=0;
		output_row_counter=output_row_counter+1;
		#(2*PERIOD);
end 
endtask

	initial begin
		#(PERIOD*50);	
		 if_loop[TEST_LAYER_COUNT].conv_if.pe2row_fifo_array1_rden=0;
		if_loop[TEST_LAYER_COUNT].conv_if.pe2row_ready=0;
		output_row_counter=0;
		#(10*PERIOD)	
		forever pe_data_out;
	end 	
//.................................................................../
//*******************************************************************/ 




VGG_CONV u_conv (
 .conv_data_in    ( if_loop[0].conv_if.row_buffer_in),
 .conv_result_out ( if_loop[TEST_LAYER_COUNT].conv_if.pe_out),
 .conv_weight_1   ( if_loop[1].conv_if.pe_weight_in),  
 .conv_weight_2   ( if_loop[2].conv_if.pe_weight_in),
 .conv_weight_3   ( if_loop[3].conv_if.pe_weight_in),
 .conv_weight_4   ( if_loop[4].conv_if.pe_weight_in),  
 .conv_weight_5   ( if_loop[5].conv_if.pe_weight_in),
 .conv_weight_6   ( if_loop[6].conv_if.pe_weight_in),
 .conv_weight_7   ( if_loop[7].conv_if.pe_weight_in),
 .conv_weight_8   ( if_loop[8].conv_if.pe_weight_in     ),
 .conv_weight_9   ( if_loop[9].conv_if.pe_weight_in     ),
 .conv_weight_10  ( if_loop[10].conv_if.pe_weight_in    ),
 .conv_weight_11  ( if_loop[11].conv_if.pe_weight_in    ),
 .conv_weight_12  ( if_loop[12].conv_if.pe_weight_in    ),
 .conv_weight_13  ( if_loop[13].conv_if.pe_weight_in    ),
  .clkin(clk),
  .rstn(rstn)
);




  function integer log2(input integer x);
        integer i;
        begin
            log2 = 1;
            for (i = 0; 2**i<x; i = i + 1)
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