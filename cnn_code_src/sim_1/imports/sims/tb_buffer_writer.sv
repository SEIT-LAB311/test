`timescale  1ns / 1ps

module tb_row_buffer_writer;

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
parameter ADDR_WIDTH        = 32                      ;
parameter RCC_WIDTH         = 10+10+10                ;
parameter ROW_WIDTH         = 10                      ;

// row_buffer_writer Inputs
  logic clk                            = 0 ;
  logic rstn                           = 0 ;
  logic buffer_writer_en               = 0 ;
  logic [LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0]fifo_array1_dataout ;
  logic pe2row_data_valid              = 0 ;

// row_buffer_writer Outputs
 logic  buffer_writer_ram_wren[BUffER_RAM_COUNT] ;
 logic  [ADDR_WIDTH-1:0] buffer_writer_ram_wr_addr[BUffER_RAM_COUNT] ;
 logic  [LAST_Iw-1:0][DATA_WIDTH-1:0] buffer_writer_ram_wr_data[BUffER_RAM_COUNT] ;
 logic buffer_writer_done             ;
 logic [LAST_Wh-1:0]pe2row_fifo_array1_rden ;
 logic pe2row_ready                   ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

    


initial
begin 
 fifo_array_init;
 repeat(10)
 begin 
 	#(10*PERIOD) pe2row_data_valid=1;
 	buffer_writer_en=1;
 	#(PERIOD)
 	buffer_writer_en=0;
 	#(10*PERIOD)
 	wait(pe2row_ready==0);
 		pe2row_data_valid=0;
  end 
 	  
end  	
 	
initial 
begin 
	forever fifo_array;
end 	
 	
integer i,j;
integer temp[LAST_Wh];
		task fifo_array_init;
			begin 
				foreach(fifo_array1_dataout[i,j])
				 fifo_array1_dataout[i][j]=0;
				foreach(temp[i])
				 temp[i]=0;
			end 
	  endtask
		
		task fifo_array;
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
		

row_buffer_writer #(
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
 u_row_buffer_writer (
    .*);
endmodule