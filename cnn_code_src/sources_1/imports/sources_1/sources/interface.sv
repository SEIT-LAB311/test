`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/18 17:48:18
// Design Name: 
// Module Name: interface
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


interface conv_top #(
  parameter DATA_WIDTH=8,
	//last conv configuration
	parameter Wh=2,
	parameter Iw=7,
	parameter Ww=29
)

();
	 
   logic [Wh-1:0]pe2row_fifo_array1_rden; 
   logic pe2row_ready;                                    
   logic [Wh-1:0][Iw-1:0][DATA_WIDTH-1:0]fifo_array1_dataout;             
   logic pe2row_data_valid; 
   
   
  (* max_fanout =50 *) logic [Wh-1:0][Ww-1:0][DATA_WIDTH-1:0] weight_buffer_din;  
   logic weight_buffer_full;                     
  (* max_fanout =50 *) logic weight_buffer_wren;    
   
   modport pe_weight_in(
   input weight_buffer_din,weight_buffer_wren,
   output weight_buffer_full
   );
   
   
//   modport pe_weight_out(
//   output  weight_buffer,weight_buffer_valid,
//   input  weight_buffer_rden
//   );
   
   modport pe_out (
   input pe2row_fifo_array1_rden,
   input pe2row_ready,
   output fifo_array1_dataout,
   output pe2row_data_valid  

     
   );
   modport row_buffer_in
   (
   output pe2row_fifo_array1_rden,
   output pe2row_ready,
   input fifo_array1_dataout,
   input pe2row_data_valid
   );
endinterface  




