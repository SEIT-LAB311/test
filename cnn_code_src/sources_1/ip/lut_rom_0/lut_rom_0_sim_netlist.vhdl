-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
-- Date        : Wed Nov  4 20:06:24 2020
-- Host        : luoconghui-System-Product-Name running 64-bit Ubuntu 18.04.2 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/luoconghui/work/cnn_code_replant/cnn_code_replant.srcs/sources_1/ip/lut_rom_0/lut_rom_0_sim_netlist.vhdl
-- Design      : lut_rom_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7vx485tffg1157-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity lut_rom_0_rom is
  port (
    spo : out STD_LOGIC_VECTOR ( 12 downto 0 );
    a : in STD_LOGIC_VECTOR ( 12 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of lut_rom_0_rom : entity is "rom";
end lut_rom_0_rom;

architecture STRUCTURE of lut_rom_0_rom is
  signal \spo[0]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[0]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[0]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[10]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[10]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[10]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[10]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[11]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[11]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_10_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_11_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_12_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_13_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_14_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_15_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_16_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_17_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_18_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_19_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_20_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_21_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_22_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_23_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_24_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_25_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_26_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_27_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_28_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_29_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_30_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_31_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_32_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_33_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_34_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_35_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_36_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_37_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_38_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_39_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_40_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_41_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_42_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_43_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_44_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_45_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_46_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_47_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_48_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[1]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[4]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_10_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_11_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_12_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_13_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_14_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_15_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_16_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_17_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_18_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_19_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_20_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_21_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_22_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_23_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_24_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_25_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_26_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_27_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_28_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_29_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[5]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_10_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_11_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_12_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_13_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_14_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_15_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_16_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_17_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_18_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_19_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_20_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_21_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_22_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_23_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_24_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_25_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_26_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[6]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_10_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_11_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_12_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_13_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_14_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_15_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_16_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_17_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_18_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_19_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_20_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_21_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_22_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[7]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_10_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_11_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_12_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_13_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[8]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_10_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_11_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_12_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \spo[9]_INST_0_i_9_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \spo[4]_INST_0_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \spo[4]_INST_0_i_3\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \spo[9]_INST_0_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \spo[9]_INST_0_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \spo[9]_INST_0_i_3\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \spo[9]_INST_0_i_4\ : label is "soft_lutpair1";
begin
\spo[0]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FCBB3088"
    )
        port map (
      I0 => \spo[0]_INST_0_i_1_n_0\,
      I1 => a(1),
      I2 => \spo[0]_INST_0_i_2_n_0\,
      I3 => a(4),
      I4 => \spo[0]_INST_0_i_3_n_0\,
      O => spo(0)
    );
\spo[0]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_10_n_0\,
      I1 => \spo[1]_INST_0_i_6_n_0\,
      I2 => a(0),
      I3 => \spo[1]_INST_0_i_12_n_0\,
      I4 => a(2),
      I5 => \spo[1]_INST_0_i_9_n_0\,
      O => \spo[0]_INST_0_i_1_n_0\
    );
\spo[0]_INST_0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_6_n_0\,
      I1 => \spo[1]_INST_0_i_7_n_0\,
      I2 => a(0),
      I3 => \spo[1]_INST_0_i_9_n_0\,
      I4 => a(2),
      I5 => \spo[1]_INST_0_i_10_n_0\,
      O => \spo[0]_INST_0_i_2_n_0\
    );
\spo[0]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_8_n_0\,
      I1 => \spo[1]_INST_0_i_11_n_0\,
      I2 => a(0),
      I3 => \spo[1]_INST_0_i_4_n_0\,
      I4 => a(2),
      I5 => \spo[1]_INST_0_i_5_n_0\,
      O => \spo[0]_INST_0_i_3_n_0\
    );
\spo[10]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[10]_INST_0_i_1_n_0\,
      I1 => \spo[10]_INST_0_i_2_n_0\,
      I2 => a(7),
      I3 => \spo[10]_INST_0_i_3_n_0\,
      I4 => a(5),
      I5 => \spo[10]_INST_0_i_4_n_0\,
      O => spo(9)
    );
\spo[10]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000E75559AAA"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(10),
      I3 => a(9),
      I4 => a(11),
      I5 => a(12),
      O => \spo[10]_INST_0_i_1_n_0\
    );
\spo[10]_INST_0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000A65551A8A"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(10),
      I3 => a(9),
      I4 => a(11),
      I5 => a(12),
      O => \spo[10]_INST_0_i_2_n_0\
    );
\spo[10]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000AAE55759A"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(10),
      I5 => a(12),
      O => \spo[10]_INST_0_i_3_n_0\
    );
\spo[10]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000AAA556518"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(10),
      I5 => a(12),
      O => \spo[10]_INST_0_i_4_n_0\
    );
\spo[11]_INST_0\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[11]_INST_0_i_1_n_0\,
      I1 => \spo[11]_INST_0_i_2_n_0\,
      O => spo(10),
      S => a(7)
    );
\spo[11]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000800AE00F50F50"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(10),
      I3 => a(12),
      I4 => a(11),
      I5 => a(9),
      O => \spo[11]_INST_0_i_1_n_0\
    );
\spo[11]_INST_0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000085E0000FA5F0"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(12),
      I5 => a(10),
      O => \spo[11]_INST_0_i_2_n_0\
    );
\spo[12]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000F8FE000F0300"
    )
        port map (
      I0 => a(7),
      I1 => a(8),
      I2 => a(9),
      I3 => a(11),
      I4 => a(12),
      I5 => a(10),
      O => spo(11)
    );
\spo[13]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00F003E0"
    )
        port map (
      I0 => a(8),
      I1 => a(9),
      I2 => a(11),
      I3 => a(12),
      I4 => a(10),
      O => spo(12)
    );
\spo[1]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FCBB3088"
    )
        port map (
      I0 => \spo[1]_INST_0_i_1_n_0\,
      I1 => a(1),
      I2 => \spo[1]_INST_0_i_2_n_0\,
      I3 => a(4),
      I4 => \spo[1]_INST_0_i_3_n_0\,
      O => spo(1)
    );
\spo[1]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_4_n_0\,
      I1 => \spo[1]_INST_0_i_5_n_0\,
      I2 => a(0),
      I3 => \spo[1]_INST_0_i_6_n_0\,
      I4 => a(2),
      I5 => \spo[1]_INST_0_i_7_n_0\,
      O => \spo[1]_INST_0_i_1_n_0\
    );
\spo[1]_INST_0_i_10\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[1]_INST_0_i_25_n_0\,
      I1 => \spo[1]_INST_0_i_26_n_0\,
      O => \spo[1]_INST_0_i_10_n_0\,
      S => a(7)
    );
\spo[1]_INST_0_i_11\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[1]_INST_0_i_27_n_0\,
      I1 => \spo[1]_INST_0_i_28_n_0\,
      O => \spo[1]_INST_0_i_11_n_0\,
      S => a(7)
    );
\spo[1]_INST_0_i_12\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[1]_INST_0_i_29_n_0\,
      I1 => \spo[1]_INST_0_i_30_n_0\,
      O => \spo[1]_INST_0_i_12_n_0\,
      S => a(7)
    );
\spo[1]_INST_0_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_31_n_0\,
      I1 => \spo[1]_INST_0_i_32_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_33_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_34_n_0\,
      O => \spo[1]_INST_0_i_13_n_0\
    );
\spo[1]_INST_0_i_14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_35_n_0\,
      I1 => \spo[1]_INST_0_i_36_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_37_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_38_n_0\,
      O => \spo[1]_INST_0_i_14_n_0\
    );
\spo[1]_INST_0_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_34_n_0\,
      I1 => \spo[1]_INST_0_i_31_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_39_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_33_n_0\,
      O => \spo[1]_INST_0_i_15_n_0\
    );
\spo[1]_INST_0_i_16\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_38_n_0\,
      I1 => \spo[1]_INST_0_i_35_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_40_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_37_n_0\,
      O => \spo[1]_INST_0_i_16_n_0\
    );
\spo[1]_INST_0_i_17\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_41_n_0\,
      I1 => \spo[1]_INST_0_i_42_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_31_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_32_n_0\,
      O => \spo[1]_INST_0_i_17_n_0\
    );
\spo[1]_INST_0_i_18\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_43_n_0\,
      I1 => \spo[1]_INST_0_i_44_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_35_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_36_n_0\,
      O => \spo[1]_INST_0_i_18_n_0\
    );
\spo[1]_INST_0_i_19\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_32_n_0\,
      I1 => \spo[1]_INST_0_i_41_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_34_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_31_n_0\,
      O => \spo[1]_INST_0_i_19_n_0\
    );
\spo[1]_INST_0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_5_n_0\,
      I1 => \spo[1]_INST_0_i_8_n_0\,
      I2 => a(0),
      I3 => \spo[1]_INST_0_i_7_n_0\,
      I4 => a(2),
      I5 => \spo[1]_INST_0_i_4_n_0\,
      O => \spo[1]_INST_0_i_2_n_0\
    );
\spo[1]_INST_0_i_20\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_36_n_0\,
      I1 => \spo[1]_INST_0_i_43_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_38_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_35_n_0\,
      O => \spo[1]_INST_0_i_20_n_0\
    );
\spo[1]_INST_0_i_21\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_33_n_0\,
      I1 => \spo[1]_INST_0_i_34_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_45_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_39_n_0\,
      O => \spo[1]_INST_0_i_21_n_0\
    );
\spo[1]_INST_0_i_22\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_37_n_0\,
      I1 => \spo[1]_INST_0_i_38_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_46_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_40_n_0\,
      O => \spo[1]_INST_0_i_22_n_0\
    );
\spo[1]_INST_0_i_23\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_47_n_0\,
      I1 => \spo[1]_INST_0_i_45_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_41_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_42_n_0\,
      O => \spo[1]_INST_0_i_23_n_0\
    );
\spo[1]_INST_0_i_24\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_48_n_0\,
      I1 => \spo[1]_INST_0_i_46_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_43_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_44_n_0\,
      O => \spo[1]_INST_0_i_24_n_0\
    );
\spo[1]_INST_0_i_25\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_42_n_0\,
      I1 => \spo[1]_INST_0_i_47_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_32_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_41_n_0\,
      O => \spo[1]_INST_0_i_25_n_0\
    );
\spo[1]_INST_0_i_26\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_44_n_0\,
      I1 => \spo[1]_INST_0_i_48_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_36_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_43_n_0\,
      O => \spo[1]_INST_0_i_26_n_0\
    );
\spo[1]_INST_0_i_27\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_39_n_0\,
      I1 => \spo[1]_INST_0_i_33_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_47_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_45_n_0\,
      O => \spo[1]_INST_0_i_27_n_0\
    );
\spo[1]_INST_0_i_28\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_40_n_0\,
      I1 => \spo[1]_INST_0_i_37_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_48_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_46_n_0\,
      O => \spo[1]_INST_0_i_28_n_0\
    );
\spo[1]_INST_0_i_29\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_45_n_0\,
      I1 => \spo[1]_INST_0_i_39_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_42_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_47_n_0\,
      O => \spo[1]_INST_0_i_29_n_0\
    );
\spo[1]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_9_n_0\,
      I1 => \spo[1]_INST_0_i_10_n_0\,
      I2 => a(0),
      I3 => \spo[1]_INST_0_i_11_n_0\,
      I4 => a(2),
      I5 => \spo[1]_INST_0_i_12_n_0\,
      O => \spo[1]_INST_0_i_3_n_0\
    );
\spo[1]_INST_0_i_30\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[1]_INST_0_i_46_n_0\,
      I1 => \spo[1]_INST_0_i_40_n_0\,
      I2 => a(3),
      I3 => \spo[1]_INST_0_i_44_n_0\,
      I4 => a(5),
      I5 => \spo[1]_INST_0_i_48_n_0\,
      O => \spo[1]_INST_0_i_30_n_0\
    );
\spo[1]_INST_0_i_31\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0024005500105A8A"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(10),
      I5 => a(11),
      O => \spo[1]_INST_0_i_31_n_0\
    );
\spo[1]_INST_0_i_32\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0100080A0A025455"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(12),
      I3 => a(9),
      I4 => a(10),
      I5 => a(11),
      O => \spo[1]_INST_0_i_32_n_0\
    );
\spo[1]_INST_0_i_33\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000050245510A8A"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(10),
      I3 => a(9),
      I4 => a(11),
      I5 => a(12),
      O => \spo[1]_INST_0_i_33_n_0\
    );
\spo[1]_INST_0_i_34\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02000A0A01084555"
    )
        port map (
      I0 => a(8),
      I1 => a(9),
      I2 => a(12),
      I3 => a(6),
      I4 => a(10),
      I5 => a(11),
      O => \spo[1]_INST_0_i_34_n_0\
    );
\spo[1]_INST_0_i_35\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550010008A14A2"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(10),
      I5 => a(11),
      O => \spo[1]_INST_0_i_35_n_0\
    );
\spo[1]_INST_0_i_36\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00008AA201004551"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(10),
      I3 => a(9),
      I4 => a(12),
      I5 => a(11),
      O => \spo[1]_INST_0_i_36_n_0\
    );
\spo[1]_INST_0_i_37\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000045AA00152018"
    )
        port map (
      I0 => a(8),
      I1 => a(9),
      I2 => a(6),
      I3 => a(11),
      I4 => a(12),
      I5 => a(10),
      O => \spo[1]_INST_0_i_37_n_0\
    );
\spo[1]_INST_0_i_38\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00AA002400551810"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(10),
      I5 => a(11),
      O => \spo[1]_INST_0_i_38_n_0\
    );
\spo[1]_INST_0_i_39\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00008AA205004551"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(10),
      I3 => a(9),
      I4 => a(12),
      I5 => a(11),
      O => \spo[1]_INST_0_i_39_n_0\
    );
\spo[1]_INST_0_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[1]_INST_0_i_13_n_0\,
      I1 => \spo[1]_INST_0_i_14_n_0\,
      O => \spo[1]_INST_0_i_4_n_0\,
      S => a(7)
    );
\spo[1]_INST_0_i_40\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000001AA2514508"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(10),
      I5 => a(12),
      O => \spo[1]_INST_0_i_40_n_0\
    );
\spo[1]_INST_0_i_41\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000005AA2514508"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(10),
      I5 => a(12),
      O => \spo[1]_INST_0_i_41_n_0\
    );
\spo[1]_INST_0_i_42\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000045AA00552018"
    )
        port map (
      I0 => a(8),
      I1 => a(9),
      I2 => a(6),
      I3 => a(11),
      I4 => a(12),
      I5 => a(10),
      O => \spo[1]_INST_0_i_42_n_0\
    );
\spo[1]_INST_0_i_43\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000010245510A8A"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(10),
      I3 => a(9),
      I4 => a(11),
      I5 => a(12),
      O => \spo[1]_INST_0_i_43_n_0\
    );
\spo[1]_INST_0_i_44\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02000A0A01080555"
    )
        port map (
      I0 => a(8),
      I1 => a(9),
      I2 => a(12),
      I3 => a(6),
      I4 => a(10),
      I5 => a(11),
      O => \spo[1]_INST_0_i_44_n_0\
    );
\spo[1]_INST_0_i_45\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550010008A54A2"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(10),
      I5 => a(11),
      O => \spo[1]_INST_0_i_45_n_0\
    );
\spo[1]_INST_0_i_46\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0100080A0A021455"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(12),
      I3 => a(9),
      I4 => a(10),
      I5 => a(11),
      O => \spo[1]_INST_0_i_46_n_0\
    );
\spo[1]_INST_0_i_47\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00AA002400555810"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(10),
      I5 => a(11),
      O => \spo[1]_INST_0_i_47_n_0\
    );
\spo[1]_INST_0_i_48\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0024005500101A8A"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(10),
      I5 => a(11),
      O => \spo[1]_INST_0_i_48_n_0\
    );
\spo[1]_INST_0_i_5\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[1]_INST_0_i_15_n_0\,
      I1 => \spo[1]_INST_0_i_16_n_0\,
      O => \spo[1]_INST_0_i_5_n_0\,
      S => a(7)
    );
\spo[1]_INST_0_i_6\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[1]_INST_0_i_17_n_0\,
      I1 => \spo[1]_INST_0_i_18_n_0\,
      O => \spo[1]_INST_0_i_6_n_0\,
      S => a(7)
    );
\spo[1]_INST_0_i_7\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[1]_INST_0_i_19_n_0\,
      I1 => \spo[1]_INST_0_i_20_n_0\,
      O => \spo[1]_INST_0_i_7_n_0\,
      S => a(7)
    );
\spo[1]_INST_0_i_8\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[1]_INST_0_i_21_n_0\,
      I1 => \spo[1]_INST_0_i_22_n_0\,
      O => \spo[1]_INST_0_i_8_n_0\,
      S => a(7)
    );
\spo[1]_INST_0_i_9\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[1]_INST_0_i_23_n_0\,
      I1 => \spo[1]_INST_0_i_24_n_0\,
      O => \spo[1]_INST_0_i_9_n_0\,
      S => a(7)
    );
\spo[3]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EF4AFDADE5405808"
    )
        port map (
      I0 => a(1),
      I1 => \spo[4]_INST_0_i_3_n_0\,
      I2 => a(4),
      I3 => \spo[4]_INST_0_i_1_n_0\,
      I4 => a(0),
      I5 => \spo[4]_INST_0_i_2_n_0\,
      O => spo(2)
    );
\spo[4]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EF4AFDADE5405808"
    )
        port map (
      I0 => a(1),
      I1 => \spo[4]_INST_0_i_1_n_0\,
      I2 => a(4),
      I3 => \spo[4]_INST_0_i_2_n_0\,
      I4 => a(0),
      I5 => \spo[4]_INST_0_i_3_n_0\,
      O => spo(3)
    );
\spo[4]_INST_0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \spo[4]_INST_0_i_4_n_0\,
      I1 => a(2),
      I2 => \spo[4]_INST_0_i_5_n_0\,
      O => \spo[4]_INST_0_i_1_n_0\
    );
\spo[4]_INST_0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \spo[4]_INST_0_i_5_n_0\,
      I1 => a(2),
      I2 => \spo[4]_INST_0_i_6_n_0\,
      O => \spo[4]_INST_0_i_2_n_0\
    );
\spo[4]_INST_0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \spo[4]_INST_0_i_6_n_0\,
      I1 => a(2),
      I2 => \spo[4]_INST_0_i_4_n_0\,
      O => \spo[4]_INST_0_i_3_n_0\
    );
\spo[4]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EDE8DF854D48DA80"
    )
        port map (
      I0 => a(7),
      I1 => \spo[4]_INST_0_i_7_n_0\,
      I2 => a(3),
      I3 => \spo[4]_INST_0_i_8_n_0\,
      I4 => a(5),
      I5 => \spo[4]_INST_0_i_9_n_0\,
      O => \spo[4]_INST_0_i_4_n_0\
    );
\spo[4]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EDE8DF854D48DA80"
    )
        port map (
      I0 => a(7),
      I1 => \spo[4]_INST_0_i_9_n_0\,
      I2 => a(3),
      I3 => \spo[4]_INST_0_i_7_n_0\,
      I4 => a(5),
      I5 => \spo[4]_INST_0_i_8_n_0\,
      O => \spo[4]_INST_0_i_5_n_0\
    );
\spo[4]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EDE8DF854D48DA80"
    )
        port map (
      I0 => a(7),
      I1 => \spo[4]_INST_0_i_8_n_0\,
      I2 => a(3),
      I3 => \spo[4]_INST_0_i_9_n_0\,
      I4 => a(5),
      I5 => \spo[4]_INST_0_i_7_n_0\,
      O => \spo[4]_INST_0_i_6_n_0\
    );
\spo[4]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000861800016186"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(10),
      I4 => a(12),
      I5 => a(11),
      O => \spo[4]_INST_0_i_7_n_0\
    );
\spo[4]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000861188661"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(10),
      I5 => a(12),
      O => \spo[4]_INST_0_i_8_n_0\
    );
\spo[4]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0018006100860618"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(10),
      I5 => a(11),
      O => \spo[4]_INST_0_i_9_n_0\
    );
\spo[5]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FCBB3088"
    )
        port map (
      I0 => \spo[5]_INST_0_i_1_n_0\,
      I1 => a(1),
      I2 => \spo[5]_INST_0_i_2_n_0\,
      I3 => a(4),
      I4 => \spo[5]_INST_0_i_3_n_0\,
      O => spo(4)
    );
\spo[5]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[5]_INST_0_i_4_n_0\,
      I1 => \spo[5]_INST_0_i_5_n_0\,
      O => \spo[5]_INST_0_i_1_n_0\,
      S => a(0)
    );
\spo[5]_INST_0_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[5]_INST_0_i_22_n_0\,
      I1 => \spo[5]_INST_0_i_23_n_0\,
      I2 => a(3),
      I3 => \spo[8]_INST_0_i_10_n_0\,
      I4 => a(5),
      I5 => \spo[8]_INST_0_i_11_n_0\,
      O => \spo[5]_INST_0_i_10_n_0\
    );
\spo[5]_INST_0_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[8]_INST_0_i_8_n_0\,
      I1 => \spo[5]_INST_0_i_24_n_0\,
      I2 => a(3),
      I3 => \spo[8]_INST_0_i_4_n_0\,
      I4 => a(5),
      I5 => \spo[8]_INST_0_i_5_n_0\,
      O => \spo[5]_INST_0_i_11_n_0\
    );
\spo[5]_INST_0_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[8]_INST_0_i_11_n_0\,
      I1 => \spo[5]_INST_0_i_22_n_0\,
      I2 => a(3),
      I3 => \spo[5]_INST_0_i_25_n_0\,
      I4 => a(5),
      I5 => \spo[8]_INST_0_i_10_n_0\,
      O => \spo[5]_INST_0_i_12_n_0\
    );
\spo[5]_INST_0_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[8]_INST_0_i_5_n_0\,
      I1 => \spo[8]_INST_0_i_8_n_0\,
      I2 => a(3),
      I3 => \spo[5]_INST_0_i_23_n_0\,
      I4 => a(5),
      I5 => \spo[8]_INST_0_i_4_n_0\,
      O => \spo[5]_INST_0_i_13_n_0\
    );
\spo[5]_INST_0_i_14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[5]_INST_0_i_26_n_0\,
      I1 => \spo[5]_INST_0_i_27_n_0\,
      I2 => a(3),
      I3 => \spo[8]_INST_0_i_7_n_0\,
      I4 => a(5),
      I5 => \spo[8]_INST_0_i_9_n_0\,
      O => \spo[5]_INST_0_i_14_n_0\
    );
\spo[5]_INST_0_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[5]_INST_0_i_28_n_0\,
      I1 => \spo[5]_INST_0_i_29_n_0\,
      I2 => a(3),
      I3 => \spo[8]_INST_0_i_12_n_0\,
      I4 => a(5),
      I5 => \spo[8]_INST_0_i_13_n_0\,
      O => \spo[5]_INST_0_i_15_n_0\
    );
\spo[5]_INST_0_i_16\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[8]_INST_0_i_9_n_0\,
      I1 => \spo[5]_INST_0_i_26_n_0\,
      I2 => a(3),
      I3 => \spo[8]_INST_0_i_6_n_0\,
      I4 => a(5),
      I5 => \spo[8]_INST_0_i_7_n_0\,
      O => \spo[5]_INST_0_i_16_n_0\
    );
\spo[5]_INST_0_i_17\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[8]_INST_0_i_13_n_0\,
      I1 => \spo[5]_INST_0_i_28_n_0\,
      I2 => a(3),
      I3 => \spo[5]_INST_0_i_27_n_0\,
      I4 => a(5),
      I5 => \spo[8]_INST_0_i_12_n_0\,
      O => \spo[5]_INST_0_i_17_n_0\
    );
\spo[5]_INST_0_i_18\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[8]_INST_0_i_10_n_0\,
      I1 => \spo[8]_INST_0_i_11_n_0\,
      I2 => a(3),
      I3 => \spo[5]_INST_0_i_24_n_0\,
      I4 => a(5),
      I5 => \spo[5]_INST_0_i_25_n_0\,
      O => \spo[5]_INST_0_i_18_n_0\
    );
\spo[5]_INST_0_i_19\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[8]_INST_0_i_4_n_0\,
      I1 => \spo[8]_INST_0_i_5_n_0\,
      I2 => a(3),
      I3 => \spo[5]_INST_0_i_22_n_0\,
      I4 => a(5),
      I5 => \spo[5]_INST_0_i_23_n_0\,
      O => \spo[5]_INST_0_i_19_n_0\
    );
\spo[5]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[5]_INST_0_i_6_n_0\,
      I1 => \spo[5]_INST_0_i_7_n_0\,
      O => \spo[5]_INST_0_i_2_n_0\,
      S => a(0)
    );
\spo[5]_INST_0_i_20\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[8]_INST_0_i_7_n_0\,
      I1 => \spo[8]_INST_0_i_9_n_0\,
      I2 => a(3),
      I3 => \spo[5]_INST_0_i_29_n_0\,
      I4 => a(5),
      I5 => \spo[8]_INST_0_i_6_n_0\,
      O => \spo[5]_INST_0_i_20_n_0\
    );
\spo[5]_INST_0_i_21\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[8]_INST_0_i_12_n_0\,
      I1 => \spo[8]_INST_0_i_13_n_0\,
      I2 => a(3),
      I3 => \spo[5]_INST_0_i_26_n_0\,
      I4 => a(5),
      I5 => \spo[5]_INST_0_i_27_n_0\,
      O => \spo[5]_INST_0_i_21_n_0\
    );
\spo[5]_INST_0_i_22\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000A54A0010F00F"
    )
        port map (
      I0 => a(8),
      I1 => a(10),
      I2 => a(6),
      I3 => a(9),
      I4 => a(12),
      I5 => a(11),
      O => \spo[5]_INST_0_i_22_n_0\
    );
\spo[5]_INST_0_i_23\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AF10001050AF"
    )
        port map (
      I0 => a(11),
      I1 => a(10),
      I2 => a(8),
      I3 => a(6),
      I4 => a(12),
      I5 => a(9),
      O => \spo[5]_INST_0_i_23_n_0\
    );
\spo[5]_INST_0_i_24\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000692C3C349"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(10),
      I4 => a(11),
      I5 => a(12),
      O => \spo[5]_INST_0_i_24_n_0\
    );
\spo[5]_INST_0_i_25\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00C400620039039C"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(10),
      I3 => a(12),
      I4 => a(11),
      I5 => a(9),
      O => \spo[5]_INST_0_i_25_n_0\
    );
\spo[5]_INST_0_i_26\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000696D3C3CB"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(10),
      I4 => a(11),
      I5 => a(12),
      O => \spo[5]_INST_0_i_26_n_0\
    );
\spo[5]_INST_0_i_27\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0C0C0606030B093D"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(12),
      I3 => a(10),
      I4 => a(11),
      I5 => a(9),
      O => \spo[5]_INST_0_i_27_n_0\
    );
\spo[5]_INST_0_i_28\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000B966000CDC33"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(10),
      I3 => a(9),
      I4 => a(12),
      I5 => a(11),
      O => \spo[5]_INST_0_i_28_n_0\
    );
\spo[5]_INST_0_i_29\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000006DCC633B9"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(10),
      I3 => a(11),
      I4 => a(9),
      I5 => a(12),
      O => \spo[5]_INST_0_i_29_n_0\
    );
\spo[5]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[5]_INST_0_i_8_n_0\,
      I1 => \spo[5]_INST_0_i_9_n_0\,
      O => \spo[5]_INST_0_i_3_n_0\,
      S => a(0)
    );
\spo[5]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[5]_INST_0_i_10_n_0\,
      I1 => \spo[5]_INST_0_i_11_n_0\,
      I2 => a(2),
      I3 => \spo[5]_INST_0_i_12_n_0\,
      I4 => a(7),
      I5 => \spo[5]_INST_0_i_13_n_0\,
      O => \spo[5]_INST_0_i_4_n_0\
    );
\spo[5]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[5]_INST_0_i_14_n_0\,
      I1 => \spo[5]_INST_0_i_15_n_0\,
      I2 => a(2),
      I3 => \spo[5]_INST_0_i_16_n_0\,
      I4 => a(7),
      I5 => \spo[5]_INST_0_i_17_n_0\,
      O => \spo[5]_INST_0_i_5_n_0\
    );
\spo[5]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[5]_INST_0_i_12_n_0\,
      I1 => \spo[5]_INST_0_i_13_n_0\,
      I2 => a(2),
      I3 => \spo[5]_INST_0_i_18_n_0\,
      I4 => a(7),
      I5 => \spo[5]_INST_0_i_19_n_0\,
      O => \spo[5]_INST_0_i_6_n_0\
    );
\spo[5]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[5]_INST_0_i_16_n_0\,
      I1 => \spo[5]_INST_0_i_17_n_0\,
      I2 => a(2),
      I3 => \spo[5]_INST_0_i_20_n_0\,
      I4 => a(7),
      I5 => \spo[5]_INST_0_i_21_n_0\,
      O => \spo[5]_INST_0_i_7_n_0\
    );
\spo[5]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[5]_INST_0_i_11_n_0\,
      I1 => \spo[5]_INST_0_i_12_n_0\,
      I2 => a(2),
      I3 => \spo[5]_INST_0_i_13_n_0\,
      I4 => a(7),
      I5 => \spo[5]_INST_0_i_18_n_0\,
      O => \spo[5]_INST_0_i_8_n_0\
    );
\spo[5]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[5]_INST_0_i_15_n_0\,
      I1 => \spo[5]_INST_0_i_16_n_0\,
      I2 => a(2),
      I3 => \spo[5]_INST_0_i_17_n_0\,
      I4 => a(7),
      I5 => \spo[5]_INST_0_i_20_n_0\,
      O => \spo[5]_INST_0_i_9_n_0\
    );
\spo[6]_INST_0\: unisim.vcomponents.MUXF8
     port map (
      I0 => \spo[6]_INST_0_i_1_n_0\,
      I1 => \spo[6]_INST_0_i_2_n_0\,
      O => spo(5),
      S => a(1)
    );
\spo[6]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[6]_INST_0_i_3_n_0\,
      I1 => \spo[6]_INST_0_i_4_n_0\,
      O => \spo[6]_INST_0_i_1_n_0\,
      S => a(4)
    );
\spo[6]_INST_0_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[6]_INST_0_i_21_n_0\,
      I1 => \spo[6]_INST_0_i_20_n_0\,
      I2 => a(3),
      I3 => \spo[9]_INST_0_i_9_n_0\,
      I4 => a(5),
      I5 => \spo[9]_INST_0_i_10_n_0\,
      O => \spo[6]_INST_0_i_10_n_0\
    );
\spo[6]_INST_0_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[6]_INST_0_i_18_n_0\,
      I1 => \spo[6]_INST_0_i_19_n_0\,
      I2 => a(3),
      I3 => \spo[9]_INST_0_i_11_n_0\,
      I4 => a(5),
      I5 => \spo[9]_INST_0_i_12_n_0\,
      O => \spo[6]_INST_0_i_11_n_0\
    );
\spo[6]_INST_0_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[9]_INST_0_i_5_n_0\,
      I1 => \spo[9]_INST_0_i_6_n_0\,
      I2 => a(3),
      I3 => \spo[6]_INST_0_i_22_n_0\,
      I4 => a(5),
      I5 => \spo[6]_INST_0_i_23_n_0\,
      O => \spo[6]_INST_0_i_12_n_0\
    );
\spo[6]_INST_0_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[9]_INST_0_i_7_n_0\,
      I1 => \spo[9]_INST_0_i_8_n_0\,
      I2 => a(3),
      I3 => \spo[6]_INST_0_i_24_n_0\,
      I4 => a(5),
      I5 => \spo[6]_INST_0_i_25_n_0\,
      O => \spo[6]_INST_0_i_13_n_0\
    );
\spo[6]_INST_0_i_14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[6]_INST_0_i_23_n_0\,
      I1 => \spo[9]_INST_0_i_5_n_0\,
      I2 => a(3),
      I3 => \spo[6]_INST_0_i_26_n_0\,
      I4 => a(5),
      I5 => \spo[6]_INST_0_i_22_n_0\,
      O => \spo[6]_INST_0_i_14_n_0\
    );
\spo[6]_INST_0_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[6]_INST_0_i_25_n_0\,
      I1 => \spo[9]_INST_0_i_7_n_0\,
      I2 => a(3),
      I3 => \spo[9]_INST_0_i_6_n_0\,
      I4 => a(5),
      I5 => \spo[6]_INST_0_i_24_n_0\,
      O => \spo[6]_INST_0_i_15_n_0\
    );
\spo[6]_INST_0_i_16\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[6]_INST_0_i_22_n_0\,
      I1 => \spo[6]_INST_0_i_23_n_0\,
      I2 => a(3),
      I3 => \spo[9]_INST_0_i_8_n_0\,
      I4 => a(5),
      I5 => \spo[6]_INST_0_i_26_n_0\,
      O => \spo[6]_INST_0_i_16_n_0\
    );
\spo[6]_INST_0_i_17\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0004002000DB03CF"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(11),
      I5 => a(10),
      O => \spo[6]_INST_0_i_17_n_0\
    );
\spo[6]_INST_0_i_18\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000004D0CB2F3"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(10),
      I5 => a(12),
      O => \spo[6]_INST_0_i_18_n_0\
    );
\spo[6]_INST_0_i_19\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000040B00F4BF"
    )
        port map (
      I0 => a(11),
      I1 => a(8),
      I2 => a(9),
      I3 => a(6),
      I4 => a(10),
      I5 => a(12),
      O => \spo[6]_INST_0_i_19_n_0\
    );
\spo[6]_INST_0_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[6]_INST_0_i_5_n_0\,
      I1 => \spo[6]_INST_0_i_6_n_0\,
      O => \spo[6]_INST_0_i_2_n_0\,
      S => a(4)
    );
\spo[6]_INST_0_i_20\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000300CEF71008"
    )
        port map (
      I0 => a(8),
      I1 => a(9),
      I2 => a(11),
      I3 => a(6),
      I4 => a(10),
      I5 => a(12),
      O => \spo[6]_INST_0_i_20_n_0\
    );
\spo[6]_INST_0_i_21\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000B20C000DF304"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(10),
      I4 => a(12),
      I5 => a(11),
      O => \spo[6]_INST_0_i_21_n_0\
    );
\spo[6]_INST_0_i_22\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000024D0CF3FB"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(10),
      I5 => a(12),
      O => \spo[6]_INST_0_i_22_n_0\
    );
\spo[6]_INST_0_i_23\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000C002400FB03DF"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(11),
      I5 => a(10),
      O => \spo[6]_INST_0_i_23_n_0\
    );
\spo[6]_INST_0_i_24\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000B2F3000F4D0C"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(12),
      I5 => a(10),
      O => \spo[6]_INST_0_i_24_n_0\
    );
\spo[6]_INST_0_i_25\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000F3FB000D0C24"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(12),
      I5 => a(10),
      O => \spo[6]_INST_0_i_25_n_0\
    );
\spo[6]_INST_0_i_26\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000CFB24DF3"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(10),
      I4 => a(11),
      I5 => a(12),
      O => \spo[6]_INST_0_i_26_n_0\
    );
\spo[6]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[6]_INST_0_i_7_n_0\,
      I1 => \spo[6]_INST_0_i_8_n_0\,
      I2 => a(2),
      I3 => \spo[6]_INST_0_i_9_n_0\,
      I4 => a(7),
      I5 => \spo[6]_INST_0_i_10_n_0\,
      O => \spo[6]_INST_0_i_3_n_0\
    );
\spo[6]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[6]_INST_0_i_8_n_0\,
      I1 => \spo[6]_INST_0_i_9_n_0\,
      I2 => a(2),
      I3 => \spo[6]_INST_0_i_10_n_0\,
      I4 => a(7),
      I5 => \spo[6]_INST_0_i_11_n_0\,
      O => \spo[6]_INST_0_i_4_n_0\
    );
\spo[6]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[6]_INST_0_i_12_n_0\,
      I1 => \spo[6]_INST_0_i_13_n_0\,
      I2 => a(2),
      I3 => \spo[6]_INST_0_i_14_n_0\,
      I4 => a(7),
      I5 => \spo[6]_INST_0_i_15_n_0\,
      O => \spo[6]_INST_0_i_5_n_0\
    );
\spo[6]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[6]_INST_0_i_13_n_0\,
      I1 => \spo[6]_INST_0_i_14_n_0\,
      I2 => a(2),
      I3 => \spo[6]_INST_0_i_15_n_0\,
      I4 => a(7),
      I5 => \spo[6]_INST_0_i_16_n_0\,
      O => \spo[6]_INST_0_i_6_n_0\
    );
\spo[6]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[6]_INST_0_i_17_n_0\,
      I1 => \spo[9]_INST_0_i_9_n_0\,
      I2 => a(3),
      I3 => \spo[6]_INST_0_i_18_n_0\,
      I4 => a(5),
      I5 => \spo[6]_INST_0_i_19_n_0\,
      O => \spo[6]_INST_0_i_7_n_0\
    );
\spo[6]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[6]_INST_0_i_20_n_0\,
      I1 => \spo[9]_INST_0_i_11_n_0\,
      I2 => a(3),
      I3 => \spo[9]_INST_0_i_10_n_0\,
      I4 => a(5),
      I5 => \spo[6]_INST_0_i_21_n_0\,
      O => \spo[6]_INST_0_i_8_n_0\
    );
\spo[6]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[6]_INST_0_i_19_n_0\,
      I1 => \spo[6]_INST_0_i_17_n_0\,
      I2 => a(3),
      I3 => \spo[9]_INST_0_i_12_n_0\,
      I4 => a(5),
      I5 => \spo[6]_INST_0_i_18_n_0\,
      O => \spo[6]_INST_0_i_9_n_0\
    );
\spo[7]_INST_0\: unisim.vcomponents.MUXF7
     port map (
      I0 => \spo[7]_INST_0_i_1_n_0\,
      I1 => \spo[7]_INST_0_i_2_n_0\,
      O => spo(6),
      S => a(4)
    );
\spo[7]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[7]_INST_0_i_3_n_0\,
      I1 => \spo[7]_INST_0_i_4_n_0\,
      I2 => a(2),
      I3 => \spo[7]_INST_0_i_5_n_0\,
      I4 => a(7),
      I5 => \spo[7]_INST_0_i_6_n_0\,
      O => \spo[7]_INST_0_i_1_n_0\
    );
\spo[7]_INST_0_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000AE75955AA"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(10),
      I5 => a(12),
      O => \spo[7]_INST_0_i_10_n_0\
    );
\spo[7]_INST_0_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"005900AE00AA0575"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(11),
      I5 => a(10),
      O => \spo[7]_INST_0_i_11_n_0\
    );
\spo[7]_INST_0_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00AA00AE00750955"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(10),
      I5 => a(11),
      O => \spo[7]_INST_0_i_12_n_0\
    );
\spo[7]_INST_0_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000AAAE75559"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(10),
      I4 => a(11),
      I5 => a(12),
      O => \spo[7]_INST_0_i_13_n_0\
    );
\spo[7]_INST_0_i_14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000055AA000759AE"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(12),
      I5 => a(10),
      O => \spo[7]_INST_0_i_14_n_0\
    );
\spo[7]_INST_0_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000229A4555A2"
    )
        port map (
      I0 => a(8),
      I1 => a(9),
      I2 => a(6),
      I3 => a(11),
      I4 => a(10),
      I5 => a(12),
      O => \spo[7]_INST_0_i_15_n_0\
    );
\spo[7]_INST_0_i_16\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"005100AA008A0565"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(11),
      I5 => a(10),
      O => \spo[7]_INST_0_i_16_n_0\
    );
\spo[7]_INST_0_i_17\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"01080A0A0A060555"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(12),
      I3 => a(9),
      I4 => a(10),
      I5 => a(11),
      O => \spo[7]_INST_0_i_17_n_0\
    );
\spo[7]_INST_0_i_18\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000A9AA02005455"
    )
        port map (
      I0 => a(8),
      I1 => a(9),
      I2 => a(10),
      I3 => a(6),
      I4 => a(12),
      I5 => a(11),
      O => \spo[7]_INST_0_i_18_n_0\
    );
\spo[7]_INST_0_i_19\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000001025455AA2A"
    )
        port map (
      I0 => a(8),
      I1 => a(9),
      I2 => a(10),
      I3 => a(6),
      I4 => a(11),
      I5 => a(12),
      O => \spo[7]_INST_0_i_19_n_0\
    );
\spo[7]_INST_0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[7]_INST_0_i_4_n_0\,
      I1 => \spo[7]_INST_0_i_7_n_0\,
      I2 => a(2),
      I3 => \spo[7]_INST_0_i_6_n_0\,
      I4 => a(7),
      I5 => \spo[7]_INST_0_i_8_n_0\,
      O => \spo[7]_INST_0_i_2_n_0\
    );
\spo[7]_INST_0_i_20\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000055AA000518A6"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(12),
      I5 => a(10),
      O => \spo[7]_INST_0_i_20_n_0\
    );
\spo[7]_INST_0_i_21\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"009A00AA00E70555"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(10),
      I5 => a(11),
      O => \spo[7]_INST_0_i_21_n_0\
    );
\spo[7]_INST_0_i_22\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"008A00AA00650155"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(10),
      I5 => a(11),
      O => \spo[7]_INST_0_i_22_n_0\
    );
\spo[7]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[10]_INST_0_i_3_n_0\,
      I1 => \spo[7]_INST_0_i_9_n_0\,
      I2 => a(3),
      I3 => \spo[7]_INST_0_i_10_n_0\,
      I4 => a(5),
      I5 => \spo[7]_INST_0_i_11_n_0\,
      O => \spo[7]_INST_0_i_3_n_0\
    );
\spo[7]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[7]_INST_0_i_12_n_0\,
      I1 => \spo[10]_INST_0_i_1_n_0\,
      I2 => a(3),
      I3 => \spo[7]_INST_0_i_13_n_0\,
      I4 => a(5),
      I5 => \spo[7]_INST_0_i_14_n_0\,
      O => \spo[7]_INST_0_i_4_n_0\
    );
\spo[7]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[7]_INST_0_i_15_n_0\,
      I1 => \spo[7]_INST_0_i_16_n_0\,
      I2 => a(3),
      I3 => \spo[10]_INST_0_i_2_n_0\,
      I4 => a(5),
      I5 => \spo[7]_INST_0_i_17_n_0\,
      O => \spo[7]_INST_0_i_5_n_0\
    );
\spo[7]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[7]_INST_0_i_18_n_0\,
      I1 => \spo[7]_INST_0_i_19_n_0\,
      I2 => a(3),
      I3 => \spo[10]_INST_0_i_4_n_0\,
      I4 => a(5),
      I5 => \spo[7]_INST_0_i_20_n_0\,
      O => \spo[7]_INST_0_i_6_n_0\
    );
\spo[7]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[7]_INST_0_i_11_n_0\,
      I1 => \spo[10]_INST_0_i_3_n_0\,
      I2 => a(3),
      I3 => \spo[7]_INST_0_i_21_n_0\,
      I4 => a(5),
      I5 => \spo[7]_INST_0_i_10_n_0\,
      O => \spo[7]_INST_0_i_7_n_0\
    );
\spo[7]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[7]_INST_0_i_17_n_0\,
      I1 => \spo[7]_INST_0_i_15_n_0\,
      I2 => a(3),
      I3 => \spo[7]_INST_0_i_22_n_0\,
      I4 => a(5),
      I5 => \spo[10]_INST_0_i_2_n_0\,
      O => \spo[7]_INST_0_i_8_n_0\
    );
\spo[7]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"005500AA009A05E7"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(11),
      I5 => a(10),
      O => \spo[7]_INST_0_i_9_n_0\
    );
\spo[8]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FCBB3088"
    )
        port map (
      I0 => \spo[8]_INST_0_i_1_n_0\,
      I1 => a(4),
      I2 => \spo[8]_INST_0_i_2_n_0\,
      I3 => a(7),
      I4 => \spo[8]_INST_0_i_3_n_0\,
      O => spo(7)
    );
\spo[8]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF33CC00B8B8B8B8"
    )
        port map (
      I0 => \spo[8]_INST_0_i_4_n_0\,
      I1 => a(5),
      I2 => \spo[8]_INST_0_i_5_n_0\,
      I3 => \spo[8]_INST_0_i_6_n_0\,
      I4 => \spo[8]_INST_0_i_7_n_0\,
      I5 => a(3),
      O => \spo[8]_INST_0_i_1_n_0\
    );
\spo[8]_INST_0_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000693C00092C34"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(12),
      I5 => a(10),
      O => \spo[8]_INST_0_i_10_n_0\
    );
\spo[8]_INST_0_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000003000AF5D40A"
    )
        port map (
      I0 => a(8),
      I1 => a(10),
      I2 => a(11),
      I3 => a(6),
      I4 => a(9),
      I5 => a(12),
      O => \spo[8]_INST_0_i_11_n_0\
    );
\spo[8]_INST_0_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000693C000B6D3C"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(12),
      I5 => a(10),
      O => \spo[8]_INST_0_i_12_n_0\
    );
\spo[8]_INST_0_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00003C3C000DB696"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(10),
      I4 => a(12),
      I5 => a(11),
      O => \spo[8]_INST_0_i_13_n_0\
    );
\spo[8]_INST_0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF33CC00B8B8B8B8"
    )
        port map (
      I0 => \spo[8]_INST_0_i_5_n_0\,
      I1 => a(5),
      I2 => \spo[8]_INST_0_i_8_n_0\,
      I3 => \spo[8]_INST_0_i_7_n_0\,
      I4 => \spo[8]_INST_0_i_9_n_0\,
      I5 => a(3),
      O => \spo[8]_INST_0_i_2_n_0\
    );
\spo[8]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF33CC00B8B8B8B8"
    )
        port map (
      I0 => \spo[8]_INST_0_i_10_n_0\,
      I1 => a(5),
      I2 => \spo[8]_INST_0_i_11_n_0\,
      I3 => \spo[8]_INST_0_i_12_n_0\,
      I4 => \spo[8]_INST_0_i_13_n_0\,
      I5 => a(3),
      O => \spo[8]_INST_0_i_3_n_0\
    );
\spo[8]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000492C0003693C"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(12),
      I5 => a(10),
      O => \spo[8]_INST_0_i_4_n_0\
    );
\spo[8]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00002C3C00093496"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(10),
      I4 => a(12),
      I5 => a(11),
      O => \spo[8]_INST_0_i_5_n_0\
    );
\spo[8]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000CB6D0003693C"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(12),
      I5 => a(10),
      O => \spo[8]_INST_0_i_6_n_0\
    );
\spo[8]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00006D3C00093CB6"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(12),
      I5 => a(10),
      O => \spo[8]_INST_0_i_7_n_0\
    );
\spo[8]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0034009600920CC3"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(10),
      I5 => a(11),
      O => \spo[8]_INST_0_i_8_n_0\
    );
\spo[8]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"003C00B600960CD3"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(10),
      I5 => a(11),
      O => \spo[8]_INST_0_i_9_n_0\
    );
\spo[9]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \spo[9]_INST_0_i_1_n_0\,
      I1 => \spo[9]_INST_0_i_2_n_0\,
      I2 => a(4),
      I3 => \spo[9]_INST_0_i_3_n_0\,
      I4 => a(7),
      I5 => \spo[9]_INST_0_i_4_n_0\,
      O => spo(8)
    );
\spo[9]_INST_0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \spo[9]_INST_0_i_5_n_0\,
      I1 => a(5),
      I2 => \spo[9]_INST_0_i_6_n_0\,
      O => \spo[9]_INST_0_i_1_n_0\
    );
\spo[9]_INST_0_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000030B2000F4D0C"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(11),
      I4 => a(12),
      I5 => a(10),
      O => \spo[9]_INST_0_i_10_n_0\
    );
\spo[9]_INST_0_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000004DCBF2300"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(11),
      I3 => a(9),
      I4 => a(10),
      I5 => a(12),
      O => \spo[9]_INST_0_i_11_n_0\
    );
\spo[9]_INST_0_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000B0FB4F04"
    )
        port map (
      I0 => a(11),
      I1 => a(8),
      I2 => a(6),
      I3 => a(9),
      I4 => a(10),
      I5 => a(12),
      O => \spo[9]_INST_0_i_12_n_0\
    );
\spo[9]_INST_0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \spo[9]_INST_0_i_7_n_0\,
      I1 => a(5),
      I2 => \spo[9]_INST_0_i_8_n_0\,
      O => \spo[9]_INST_0_i_2_n_0\
    );
\spo[9]_INST_0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \spo[9]_INST_0_i_9_n_0\,
      I1 => a(5),
      I2 => \spo[9]_INST_0_i_10_n_0\,
      O => \spo[9]_INST_0_i_3_n_0\
    );
\spo[9]_INST_0_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \spo[9]_INST_0_i_11_n_0\,
      I1 => a(5),
      I2 => \spo[9]_INST_0_i_12_n_0\,
      O => \spo[9]_INST_0_i_4_n_0\
    );
\spo[9]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0024003000DF0BCF"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(11),
      I5 => a(10),
      O => \spo[9]_INST_0_i_5_n_0\
    );
\spo[9]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"003000B200CF0F4D"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(11),
      I5 => a(10),
      O => \spo[9]_INST_0_i_6_n_0\
    );
\spo[9]_INST_0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000CFDBF2340"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(11),
      I3 => a(9),
      I4 => a(10),
      I5 => a(12),
      O => \spo[9]_INST_0_i_7_n_0\
    );
\spo[9]_INST_0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000004DCFF3B02"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(11),
      I3 => a(9),
      I4 => a(10),
      I5 => a(12),
      O => \spo[9]_INST_0_i_8_n_0\
    );
\spo[9]_INST_0_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020003000CF0B4D"
    )
        port map (
      I0 => a(8),
      I1 => a(6),
      I2 => a(9),
      I3 => a(12),
      I4 => a(11),
      I5 => a(10),
      O => \spo[9]_INST_0_i_9_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity lut_rom_0_dist_mem_gen_v8_0_13_synth is
  port (
    spo : out STD_LOGIC_VECTOR ( 12 downto 0 );
    a : in STD_LOGIC_VECTOR ( 12 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of lut_rom_0_dist_mem_gen_v8_0_13_synth : entity is "dist_mem_gen_v8_0_13_synth";
end lut_rom_0_dist_mem_gen_v8_0_13_synth;

architecture STRUCTURE of lut_rom_0_dist_mem_gen_v8_0_13_synth is
begin
\gen_rom.rom_inst\: entity work.lut_rom_0_rom
     port map (
      a(12 downto 0) => a(12 downto 0),
      spo(12 downto 0) => spo(12 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity lut_rom_0_dist_mem_gen_v8_0_13 is
  port (
    a : in STD_LOGIC_VECTOR ( 12 downto 0 );
    d : in STD_LOGIC_VECTOR ( 15 downto 0 );
    dpra : in STD_LOGIC_VECTOR ( 12 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    i_ce : in STD_LOGIC;
    qspo_ce : in STD_LOGIC;
    qdpo_ce : in STD_LOGIC;
    qdpo_clk : in STD_LOGIC;
    qspo_rst : in STD_LOGIC;
    qdpo_rst : in STD_LOGIC;
    qspo_srst : in STD_LOGIC;
    qdpo_srst : in STD_LOGIC;
    spo : out STD_LOGIC_VECTOR ( 15 downto 0 );
    dpo : out STD_LOGIC_VECTOR ( 15 downto 0 );
    qspo : out STD_LOGIC_VECTOR ( 15 downto 0 );
    qdpo : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute C_ADDR_WIDTH : integer;
  attribute C_ADDR_WIDTH of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 13;
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of lut_rom_0_dist_mem_gen_v8_0_13 : entity is "0";
  attribute C_DEPTH : integer;
  attribute C_DEPTH of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 4800;
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of lut_rom_0_dist_mem_gen_v8_0_13 : entity is "./";
  attribute C_FAMILY : string;
  attribute C_FAMILY of lut_rom_0_dist_mem_gen_v8_0_13 : entity is "virtex7";
  attribute C_HAS_CLK : integer;
  attribute C_HAS_CLK of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_D : integer;
  attribute C_HAS_D of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_DPO : integer;
  attribute C_HAS_DPO of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_DPRA : integer;
  attribute C_HAS_DPRA of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_I_CE : integer;
  attribute C_HAS_I_CE of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO : integer;
  attribute C_HAS_QDPO of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO_CE : integer;
  attribute C_HAS_QDPO_CE of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO_CLK : integer;
  attribute C_HAS_QDPO_CLK of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO_RST : integer;
  attribute C_HAS_QDPO_RST of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO_SRST : integer;
  attribute C_HAS_QDPO_SRST of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QSPO : integer;
  attribute C_HAS_QSPO of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QSPO_CE : integer;
  attribute C_HAS_QSPO_CE of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QSPO_RST : integer;
  attribute C_HAS_QSPO_RST of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QSPO_SRST : integer;
  attribute C_HAS_QSPO_SRST of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_SPO : integer;
  attribute C_HAS_SPO of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_HAS_WE : integer;
  attribute C_HAS_WE of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_MEM_INIT_FILE : string;
  attribute C_MEM_INIT_FILE of lut_rom_0_dist_mem_gen_v8_0_13 : entity is "lut_rom_0.mif";
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_PARSER_TYPE : integer;
  attribute C_PARSER_TYPE of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_PIPELINE_STAGES : integer;
  attribute C_PIPELINE_STAGES of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_QCE_JOINED : integer;
  attribute C_QCE_JOINED of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_QUALIFY_WE : integer;
  attribute C_QUALIFY_WE of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_READ_MIF : integer;
  attribute C_READ_MIF of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_REG_A_D_INPUTS : integer;
  attribute C_REG_A_D_INPUTS of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_REG_DPRA_INPUT : integer;
  attribute C_REG_DPRA_INPUT of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_SYNC_ENABLE : integer;
  attribute C_SYNC_ENABLE of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_WIDTH : integer;
  attribute C_WIDTH of lut_rom_0_dist_mem_gen_v8_0_13 : entity is 16;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of lut_rom_0_dist_mem_gen_v8_0_13 : entity is "dist_mem_gen_v8_0_13";
end lut_rom_0_dist_mem_gen_v8_0_13;

architecture STRUCTURE of lut_rom_0_dist_mem_gen_v8_0_13 is
  signal \<const0>\ : STD_LOGIC;
  signal \^spo\ : STD_LOGIC_VECTOR ( 13 downto 0 );
begin
  dpo(15) <= \<const0>\;
  dpo(14) <= \<const0>\;
  dpo(13) <= \<const0>\;
  dpo(12) <= \<const0>\;
  dpo(11) <= \<const0>\;
  dpo(10) <= \<const0>\;
  dpo(9) <= \<const0>\;
  dpo(8) <= \<const0>\;
  dpo(7) <= \<const0>\;
  dpo(6) <= \<const0>\;
  dpo(5) <= \<const0>\;
  dpo(4) <= \<const0>\;
  dpo(3) <= \<const0>\;
  dpo(2) <= \<const0>\;
  dpo(1) <= \<const0>\;
  dpo(0) <= \<const0>\;
  qdpo(15) <= \<const0>\;
  qdpo(14) <= \<const0>\;
  qdpo(13) <= \<const0>\;
  qdpo(12) <= \<const0>\;
  qdpo(11) <= \<const0>\;
  qdpo(10) <= \<const0>\;
  qdpo(9) <= \<const0>\;
  qdpo(8) <= \<const0>\;
  qdpo(7) <= \<const0>\;
  qdpo(6) <= \<const0>\;
  qdpo(5) <= \<const0>\;
  qdpo(4) <= \<const0>\;
  qdpo(3) <= \<const0>\;
  qdpo(2) <= \<const0>\;
  qdpo(1) <= \<const0>\;
  qdpo(0) <= \<const0>\;
  qspo(15) <= \<const0>\;
  qspo(14) <= \<const0>\;
  qspo(13) <= \<const0>\;
  qspo(12) <= \<const0>\;
  qspo(11) <= \<const0>\;
  qspo(10) <= \<const0>\;
  qspo(9) <= \<const0>\;
  qspo(8) <= \<const0>\;
  qspo(7) <= \<const0>\;
  qspo(6) <= \<const0>\;
  qspo(5) <= \<const0>\;
  qspo(4) <= \<const0>\;
  qspo(3) <= \<const0>\;
  qspo(2) <= \<const0>\;
  qspo(1) <= \<const0>\;
  qspo(0) <= \<const0>\;
  spo(15) <= \<const0>\;
  spo(14) <= \<const0>\;
  spo(13 downto 3) <= \^spo\(13 downto 3);
  spo(2) <= \<const0>\;
  spo(1 downto 0) <= \^spo\(1 downto 0);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\synth_options.dist_mem_inst\: entity work.lut_rom_0_dist_mem_gen_v8_0_13_synth
     port map (
      a(12 downto 0) => a(12 downto 0),
      spo(12 downto 2) => \^spo\(13 downto 3),
      spo(1 downto 0) => \^spo\(1 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity lut_rom_0 is
  port (
    a : in STD_LOGIC_VECTOR ( 12 downto 0 );
    spo : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of lut_rom_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of lut_rom_0 : entity is "lut_rom_0,dist_mem_gen_v8_0_13,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of lut_rom_0 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of lut_rom_0 : entity is "dist_mem_gen_v8_0_13,Vivado 2020.1";
end lut_rom_0;

architecture STRUCTURE of lut_rom_0 is
  signal NLW_U0_dpo_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_U0_qdpo_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_U0_qspo_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "virtex7";
  attribute C_HAS_D : integer;
  attribute C_HAS_D of U0 : label is 0;
  attribute C_HAS_DPO : integer;
  attribute C_HAS_DPO of U0 : label is 0;
  attribute C_HAS_DPRA : integer;
  attribute C_HAS_DPRA of U0 : label is 0;
  attribute C_HAS_I_CE : integer;
  attribute C_HAS_I_CE of U0 : label is 0;
  attribute C_HAS_QDPO : integer;
  attribute C_HAS_QDPO of U0 : label is 0;
  attribute C_HAS_QDPO_CE : integer;
  attribute C_HAS_QDPO_CE of U0 : label is 0;
  attribute C_HAS_QDPO_CLK : integer;
  attribute C_HAS_QDPO_CLK of U0 : label is 0;
  attribute C_HAS_QDPO_RST : integer;
  attribute C_HAS_QDPO_RST of U0 : label is 0;
  attribute C_HAS_QDPO_SRST : integer;
  attribute C_HAS_QDPO_SRST of U0 : label is 0;
  attribute C_HAS_WE : integer;
  attribute C_HAS_WE of U0 : label is 0;
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of U0 : label is 0;
  attribute C_PIPELINE_STAGES : integer;
  attribute C_PIPELINE_STAGES of U0 : label is 0;
  attribute C_QCE_JOINED : integer;
  attribute C_QCE_JOINED of U0 : label is 0;
  attribute C_QUALIFY_WE : integer;
  attribute C_QUALIFY_WE of U0 : label is 0;
  attribute C_REG_DPRA_INPUT : integer;
  attribute C_REG_DPRA_INPUT of U0 : label is 0;
  attribute KEEP_HIERARCHY : string;
  attribute KEEP_HIERARCHY of U0 : label is "soft";
  attribute c_addr_width : integer;
  attribute c_addr_width of U0 : label is 13;
  attribute c_default_data : string;
  attribute c_default_data of U0 : label is "0";
  attribute c_depth : integer;
  attribute c_depth of U0 : label is 4800;
  attribute c_elaboration_dir : string;
  attribute c_elaboration_dir of U0 : label is "./";
  attribute c_has_clk : integer;
  attribute c_has_clk of U0 : label is 0;
  attribute c_has_qspo : integer;
  attribute c_has_qspo of U0 : label is 0;
  attribute c_has_qspo_ce : integer;
  attribute c_has_qspo_ce of U0 : label is 0;
  attribute c_has_qspo_rst : integer;
  attribute c_has_qspo_rst of U0 : label is 0;
  attribute c_has_qspo_srst : integer;
  attribute c_has_qspo_srst of U0 : label is 0;
  attribute c_has_spo : integer;
  attribute c_has_spo of U0 : label is 1;
  attribute c_mem_init_file : string;
  attribute c_mem_init_file of U0 : label is "lut_rom_0.mif";
  attribute c_parser_type : integer;
  attribute c_parser_type of U0 : label is 1;
  attribute c_read_mif : integer;
  attribute c_read_mif of U0 : label is 1;
  attribute c_reg_a_d_inputs : integer;
  attribute c_reg_a_d_inputs of U0 : label is 0;
  attribute c_sync_enable : integer;
  attribute c_sync_enable of U0 : label is 1;
  attribute c_width : integer;
  attribute c_width of U0 : label is 16;
begin
U0: entity work.lut_rom_0_dist_mem_gen_v8_0_13
     port map (
      a(12 downto 0) => a(12 downto 0),
      clk => '0',
      d(15 downto 0) => B"0000000000000000",
      dpo(15 downto 0) => NLW_U0_dpo_UNCONNECTED(15 downto 0),
      dpra(12 downto 0) => B"0000000000000",
      i_ce => '1',
      qdpo(15 downto 0) => NLW_U0_qdpo_UNCONNECTED(15 downto 0),
      qdpo_ce => '1',
      qdpo_clk => '0',
      qdpo_rst => '0',
      qdpo_srst => '0',
      qspo(15 downto 0) => NLW_U0_qspo_UNCONNECTED(15 downto 0),
      qspo_ce => '1',
      qspo_rst => '0',
      qspo_srst => '0',
      spo(15 downto 0) => spo(15 downto 0),
      we => '0'
    );
end STRUCTURE;
