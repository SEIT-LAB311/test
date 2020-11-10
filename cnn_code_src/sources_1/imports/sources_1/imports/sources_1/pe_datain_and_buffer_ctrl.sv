`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
pe_datain_and_buffer_ctrl
1. 实例化  pe_datain_ctrl_n_sv   查找表取值 RCC，访问row buffer 取回对应data，再把data 推入bi模块中。          
2. 实例化	pe_buffer_ctrl_sv	: 控制pe buffer 写入与乒乓切换，准备 pe array 输入data 和weight ，并启动pe array。		
3. 实例化 pe_array_ram ：接收 pe array 计算结果；进行部分积累加,数据量化； 控制 结果存储和输出	；
4.实例化 weight fifo 按照一列的量   （因为前面的数据用完就不用了，所以可以用fifo往前推）
*/
//////////////////////////////////////////////////////////////////////////////////


module pe_datain_and_buffer_ctrl#(
	parameter DATA_WIDTH=8,
	parameter REAL_HOUT=56,	
	parameter K=3,
	parameter C=256,
	parameter N=256,
	parameter S=1,
	parameter Wh=2,
	parameter Ww=29,
	parameter Ih=29,
	parameter Iw=7,
	parameter Bi=4,
	parameter HOUT=ceil(REAL_HOUT,Iw),  // hout is not divisible , need adding 0  // must use real  ,or that int/int=int, ceil is useless
	parameter GROUPID_WIDTH=32,
	parameter ROWID_WIDTH=32,
	parameter CKK=C*K*K,
	parameter RCC_WIDTH=2+6+9,   // row , col , channel 
	parameter PRECISION=4,    //   DATA_WIDTH=8 = 1+3+4 SIGNED 
	parameter ROW_WIDTH=10
)(   
     input   wire  clk,   
     input   wire  rstn,  
     
     
     //********pe_datain_ctrl interface*********//           
     // interface with row RAM                  
     input wire  [HOUT-1:0][DATA_WIDTH-1:0] data_in,
     input wire  row_valid,                     
     output wire  [2:0][ROW_WIDTH-1:0]R_C_Channel,    
     output wire  row_ready,                     
     output wire  row_RAM_switch,                

      //test interface                              
      //input wire [RCC_WIDTH-1:0] rcc_in_for_test, 
     output wire [GROUPID_WIDTH-1:0] groupID_o,           
     output wire [ROWID_WIDTH-1:0]   rowID_o,
     
         
      //********pe_buffer_ctrl interface*********//
     
      // interface with weight buffer  fifo               
      input wire [Wh-1:0][Ww-1:0][DATA_WIDTH-1:0] weight_buffer_din,  
      output wire weight_buffer_full,                     
      input wire weight_buffer_wren,                      
                                                          
       //********pe_array_ram interface*********//
      input wire [Wh-1:0]pe2row_fifo_array1_rden, 
      input wire pe2row_ready,                                    
      output wire[Wh-1:0][Iw-1:0][DATA_WIDTH-1:0]fifo_array1_dataout,             
      output reg pe2row_data_valid                                   
    );
    
    localparam N_UP_WH=ceil(N,Wh);                                                    
    // interface datain_ctrl with pe buffer                          
    wire  pe_buffer_switch;  //group switch        
    wire  buffer_ready;                            
    wire [Bi-1:0]pe_buffer_fifo_we;               
    wire [ROWID_WIDTH-1:0]BI_rowID[Bi];           
    wire [DATA_WIDTH-1:0]pe_buffer_input[Bi][Iw];   
    
    // interface pe buffer(pe array) with pe array
     wire [2*DATA_WIDTH-1:0]partial_sum [Iw][Wh];
     wire pe_out_fifo_wren[Iw][Wh];             
     wire pe_out_fifo_rden[Iw][Wh] ;    
     wire ram_output_blocked; 
    
     wire [Wh-1:0][Ww-1:0][DATA_WIDTH-1:0] weight_buffer; 
     wire weight_buffer_valid;                     
     wire weight_buffer_rden;
//1. 实例化  pe_datain_ctrl_n_sv   查找表取值 RCC，访问row buffer 取回对应data，再把data 推入bi模块中。          
 pe_datain_ctrl_n_sv 
 #(                                    																																		
	   .DATA_WIDTH    ( DATA_WIDTH    ), 																																																																			
	   .HOUT          ( HOUT          ), 																																		
	   .K             ( K             ), 																																																																			
	   .C             ( C             ), 																																		
	   .N             ( N_UP_WH       ), 																																		
	   .S             ( S             ), 																																		
	   .Wh            ( Wh            ), 																																		
	   .Ww            ( Ww            ), 																																		
	   .Ih            ( Ih            ), 																																		
	   .Iw            ( Iw            ), 																																		
	   .Bi            ( Bi            ), 																																		
	   .GROUPID_WIDTH ( GROUPID_WIDTH ), 																																		
	   .ROWID_WIDTH   ( ROWID_WIDTH   ), 																																																																			
	   .CKK           ( CKK           ), 																																		
	   .RCC_WIDTH     ( RCC_WIDTH     ))
	 u_pe_datain_ctrl_n  (
	   	.clk(clk),                                             //input wire  clk, 
	   	.rstn(rstn),                                           //input wire  rstn,
	   	
	   	                                                        //// interface with row RAM                  
	   	.data_in(data_in),                                      //input wire  [DATA_WIDTH-1:0] data_in[HOUT],
	   	.row_valid(row_valid),                                  //input wire  row_valid,                     
	   	.R_C_Channel(R_C_Channel),                              //output reg  [RCC_WIDTH-1:0]R_C_Channel,    
	   	.row_ready(row_ready),                                  //output reg  row_ready,                     
	   	.row_RAM_switch(row_RAM_switch),                        //output reg  row_RAM_switch,                
	   	
	   	
	   	                                                        //// interface with pe buffer                          
	   	.pe_buffer_switch(pe_buffer_switch),										//output reg  pe_buffer_switch,  //group switch       																							                                     
	    .buffer_ready(buffer_ready),                            //input wire  buffer_ready,                           
	    .pe_buffer_fifo_we(pe_buffer_fifo_we),                  //output wire [Bi-1:0]pe_buffer_fifo_we,                                                                                                         
	    .BI_rowID(BI_rowID),                                    //output wire [ROWID_WIDTH-1:0]BI_rowID[Bi],          
	    .pe_buffer_input(pe_buffer_input),                      //output wire [DATA_WIDTH-1:0]pe_buffer_input[Bi][Iw],
	    
	                                                             ////test interface                             
	    .groupID_o(groupID_o),                                    //output wire [GROUPID_WIDTH-1:0] groupID_o,
	    .rowID_o(rowID_o)                                        //output wire [ROWID_WIDTH-1:0]   rowID_o                                                                                       
	                                                                             																																		
			);
			
//2. 实例化	pe_buffer_ctrl_sv	: 控制pe buffer 写入与乒乓切换，准备 pe array 输入data 和weight ，并启动pe array。																																																		
	pe_buffer_ctrl_sv #(                                    																																		
	   .DATA_WIDTH    ( DATA_WIDTH    ), 																																																																		
	   .HOUT          ( HOUT          ), 																																		
	   .K             ( K             ), 																																																																			
	   .C             ( C             ), 																																		
	   .N             ( N_UP_WH        ), 																																		
	   .S             ( S             ), 																																		
	   .Wh            ( Wh            ), 																																		
	   .Ww            ( Ww            ), 																																		
	   .Ih            ( Ih            ), 																																		
	   .Iw            ( Iw            ), 																																		
	   .Bi            ( Bi            ), 																																		
	   .GROUPID_WIDTH ( GROUPID_WIDTH ), 																																		
	   .ROWID_WIDTH   ( ROWID_WIDTH   ), 																																																																			
	   .CKK           ( CKK           ), 																																		
	   .RCC_WIDTH     ( RCC_WIDTH     ))
	   u_pe_buffer_ctrl_sv(
		.clk(clk),                                  //   input clk,  
		.rstn(rstn),                                //   input rstn, 
		
		
		                                            //   // pe_datain_ctrl   fifo write  (fifo is in this module)
		.pe_buffer_switch(pe_buffer_switch),        //   input wire  pe_buffer_switch,  //group switch           
		.buffer_ready(buffer_ready),                //   output reg  buffer_ready,                               
		.pe_buffer_fifo_we(pe_buffer_fifo_we),      //   input  wire [Bi-1:0]pe_buffer_fifo_we,                  
		.BI_rowID(BI_rowID),                        //   input  wire [ROWID_WIDTH-1:0]BI_rowID[Bi],              
		.pe_buffer_input(pe_buffer_input),          //   input  wire [DATA_WIDTH-1:0]pe_buffer_input[Bi][Iw],   
		
		 
			                                          //   // interface with weight buffer  fifo             
		.weight_buffer(weight_buffer),              //   input wire [DATA_WIDTH-1:0] weight_buffer[Wh][Ww],
		.weight_buffer_valid(weight_buffer_valid),  //   input wire weight_buffer_valid,                   
		.weight_buffer_rden(weight_buffer_rden),    //   output reg weight_buffer_rden,                    
		                                            //
		.partial_sum(partial_sum),                  //   output wire [2*DATA_WIDTH-1:0]partial_sum [Iw][Wh],
		.pe_out_fifo_wren(pe_out_fifo_wren),        //   output wire pe_out_fifo_wren[Iw][Wh],            
		.pe_out_fifo_rden(pe_out_fifo_rden), 				//	 output wire pe_out_fifo_rden[Iw][Wh]             
		
		
		.ram_output_blocked(ram_output_blocked)																		        	
			);																						 
// 3. 实例化 pe_array_ram ：接收 pe array 计算结果；进行部分积累加,数据量化； 控制 结果存储和输出	；																								
		pe_array_ram #(                                    																																		
	   .DATA_WIDTH    ( DATA_WIDTH    ), 																																																																			
	   .HOUT          ( HOUT          ), 																																		
	   .K             ( K             ), 																																																																			
	   .C             ( C             ), 																																		
	   .N             ( N_UP_WH       ), 																																		
	   .S             ( S             ), 																																		
	   .Wh            ( Wh            ), 																																		
	   .Ww            ( Ww            ), 																																		
	   .Ih            ( Ih            ), 																																		
	   .Iw            ( Iw            ), 																																		
	   .Bi            ( Bi            ), 																																		
	   .GROUPID_WIDTH ( GROUPID_WIDTH ), 																																		
	   .ROWID_WIDTH   ( ROWID_WIDTH   ), 																																																																			
	   .CKK           ( CKK           ), 																																		
	   .RCC_WIDTH     ( RCC_WIDTH     ),
	   .PRECISION     (PRECISION      ))
	   pe_array_ram_ctrl_u1(
	   .clk(clk),                                   //  input wire clk ,                                                 
	   .rstn(rstn),                                 //  input wire rstn,                                                 
	    //  //interface with pe_buffer_ctrl         //  //interface with pe_buffer_ctrl                                  
	   .partial_sum(partial_sum),                   //  input wire [2*DATA_WIDTH-1:0]partial_sum [Iw][Wh],  // 16 = 1+7+8
	   .pe_out_fifo_wren(pe_out_fifo_wren),         //  input wire pe_out_fifo_wren[Iw][Wh],                             
	   // interface with row rom                    //  // interface with row rom                                        
	   .row_rom_ready(pe2row_ready),               //  input wire row_rom_ready,                                        
	   .fifo_array1_dataout(fifo_array1_dataout),   //  output wire [Iw-1:0][DATA_WIDTH-1:0]fifo_array1_dataout[Wh],     
	   .data_valid(pe2row_data_valid),                     //  output reg data_valid,                                           
	   .fifo_array1_rden(pe2row_fifo_array1_rden) ,                                            //                                                                   
	   .ram_output_blocked(ram_output_blocked)      //  output wire ram_ouptut_blocked                                   
	   );
	
	
	//4.实例化 weight fifo 按照一列的量   （因为前面的数据用完就不用了，所以可以用fifo往前推）   
	   logic temp;                                    
	   user_fifo#(
	   .FIFO_WIDTH(Wh*Ww*DATA_WIDTH),
	   .FIFO_DEPTH(N_UP_WH/Wh+8)
	   ) f_weight_fifo
	   (
	   .clk(clk),
	   .rstn(rstn),	   
	   .wr_en(weight_buffer_wren),
	   .din(weight_buffer_din),
	   .full(weight_buffer_full),
	   .rd_en(weight_buffer_rden),
	   .dout(weight_buffer),
	   .prog_empty(temp)
	   );
	   assign weight_buffer_valid=!temp;                                   
		                                     
		                                     
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
