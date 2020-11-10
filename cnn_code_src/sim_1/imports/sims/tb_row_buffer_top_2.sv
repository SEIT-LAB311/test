`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/18 18:34:56
// Design Name: 
// Module Name: tb_row_buffer_top_2
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


module tb_row_buffer_top_2(

    );

parameter  BATCH=9;

// row_buffer_writer Parameters
parameter PERIOD            = 10                      ;
parameter DATA_WIDTH        = 8                       ;
parameter REAL_HINT         = 25                      ;
parameter REAL_HOUT         = 25                      ;
parameter K                 = 3                       ;
parameter S                 = 1                       ;
parameter LAST_PK           = 2                       ;
parameter LAST_C            = 32                     ;
parameter LAST_N            = 32                     ;
parameter LAST_Wh           = 3                       ;
parameter LAST_Ww           = 29                      ;
parameter LAST_Ih           = 29                      ;
parameter LAST_Iw           = 7                       ;
parameter LAST_Bi           = 4                       ;
parameter LAST_CKK          = LAST_C*K*K              ;
parameter NEXT_PK           = 2                       ;
parameter NEXT_C            = 32                     ;
parameter NEXT_N            = 32                     ;
parameter NEXT_Wh           = 2                       ;
parameter NEXT_Ww           = 29                      ;
parameter NEXT_Ih           = 29                      ;
parameter NEXT_Iw           = 7                       ;
parameter NEXT_Bi           = 4                       ;
parameter NEXT_CKK          = NEXT_C*K*K              ;
parameter HOUT=ceil(REAL_HOUT,NEXT_Iw);  // hout is not divisible , need adding 0  // must use real'  ,or that int'/int'=int', ceil is useless
parameter HINT=ceil(REAL_HINT,LAST_Iw);
parameter BUffER_RAM_COUNT=ceil(REAL_HINT,LAST_Iw)/LAST_Iw;

parameter LAST_N_UP= ceil(LAST_N,LAST_Wh);
parameter NEXT_N_UP= ceil(LAST_N,NEXT_Wh);

parameter FM_IN_ADDRESS=(LAST_N_UP*HINT)/(LAST_Wh*LAST_Iw);
parameter LAST_N_K_K_UP=ceil(LAST_N*K*K,LAST_Ww);




parameter ADDR_WIDTH        = 32                      ;
parameter RCC_WIDTH         = 10+10+10                ;
parameter ROW_WIDTH         = 10                      ;

   logic clk=0;
   logic rstn=0;
  
    // interface with pe_datain 
   logic [HOUT-1:0][DATA_WIDTH-1:0]pe_ctrl_data;
   logic  [2:0][ROW_WIDTH-1:0]R_C_Channel;
   logic row_buffer_data_valid;
   logic  pe_ctrl_ready;
   logic  pe_buffer_switch;
  
  
   logic [LAST_Wh-1:0]pe2row_fifo_array1_rden; 
   logic pe2row_ready;                                    
   logic [LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0]fifo_array1_dataout;             
   logic pe2row_data_valid; 
   
row_buffer_top#(
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
    row_buffer_top_tb_u(.*);
   logic [LAST_Wh-1:0]fin_fifo_wren;
   logic [LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0]fin_fifo_din;
   logic [LAST_Wh-1:0]fin_fifo_full;   
   logic [LAST_Wh-1:0]prog_empty; 
   assign pe2row_data_valid=~(|prog_empty);
   
 genvar n,m;  
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
   
  bit [REAL_HINT*FM_IN_ADDRESS-1:0][LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] fin_data; 
  bit [REAL_HINT-1:0][LAST_N-1:0][HOUT-1:0][DATA_WIDTH-1:0]pe_ctrl_data_mem;
  bit [REAL_HINT-1:0][LAST_N_UP-1:0][HINT-1:0][DATA_WIDTH-1:0] fm_in_reshape0;
  integer fin_addr;
 
 integer fid_fm_in_reshape1;
 initial 
 begin 
 	   // get data from bin 
 	   fid_fm_in_reshape1 = $fopen("C:/Users/HT/Desktop/code/row_buffer/data_generate/fm_in_reshape1.bin","rb");
	   read_fm_in_reshape1(1,fid_fm_in_reshape1,fin_data);
 	   // push to fifo 
 	   #(10*PERIOD) ;
 	   fin_addr=0;
 	    forever push_2_fifo;
 	    	
 end 
  
  
  
    
 task read_fm_in_reshape1;
	input integer which_batch;
	input  integer fid;
	output [REAL_HINT-1:0][FM_IN_ADDRESS-1:0][LAST_Wh-1:0][LAST_Iw-1:0][7:0] fm;
	integer n=BATCH;
	for(n=BATCH;n>=which_batch;n=n-1)
		$fread(fm, fid);
	$fclose(fid);
endtask
 
initial 
begin 
	pe_ctrl_ready=0;
	pe_buffer_switch=0;
	R_C_Channel=0;
	forever pe_addr_data;
end 
 
 task push_2_fifo ;
 	@(negedge clk )
 	  	if((|fin_fifo_full)==0 && fin_addr<=1099)
 	  		begin 
 	  		fin_fifo_wren='1;
 	  		fin_fifo_din=fin_data[fin_addr];
 	  		fin_addr=fin_addr+1; 	  		
 	  	end 
 	    else 
 	    	begin 
 	    		fin_fifo_wren=0;
 	  		  fin_fifo_din=0;
 	  		  fin_addr=fin_addr;
 	  		end 

endtask
 	  		
 	  		
 	  	  
 
      
initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
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
task pe_addr_data;
integer k,f;
begin 
	wait(row_buffer_data_valid==1);	
	
		 #(PERIOD/2);
		 pe_ctrl_ready=1;
		 for(k=0;k<3;k=k+1)
		 	for(f=0;f<LAST_N;f=f+1)   // 这里注意N没去上届， 虚拟数据不考虑补0，会输入非0数据，实际数据由于补0操作，会输入0。
		 	begin
		 		#(PERIOD); 
		 		R_C_Channel[0]=k;
		 		R_C_Channel[1]=1;
		 		R_C_Channel[2]=f;
		  end 
		  #(PERIOD*2);
		  pe_buffer_switch=1;
		  #(PERIOD)          
		  pe_buffer_switch=0;
		  pe_ctrl_ready=0;
		  #(10*PERIOD)
		 pe_ctrl_ready=1;
	
		
end 
endtask

endmodule
