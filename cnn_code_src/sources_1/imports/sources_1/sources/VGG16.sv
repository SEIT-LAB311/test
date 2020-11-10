`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/07 13:23:32
// Design Name: 
// Module Name: vgg16
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


module VGG16#(
	parameter AF=3,
  parameter BATCH=9,
  parameter FOUT1=4096,
	parameter FOUT2=4096,
	parameter FOUT3=1000,
  parameter FIN1=8379,          // 注意，这里的FOUT不能整除AF     
  parameter FIN2=1366,        // 如FOUT1，在fin2中会被补全，计算的数据会多出几个
  parameter FIN3=1366,       // 所以weight也要做类似的处理，最后AF组数据用0补全
  parameter FIN4=1002 ,      // 这样，就算计算数据多几个，因为weight=0，不影响结果
	parameter WEIGHT_WIDTH=8,
	parameter DATA_WIDTH=8,
	parameter PRECISION=4,  // 1+3+4,  4 decimal
	parameter ADDR_WIDTH=32,
	
	parameter REAL_HINT=14,       // 被 ctrl 连接时注意 大小
	parameter REAL_HOUT=7,	  
	
	parameter K=3,
	parameter S=1,
	
	//last conv configuration
	parameter LAST_PK=2,

	parameter LAST_N=516,
	parameter LAST_Wh=6,
	parameter LAST_Ww=17,
	parameter LAST_Ih=17,
	parameter LAST_Iw=1,
	parameter LAST_Bi=1

  
)(
   input  logic  clk,
   input logic rstn,

	// interface FC to Result output 
   output logic [AF-1:0][DATA_WIDTH-1:0] result_data[BATCH],
   input logic [ADDR_WIDTH-1:0] result_rd_ADDR, // 0- $ceil(real(FOUT3)/AF)-1
   output logic result_valid,
   input logic result_ready,


  //fc_weight_in
   input logic weight_fifo_wren,
   input logic [AF-1:0][DATA_WIDTH-1:0] weight_fifo_din,
   output logic weight_fifo_full,


   conv_top.row_buffer_in conv_data_in,                                               
   input logic [127:0] fifo_in,             
   input logic fifo_wren                   

    );
 import parameter_package::*;
 logic [LAST_Wh-1:0]pe2row_fifo_array1_rden;                     
 logic pe2row_ready;                                              
 logic [LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0]fifo_array1_dataout; 
 logic pe2row_data_valid;
    
 logic clkin; 
 clk_wiz_0 u_clk1 
 (
 .clkin(clk),
 .resetn(rstn),
 .clk_out1(clkin)
 ); 
  
   conv_top #      
   (               
   .Wh(CONV_Wh[TEST_LAYER_COUNT]),
   .Iw(CONV_Iw[TEST_LAYER_COUNT]),
   .Ww(CONV_Ww[TEST_LAYER_COUNT]) 
   )               
    conv_result_out_t (      
                     );  
                     
  assign conv_result_out_t.pe2row_fifo_array1_rden =  pe2row_fifo_array1_rden ;
  assign conv_result_out_t.pe2row_ready            =  pe2row_ready ;
  assign fifo_array1_dataout                     =  conv_result_out_t.fifo_array1_dataout;
  assign pe2row_data_valid                       =  conv_result_out_t.pe2row_data_valid;
  
   
  
  vgg16_fc_top  u_fc (.*);  
  VGG_CONV_SYN  u_conv(.conv_result_out(conv_result_out_t.pe_out),   // 需要把clk ip 去掉
  										 .*				);
  
  
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
