
`timescale 1ns/1ps

module tb_u();
	reg clk;
	reg rst;
	reg  [31:0] data_in;
	reg scram_en;
	reg  scram_rst;
	wire [31:0] data_out;
	wire [31:0] data_c;
	always #5 clk = ~clk;
	initial begin
		clk = 1;
		rst = 1;
		scram_rst = 1;
		scram_en = 0;
		#10
		rst = 0;
		scram_en = 1;
		scram_rst = 0;
		data_in = 32'h00000000;
		
		#10
		data_in = 32'h11111111;
		
		#10
		data_in = 32'h22222222;
		
		#10
		data_in = 32'h33333333;
		
		#10
		data_in = 32'h44444444;
		
		
		#10
		rst = 1;
		scram_rst = 1;
		scram_en = 0;
		
		#10
		rst = 0;
		scram_rst = 0;
		scram_en = 1;
		data_in = 32'h1f26b368;
		#10
		data_in = 32'hb419527d;
		#10
		data_in = 32'h1670f176;
		#10
		data_in = 32'hb966a631;
		#10
		data_in = 32'hff5efa5f;
		
		#10
		rst = 1;
		scram_rst = 1;
		scram_en = 0;
		
	end
	
	
	
	scrambler u_scrambler (
		.clk      (clk),
		.data_c   (data_c),
		.data_in  (data_in),
		.data_out (data_out),
		.rst      (rst),
		.scram_en (scram_en),
		.scram_rst(scram_rst)
	);// 注释
endmodule