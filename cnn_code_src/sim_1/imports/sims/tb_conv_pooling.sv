`timescale  1ns / 1ps

module tb_conv_pooling;
parameter BATCH=9;
// conv Parameters
parameter PERIOD            = 10                      ;
parameter DATA_WIDTH        = 8                       ;
parameter REAL_HINT         = 50                      ;
parameter REAL_HOUT         = 25                      ;
parameter K                 = 3                       ;
parameter S                 = 1                       ;
parameter LAST_PK           = 2                       ;
parameter LAST_C            = 32                      ;
parameter LAST_N            = 32                      ;
parameter LAST_Wh           = 3                       ;
parameter LAST_Ww           = 11                      ;
parameter LAST_Ih           = 11                      ;
parameter LAST_Iw           = 7                       ;
parameter LAST_Bi           = 2                       ;
parameter LAST_CKK          = LAST_C*K*K              ;
parameter NEXT_PK           = 2                       ;
parameter NEXT_C            = 32                      ;
parameter NEXT_N            = 32                      ;
parameter NEXT_Wh           = 3                       ;
parameter NEXT_Ww           = 11                      ;
parameter NEXT_Ih           = 11                      ;
parameter NEXT_Iw           = 7                       ;
parameter NEXT_Bi           = 2                       ;
parameter HOUT=ceil(REAL_HOUT,NEXT_Iw);  // hout is not divisible , need adding 0  // must use real'  ,or that int'/int'=int', ceil is useless
parameter HINT=ceil(REAL_HINT,LAST_Iw);
parameter BUffER_RAM_COUNT=ceil(REAL_HINT,LAST_Iw)/LAST_Iw;

parameter LAST_N_UP= ceil(LAST_N,LAST_Wh);
parameter NEXT_N_UP= ceil(LAST_N,NEXT_Wh);

parameter FM_IN_ADDRESS=(LAST_N_UP*HINT)/(LAST_Wh*LAST_Iw);
parameter LAST_N_K_K_UP=ceil(LAST_N*K*K,LAST_Ww);

parameter NEXT_N_K_K_UP=ceil(NEXT_N*K*K,NEXT_Ww);

parameter FM_OUT_ADDRESS = int'(real'(NEXT_N_UP*HOUT)/(NEXT_Wh*NEXT_Iw));
parameter WEIGHT_ADDRESS = int'(real'(NEXT_N_UP*NEXT_N_K_K_UP)/(NEXT_Wh*NEXT_Ww));

parameter ADDR_WIDTH        = 32            ;
parameter RCC_WIDTH         = 10+10+10      ;
parameter ROW_WIDTH         = 10            ;

// conv Inputs


// conv Outputs
logic clk =0;
logic rstn=0;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end




   
   logic [LAST_Wh-1:0]fin_fifo_wren;
   logic [LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0]fin_fifo_din;
   logic [LAST_Wh-1:0]fin_fifo_full;   
   logic [LAST_Wh-1:0]prog_empty; 
   assign test_interface_last.pe2row_data_valid=~(|prog_empty);
 
  bit [REAL_HINT*FM_IN_ADDRESS-1:0][LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] fin_data_pool; 
  bit [WEIGHT_ADDRESS-1:0][LAST_Wh-1:0][LAST_Ww-1:0][DATA_WIDTH-1:0] weight_reshape2;

  integer fin_addr,weight_addr;
 
 integer fid_fm_in_pool_reshape1;
 integer fid;
/*******************************************************************/
//................................................................../
 initial  // input weight data 
 begin 
  fid = $fopen("C:/Users/HT/Desktop/code/row_buffer/data_generate/weight_reshape2.bin","rb");
	$fread(weight_reshape2,fid);
	$fclose(fid);
	#(10*PERIOD)
		weight_addr=0;
		test_interface.weight_buffer_wren=0;
 	  test_interface.weight_buffer_din=0;
		forever push_2_weight_fifo;
	
	
 end  
 
 task push_2_weight_fifo; // input weight data 
 @(negedge clk )
 	  	if((|test_interface.weight_buffer_full)==0 && weight_addr<=WEIGHT_ADDRESS-1)
 	  		begin 
 	  		test_interface.weight_buffer_wren='1;
 	  		test_interface.weight_buffer_din=weight_reshape2[weight_addr];
 	  		weight_addr=weight_addr+1; 	  		
 	  	end 
 	    else if(weight_addr==WEIGHT_ADDRESS)
 	    	begin
 	    	test_interface.weight_buffer_wren=0;
 	  		test_interface.weight_buffer_din=0;
 	  		weight_addr=0; 
 	    end 
 	    else 
 	    	begin 
 	    	test_interface.weight_buffer_wren=0;
 	  		test_interface.weight_buffer_din=0;
 	  		weight_addr=weight_addr; 	  
 	  		end 
 endtask
//.................................................................../
//*******************************************************************/ 


/*******************************************************************/
//................................................................../
 initial  // input row data 
 begin 
 	   // get data from bin 
 	   fid_fm_in_pool_reshape1 = $fopen("C:/Users/HT/Desktop/code/row_buffer/data_generate/fm_in_pool_reshape1.bin","rb");
	   read_fm_in_reshape1(1,fid_fm_in_pool_reshape1,fin_data_pool);
	   $fclose(fid_fm_in_pool_reshape1);
 	   // push to fifo 
 	   #(10*PERIOD) ;
 	   fin_addr=0;
 	    forever push_2_fifo;
 	    	
 end 

  task read_fm_in_reshape1; // input row data 
	input integer which_batch;
	input  integer fid;
	output [REAL_HINT-1:0][FM_IN_ADDRESS-1:0][LAST_Wh-1:0][LAST_Iw-1:0][7:0] fm;
	integer n=BATCH;
	for(n=BATCH;n>=which_batch;n=n-1)
		$fread(fm, fid);
	$fclose(fid);
endtask

task push_2_fifo ; // input fin fifo 
 	@(negedge clk )
 	  	if((|fin_fifo_full)==0 && fin_addr<=REAL_HINT*FM_IN_ADDRESS-1)
 	  		begin 
 	  		fin_fifo_wren='1;
 	  		fin_fifo_din=fin_data_pool[fin_addr];
 	  		fin_addr=fin_addr+1; 	  		
 	  	end 
 	    else if(fin_addr==REAL_HINT*FM_IN_ADDRESS)
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


genvar n,m;  // fin fifo 
  generate
  	for(n=0;n<LAST_Wh;n=n+1)
  	begin : fin_fifo_loop
   user_fifo#(
   .FIFO_WIDTH(LAST_Iw*DATA_WIDTH),
   .FIFO_DEPTH(2**9),
   .FIFO_PROG_EMPTY_THRESH(20)
   ) fin_fifo_f
   (
   .clk(clk),
   .rstn(rstn),
   
   .wr_en(fin_fifo_wren[n]),
   .din(fin_fifo_din[n]),
   .prog_full(fin_fifo_full[n]),
   .rd_en(test_interface_last.pe2row_fifo_array1_rden[n]),
   .dout(test_interface_last.fifo_array1_dataout[n]),
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
	
	wait(test_interface.pe2row_data_valid==1);
		#(PERIOD*3/2);
		test_interface.pe2row_fifo_array1_rden='1;
		test_interface.pe2row_ready=1;
		#(PERIOD*FM_OUT_ADDRESS)
		test_interface.pe2row_fifo_array1_rden=0;
		test_interface.pe2row_ready=0;
		output_row_counter=output_row_counter+1;
		#(2*PERIOD);
end 
endtask

	initial begin
		 test_interface.pe2row_fifo_array1_rden=0;
		test_interface.pe2row_ready=0;
		output_row_counter=0;
		#(10*PERIOD)	
		forever pe_data_out;
	end 	
//.................................................................../
//*******************************************************************/ 


// 注意 不同interface的不同参数
conv_top #
(
.Wh(LAST_Wh),
.Iw(LAST_Iw),
.Ww(LAST_Ww)
)
test_interface_last (
.clk(clk),
.rstn(rstn)
);


conv_top #
(
.Wh(NEXT_Wh),
.Iw(NEXT_Iw),
.Ww(NEXT_Ww)
)
test_interface (
.clk(clk),
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
conv_pooling #(
    .DATA_WIDTH       ( DATA_WIDTH       ),
    .REAL_HINT        ( REAL_HINT        ),
    .REAL_HOUT        ( REAL_HOUT        ),
    .K                ( K                ),
    .S                ( S                ),
    .LAST_PK          ( LAST_PK          ),
    .LAST_C           ( LAST_C           ),
    .LAST_N           ( LAST_N           ),
    .LAST_Wh          ( LAST_Wh          ),
    .LAST_Ww          ( LAST_Ww          ),
    .LAST_Ih          ( LAST_Ih          ),
    .LAST_Iw          ( LAST_Iw          ),
    .LAST_Bi          ( LAST_Bi          ),
    .NEXT_PK          ( NEXT_PK          ),
    .NEXT_C           ( NEXT_C           ),
    .NEXT_N           ( NEXT_N           ),
    .NEXT_Wh          ( NEXT_Wh          ),
    .NEXT_Ww          ( NEXT_Ww          ),
    .NEXT_Ih          ( NEXT_Ih          ),
    .NEXT_Iw          ( NEXT_Iw          ),
    .NEXT_Bi          ( NEXT_Bi          ),

    .ADDR_WIDTH       ( ADDR_WIDTH       ),
    .RCC_WIDTH        ( RCC_WIDTH        ),
    .ROW_WIDTH        ( ROW_WIDTH        ))
 u_conv_pool (
   .pe_data_out (test_interface.pe_out),
   .row_data_in (test_interface_last.row_buffer_in),
   .pe_weight_data_in(test_interface.pe_weight_in)
);

endmodule