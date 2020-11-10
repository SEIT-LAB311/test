`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/18 17:35:46
// Design Name: 
// Module Name: conv
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


module conv_pooling#(
  parameter DATA_WIDTH=8,
	parameter REAL_HINT=56, 
	parameter REAL_HOUT=28,	
	parameter PRECISION=4,  
	
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
	
	
	localparam HOUT=ceil(REAL_HOUT,NEXT_Iw),  // hout is not divisible , need adding 0  // must use real'  ,or that int'/int'=int', ceil is useless
	localparam HINT=ceil(REAL_HINT,LAST_Iw),
  localparam BUffER_RAM_COUNT=HINT/LAST_Iw,
	parameter ADDR_WIDTH=32,
	parameter RCC_WIDTH=10+10+10,   // row , col , channel 
  parameter ROW_WIDTH=10
)
(
   conv_top.pe_out pe_data_out,
   conv_top.row_buffer_in row_data_in,
   conv_top.pe_weight_in pe_weight_data_in,
   input logic clk , 
   input logic rstn  
   
    );
  
   logic [HOUT-1:0][DATA_WIDTH-1:0]pe_ctrl_data;
   logic  [2:0][ROW_WIDTH-1:0]R_C_Channel;
   logic row_buffer_data_valid;
   logic  pe_ctrl_ready;
   logic  pe_buffer_switch;
  
  
   
  
   row_buffer_top_pooling#(
    .DATA_WIDTH       ( DATA_WIDTH       ),
    .REAL_HINT        ( REAL_HOUT        ),  //*****内部自己 *2 
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
    row_buffer_top_u(
    .*,
    .clk (clk),
    .rstn(rstn),
    
    .pe2row_fifo_array1_rden(row_data_in.pe2row_fifo_array1_rden),
    .pe2row_ready(row_data_in.pe2row_ready),
    .fifo_array1_dataout(row_data_in.fifo_array1_dataout),
    .pe2row_data_valid(row_data_in.pe2row_data_valid)
    );
    
    pe_datain_and_buffer_ctrl #(
    .DATA_WIDTH    ( DATA_WIDTH    ),
    .REAL_HOUT     ( REAL_HOUT     ),
    .K             ( K             ),
    .C             ( NEXT_C        ),
    .N             ( NEXT_N        ),
    .S             ( S             ),
    .Wh            ( NEXT_Wh       ),
    .Ww            ( NEXT_Ww       ),
    .Ih            ( NEXT_Ih       ),
    .Iw            ( NEXT_Iw       ),
    .Bi            ( NEXT_Bi       ),
    .PRECISION     ( PRECISION     ),
    .ROW_WIDTH     ( ROW_WIDTH     ))
    pe_top_u
    (
    
    .clk (clk),
    .rstn(rstn),
    
    .pe2row_fifo_array1_rden(pe_data_out.pe2row_fifo_array1_rden),
    .pe2row_ready(pe_data_out.pe2row_ready),
    .fifo_array1_dataout(pe_data_out.fifo_array1_dataout),
    .pe2row_data_valid(pe_data_out.pe2row_data_valid),
    
    .weight_buffer_din(pe_weight_data_in.weight_buffer_din),
    .weight_buffer_full(pe_weight_data_in.weight_buffer_full),
    .weight_buffer_wren(pe_weight_data_in.weight_buffer_wren),
    
    .data_in(pe_ctrl_data),
    .row_valid(row_buffer_data_valid),
    .R_C_Channel(R_C_Channel),
    .row_ready(pe_ctrl_ready),
    .row_RAM_switch(pe_buffer_switch)
    
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
