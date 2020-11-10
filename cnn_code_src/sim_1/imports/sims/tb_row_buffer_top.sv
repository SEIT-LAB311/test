`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/12 14:01:25
// Design Name: 
// Module Name: tb_row_buffer_top
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


module tb_row_buffer_top(

    );


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
parameter NEXT_C            = 256                     ;
parameter NEXT_N            = 256                     ;
parameter NEXT_Wh           = 2                       ;
parameter NEXT_Ww           = 29                      ;
parameter NEXT_Ih           = 29                      ;
parameter NEXT_Iw           = 7                       ;
parameter NEXT_Bi           = 4                       ;
parameter NEXT_CKK          = NEXT_C*K*K              ;
parameter HOUT=int'($ceil(real'(REAL_HOUT)/NEXT_Iw)*NEXT_Iw);  // hout is not divisible , need adding 0  // must use real'  ,or that int'/int'=int', ceil is useless
parameter HINT=int'($ceil(real'(REAL_HINT)/LAST_Iw)*LAST_Iw);
parameter BUffER_RAM_COUNT=int'($ceil(real'(REAL_HINT)/LAST_Iw));

parameter LAST_N_UP         =  0;   


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

initial
begin 
 
 repeat(100)
 begin 
 	#(10*PERIOD) pe2row_data_valid=1;
 	#(PERIOD)
 	wait(pe2row_ready==1);
 	#(PERIOD)
 	wait(pe2row_ready==0);
 		pe2row_data_valid=0;
  end 
 	  
end  	
 	
initial 
begin 
	fifo_array_init;
	forever fifo_array;
end 	

initial 
begin 
	pe_ctrl_ready=0;
	pe_buffer_switch=0;
	R_C_Channel=0;
	forever pe_addr_data;
end 
 	

integer temp[LAST_Wh];


		task fifo_array_init;
		integer i,j;
			begin 
				foreach(fifo_array1_dataout[i,j])
				 fifo_array1_dataout[i][j]=0;
				foreach(temp[i])
				 temp[i]=0;
			end 
	  endtask
		
	task fifo_array;
	integer i,j;
				begin 
					
					
					@(negedge clk )
					
						for(i=0;i<LAST_Wh;i=i+1)
						  for(j=0;j<LAST_Iw;j=j+1)
							if(pe2row_fifo_array1_rden[i]==1)
							begin 
								fifo_array1_dataout[i][j]=j+temp[i];
								temp[i]=temp[i]+1;
							end 
						  else 
						  	fifo_array1_dataout[i][j]=0;
				end 
	endtask
	
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
		 		R_C_Channel[1]=0;
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


   
initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

//logic [2:0][3:0][4:0][5:0][7:0] a;
//logic [255:0][55:0][55:0][7:0] b;
//logic [7:0]c[3][4][5][6];
//reg [7:0]d[360];
// integer handle1,mm;
//initial 
//begin 
// //handle1=$fopen("C:/Users/HT/Desktop/code/row_buffer/data_generate/test.txt");
// //$readmemb("C:/Users/HT/Desktop/code/row_buffer/data_generate/test.dat",d);
// handle1=$fopen("C:/Users/HT/Desktop/code/row_buffer/data_generate/test.dat","rb");     
// 
// 	$fread(b,handle1);
//
// $fclose(handle1);
// end    






endmodule
