`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/18 14:37:27
// Design Name: 
// Module Name: user_lut
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


module user_lut
#(
parameter Ih,
parameter CKK
)
(
input logic  [31:0] group,
input logic  [31:0] row, 
output logic [15:0] dout
    );
  logic [15:0]spo;
  
  logic [31:0]addr;
  
  assign addr=group*Ih+row;
  always_comb
  begin 
  	if(addr>=CKK)
  		dout=3;
  	else 
  		dout=spo;
  end 
  
 
 lut_rom_0 lut_rom_u
 (
 .a(addr),
 .spo(spo)
 ) ;
endmodule
