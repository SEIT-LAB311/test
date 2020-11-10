`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/13 21:32:46
// Design Name: 
// Module Name: user_fifo
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

// fifo 0 read lantancy
module user_fifo_prog_empty#(
parameter FIFO_WIDTH=32,
parameter FIFO_DEPTH=100,
parameter FIFO_READ_LATANCY=1
)
(
input logic clk,
input logic rstn,

input logic wr_en,
input logic [FIFO_WIDTH-1:0] din,
output logic full,
output logic [log2(FIFO_DEPTH):0] wr_data_count,
output logic prog_full,
output logic overflow,

input logic rd_en,
output logic [FIFO_WIDTH-1:0] dout,
output logic empty,
output logic prog_empty,
output logic [log2(FIFO_DEPTH):0] rd_data_count,
output logic underflow,

input logic [31:0] user_prog_empty_thresh,
output logic user_prog_empty

    );
    
 always_ff@(posedge clk or negedge rstn)
 begin 
 	if(rstn==0)
 		user_prog_empty<=1;
 	else 
 		if(rd_data_count>=user_prog_empty_thresh)
 			user_prog_empty<=0;
 		else 
 			user_prog_empty<=1;
 end    
    
    
    
    
 xpm_fifo_sync # (

  .FIFO_MEMORY_TYPE          ("auto"),           //string; "auto", "block", "distributed", or "ultra";
  .ECC_MODE                  ("no_ecc"),         //string; "no_ecc" or "en_ecc";
  .FIFO_WRITE_DEPTH          (FIFO_DEPTH),             //positive integer
  .WRITE_DATA_WIDTH          (FIFO_WIDTH),               //positive integer
  .WR_DATA_COUNT_WIDTH       (log2(FIFO_DEPTH)+1),               //positive integer
  .PROG_FULL_THRESH          (FIFO_DEPTH-5),               //positive integer
  .FULL_RESET_VALUE          (0),                //positive integer; 0 or 1
  .USE_ADV_FEATURES          ("0707"),           //string; "0000" to "1F1F"; 
  .READ_MODE                 ("std"),            //string; "std" or "fwft";
  .FIFO_READ_LATENCY         (FIFO_READ_LATANCY),                //positive integer;
  .READ_DATA_WIDTH           (FIFO_WIDTH),               //positive integer
  .RD_DATA_COUNT_WIDTH       (log2(FIFO_DEPTH)+1),               //positive integer
  .PROG_EMPTY_THRESH         (5),               //positive integer
  .DOUT_RESET_VALUE          ("0"),              //string
  .WAKEUP_TIME               (0)                 //positive integer; 0 or 2;

) xpm_fifo_sync_inst (

  .sleep            (1'b0),
  .rst              (!rstn),
  .wr_clk           (clk),
  .wr_en            (wr_en),
  .din              (din),
  .full             (full),
  .overflow         (overflow),
  .prog_full        (prog_full),
  .wr_data_count    (wr_data_count),
  .almost_full      (),
  .wr_ack           (),
  .wr_rst_busy      (wr_rst_busy),
  .rd_en            (rd_en),
  .dout             (dout),
  .empty            (empty),
  .prog_empty       (prog_empty),
  .rd_data_count    (rd_data_count),
  .almost_empty     (),
  .data_valid       (),
  .underflow        (underflow),
  .rd_rst_busy      (rd_rst_busy),
  .injectsbiterr    (1'b0),
  .injectdbiterr    (1'b0),
  .sbiterr          (),
  .dbiterr          ()

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
/*
XPM_FIFO instantiation template for Synchronous FIFO configurations
Refer to the targeted device family architecture libraries guide for XPM_FIFO documentation
=======================================================================================================================

Parameter usage table, organized as follows:
+---------------------------------------------------------------------------------------------------------------------+
| Parameter name          | Data type          | Restrictions, if applicable                                          |
|---------------------------------------------------------------------------------------------------------------------|
| Description                                                                                                         |
+---------------------------------------------------------------------------------------------------------------------+
+---------------------------------------------------------------------------------------------------------------------+
| FIFO_MEMORY_TYPE        | String             | Must be "auto", "block", "distributed" or "ultra"                    |
|---------------------------------------------------------------------------------------------------------------------|
| Designate the fifo memory primitive (resource type) to use:                                                         |
|   "auto": Allow Vivado Synthesis to choose                                                                          |
|   "block": Block RAM FIFO                                                                                           |
|   "distributed": Distributed RAM FIFO                                                                               |
|   "ultra": URAM FIFO                                                                                                |
+---------------------------------------------------------------------------------------------------------------------+
| FIFO_WRITE_DEPTH        | Integer            | Must be between 16 and 4194304                                       |
|---------------------------------------------------------------------------------------------------------------------|
| Defines the FIFO Write Depth, must be power of two                                                                  |
+---------------------------------------------------------------------------------------------------------------------+
| WRITE_DATA_WIDTH        | Integer            | Must be between 1 and 4096                                           |
|---------------------------------------------------------------------------------------------------------------------|
| Defines the width of the write data port, din                                                                       |
+---------------------------------------------------------------------------------------------------------------------+
| WR_DATA_COUNT_WIDTH     | Integer            | Must be between 1 and log2(FIFO_WRITE_DEPTH)+1                       |
|---------------------------------------------------------------------------------------------------------------------|
| Specifies the width of wr_data_count                                                                                |
+---------------------------------------------------------------------------------------------------------------------+
| READ_MODE               | String             | Must be "std" or "fwft"                                              |
|---------------------------------------------------------------------------------------------------------------------|
|  "std": standard read mode                                                                                          |
|  "fwft": First-Word-Fall-Through read mode                                                                          |
+---------------------------------------------------------------------------------------------------------------------+
| FIFO_READ_LATENCY       | Integer            | Must be >= 0                                                         |
|---------------------------------------------------------------------------------------------------------------------|
|  Number of output register stages in the read data path                                                             |
|  If READ_MODE = "fwft", then the only applicable value is 0.                                                        |
+---------------------------------------------------------------------------------------------------------------------+
| FULL_RESET_VALUE        | Integer            | Must be 0 or 1                                                       |
|---------------------------------------------------------------------------------------------------------------------|
|  Sets FULL, PROG_FULL and ALMOST_FULL to FULL_RESET_VALUE during reset                                              |
+---------------------------------------------------------------------------------------------------------------------+
| USE_ADV_FEATURES        | String             | Must be between "0000" and "1F1F"                                    |
|---------------------------------------------------------------------------------------------------------------------|
|  Enables data_valid, almost_empty, rd_data_count, prog_empty, underflow, wr_ack, almost_full, wr_data_count,        |
|  prog_full, overflow features                                                                                       |
|    Setting USE_ADV_FEATURES[0]  to 1 enables overflow flag;     Default value of this bit is 1                      |
|    Setting USE_ADV_FEATURES[1]  to 1 enables prog_full flag;    Default value of this bit is 1                      |
|    Setting USE_ADV_FEATURES[2]  to 1 enables wr_data_count;     Default value of this bit is 1                      |
|    Setting USE_ADV_FEATURES[3]  to 1 enables almost_full flag;  Default value of this bit is 0                      |
|    Setting USE_ADV_FEATURES[4]  to 1 enables wr_ack flag;       Default value of this bit is 0                      |
|    Setting USE_ADV_FEATURES[8]  to 1 enables underflow flag;    Default value of this bit is 1                      |
|    Setting USE_ADV_FEATURES[9]  to 1 enables prog_empty flag;   Default value of this bit is 1                      |
|    Setting USE_ADV_FEATURES[10] to 1 enables rd_data_count;     Default value of this bit is 1                      |
|    Setting USE_ADV_FEATURES[11] to 1 enables almost_empty flag; Default value of this bit is 0                      |
|    Setting USE_ADV_FEATURES[12] to 1 enables data_valid flag;   Default value of this bit is 0                      |
+---------------------------------------------------------------------------------------------------------------------+
| READ_DATA_WIDTH         | Integer            | Must be between >= 1                                                 |
|---------------------------------------------------------------------------------------------------------------------|
| Defines the width of the read data port, dout                                                                       |
+---------------------------------------------------------------------------------------------------------------------+
| RD_DATA_COUNT_WIDTH     | Integer            | Must be between 1 and log2(FIFO_READ_DEPTH)+1                        |
|---------------------------------------------------------------------------------------------------------------------|
| Specifies the width of rd_data_count                                                                                |
| FIFO_READ_DEPTH = FIFO_WRITE_DEPTH*WRITE_DATA_WIDTH/READ_DATA_WIDTH                                                 |
+---------------------------------------------------------------------------------------------------------------------+
| ECC_MODE                | String             | Must be "no_ecc" or "en_ecc"                                         |
|---------------------------------------------------------------------------------------------------------------------|
| "no_ecc" : Disables ECC                                                                                             |
| "en_ecc" : Enables both ECC Encoder and Decoder                                                                     |
+---------------------------------------------------------------------------------------------------------------------+
| PROG_FULL_THRESH        | Integer            | Must be between "Min_Value" and "Max_Value"                          |
|---------------------------------------------------------------------------------------------------------------------|
| Specifies the maximum number of write words in the FIFO at or above which prog_full is asserted.                    |
| Min_Value = 3 + (READ_MODE_VAL*2*(FIFO_WRITE_DEPTH/FIFO_READ_DEPTH))+CDC_SYNC_STAGES                                |
| Max_Value = (FIFO_WRITE_DEPTH-3) - (READ_MODE_VAL*2*(FIFO_WRITE_DEPTH/FIFO_READ_DEPTH))                             |
| If READ_MODE = "std", then READ_MODE_VAL = 0; Otherwise READ_MODE_VAL = 1                                           |
+---------------------------------------------------------------------------------------------------------------------+
| PROG_EMPTY_THRESH       | Integer            | Must be between "Min_Value" and "Max_Value"                          |
|---------------------------------------------------------------------------------------------------------------------|
| Specifies the minimum number of read words in the FIFO at or below which prog_empty is asserted                     |
| Min_Value = 3 + (READ_MODE_VAL*2)                                                                                   |
| Max_Value = (FIFO_WRITE_DEPTH-3) - (READ_MODE_VAL*2)                                                                |
| If READ_MODE = "std", then READ_MODE_VAL = 0; Otherwise READ_MODE_VAL = 1                                           |
+---------------------------------------------------------------------------------------------------------------------+
| DOUT_RESET_VALUE        | String             | Must be >="0". Valid hexa decimal value                              |
|---------------------------------------------------------------------------------------------------------------------|
| Reset value of read data path.                                                                                      |
+---------------------------------------------------------------------------------------------------------------------+
| WAKEUP_TIME             | Integer            | Must be 0 or 2                                                       |
|---------------------------------------------------------------------------------------------------------------------|
| 0 : Disable sleep.                                                                                                  |
| 2 : Use Sleep Pin.                                                                                                  |
+---------------------------------------------------------------------------------------------------------------------+


Port usage table, organized as follows:
+---------------------------------------------------------------------------------------------------------------------+
| Port name      | Direction | Size, in bits                         | Domain | Sense       | Handling if unused      |
|---------------------------------------------------------------------------------------------------------------------|
| Description                                                                                                         |
+---------------------------------------------------------------------------------------------------------------------+
+---------------------------------------------------------------------------------------------------------------------+
| sleep          | Input     | 1                                     |        | Active-high | Tie to 1'b0             |
|---------------------------------------------------------------------------------------------------------------------|
| Dynamic power saving: If sleep is High, the memory/fifo block is in power saving mode.                              |
| Synchronous to the slower of wr_clk and rd_clk when COMMON_CLOCK = 0, otherwise synchronous to rd_clk.              |
+---------------------------------------------------------------------------------------------------------------------+
| rst            | Input     | 1                                     | wr_clk | Active-high | Tie to 1'b0             |
+---------------------------------------------------------------------------------------------------------------------+
| Reset: Must be synchronous to wr_clk. Must be applied only when wr_clk is stable and free-running.                  |
| Once reset is applied to FIFO, the subsequent reset must be applied only when wr_rst_busy becomes zero from one.    |
+---------------------------------------------------------------------------------------------------------------------+
| wr_clk         | Input     | 1                                     |        | Rising edge | Tie to 1'b0             |
|---------------------------------------------------------------------------------------------------------------------|
| Write clock: Used for write operation.                                                                              |
| When parameter COMMON_CLOCK = 1, wr_clk is used for both write and read operation.                                  |
+---------------------------------------------------------------------------------------------------------------------+
| wr_en          | Input     | 1                                     | wr_clk | Active-high | Tie to 1'b1             |
|---------------------------------------------------------------------------------------------------------------------|
| Write Enable: If the FIFO is not full, asserting this signal causes data (on din) to be written to the FIFO         |
| Must be held active-low when rst or wr_rst_busy or rd_rst_busy is active high.                                      |
+---------------------------------------------------------------------------------------------------------------------+
| din            | Input     | WRITE_DATA_WIDTH                      | wr_clk |             | Required                |
|---------------------------------------------------------------------------------------------------------------------|
| Write Data: The input data bus used when writing the FIFO.                                                          |
+---------------------------------------------------------------------------------------------------------------------+
| full           | Output    | 1                                     | wr_clk | Active-high | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Full Flag: When asserted, this signal indicates that the FIFO is full.                                              |
| Write requests are ignored when the FIFO is full, initiating a write when the FIFO is full is not destructive       |
| to the contents of the FIFO.                                                                                        |
+---------------------------------------------------------------------------------------------------------------------+
| prog_full      | Output    | 1                                     | wr_clk | Active-high | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Programmable Full: This signal is asserted when the number of words in the FIFO is greater than or equal            |
| to the programmable full threshold value.                                                                           |
| It is de-asserted when the number of words in the FIFO is less than the programmable full threshold value.          |
+---------------------------------------------------------------------------------------------------------------------+
| wr_data_count  | Output    | WR_DATA_COUNT_WIDTH                   | wr_clk |             | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Write Data Count: This bus indicates the number of words written into the FIFO.                                     |
+---------------------------------------------------------------------------------------------------------------------+
| overflow       | Output    | 1                                     | wr_clk | Active-high | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Overflow: This signal indicates that a write request (wren) during the prior clock cycle was rejected,              |
| because the FIFO is full. Overflowing the FIFO is not destructive to the contents of the FIFO.                      |
+---------------------------------------------------------------------------------------------------------------------+
| wr_rst_busy    | Output    | 1                                     | wr_clk | Active-high | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Write Reset Busy: Active-High indicator that the FIFO write domain is currently in a reset state.                   |
+---------------------------------------------------------------------------------------------------------------------+
| almost_full    | Output    | 1                                     | wr_clk | Active-high | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Almost Full: When asserted, this signal indicates that only one more write can be performed before the FIFO is full.|
+---------------------------------------------------------------------------------------------------------------------+
| wr_ack         | Output    | 1                                     | wr_clk | Active-high | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Write Acknowledge: This signal indicates that a write request (wr_en) during the prior clock cycle is succeeded.    |
+---------------------------------------------------------------------------------------------------------------------+
| rd_en          | Input     | 1                                     | wr_clk | Active-high | Tie to 1'b1             |
|---------------------------------------------------------------------------------------------------------------------|
| Read Enable: If the FIFO is not empty, asserting this signal causes data (on dout) to be read from the FIFO         |
| Must be held active-low when rst or wr_rst_busy or rd_rst_busy is active high.                                      |
+---------------------------------------------------------------------------------------------------------------------+
| dout           | Output    | READ_DATA_WIDTH                       | wr_clk |             | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Read Data: The output data bus is driven when reading the FIFO.                                                     |
+---------------------------------------------------------------------------------------------------------------------+
| empty          | Output    | 1                                     | wr_clk | Active-high | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Empty Flag: When asserted, this signal indicates that the FIFO is empty.                                            |
| Read requests are ignored when the FIFO is empty, initiating a read while empty is not destructive to the FIFO.     |
+---------------------------------------------------------------------------------------------------------------------+
| prog_empty     | Output    | 1                                     | wr_clk | Active-high | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Programmable Empty: This signal is asserted when the number of words in the FIFO is less than or equal              |
| to the programmable empty threshold value.                                                                          |
| It is de-asserted when the number of words in the FIFO exceeds the programmable empty threshold value.              |
+---------------------------------------------------------------------------------------------------------------------+
| rd_data_count  | Output    | RD_DATA_COUNT_WIDTH                   | wr_clk |             | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Read Data Count: This bus indicates the number of words read from the FIFO.                                         |
+---------------------------------------------------------------------------------------------------------------------+
| underflow      | Output    | 1                                     | wr_clk | Active-high | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Underflow: Indicates that the read request (rd_en) during the previous clock cycle was rejected                     |
| because the FIFO is empty. Under flowing the FIFO is not destructive to the FIFO.                                   |
+---------------------------------------------------------------------------------------------------------------------+
| rd_rst_busy    | Output    | 1                                     | wr_clk | Active-high | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Read Reset Busy: Active-High indicator that the FIFO read domain is currently in a reset state.                     |
+---------------------------------------------------------------------------------------------------------------------+
| almost_empty   | Output    | 1                                     | wr_clk | Active-high | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Almost Empty : When asserted, this signal indicates that only one more read can be performed before the FIFO goes to|
| empty.                                                                                                              |
+---------------------------------------------------------------------------------------------------------------------+
| data_valid     | Output    | 1                                     | wr_clk | Active-high | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Read Data Valid: When asserted, this signal indicates that valid data is available on the output bus (dout).        |
+---------------------------------------------------------------------------------------------------------------------+
| injectsbiterr  | Intput    | 1                                     | wr_clk | Active-high | Tie to 1'b0             |
|---------------------------------------------------------------------------------------------------------------------|
| Single Bit Error Injection: Injects a single bit error if the ECC feature is used on block RAMs or                  |
| built-in FIFO macros.                                                                                               |
+---------------------------------------------------------------------------------------------------------------------+
| injectdbiterr  | Intput    | 1                                     | wr_clk | Active-high | Tie to 1'b0             |
|---------------------------------------------------------------------------------------------------------------------|
| Double Bit Error Injection: Injects a double bit error if the ECC feature is used on block RAMs or                  |
| built-in FIFO macros.                                                                                               |
+---------------------------------------------------------------------------------------------------------------------+
| sbiterr        | Output    | 1                                     | wr_clk | Active-high | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Single Bit Error: Indicates that the ECC decoder detected and fixed a single-bit error.                             |
+---------------------------------------------------------------------------------------------------------------------+
| dbiterr        | Output    | 1                                     | wr_clk | Active-high | Leave open              |
|---------------------------------------------------------------------------------------------------------------------|
| Double Bit Error: Indicates that the ECC decoder detected a double-bit error and data in the FIFO core is corrupted.|
+---------------------------------------------------------------------------------------------------------------------+
*/

//  xpm_fifo_sync       : In order to incorporate this function into the design, the following module instantiation
//       Verilog        : needs to be placed in the body of the design code.  The default values for the parameters
//        module        : may be changed to meet design requirements.  The instance name (xpm_fifo_sync)
//     instantiation    : and/or the port declarations within the parenthesis may be changed to properly reference and
//         code         : connect this function to the design.  All inputs and outputs must be connected, unless
//                      : otherwise specified.

//  <--Cut the following instance declaration and paste it into the design-->

// xpm_fifo_sync: Synchronous FIFO
// Xilinx Parameterized Macro, Version 2017.4

// End of xpm_fifo_sync instance declaration
			
		
endmodule
