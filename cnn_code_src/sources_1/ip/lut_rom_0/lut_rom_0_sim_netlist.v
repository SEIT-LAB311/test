// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
// Date        : Wed Nov  4 20:06:24 2020
// Host        : luoconghui-System-Product-Name running 64-bit Ubuntu 18.04.2 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/luoconghui/work/cnn_code_replant/cnn_code_replant.srcs/sources_1/ip/lut_rom_0/lut_rom_0_sim_netlist.v
// Design      : lut_rom_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx485tffg1157-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "lut_rom_0,dist_mem_gen_v8_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module lut_rom_0
   (a,
    spo);
  input [12:0]a;
  output [15:0]spo;

  wire [12:0]a;
  wire [15:0]spo;
  wire [15:0]NLW_U0_dpo_UNCONNECTED;
  wire [15:0]NLW_U0_qdpo_UNCONNECTED;
  wire [15:0]NLW_U0_qspo_UNCONNECTED;

  (* C_FAMILY = "virtex7" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_DPO = "0" *) 
  (* C_HAS_DPRA = "0" *) 
  (* C_HAS_I_CE = "0" *) 
  (* C_HAS_QDPO = "0" *) 
  (* C_HAS_QDPO_CE = "0" *) 
  (* C_HAS_QDPO_CLK = "0" *) 
  (* C_HAS_QDPO_RST = "0" *) 
  (* C_HAS_QDPO_SRST = "0" *) 
  (* C_HAS_WE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_PIPELINE_STAGES = "0" *) 
  (* C_QCE_JOINED = "0" *) 
  (* C_QUALIFY_WE = "0" *) 
  (* C_REG_DPRA_INPUT = "0" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* c_addr_width = "13" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "4800" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_clk = "0" *) 
  (* c_has_qspo = "0" *) 
  (* c_has_qspo_ce = "0" *) 
  (* c_has_qspo_rst = "0" *) 
  (* c_has_qspo_srst = "0" *) 
  (* c_has_spo = "1" *) 
  (* c_mem_init_file = "lut_rom_0.mif" *) 
  (* c_parser_type = "1" *) 
  (* c_read_mif = "1" *) 
  (* c_reg_a_d_inputs = "0" *) 
  (* c_sync_enable = "1" *) 
  (* c_width = "16" *) 
  lut_rom_0_dist_mem_gen_v8_0_13 U0
       (.a(a),
        .clk(1'b0),
        .d({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dpo(NLW_U0_dpo_UNCONNECTED[15:0]),
        .dpra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .i_ce(1'b1),
        .qdpo(NLW_U0_qdpo_UNCONNECTED[15:0]),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(NLW_U0_qspo_UNCONNECTED[15:0]),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo(spo),
        .we(1'b0));
endmodule

(* C_ADDR_WIDTH = "13" *) (* C_DEFAULT_DATA = "0" *) (* C_DEPTH = "4800" *) 
(* C_ELABORATION_DIR = "./" *) (* C_FAMILY = "virtex7" *) (* C_HAS_CLK = "0" *) 
(* C_HAS_D = "0" *) (* C_HAS_DPO = "0" *) (* C_HAS_DPRA = "0" *) 
(* C_HAS_I_CE = "0" *) (* C_HAS_QDPO = "0" *) (* C_HAS_QDPO_CE = "0" *) 
(* C_HAS_QDPO_CLK = "0" *) (* C_HAS_QDPO_RST = "0" *) (* C_HAS_QDPO_SRST = "0" *) 
(* C_HAS_QSPO = "0" *) (* C_HAS_QSPO_CE = "0" *) (* C_HAS_QSPO_RST = "0" *) 
(* C_HAS_QSPO_SRST = "0" *) (* C_HAS_SPO = "1" *) (* C_HAS_WE = "0" *) 
(* C_MEM_INIT_FILE = "lut_rom_0.mif" *) (* C_MEM_TYPE = "0" *) (* C_PARSER_TYPE = "1" *) 
(* C_PIPELINE_STAGES = "0" *) (* C_QCE_JOINED = "0" *) (* C_QUALIFY_WE = "0" *) 
(* C_READ_MIF = "1" *) (* C_REG_A_D_INPUTS = "0" *) (* C_REG_DPRA_INPUT = "0" *) 
(* C_SYNC_ENABLE = "1" *) (* C_WIDTH = "16" *) (* ORIG_REF_NAME = "dist_mem_gen_v8_0_13" *) 
module lut_rom_0_dist_mem_gen_v8_0_13
   (a,
    d,
    dpra,
    clk,
    we,
    i_ce,
    qspo_ce,
    qdpo_ce,
    qdpo_clk,
    qspo_rst,
    qdpo_rst,
    qspo_srst,
    qdpo_srst,
    spo,
    dpo,
    qspo,
    qdpo);
  input [12:0]a;
  input [15:0]d;
  input [12:0]dpra;
  input clk;
  input we;
  input i_ce;
  input qspo_ce;
  input qdpo_ce;
  input qdpo_clk;
  input qspo_rst;
  input qdpo_rst;
  input qspo_srst;
  input qdpo_srst;
  output [15:0]spo;
  output [15:0]dpo;
  output [15:0]qspo;
  output [15:0]qdpo;

  wire \<const0> ;
  wire [12:0]a;
  wire [13:0]\^spo ;

  assign dpo[15] = \<const0> ;
  assign dpo[14] = \<const0> ;
  assign dpo[13] = \<const0> ;
  assign dpo[12] = \<const0> ;
  assign dpo[11] = \<const0> ;
  assign dpo[10] = \<const0> ;
  assign dpo[9] = \<const0> ;
  assign dpo[8] = \<const0> ;
  assign dpo[7] = \<const0> ;
  assign dpo[6] = \<const0> ;
  assign dpo[5] = \<const0> ;
  assign dpo[4] = \<const0> ;
  assign dpo[3] = \<const0> ;
  assign dpo[2] = \<const0> ;
  assign dpo[1] = \<const0> ;
  assign dpo[0] = \<const0> ;
  assign qdpo[15] = \<const0> ;
  assign qdpo[14] = \<const0> ;
  assign qdpo[13] = \<const0> ;
  assign qdpo[12] = \<const0> ;
  assign qdpo[11] = \<const0> ;
  assign qdpo[10] = \<const0> ;
  assign qdpo[9] = \<const0> ;
  assign qdpo[8] = \<const0> ;
  assign qdpo[7] = \<const0> ;
  assign qdpo[6] = \<const0> ;
  assign qdpo[5] = \<const0> ;
  assign qdpo[4] = \<const0> ;
  assign qdpo[3] = \<const0> ;
  assign qdpo[2] = \<const0> ;
  assign qdpo[1] = \<const0> ;
  assign qdpo[0] = \<const0> ;
  assign qspo[15] = \<const0> ;
  assign qspo[14] = \<const0> ;
  assign qspo[13] = \<const0> ;
  assign qspo[12] = \<const0> ;
  assign qspo[11] = \<const0> ;
  assign qspo[10] = \<const0> ;
  assign qspo[9] = \<const0> ;
  assign qspo[8] = \<const0> ;
  assign qspo[7] = \<const0> ;
  assign qspo[6] = \<const0> ;
  assign qspo[5] = \<const0> ;
  assign qspo[4] = \<const0> ;
  assign qspo[3] = \<const0> ;
  assign qspo[2] = \<const0> ;
  assign qspo[1] = \<const0> ;
  assign qspo[0] = \<const0> ;
  assign spo[15] = \<const0> ;
  assign spo[14] = \<const0> ;
  assign spo[13:3] = \^spo [13:3];
  assign spo[2] = \<const0> ;
  assign spo[1:0] = \^spo [1:0];
  GND GND
       (.G(\<const0> ));
  lut_rom_0_dist_mem_gen_v8_0_13_synth \synth_options.dist_mem_inst 
       (.a(a),
        .spo({\^spo [13:3],\^spo [1:0]}));
endmodule

(* ORIG_REF_NAME = "dist_mem_gen_v8_0_13_synth" *) 
module lut_rom_0_dist_mem_gen_v8_0_13_synth
   (spo,
    a);
  output [12:0]spo;
  input [12:0]a;

  wire [12:0]a;
  wire [12:0]spo;

  lut_rom_0_rom \gen_rom.rom_inst 
       (.a(a),
        .spo(spo));
endmodule

(* ORIG_REF_NAME = "rom" *) 
module lut_rom_0_rom
   (spo,
    a);
  output [12:0]spo;
  input [12:0]a;

  wire [12:0]a;
  wire [12:0]spo;
  wire \spo[0]_INST_0_i_1_n_0 ;
  wire \spo[0]_INST_0_i_2_n_0 ;
  wire \spo[0]_INST_0_i_3_n_0 ;
  wire \spo[10]_INST_0_i_1_n_0 ;
  wire \spo[10]_INST_0_i_2_n_0 ;
  wire \spo[10]_INST_0_i_3_n_0 ;
  wire \spo[10]_INST_0_i_4_n_0 ;
  wire \spo[11]_INST_0_i_1_n_0 ;
  wire \spo[11]_INST_0_i_2_n_0 ;
  wire \spo[1]_INST_0_i_10_n_0 ;
  wire \spo[1]_INST_0_i_11_n_0 ;
  wire \spo[1]_INST_0_i_12_n_0 ;
  wire \spo[1]_INST_0_i_13_n_0 ;
  wire \spo[1]_INST_0_i_14_n_0 ;
  wire \spo[1]_INST_0_i_15_n_0 ;
  wire \spo[1]_INST_0_i_16_n_0 ;
  wire \spo[1]_INST_0_i_17_n_0 ;
  wire \spo[1]_INST_0_i_18_n_0 ;
  wire \spo[1]_INST_0_i_19_n_0 ;
  wire \spo[1]_INST_0_i_1_n_0 ;
  wire \spo[1]_INST_0_i_20_n_0 ;
  wire \spo[1]_INST_0_i_21_n_0 ;
  wire \spo[1]_INST_0_i_22_n_0 ;
  wire \spo[1]_INST_0_i_23_n_0 ;
  wire \spo[1]_INST_0_i_24_n_0 ;
  wire \spo[1]_INST_0_i_25_n_0 ;
  wire \spo[1]_INST_0_i_26_n_0 ;
  wire \spo[1]_INST_0_i_27_n_0 ;
  wire \spo[1]_INST_0_i_28_n_0 ;
  wire \spo[1]_INST_0_i_29_n_0 ;
  wire \spo[1]_INST_0_i_2_n_0 ;
  wire \spo[1]_INST_0_i_30_n_0 ;
  wire \spo[1]_INST_0_i_31_n_0 ;
  wire \spo[1]_INST_0_i_32_n_0 ;
  wire \spo[1]_INST_0_i_33_n_0 ;
  wire \spo[1]_INST_0_i_34_n_0 ;
  wire \spo[1]_INST_0_i_35_n_0 ;
  wire \spo[1]_INST_0_i_36_n_0 ;
  wire \spo[1]_INST_0_i_37_n_0 ;
  wire \spo[1]_INST_0_i_38_n_0 ;
  wire \spo[1]_INST_0_i_39_n_0 ;
  wire \spo[1]_INST_0_i_3_n_0 ;
  wire \spo[1]_INST_0_i_40_n_0 ;
  wire \spo[1]_INST_0_i_41_n_0 ;
  wire \spo[1]_INST_0_i_42_n_0 ;
  wire \spo[1]_INST_0_i_43_n_0 ;
  wire \spo[1]_INST_0_i_44_n_0 ;
  wire \spo[1]_INST_0_i_45_n_0 ;
  wire \spo[1]_INST_0_i_46_n_0 ;
  wire \spo[1]_INST_0_i_47_n_0 ;
  wire \spo[1]_INST_0_i_48_n_0 ;
  wire \spo[1]_INST_0_i_4_n_0 ;
  wire \spo[1]_INST_0_i_5_n_0 ;
  wire \spo[1]_INST_0_i_6_n_0 ;
  wire \spo[1]_INST_0_i_7_n_0 ;
  wire \spo[1]_INST_0_i_8_n_0 ;
  wire \spo[1]_INST_0_i_9_n_0 ;
  wire \spo[4]_INST_0_i_1_n_0 ;
  wire \spo[4]_INST_0_i_2_n_0 ;
  wire \spo[4]_INST_0_i_3_n_0 ;
  wire \spo[4]_INST_0_i_4_n_0 ;
  wire \spo[4]_INST_0_i_5_n_0 ;
  wire \spo[4]_INST_0_i_6_n_0 ;
  wire \spo[4]_INST_0_i_7_n_0 ;
  wire \spo[4]_INST_0_i_8_n_0 ;
  wire \spo[4]_INST_0_i_9_n_0 ;
  wire \spo[5]_INST_0_i_10_n_0 ;
  wire \spo[5]_INST_0_i_11_n_0 ;
  wire \spo[5]_INST_0_i_12_n_0 ;
  wire \spo[5]_INST_0_i_13_n_0 ;
  wire \spo[5]_INST_0_i_14_n_0 ;
  wire \spo[5]_INST_0_i_15_n_0 ;
  wire \spo[5]_INST_0_i_16_n_0 ;
  wire \spo[5]_INST_0_i_17_n_0 ;
  wire \spo[5]_INST_0_i_18_n_0 ;
  wire \spo[5]_INST_0_i_19_n_0 ;
  wire \spo[5]_INST_0_i_1_n_0 ;
  wire \spo[5]_INST_0_i_20_n_0 ;
  wire \spo[5]_INST_0_i_21_n_0 ;
  wire \spo[5]_INST_0_i_22_n_0 ;
  wire \spo[5]_INST_0_i_23_n_0 ;
  wire \spo[5]_INST_0_i_24_n_0 ;
  wire \spo[5]_INST_0_i_25_n_0 ;
  wire \spo[5]_INST_0_i_26_n_0 ;
  wire \spo[5]_INST_0_i_27_n_0 ;
  wire \spo[5]_INST_0_i_28_n_0 ;
  wire \spo[5]_INST_0_i_29_n_0 ;
  wire \spo[5]_INST_0_i_2_n_0 ;
  wire \spo[5]_INST_0_i_3_n_0 ;
  wire \spo[5]_INST_0_i_4_n_0 ;
  wire \spo[5]_INST_0_i_5_n_0 ;
  wire \spo[5]_INST_0_i_6_n_0 ;
  wire \spo[5]_INST_0_i_7_n_0 ;
  wire \spo[5]_INST_0_i_8_n_0 ;
  wire \spo[5]_INST_0_i_9_n_0 ;
  wire \spo[6]_INST_0_i_10_n_0 ;
  wire \spo[6]_INST_0_i_11_n_0 ;
  wire \spo[6]_INST_0_i_12_n_0 ;
  wire \spo[6]_INST_0_i_13_n_0 ;
  wire \spo[6]_INST_0_i_14_n_0 ;
  wire \spo[6]_INST_0_i_15_n_0 ;
  wire \spo[6]_INST_0_i_16_n_0 ;
  wire \spo[6]_INST_0_i_17_n_0 ;
  wire \spo[6]_INST_0_i_18_n_0 ;
  wire \spo[6]_INST_0_i_19_n_0 ;
  wire \spo[6]_INST_0_i_1_n_0 ;
  wire \spo[6]_INST_0_i_20_n_0 ;
  wire \spo[6]_INST_0_i_21_n_0 ;
  wire \spo[6]_INST_0_i_22_n_0 ;
  wire \spo[6]_INST_0_i_23_n_0 ;
  wire \spo[6]_INST_0_i_24_n_0 ;
  wire \spo[6]_INST_0_i_25_n_0 ;
  wire \spo[6]_INST_0_i_26_n_0 ;
  wire \spo[6]_INST_0_i_2_n_0 ;
  wire \spo[6]_INST_0_i_3_n_0 ;
  wire \spo[6]_INST_0_i_4_n_0 ;
  wire \spo[6]_INST_0_i_5_n_0 ;
  wire \spo[6]_INST_0_i_6_n_0 ;
  wire \spo[6]_INST_0_i_7_n_0 ;
  wire \spo[6]_INST_0_i_8_n_0 ;
  wire \spo[6]_INST_0_i_9_n_0 ;
  wire \spo[7]_INST_0_i_10_n_0 ;
  wire \spo[7]_INST_0_i_11_n_0 ;
  wire \spo[7]_INST_0_i_12_n_0 ;
  wire \spo[7]_INST_0_i_13_n_0 ;
  wire \spo[7]_INST_0_i_14_n_0 ;
  wire \spo[7]_INST_0_i_15_n_0 ;
  wire \spo[7]_INST_0_i_16_n_0 ;
  wire \spo[7]_INST_0_i_17_n_0 ;
  wire \spo[7]_INST_0_i_18_n_0 ;
  wire \spo[7]_INST_0_i_19_n_0 ;
  wire \spo[7]_INST_0_i_1_n_0 ;
  wire \spo[7]_INST_0_i_20_n_0 ;
  wire \spo[7]_INST_0_i_21_n_0 ;
  wire \spo[7]_INST_0_i_22_n_0 ;
  wire \spo[7]_INST_0_i_2_n_0 ;
  wire \spo[7]_INST_0_i_3_n_0 ;
  wire \spo[7]_INST_0_i_4_n_0 ;
  wire \spo[7]_INST_0_i_5_n_0 ;
  wire \spo[7]_INST_0_i_6_n_0 ;
  wire \spo[7]_INST_0_i_7_n_0 ;
  wire \spo[7]_INST_0_i_8_n_0 ;
  wire \spo[7]_INST_0_i_9_n_0 ;
  wire \spo[8]_INST_0_i_10_n_0 ;
  wire \spo[8]_INST_0_i_11_n_0 ;
  wire \spo[8]_INST_0_i_12_n_0 ;
  wire \spo[8]_INST_0_i_13_n_0 ;
  wire \spo[8]_INST_0_i_1_n_0 ;
  wire \spo[8]_INST_0_i_2_n_0 ;
  wire \spo[8]_INST_0_i_3_n_0 ;
  wire \spo[8]_INST_0_i_4_n_0 ;
  wire \spo[8]_INST_0_i_5_n_0 ;
  wire \spo[8]_INST_0_i_6_n_0 ;
  wire \spo[8]_INST_0_i_7_n_0 ;
  wire \spo[8]_INST_0_i_8_n_0 ;
  wire \spo[8]_INST_0_i_9_n_0 ;
  wire \spo[9]_INST_0_i_10_n_0 ;
  wire \spo[9]_INST_0_i_11_n_0 ;
  wire \spo[9]_INST_0_i_12_n_0 ;
  wire \spo[9]_INST_0_i_1_n_0 ;
  wire \spo[9]_INST_0_i_2_n_0 ;
  wire \spo[9]_INST_0_i_3_n_0 ;
  wire \spo[9]_INST_0_i_4_n_0 ;
  wire \spo[9]_INST_0_i_5_n_0 ;
  wire \spo[9]_INST_0_i_6_n_0 ;
  wire \spo[9]_INST_0_i_7_n_0 ;
  wire \spo[9]_INST_0_i_8_n_0 ;
  wire \spo[9]_INST_0_i_9_n_0 ;

  LUT5 #(
    .INIT(32'hFCBB3088)) 
    \spo[0]_INST_0 
       (.I0(\spo[0]_INST_0_i_1_n_0 ),
        .I1(a[1]),
        .I2(\spo[0]_INST_0_i_2_n_0 ),
        .I3(a[4]),
        .I4(\spo[0]_INST_0_i_3_n_0 ),
        .O(spo[0]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[0]_INST_0_i_1 
       (.I0(\spo[1]_INST_0_i_10_n_0 ),
        .I1(\spo[1]_INST_0_i_6_n_0 ),
        .I2(a[0]),
        .I3(\spo[1]_INST_0_i_12_n_0 ),
        .I4(a[2]),
        .I5(\spo[1]_INST_0_i_9_n_0 ),
        .O(\spo[0]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[0]_INST_0_i_2 
       (.I0(\spo[1]_INST_0_i_6_n_0 ),
        .I1(\spo[1]_INST_0_i_7_n_0 ),
        .I2(a[0]),
        .I3(\spo[1]_INST_0_i_9_n_0 ),
        .I4(a[2]),
        .I5(\spo[1]_INST_0_i_10_n_0 ),
        .O(\spo[0]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[0]_INST_0_i_3 
       (.I0(\spo[1]_INST_0_i_8_n_0 ),
        .I1(\spo[1]_INST_0_i_11_n_0 ),
        .I2(a[0]),
        .I3(\spo[1]_INST_0_i_4_n_0 ),
        .I4(a[2]),
        .I5(\spo[1]_INST_0_i_5_n_0 ),
        .O(\spo[0]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[10]_INST_0 
       (.I0(\spo[10]_INST_0_i_1_n_0 ),
        .I1(\spo[10]_INST_0_i_2_n_0 ),
        .I2(a[7]),
        .I3(\spo[10]_INST_0_i_3_n_0 ),
        .I4(a[5]),
        .I5(\spo[10]_INST_0_i_4_n_0 ),
        .O(spo[9]));
  LUT6 #(
    .INIT(64'h0000000E75559AAA)) 
    \spo[10]_INST_0_i_1 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[10]),
        .I3(a[9]),
        .I4(a[11]),
        .I5(a[12]),
        .O(\spo[10]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000A65551A8A)) 
    \spo[10]_INST_0_i_2 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[10]),
        .I3(a[9]),
        .I4(a[11]),
        .I5(a[12]),
        .O(\spo[10]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000AAE55759A)) 
    \spo[10]_INST_0_i_3 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[10]),
        .I5(a[12]),
        .O(\spo[10]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000AAA556518)) 
    \spo[10]_INST_0_i_4 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[10]),
        .I5(a[12]),
        .O(\spo[10]_INST_0_i_4_n_0 ));
  MUXF7 \spo[11]_INST_0 
       (.I0(\spo[11]_INST_0_i_1_n_0 ),
        .I1(\spo[11]_INST_0_i_2_n_0 ),
        .O(spo[10]),
        .S(a[7]));
  LUT6 #(
    .INIT(64'h000800AE00F50F50)) 
    \spo[11]_INST_0_i_1 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[10]),
        .I3(a[12]),
        .I4(a[11]),
        .I5(a[9]),
        .O(\spo[11]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000085E0000FA5F0)) 
    \spo[11]_INST_0_i_2 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[12]),
        .I5(a[10]),
        .O(\spo[11]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000F8FE000F0300)) 
    \spo[12]_INST_0 
       (.I0(a[7]),
        .I1(a[8]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[12]),
        .I5(a[10]),
        .O(spo[11]));
  LUT5 #(
    .INIT(32'h00F003E0)) 
    \spo[13]_INST_0 
       (.I0(a[8]),
        .I1(a[9]),
        .I2(a[11]),
        .I3(a[12]),
        .I4(a[10]),
        .O(spo[12]));
  LUT5 #(
    .INIT(32'hFCBB3088)) 
    \spo[1]_INST_0 
       (.I0(\spo[1]_INST_0_i_1_n_0 ),
        .I1(a[1]),
        .I2(\spo[1]_INST_0_i_2_n_0 ),
        .I3(a[4]),
        .I4(\spo[1]_INST_0_i_3_n_0 ),
        .O(spo[1]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_1 
       (.I0(\spo[1]_INST_0_i_4_n_0 ),
        .I1(\spo[1]_INST_0_i_5_n_0 ),
        .I2(a[0]),
        .I3(\spo[1]_INST_0_i_6_n_0 ),
        .I4(a[2]),
        .I5(\spo[1]_INST_0_i_7_n_0 ),
        .O(\spo[1]_INST_0_i_1_n_0 ));
  MUXF7 \spo[1]_INST_0_i_10 
       (.I0(\spo[1]_INST_0_i_25_n_0 ),
        .I1(\spo[1]_INST_0_i_26_n_0 ),
        .O(\spo[1]_INST_0_i_10_n_0 ),
        .S(a[7]));
  MUXF7 \spo[1]_INST_0_i_11 
       (.I0(\spo[1]_INST_0_i_27_n_0 ),
        .I1(\spo[1]_INST_0_i_28_n_0 ),
        .O(\spo[1]_INST_0_i_11_n_0 ),
        .S(a[7]));
  MUXF7 \spo[1]_INST_0_i_12 
       (.I0(\spo[1]_INST_0_i_29_n_0 ),
        .I1(\spo[1]_INST_0_i_30_n_0 ),
        .O(\spo[1]_INST_0_i_12_n_0 ),
        .S(a[7]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_13 
       (.I0(\spo[1]_INST_0_i_31_n_0 ),
        .I1(\spo[1]_INST_0_i_32_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_33_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_34_n_0 ),
        .O(\spo[1]_INST_0_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_14 
       (.I0(\spo[1]_INST_0_i_35_n_0 ),
        .I1(\spo[1]_INST_0_i_36_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_37_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_38_n_0 ),
        .O(\spo[1]_INST_0_i_14_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_15 
       (.I0(\spo[1]_INST_0_i_34_n_0 ),
        .I1(\spo[1]_INST_0_i_31_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_39_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_33_n_0 ),
        .O(\spo[1]_INST_0_i_15_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_16 
       (.I0(\spo[1]_INST_0_i_38_n_0 ),
        .I1(\spo[1]_INST_0_i_35_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_40_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_37_n_0 ),
        .O(\spo[1]_INST_0_i_16_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_17 
       (.I0(\spo[1]_INST_0_i_41_n_0 ),
        .I1(\spo[1]_INST_0_i_42_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_31_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_32_n_0 ),
        .O(\spo[1]_INST_0_i_17_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_18 
       (.I0(\spo[1]_INST_0_i_43_n_0 ),
        .I1(\spo[1]_INST_0_i_44_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_35_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_36_n_0 ),
        .O(\spo[1]_INST_0_i_18_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_19 
       (.I0(\spo[1]_INST_0_i_32_n_0 ),
        .I1(\spo[1]_INST_0_i_41_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_34_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_31_n_0 ),
        .O(\spo[1]_INST_0_i_19_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_2 
       (.I0(\spo[1]_INST_0_i_5_n_0 ),
        .I1(\spo[1]_INST_0_i_8_n_0 ),
        .I2(a[0]),
        .I3(\spo[1]_INST_0_i_7_n_0 ),
        .I4(a[2]),
        .I5(\spo[1]_INST_0_i_4_n_0 ),
        .O(\spo[1]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_20 
       (.I0(\spo[1]_INST_0_i_36_n_0 ),
        .I1(\spo[1]_INST_0_i_43_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_38_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_35_n_0 ),
        .O(\spo[1]_INST_0_i_20_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_21 
       (.I0(\spo[1]_INST_0_i_33_n_0 ),
        .I1(\spo[1]_INST_0_i_34_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_45_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_39_n_0 ),
        .O(\spo[1]_INST_0_i_21_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_22 
       (.I0(\spo[1]_INST_0_i_37_n_0 ),
        .I1(\spo[1]_INST_0_i_38_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_46_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_40_n_0 ),
        .O(\spo[1]_INST_0_i_22_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_23 
       (.I0(\spo[1]_INST_0_i_47_n_0 ),
        .I1(\spo[1]_INST_0_i_45_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_41_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_42_n_0 ),
        .O(\spo[1]_INST_0_i_23_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_24 
       (.I0(\spo[1]_INST_0_i_48_n_0 ),
        .I1(\spo[1]_INST_0_i_46_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_43_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_44_n_0 ),
        .O(\spo[1]_INST_0_i_24_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_25 
       (.I0(\spo[1]_INST_0_i_42_n_0 ),
        .I1(\spo[1]_INST_0_i_47_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_32_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_41_n_0 ),
        .O(\spo[1]_INST_0_i_25_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_26 
       (.I0(\spo[1]_INST_0_i_44_n_0 ),
        .I1(\spo[1]_INST_0_i_48_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_36_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_43_n_0 ),
        .O(\spo[1]_INST_0_i_26_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_27 
       (.I0(\spo[1]_INST_0_i_39_n_0 ),
        .I1(\spo[1]_INST_0_i_33_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_47_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_45_n_0 ),
        .O(\spo[1]_INST_0_i_27_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_28 
       (.I0(\spo[1]_INST_0_i_40_n_0 ),
        .I1(\spo[1]_INST_0_i_37_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_48_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_46_n_0 ),
        .O(\spo[1]_INST_0_i_28_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_29 
       (.I0(\spo[1]_INST_0_i_45_n_0 ),
        .I1(\spo[1]_INST_0_i_39_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_42_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_47_n_0 ),
        .O(\spo[1]_INST_0_i_29_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_3 
       (.I0(\spo[1]_INST_0_i_9_n_0 ),
        .I1(\spo[1]_INST_0_i_10_n_0 ),
        .I2(a[0]),
        .I3(\spo[1]_INST_0_i_11_n_0 ),
        .I4(a[2]),
        .I5(\spo[1]_INST_0_i_12_n_0 ),
        .O(\spo[1]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_30 
       (.I0(\spo[1]_INST_0_i_46_n_0 ),
        .I1(\spo[1]_INST_0_i_40_n_0 ),
        .I2(a[3]),
        .I3(\spo[1]_INST_0_i_44_n_0 ),
        .I4(a[5]),
        .I5(\spo[1]_INST_0_i_48_n_0 ),
        .O(\spo[1]_INST_0_i_30_n_0 ));
  LUT6 #(
    .INIT(64'h0024005500105A8A)) 
    \spo[1]_INST_0_i_31 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[1]_INST_0_i_31_n_0 ));
  LUT6 #(
    .INIT(64'h0100080A0A025455)) 
    \spo[1]_INST_0_i_32 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[12]),
        .I3(a[9]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[1]_INST_0_i_32_n_0 ));
  LUT6 #(
    .INIT(64'h0000050245510A8A)) 
    \spo[1]_INST_0_i_33 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[10]),
        .I3(a[9]),
        .I4(a[11]),
        .I5(a[12]),
        .O(\spo[1]_INST_0_i_33_n_0 ));
  LUT6 #(
    .INIT(64'h02000A0A01084555)) 
    \spo[1]_INST_0_i_34 
       (.I0(a[8]),
        .I1(a[9]),
        .I2(a[12]),
        .I3(a[6]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[1]_INST_0_i_34_n_0 ));
  LUT6 #(
    .INIT(64'h00550010008A14A2)) 
    \spo[1]_INST_0_i_35 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[1]_INST_0_i_35_n_0 ));
  LUT6 #(
    .INIT(64'h00008AA201004551)) 
    \spo[1]_INST_0_i_36 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[10]),
        .I3(a[9]),
        .I4(a[12]),
        .I5(a[11]),
        .O(\spo[1]_INST_0_i_36_n_0 ));
  LUT6 #(
    .INIT(64'h000045AA00152018)) 
    \spo[1]_INST_0_i_37 
       (.I0(a[8]),
        .I1(a[9]),
        .I2(a[6]),
        .I3(a[11]),
        .I4(a[12]),
        .I5(a[10]),
        .O(\spo[1]_INST_0_i_37_n_0 ));
  LUT6 #(
    .INIT(64'h00AA002400551810)) 
    \spo[1]_INST_0_i_38 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[1]_INST_0_i_38_n_0 ));
  LUT6 #(
    .INIT(64'h00008AA205004551)) 
    \spo[1]_INST_0_i_39 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[10]),
        .I3(a[9]),
        .I4(a[12]),
        .I5(a[11]),
        .O(\spo[1]_INST_0_i_39_n_0 ));
  MUXF7 \spo[1]_INST_0_i_4 
       (.I0(\spo[1]_INST_0_i_13_n_0 ),
        .I1(\spo[1]_INST_0_i_14_n_0 ),
        .O(\spo[1]_INST_0_i_4_n_0 ),
        .S(a[7]));
  LUT6 #(
    .INIT(64'h0000001AA2514508)) 
    \spo[1]_INST_0_i_40 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[10]),
        .I5(a[12]),
        .O(\spo[1]_INST_0_i_40_n_0 ));
  LUT6 #(
    .INIT(64'h0000005AA2514508)) 
    \spo[1]_INST_0_i_41 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[10]),
        .I5(a[12]),
        .O(\spo[1]_INST_0_i_41_n_0 ));
  LUT6 #(
    .INIT(64'h000045AA00552018)) 
    \spo[1]_INST_0_i_42 
       (.I0(a[8]),
        .I1(a[9]),
        .I2(a[6]),
        .I3(a[11]),
        .I4(a[12]),
        .I5(a[10]),
        .O(\spo[1]_INST_0_i_42_n_0 ));
  LUT6 #(
    .INIT(64'h0000010245510A8A)) 
    \spo[1]_INST_0_i_43 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[10]),
        .I3(a[9]),
        .I4(a[11]),
        .I5(a[12]),
        .O(\spo[1]_INST_0_i_43_n_0 ));
  LUT6 #(
    .INIT(64'h02000A0A01080555)) 
    \spo[1]_INST_0_i_44 
       (.I0(a[8]),
        .I1(a[9]),
        .I2(a[12]),
        .I3(a[6]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[1]_INST_0_i_44_n_0 ));
  LUT6 #(
    .INIT(64'h00550010008A54A2)) 
    \spo[1]_INST_0_i_45 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[1]_INST_0_i_45_n_0 ));
  LUT6 #(
    .INIT(64'h0100080A0A021455)) 
    \spo[1]_INST_0_i_46 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[12]),
        .I3(a[9]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[1]_INST_0_i_46_n_0 ));
  LUT6 #(
    .INIT(64'h00AA002400555810)) 
    \spo[1]_INST_0_i_47 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[1]_INST_0_i_47_n_0 ));
  LUT6 #(
    .INIT(64'h0024005500101A8A)) 
    \spo[1]_INST_0_i_48 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[1]_INST_0_i_48_n_0 ));
  MUXF7 \spo[1]_INST_0_i_5 
       (.I0(\spo[1]_INST_0_i_15_n_0 ),
        .I1(\spo[1]_INST_0_i_16_n_0 ),
        .O(\spo[1]_INST_0_i_5_n_0 ),
        .S(a[7]));
  MUXF7 \spo[1]_INST_0_i_6 
       (.I0(\spo[1]_INST_0_i_17_n_0 ),
        .I1(\spo[1]_INST_0_i_18_n_0 ),
        .O(\spo[1]_INST_0_i_6_n_0 ),
        .S(a[7]));
  MUXF7 \spo[1]_INST_0_i_7 
       (.I0(\spo[1]_INST_0_i_19_n_0 ),
        .I1(\spo[1]_INST_0_i_20_n_0 ),
        .O(\spo[1]_INST_0_i_7_n_0 ),
        .S(a[7]));
  MUXF7 \spo[1]_INST_0_i_8 
       (.I0(\spo[1]_INST_0_i_21_n_0 ),
        .I1(\spo[1]_INST_0_i_22_n_0 ),
        .O(\spo[1]_INST_0_i_8_n_0 ),
        .S(a[7]));
  MUXF7 \spo[1]_INST_0_i_9 
       (.I0(\spo[1]_INST_0_i_23_n_0 ),
        .I1(\spo[1]_INST_0_i_24_n_0 ),
        .O(\spo[1]_INST_0_i_9_n_0 ),
        .S(a[7]));
  LUT6 #(
    .INIT(64'hEF4AFDADE5405808)) 
    \spo[3]_INST_0 
       (.I0(a[1]),
        .I1(\spo[4]_INST_0_i_3_n_0 ),
        .I2(a[4]),
        .I3(\spo[4]_INST_0_i_1_n_0 ),
        .I4(a[0]),
        .I5(\spo[4]_INST_0_i_2_n_0 ),
        .O(spo[2]));
  LUT6 #(
    .INIT(64'hEF4AFDADE5405808)) 
    \spo[4]_INST_0 
       (.I0(a[1]),
        .I1(\spo[4]_INST_0_i_1_n_0 ),
        .I2(a[4]),
        .I3(\spo[4]_INST_0_i_2_n_0 ),
        .I4(a[0]),
        .I5(\spo[4]_INST_0_i_3_n_0 ),
        .O(spo[3]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spo[4]_INST_0_i_1 
       (.I0(\spo[4]_INST_0_i_4_n_0 ),
        .I1(a[2]),
        .I2(\spo[4]_INST_0_i_5_n_0 ),
        .O(\spo[4]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \spo[4]_INST_0_i_2 
       (.I0(\spo[4]_INST_0_i_5_n_0 ),
        .I1(a[2]),
        .I2(\spo[4]_INST_0_i_6_n_0 ),
        .O(\spo[4]_INST_0_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spo[4]_INST_0_i_3 
       (.I0(\spo[4]_INST_0_i_6_n_0 ),
        .I1(a[2]),
        .I2(\spo[4]_INST_0_i_4_n_0 ),
        .O(\spo[4]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hEDE8DF854D48DA80)) 
    \spo[4]_INST_0_i_4 
       (.I0(a[7]),
        .I1(\spo[4]_INST_0_i_7_n_0 ),
        .I2(a[3]),
        .I3(\spo[4]_INST_0_i_8_n_0 ),
        .I4(a[5]),
        .I5(\spo[4]_INST_0_i_9_n_0 ),
        .O(\spo[4]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hEDE8DF854D48DA80)) 
    \spo[4]_INST_0_i_5 
       (.I0(a[7]),
        .I1(\spo[4]_INST_0_i_9_n_0 ),
        .I2(a[3]),
        .I3(\spo[4]_INST_0_i_7_n_0 ),
        .I4(a[5]),
        .I5(\spo[4]_INST_0_i_8_n_0 ),
        .O(\spo[4]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hEDE8DF854D48DA80)) 
    \spo[4]_INST_0_i_6 
       (.I0(a[7]),
        .I1(\spo[4]_INST_0_i_8_n_0 ),
        .I2(a[3]),
        .I3(\spo[4]_INST_0_i_9_n_0 ),
        .I4(a[5]),
        .I5(\spo[4]_INST_0_i_7_n_0 ),
        .O(\spo[4]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000861800016186)) 
    \spo[4]_INST_0_i_7 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[10]),
        .I4(a[12]),
        .I5(a[11]),
        .O(\spo[4]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0000000861188661)) 
    \spo[4]_INST_0_i_8 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[10]),
        .I5(a[12]),
        .O(\spo[4]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h0018006100860618)) 
    \spo[4]_INST_0_i_9 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[4]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hFCBB3088)) 
    \spo[5]_INST_0 
       (.I0(\spo[5]_INST_0_i_1_n_0 ),
        .I1(a[1]),
        .I2(\spo[5]_INST_0_i_2_n_0 ),
        .I3(a[4]),
        .I4(\spo[5]_INST_0_i_3_n_0 ),
        .O(spo[4]));
  MUXF7 \spo[5]_INST_0_i_1 
       (.I0(\spo[5]_INST_0_i_4_n_0 ),
        .I1(\spo[5]_INST_0_i_5_n_0 ),
        .O(\spo[5]_INST_0_i_1_n_0 ),
        .S(a[0]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_10 
       (.I0(\spo[5]_INST_0_i_22_n_0 ),
        .I1(\spo[5]_INST_0_i_23_n_0 ),
        .I2(a[3]),
        .I3(\spo[8]_INST_0_i_10_n_0 ),
        .I4(a[5]),
        .I5(\spo[8]_INST_0_i_11_n_0 ),
        .O(\spo[5]_INST_0_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_11 
       (.I0(\spo[8]_INST_0_i_8_n_0 ),
        .I1(\spo[5]_INST_0_i_24_n_0 ),
        .I2(a[3]),
        .I3(\spo[8]_INST_0_i_4_n_0 ),
        .I4(a[5]),
        .I5(\spo[8]_INST_0_i_5_n_0 ),
        .O(\spo[5]_INST_0_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_12 
       (.I0(\spo[8]_INST_0_i_11_n_0 ),
        .I1(\spo[5]_INST_0_i_22_n_0 ),
        .I2(a[3]),
        .I3(\spo[5]_INST_0_i_25_n_0 ),
        .I4(a[5]),
        .I5(\spo[8]_INST_0_i_10_n_0 ),
        .O(\spo[5]_INST_0_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_13 
       (.I0(\spo[8]_INST_0_i_5_n_0 ),
        .I1(\spo[8]_INST_0_i_8_n_0 ),
        .I2(a[3]),
        .I3(\spo[5]_INST_0_i_23_n_0 ),
        .I4(a[5]),
        .I5(\spo[8]_INST_0_i_4_n_0 ),
        .O(\spo[5]_INST_0_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_14 
       (.I0(\spo[5]_INST_0_i_26_n_0 ),
        .I1(\spo[5]_INST_0_i_27_n_0 ),
        .I2(a[3]),
        .I3(\spo[8]_INST_0_i_7_n_0 ),
        .I4(a[5]),
        .I5(\spo[8]_INST_0_i_9_n_0 ),
        .O(\spo[5]_INST_0_i_14_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_15 
       (.I0(\spo[5]_INST_0_i_28_n_0 ),
        .I1(\spo[5]_INST_0_i_29_n_0 ),
        .I2(a[3]),
        .I3(\spo[8]_INST_0_i_12_n_0 ),
        .I4(a[5]),
        .I5(\spo[8]_INST_0_i_13_n_0 ),
        .O(\spo[5]_INST_0_i_15_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_16 
       (.I0(\spo[8]_INST_0_i_9_n_0 ),
        .I1(\spo[5]_INST_0_i_26_n_0 ),
        .I2(a[3]),
        .I3(\spo[8]_INST_0_i_6_n_0 ),
        .I4(a[5]),
        .I5(\spo[8]_INST_0_i_7_n_0 ),
        .O(\spo[5]_INST_0_i_16_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_17 
       (.I0(\spo[8]_INST_0_i_13_n_0 ),
        .I1(\spo[5]_INST_0_i_28_n_0 ),
        .I2(a[3]),
        .I3(\spo[5]_INST_0_i_27_n_0 ),
        .I4(a[5]),
        .I5(\spo[8]_INST_0_i_12_n_0 ),
        .O(\spo[5]_INST_0_i_17_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_18 
       (.I0(\spo[8]_INST_0_i_10_n_0 ),
        .I1(\spo[8]_INST_0_i_11_n_0 ),
        .I2(a[3]),
        .I3(\spo[5]_INST_0_i_24_n_0 ),
        .I4(a[5]),
        .I5(\spo[5]_INST_0_i_25_n_0 ),
        .O(\spo[5]_INST_0_i_18_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_19 
       (.I0(\spo[8]_INST_0_i_4_n_0 ),
        .I1(\spo[8]_INST_0_i_5_n_0 ),
        .I2(a[3]),
        .I3(\spo[5]_INST_0_i_22_n_0 ),
        .I4(a[5]),
        .I5(\spo[5]_INST_0_i_23_n_0 ),
        .O(\spo[5]_INST_0_i_19_n_0 ));
  MUXF7 \spo[5]_INST_0_i_2 
       (.I0(\spo[5]_INST_0_i_6_n_0 ),
        .I1(\spo[5]_INST_0_i_7_n_0 ),
        .O(\spo[5]_INST_0_i_2_n_0 ),
        .S(a[0]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_20 
       (.I0(\spo[8]_INST_0_i_7_n_0 ),
        .I1(\spo[8]_INST_0_i_9_n_0 ),
        .I2(a[3]),
        .I3(\spo[5]_INST_0_i_29_n_0 ),
        .I4(a[5]),
        .I5(\spo[8]_INST_0_i_6_n_0 ),
        .O(\spo[5]_INST_0_i_20_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_21 
       (.I0(\spo[8]_INST_0_i_12_n_0 ),
        .I1(\spo[8]_INST_0_i_13_n_0 ),
        .I2(a[3]),
        .I3(\spo[5]_INST_0_i_26_n_0 ),
        .I4(a[5]),
        .I5(\spo[5]_INST_0_i_27_n_0 ),
        .O(\spo[5]_INST_0_i_21_n_0 ));
  LUT6 #(
    .INIT(64'h0000A54A0010F00F)) 
    \spo[5]_INST_0_i_22 
       (.I0(a[8]),
        .I1(a[10]),
        .I2(a[6]),
        .I3(a[9]),
        .I4(a[12]),
        .I5(a[11]),
        .O(\spo[5]_INST_0_i_22_n_0 ));
  LUT6 #(
    .INIT(64'h0000AF10001050AF)) 
    \spo[5]_INST_0_i_23 
       (.I0(a[11]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[6]),
        .I4(a[12]),
        .I5(a[9]),
        .O(\spo[5]_INST_0_i_23_n_0 ));
  LUT6 #(
    .INIT(64'h0000000692C3C349)) 
    \spo[5]_INST_0_i_24 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[10]),
        .I4(a[11]),
        .I5(a[12]),
        .O(\spo[5]_INST_0_i_24_n_0 ));
  LUT6 #(
    .INIT(64'h00C400620039039C)) 
    \spo[5]_INST_0_i_25 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[10]),
        .I3(a[12]),
        .I4(a[11]),
        .I5(a[9]),
        .O(\spo[5]_INST_0_i_25_n_0 ));
  LUT6 #(
    .INIT(64'h0000000696D3C3CB)) 
    \spo[5]_INST_0_i_26 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[10]),
        .I4(a[11]),
        .I5(a[12]),
        .O(\spo[5]_INST_0_i_26_n_0 ));
  LUT6 #(
    .INIT(64'h0C0C0606030B093D)) 
    \spo[5]_INST_0_i_27 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[12]),
        .I3(a[10]),
        .I4(a[11]),
        .I5(a[9]),
        .O(\spo[5]_INST_0_i_27_n_0 ));
  LUT6 #(
    .INIT(64'h0000B966000CDC33)) 
    \spo[5]_INST_0_i_28 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[10]),
        .I3(a[9]),
        .I4(a[12]),
        .I5(a[11]),
        .O(\spo[5]_INST_0_i_28_n_0 ));
  LUT6 #(
    .INIT(64'h00000006DCC633B9)) 
    \spo[5]_INST_0_i_29 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[10]),
        .I3(a[11]),
        .I4(a[9]),
        .I5(a[12]),
        .O(\spo[5]_INST_0_i_29_n_0 ));
  MUXF7 \spo[5]_INST_0_i_3 
       (.I0(\spo[5]_INST_0_i_8_n_0 ),
        .I1(\spo[5]_INST_0_i_9_n_0 ),
        .O(\spo[5]_INST_0_i_3_n_0 ),
        .S(a[0]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_4 
       (.I0(\spo[5]_INST_0_i_10_n_0 ),
        .I1(\spo[5]_INST_0_i_11_n_0 ),
        .I2(a[2]),
        .I3(\spo[5]_INST_0_i_12_n_0 ),
        .I4(a[7]),
        .I5(\spo[5]_INST_0_i_13_n_0 ),
        .O(\spo[5]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_5 
       (.I0(\spo[5]_INST_0_i_14_n_0 ),
        .I1(\spo[5]_INST_0_i_15_n_0 ),
        .I2(a[2]),
        .I3(\spo[5]_INST_0_i_16_n_0 ),
        .I4(a[7]),
        .I5(\spo[5]_INST_0_i_17_n_0 ),
        .O(\spo[5]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_6 
       (.I0(\spo[5]_INST_0_i_12_n_0 ),
        .I1(\spo[5]_INST_0_i_13_n_0 ),
        .I2(a[2]),
        .I3(\spo[5]_INST_0_i_18_n_0 ),
        .I4(a[7]),
        .I5(\spo[5]_INST_0_i_19_n_0 ),
        .O(\spo[5]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_7 
       (.I0(\spo[5]_INST_0_i_16_n_0 ),
        .I1(\spo[5]_INST_0_i_17_n_0 ),
        .I2(a[2]),
        .I3(\spo[5]_INST_0_i_20_n_0 ),
        .I4(a[7]),
        .I5(\spo[5]_INST_0_i_21_n_0 ),
        .O(\spo[5]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_8 
       (.I0(\spo[5]_INST_0_i_11_n_0 ),
        .I1(\spo[5]_INST_0_i_12_n_0 ),
        .I2(a[2]),
        .I3(\spo[5]_INST_0_i_13_n_0 ),
        .I4(a[7]),
        .I5(\spo[5]_INST_0_i_18_n_0 ),
        .O(\spo[5]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_9 
       (.I0(\spo[5]_INST_0_i_15_n_0 ),
        .I1(\spo[5]_INST_0_i_16_n_0 ),
        .I2(a[2]),
        .I3(\spo[5]_INST_0_i_17_n_0 ),
        .I4(a[7]),
        .I5(\spo[5]_INST_0_i_20_n_0 ),
        .O(\spo[5]_INST_0_i_9_n_0 ));
  MUXF8 \spo[6]_INST_0 
       (.I0(\spo[6]_INST_0_i_1_n_0 ),
        .I1(\spo[6]_INST_0_i_2_n_0 ),
        .O(spo[5]),
        .S(a[1]));
  MUXF7 \spo[6]_INST_0_i_1 
       (.I0(\spo[6]_INST_0_i_3_n_0 ),
        .I1(\spo[6]_INST_0_i_4_n_0 ),
        .O(\spo[6]_INST_0_i_1_n_0 ),
        .S(a[4]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0_i_10 
       (.I0(\spo[6]_INST_0_i_21_n_0 ),
        .I1(\spo[6]_INST_0_i_20_n_0 ),
        .I2(a[3]),
        .I3(\spo[9]_INST_0_i_9_n_0 ),
        .I4(a[5]),
        .I5(\spo[9]_INST_0_i_10_n_0 ),
        .O(\spo[6]_INST_0_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0_i_11 
       (.I0(\spo[6]_INST_0_i_18_n_0 ),
        .I1(\spo[6]_INST_0_i_19_n_0 ),
        .I2(a[3]),
        .I3(\spo[9]_INST_0_i_11_n_0 ),
        .I4(a[5]),
        .I5(\spo[9]_INST_0_i_12_n_0 ),
        .O(\spo[6]_INST_0_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0_i_12 
       (.I0(\spo[9]_INST_0_i_5_n_0 ),
        .I1(\spo[9]_INST_0_i_6_n_0 ),
        .I2(a[3]),
        .I3(\spo[6]_INST_0_i_22_n_0 ),
        .I4(a[5]),
        .I5(\spo[6]_INST_0_i_23_n_0 ),
        .O(\spo[6]_INST_0_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0_i_13 
       (.I0(\spo[9]_INST_0_i_7_n_0 ),
        .I1(\spo[9]_INST_0_i_8_n_0 ),
        .I2(a[3]),
        .I3(\spo[6]_INST_0_i_24_n_0 ),
        .I4(a[5]),
        .I5(\spo[6]_INST_0_i_25_n_0 ),
        .O(\spo[6]_INST_0_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0_i_14 
       (.I0(\spo[6]_INST_0_i_23_n_0 ),
        .I1(\spo[9]_INST_0_i_5_n_0 ),
        .I2(a[3]),
        .I3(\spo[6]_INST_0_i_26_n_0 ),
        .I4(a[5]),
        .I5(\spo[6]_INST_0_i_22_n_0 ),
        .O(\spo[6]_INST_0_i_14_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0_i_15 
       (.I0(\spo[6]_INST_0_i_25_n_0 ),
        .I1(\spo[9]_INST_0_i_7_n_0 ),
        .I2(a[3]),
        .I3(\spo[9]_INST_0_i_6_n_0 ),
        .I4(a[5]),
        .I5(\spo[6]_INST_0_i_24_n_0 ),
        .O(\spo[6]_INST_0_i_15_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0_i_16 
       (.I0(\spo[6]_INST_0_i_22_n_0 ),
        .I1(\spo[6]_INST_0_i_23_n_0 ),
        .I2(a[3]),
        .I3(\spo[9]_INST_0_i_8_n_0 ),
        .I4(a[5]),
        .I5(\spo[6]_INST_0_i_26_n_0 ),
        .O(\spo[6]_INST_0_i_16_n_0 ));
  LUT6 #(
    .INIT(64'h0004002000DB03CF)) 
    \spo[6]_INST_0_i_17 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[11]),
        .I5(a[10]),
        .O(\spo[6]_INST_0_i_17_n_0 ));
  LUT6 #(
    .INIT(64'h000000004D0CB2F3)) 
    \spo[6]_INST_0_i_18 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[10]),
        .I5(a[12]),
        .O(\spo[6]_INST_0_i_18_n_0 ));
  LUT6 #(
    .INIT(64'h000000040B00F4BF)) 
    \spo[6]_INST_0_i_19 
       (.I0(a[11]),
        .I1(a[8]),
        .I2(a[9]),
        .I3(a[6]),
        .I4(a[10]),
        .I5(a[12]),
        .O(\spo[6]_INST_0_i_19_n_0 ));
  MUXF7 \spo[6]_INST_0_i_2 
       (.I0(\spo[6]_INST_0_i_5_n_0 ),
        .I1(\spo[6]_INST_0_i_6_n_0 ),
        .O(\spo[6]_INST_0_i_2_n_0 ),
        .S(a[4]));
  LUT6 #(
    .INIT(64'h00000300CEF71008)) 
    \spo[6]_INST_0_i_20 
       (.I0(a[8]),
        .I1(a[9]),
        .I2(a[11]),
        .I3(a[6]),
        .I4(a[10]),
        .I5(a[12]),
        .O(\spo[6]_INST_0_i_20_n_0 ));
  LUT6 #(
    .INIT(64'h0000B20C000DF304)) 
    \spo[6]_INST_0_i_21 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[10]),
        .I4(a[12]),
        .I5(a[11]),
        .O(\spo[6]_INST_0_i_21_n_0 ));
  LUT6 #(
    .INIT(64'h000000024D0CF3FB)) 
    \spo[6]_INST_0_i_22 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[10]),
        .I5(a[12]),
        .O(\spo[6]_INST_0_i_22_n_0 ));
  LUT6 #(
    .INIT(64'h000C002400FB03DF)) 
    \spo[6]_INST_0_i_23 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[11]),
        .I5(a[10]),
        .O(\spo[6]_INST_0_i_23_n_0 ));
  LUT6 #(
    .INIT(64'h0000B2F3000F4D0C)) 
    \spo[6]_INST_0_i_24 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[12]),
        .I5(a[10]),
        .O(\spo[6]_INST_0_i_24_n_0 ));
  LUT6 #(
    .INIT(64'h0000F3FB000D0C24)) 
    \spo[6]_INST_0_i_25 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[12]),
        .I5(a[10]),
        .O(\spo[6]_INST_0_i_25_n_0 ));
  LUT6 #(
    .INIT(64'h00000000CFB24DF3)) 
    \spo[6]_INST_0_i_26 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[10]),
        .I4(a[11]),
        .I5(a[12]),
        .O(\spo[6]_INST_0_i_26_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0_i_3 
       (.I0(\spo[6]_INST_0_i_7_n_0 ),
        .I1(\spo[6]_INST_0_i_8_n_0 ),
        .I2(a[2]),
        .I3(\spo[6]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[6]_INST_0_i_10_n_0 ),
        .O(\spo[6]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0_i_4 
       (.I0(\spo[6]_INST_0_i_8_n_0 ),
        .I1(\spo[6]_INST_0_i_9_n_0 ),
        .I2(a[2]),
        .I3(\spo[6]_INST_0_i_10_n_0 ),
        .I4(a[7]),
        .I5(\spo[6]_INST_0_i_11_n_0 ),
        .O(\spo[6]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0_i_5 
       (.I0(\spo[6]_INST_0_i_12_n_0 ),
        .I1(\spo[6]_INST_0_i_13_n_0 ),
        .I2(a[2]),
        .I3(\spo[6]_INST_0_i_14_n_0 ),
        .I4(a[7]),
        .I5(\spo[6]_INST_0_i_15_n_0 ),
        .O(\spo[6]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0_i_6 
       (.I0(\spo[6]_INST_0_i_13_n_0 ),
        .I1(\spo[6]_INST_0_i_14_n_0 ),
        .I2(a[2]),
        .I3(\spo[6]_INST_0_i_15_n_0 ),
        .I4(a[7]),
        .I5(\spo[6]_INST_0_i_16_n_0 ),
        .O(\spo[6]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0_i_7 
       (.I0(\spo[6]_INST_0_i_17_n_0 ),
        .I1(\spo[9]_INST_0_i_9_n_0 ),
        .I2(a[3]),
        .I3(\spo[6]_INST_0_i_18_n_0 ),
        .I4(a[5]),
        .I5(\spo[6]_INST_0_i_19_n_0 ),
        .O(\spo[6]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0_i_8 
       (.I0(\spo[6]_INST_0_i_20_n_0 ),
        .I1(\spo[9]_INST_0_i_11_n_0 ),
        .I2(a[3]),
        .I3(\spo[9]_INST_0_i_10_n_0 ),
        .I4(a[5]),
        .I5(\spo[6]_INST_0_i_21_n_0 ),
        .O(\spo[6]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0_i_9 
       (.I0(\spo[6]_INST_0_i_19_n_0 ),
        .I1(\spo[6]_INST_0_i_17_n_0 ),
        .I2(a[3]),
        .I3(\spo[9]_INST_0_i_12_n_0 ),
        .I4(a[5]),
        .I5(\spo[6]_INST_0_i_18_n_0 ),
        .O(\spo[6]_INST_0_i_9_n_0 ));
  MUXF7 \spo[7]_INST_0 
       (.I0(\spo[7]_INST_0_i_1_n_0 ),
        .I1(\spo[7]_INST_0_i_2_n_0 ),
        .O(spo[6]),
        .S(a[4]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[7]_INST_0_i_1 
       (.I0(\spo[7]_INST_0_i_3_n_0 ),
        .I1(\spo[7]_INST_0_i_4_n_0 ),
        .I2(a[2]),
        .I3(\spo[7]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[7]_INST_0_i_6_n_0 ),
        .O(\spo[7]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000AE75955AA)) 
    \spo[7]_INST_0_i_10 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[10]),
        .I5(a[12]),
        .O(\spo[7]_INST_0_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h005900AE00AA0575)) 
    \spo[7]_INST_0_i_11 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[11]),
        .I5(a[10]),
        .O(\spo[7]_INST_0_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h00AA00AE00750955)) 
    \spo[7]_INST_0_i_12 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[7]_INST_0_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h0000000AAAE75559)) 
    \spo[7]_INST_0_i_13 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[10]),
        .I4(a[11]),
        .I5(a[12]),
        .O(\spo[7]_INST_0_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h000055AA000759AE)) 
    \spo[7]_INST_0_i_14 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[12]),
        .I5(a[10]),
        .O(\spo[7]_INST_0_i_14_n_0 ));
  LUT6 #(
    .INIT(64'h000000229A4555A2)) 
    \spo[7]_INST_0_i_15 
       (.I0(a[8]),
        .I1(a[9]),
        .I2(a[6]),
        .I3(a[11]),
        .I4(a[10]),
        .I5(a[12]),
        .O(\spo[7]_INST_0_i_15_n_0 ));
  LUT6 #(
    .INIT(64'h005100AA008A0565)) 
    \spo[7]_INST_0_i_16 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[11]),
        .I5(a[10]),
        .O(\spo[7]_INST_0_i_16_n_0 ));
  LUT6 #(
    .INIT(64'h01080A0A0A060555)) 
    \spo[7]_INST_0_i_17 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[12]),
        .I3(a[9]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[7]_INST_0_i_17_n_0 ));
  LUT6 #(
    .INIT(64'h0000A9AA02005455)) 
    \spo[7]_INST_0_i_18 
       (.I0(a[8]),
        .I1(a[9]),
        .I2(a[10]),
        .I3(a[6]),
        .I4(a[12]),
        .I5(a[11]),
        .O(\spo[7]_INST_0_i_18_n_0 ));
  LUT6 #(
    .INIT(64'h000001025455AA2A)) 
    \spo[7]_INST_0_i_19 
       (.I0(a[8]),
        .I1(a[9]),
        .I2(a[10]),
        .I3(a[6]),
        .I4(a[11]),
        .I5(a[12]),
        .O(\spo[7]_INST_0_i_19_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[7]_INST_0_i_2 
       (.I0(\spo[7]_INST_0_i_4_n_0 ),
        .I1(\spo[7]_INST_0_i_7_n_0 ),
        .I2(a[2]),
        .I3(\spo[7]_INST_0_i_6_n_0 ),
        .I4(a[7]),
        .I5(\spo[7]_INST_0_i_8_n_0 ),
        .O(\spo[7]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h000055AA000518A6)) 
    \spo[7]_INST_0_i_20 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[12]),
        .I5(a[10]),
        .O(\spo[7]_INST_0_i_20_n_0 ));
  LUT6 #(
    .INIT(64'h009A00AA00E70555)) 
    \spo[7]_INST_0_i_21 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[7]_INST_0_i_21_n_0 ));
  LUT6 #(
    .INIT(64'h008A00AA00650155)) 
    \spo[7]_INST_0_i_22 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[7]_INST_0_i_22_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[7]_INST_0_i_3 
       (.I0(\spo[10]_INST_0_i_3_n_0 ),
        .I1(\spo[7]_INST_0_i_9_n_0 ),
        .I2(a[3]),
        .I3(\spo[7]_INST_0_i_10_n_0 ),
        .I4(a[5]),
        .I5(\spo[7]_INST_0_i_11_n_0 ),
        .O(\spo[7]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[7]_INST_0_i_4 
       (.I0(\spo[7]_INST_0_i_12_n_0 ),
        .I1(\spo[10]_INST_0_i_1_n_0 ),
        .I2(a[3]),
        .I3(\spo[7]_INST_0_i_13_n_0 ),
        .I4(a[5]),
        .I5(\spo[7]_INST_0_i_14_n_0 ),
        .O(\spo[7]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[7]_INST_0_i_5 
       (.I0(\spo[7]_INST_0_i_15_n_0 ),
        .I1(\spo[7]_INST_0_i_16_n_0 ),
        .I2(a[3]),
        .I3(\spo[10]_INST_0_i_2_n_0 ),
        .I4(a[5]),
        .I5(\spo[7]_INST_0_i_17_n_0 ),
        .O(\spo[7]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[7]_INST_0_i_6 
       (.I0(\spo[7]_INST_0_i_18_n_0 ),
        .I1(\spo[7]_INST_0_i_19_n_0 ),
        .I2(a[3]),
        .I3(\spo[10]_INST_0_i_4_n_0 ),
        .I4(a[5]),
        .I5(\spo[7]_INST_0_i_20_n_0 ),
        .O(\spo[7]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[7]_INST_0_i_7 
       (.I0(\spo[7]_INST_0_i_11_n_0 ),
        .I1(\spo[10]_INST_0_i_3_n_0 ),
        .I2(a[3]),
        .I3(\spo[7]_INST_0_i_21_n_0 ),
        .I4(a[5]),
        .I5(\spo[7]_INST_0_i_10_n_0 ),
        .O(\spo[7]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[7]_INST_0_i_8 
       (.I0(\spo[7]_INST_0_i_17_n_0 ),
        .I1(\spo[7]_INST_0_i_15_n_0 ),
        .I2(a[3]),
        .I3(\spo[7]_INST_0_i_22_n_0 ),
        .I4(a[5]),
        .I5(\spo[10]_INST_0_i_2_n_0 ),
        .O(\spo[7]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h005500AA009A05E7)) 
    \spo[7]_INST_0_i_9 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[11]),
        .I5(a[10]),
        .O(\spo[7]_INST_0_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hFCBB3088)) 
    \spo[8]_INST_0 
       (.I0(\spo[8]_INST_0_i_1_n_0 ),
        .I1(a[4]),
        .I2(\spo[8]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(\spo[8]_INST_0_i_3_n_0 ),
        .O(spo[7]));
  LUT6 #(
    .INIT(64'hFF33CC00B8B8B8B8)) 
    \spo[8]_INST_0_i_1 
       (.I0(\spo[8]_INST_0_i_4_n_0 ),
        .I1(a[5]),
        .I2(\spo[8]_INST_0_i_5_n_0 ),
        .I3(\spo[8]_INST_0_i_6_n_0 ),
        .I4(\spo[8]_INST_0_i_7_n_0 ),
        .I5(a[3]),
        .O(\spo[8]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000693C00092C34)) 
    \spo[8]_INST_0_i_10 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[12]),
        .I5(a[10]),
        .O(\spo[8]_INST_0_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h000003000AF5D40A)) 
    \spo[8]_INST_0_i_11 
       (.I0(a[8]),
        .I1(a[10]),
        .I2(a[11]),
        .I3(a[6]),
        .I4(a[9]),
        .I5(a[12]),
        .O(\spo[8]_INST_0_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h0000693C000B6D3C)) 
    \spo[8]_INST_0_i_12 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[12]),
        .I5(a[10]),
        .O(\spo[8]_INST_0_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h00003C3C000DB696)) 
    \spo[8]_INST_0_i_13 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[10]),
        .I4(a[12]),
        .I5(a[11]),
        .O(\spo[8]_INST_0_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hFF33CC00B8B8B8B8)) 
    \spo[8]_INST_0_i_2 
       (.I0(\spo[8]_INST_0_i_5_n_0 ),
        .I1(a[5]),
        .I2(\spo[8]_INST_0_i_8_n_0 ),
        .I3(\spo[8]_INST_0_i_7_n_0 ),
        .I4(\spo[8]_INST_0_i_9_n_0 ),
        .I5(a[3]),
        .O(\spo[8]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFF33CC00B8B8B8B8)) 
    \spo[8]_INST_0_i_3 
       (.I0(\spo[8]_INST_0_i_10_n_0 ),
        .I1(a[5]),
        .I2(\spo[8]_INST_0_i_11_n_0 ),
        .I3(\spo[8]_INST_0_i_12_n_0 ),
        .I4(\spo[8]_INST_0_i_13_n_0 ),
        .I5(a[3]),
        .O(\spo[8]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000492C0003693C)) 
    \spo[8]_INST_0_i_4 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[12]),
        .I5(a[10]),
        .O(\spo[8]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00002C3C00093496)) 
    \spo[8]_INST_0_i_5 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[10]),
        .I4(a[12]),
        .I5(a[11]),
        .O(\spo[8]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000CB6D0003693C)) 
    \spo[8]_INST_0_i_6 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[12]),
        .I5(a[10]),
        .O(\spo[8]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h00006D3C00093CB6)) 
    \spo[8]_INST_0_i_7 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[12]),
        .I5(a[10]),
        .O(\spo[8]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0034009600920CC3)) 
    \spo[8]_INST_0_i_8 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[8]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h003C00B600960CD3)) 
    \spo[8]_INST_0_i_9 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[10]),
        .I5(a[11]),
        .O(\spo[8]_INST_0_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[9]_INST_0 
       (.I0(\spo[9]_INST_0_i_1_n_0 ),
        .I1(\spo[9]_INST_0_i_2_n_0 ),
        .I2(a[4]),
        .I3(\spo[9]_INST_0_i_3_n_0 ),
        .I4(a[7]),
        .I5(\spo[9]_INST_0_i_4_n_0 ),
        .O(spo[8]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spo[9]_INST_0_i_1 
       (.I0(\spo[9]_INST_0_i_5_n_0 ),
        .I1(a[5]),
        .I2(\spo[9]_INST_0_i_6_n_0 ),
        .O(\spo[9]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000030B2000F4D0C)) 
    \spo[9]_INST_0_i_10 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[11]),
        .I4(a[12]),
        .I5(a[10]),
        .O(\spo[9]_INST_0_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h00000004DCBF2300)) 
    \spo[9]_INST_0_i_11 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[11]),
        .I3(a[9]),
        .I4(a[10]),
        .I5(a[12]),
        .O(\spo[9]_INST_0_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h00000000B0FB4F04)) 
    \spo[9]_INST_0_i_12 
       (.I0(a[11]),
        .I1(a[8]),
        .I2(a[6]),
        .I3(a[9]),
        .I4(a[10]),
        .I5(a[12]),
        .O(\spo[9]_INST_0_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spo[9]_INST_0_i_2 
       (.I0(\spo[9]_INST_0_i_7_n_0 ),
        .I1(a[5]),
        .I2(\spo[9]_INST_0_i_8_n_0 ),
        .O(\spo[9]_INST_0_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spo[9]_INST_0_i_3 
       (.I0(\spo[9]_INST_0_i_9_n_0 ),
        .I1(a[5]),
        .I2(\spo[9]_INST_0_i_10_n_0 ),
        .O(\spo[9]_INST_0_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spo[9]_INST_0_i_4 
       (.I0(\spo[9]_INST_0_i_11_n_0 ),
        .I1(a[5]),
        .I2(\spo[9]_INST_0_i_12_n_0 ),
        .O(\spo[9]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0024003000DF0BCF)) 
    \spo[9]_INST_0_i_5 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[11]),
        .I5(a[10]),
        .O(\spo[9]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h003000B200CF0F4D)) 
    \spo[9]_INST_0_i_6 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[11]),
        .I5(a[10]),
        .O(\spo[9]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000000CFDBF2340)) 
    \spo[9]_INST_0_i_7 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[11]),
        .I3(a[9]),
        .I4(a[10]),
        .I5(a[12]),
        .O(\spo[9]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h00000004DCFF3B02)) 
    \spo[9]_INST_0_i_8 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[11]),
        .I3(a[9]),
        .I4(a[10]),
        .I5(a[12]),
        .O(\spo[9]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h0020003000CF0B4D)) 
    \spo[9]_INST_0_i_9 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[12]),
        .I4(a[11]),
        .I5(a[10]),
        .O(\spo[9]_INST_0_i_9_n_0 ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
