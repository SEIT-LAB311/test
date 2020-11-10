`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
row_buffer_top 赋值上层结果读取，和row buffer 存储和切换，并提供接口访问。
1. 实例化 row_buffer_writer ：读取上层结果输出，并写入本层row buffer 中
2. 实例化 row_buffer_ctrl   ：控制row buffer 切换，启动row buffer writer
3. 实例化 row_buffer ram 
*/ 
//////////////////////////////////////////////////////////////////////////////////


module row_buffer_top
#(
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
	parameter RCC_WIDTH=10+10+10,   // row , col , channel 
  parameter ROW_WIDTH=10
)

(

  input logic clk,
  input logic rstn,
  
    // interface with pe_datain 
  output logic [HOUT-1:0][DATA_WIDTH-1:0]pe_ctrl_data,
  input logic  [2:0][ROW_WIDTH-1:0]R_C_Channel,
  output logic row_buffer_data_valid,
  input logic  pe_ctrl_ready,
  input logic  pe_buffer_switch,
  
  
  output logic [LAST_Wh-1:0]pe2row_fifo_array1_rden, 
  output logic pe2row_ready,                                    
  input  logic [LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0]fifo_array1_dataout,             
  input  logic pe2row_data_valid 

    );

 
 localparam LAST_N_UP=ceil(LAST_N,LAST_Wh);
  //row buffer 0~K+S-1  read   ---interface with buffer ram 
   logic [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] buffer_rd_addr[K+S];
   logic [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] buffer_rd_data[K+S];
  
  //row buffer 0~K+S-1write    ---interface with buffer ram
   logic [BUffER_RAM_COUNT-1:0]buffer_wren[K+S];
   logic [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] buffer_wr_addr[K+S];
   logic [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] buffer_wr_data[K+S];
   
   // buffer_writer signal
   logic buffer_writer_done;
   logic buffer_writer_en;
  

  // buffer_writer ram write   ---interface with writer
 logic  [BUffER_RAM_COUNT-1:0]buffer_writer_ram_wren;
 logic  [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] buffer_writer_ram_wr_addr;
 logic  [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] buffer_writer_ram_wr_data;
   
  
  
  
//  1. 实例化 row_buffer_writer ：读取上层结果输出，并写入本层row buffer 中 
  row_buffer_writer #(
    .DATA_WIDTH       ( DATA_WIDTH       ),
    .REAL_HINT        ( REAL_HINT        ),
    .REAL_HOUT        ( REAL_HOUT        ),
    .K                ( K                ),
    .S                ( S                ),
    .LAST_PK          ( LAST_PK          ),
    .LAST_C           ( LAST_C           ),
    .LAST_N           ( LAST_N_UP        ),  //  补0影响到上下界。需要向上取整
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
    .ROW_WIDTH        ( ROW_WIDTH        )  
  ) u_row_buffer_writer
  (.*);
//2. 实例化 row_buffer_ctrl   ：控制row buffer 切换，启动row buffer writer  
  row_buffer_ctrl #(
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
    .ROW_WIDTH        ( ROW_WIDTH        )
    ) u_row_buffer_ctrl
    (.*);
    
 //3. 实例化 row_buffer ram 
 genvar m,n;   
 generate
  for(m=0;m<K+S;m=m+1)
  	for(n=0;n<BUffER_RAM_COUNT;n=n+1)
  		begin: conv_row_buffer_loop 
  			user_ram #(
  			.RAM_DEPTH(LAST_N_UP),
  			.RAM_WIDTH(LAST_Iw*DATA_WIDTH)
  			) conv_row_buffer
  			(
  			.clk(clk),
  			.rstn(rstn),
  			.wea(buffer_wren[m][n]),
  			.addra(buffer_wr_addr[m][n]),
  			
  			.dina(buffer_wr_data[m][n]),
  			.addrb(buffer_rd_addr[m][n]),
  			.doutb(buffer_rd_data[m][n])
  			
  			);
  			
  		end 
 endgenerate

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
  
  