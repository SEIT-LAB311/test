`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*

conv 单层 top
1. 实例化 row_buffer_top ：赋值上层结果读取，和row buffer 存储和切换，并提供接口访问。
2. 实例化 pe 及外围部件： 包含pe data 数据寻址和读取，pe weight 准备， pe array 计算和 pe out 缓存。

*/
//////////////////////////////////////////////////////////////////////////////////


module conv#(
  parameter DATA_WIDTH=8,
	parameter REAL_HINT=56, // when pooling ,let real_hint=real_hout
	parameter REAL_HOUT=56,	  
	
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
	parameter ADDR_WIDTH=32,
	parameter ROW_WIDTH=10,
	parameter RCC_WIDTH=3*ROW_WIDTH,   // row , col , channel 
	parameter PRECISION=4
  
)
(
   conv_top.pe_out pe_data_out,            // 单层结果输出总线
   conv_top.row_buffer_in row_data_in,     // 单层数据输入
   conv_top.pe_weight_in pe_weight_data_in,// 单层权重输入
   input logic clk ,
   input logic rstn
  
    );
  
   logic [HOUT-1:0][DATA_WIDTH-1:0]pe_ctrl_data;
   logic  [2:0][ROW_WIDTH-1:0]R_C_Channel;
   logic row_buffer_data_valid;
   logic  pe_ctrl_ready;
   logic  pe_buffer_switch;
  
  
   
 //1. 实例化 row_buffer_top ：赋值上层结果读取，和row buffer 存储和切换，并提供接口访问。 
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
    u_row_buffer_top(
    .*,
    .clk (clk),
    .rstn(rstn),
    
    .pe2row_fifo_array1_rden(row_data_in.pe2row_fifo_array1_rden),
    .pe2row_ready(row_data_in.pe2row_ready),
    .fifo_array1_dataout(row_data_in.fifo_array1_dataout),
    .pe2row_data_valid(row_data_in.pe2row_data_valid)
    );
 //2. 实例化 pe 及外围部件： 包含pe data 数据寻址和读取，pe weight 准备， pe array 计算和 pe out 缓存。   
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
    u_pe_top
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
