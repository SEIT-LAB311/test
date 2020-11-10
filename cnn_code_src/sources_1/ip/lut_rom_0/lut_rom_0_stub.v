// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
// Date        : Wed Nov  4 20:06:24 2020
// Host        : luoconghui-System-Product-Name running 64-bit Ubuntu 18.04.2 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/luoconghui/work/cnn_code_replant/cnn_code_replant.srcs/sources_1/ip/lut_rom_0/lut_rom_0_stub.v
// Design      : lut_rom_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx485tffg1157-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2020.1" *)
module lut_rom_0(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[12:0],spo[15:0]" */;
  input [12:0]a;
  output [15:0]spo;
endmodule
