`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
fc_writer 
1. 实例化 fc_writer_pooling
2. 实例化 pooling用的行缓存ram（2x2pooling，缓存2行）

*/
//////////////////////////////////////////////////////////////////////////////////


module fc_writer#
(
  parameter AF=3,
  parameter BATCH=9,
  
	parameter DATA_WIDTH=8,
	parameter REAL_HINT=14,       // 被 ctrl 连接时注意 大小
	parameter REAL_HOUT=7,	  
	
	parameter K=3,
	parameter S=1,
	
	//last conv configuration
	parameter LAST_N=512,
	parameter LAST_Wh=6,
	parameter LAST_Ww=17,
	parameter LAST_Ih=17,
	parameter LAST_Iw=1,
	parameter LAST_Bi=1,
	
	parameter BUffER_RAM_COUNT=HINT/LAST_Iw,
	parameter HINT=ceil(REAL_HINT,LAST_Iw),
	//parameter BUffER_RAM_COUNT_POOLING=int'($ceil(real'(REAL_HOUT)/LAST_Iw)), // pooling let hout reshape with LAST_Iw, for row_buffer_ctrl use hint(=hout) and last config in code
	parameter ADDR_WIDTH=32
	
	
)(
 
 input logic clk,
 input logic rstn,
  // 接口：接fc data buffer ram
  output   logic  [ADDR_WIDTH-1:0] RAM_writer_wr_ADDR[BATCH],                                                               
  output   logic  [AF-1:0]RAM_writer_byte_en[BATCH],   // 写入时是一个数据一个数据写入，所以一个addr需要通过byte选通写入AF次                            
  output   logic  [AF-1:0][DATA_WIDTH-1:0] RAM_writer_wr_data[BATCH],      
  // 接口：接conv 输出
  output logic [LAST_Wh-1:0]pe2row_fifo_array1_rden,                      
  output logic pe2row_ready,                                              
  input  logic [LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0]fifo_array1_dataout, 
  input  logic pe2row_data_valid,
  //指示信号
  output logic buffer_writer_done,
  input logic buffer_writer_en                                       
    );

  
  //pooling ram read                                                                   
  logic [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] pooling_rd_addr[2] ;             
  logic [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] pooling_rd_data[2] ;
                                                                                       
  //pooling ram write                                                                  
  logic [BUffER_RAM_COUNT-1:0]pooling_wren[2] ;                                   
  logic [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] pooling_wr_addr[2] ;               
  logic [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] pooling_wr_data[2];  
  
  
  
  
  
  localparam LAST_N_UP=ceil(LAST_N,LAST_Wh);
   fc_buffer_writer_with_pooling #(
    .AF(AF),
    .BATCH(BATCH),
    .DATA_WIDTH       ( DATA_WIDTH       ),
    .REAL_HINT        ( REAL_HINT        ),  
    .REAL_HOUT        ( REAL_HOUT        ),
    .K                ( K                ),
    .S                ( S                ),
    .LAST_N           ( LAST_N_UP        ),  //  补0影响到上下界。需要向上取整
    .LAST_Wh          ( LAST_Wh          ),
    .LAST_Ww          ( LAST_Ww          ),
    .LAST_Ih          ( LAST_Ih          ),
    .LAST_Iw          ( LAST_Iw          ),
    .LAST_Bi          ( LAST_Bi          ), 
    .ADDR_WIDTH       ( ADDR_WIDTH       )
     
  ) row_buffer_writer_u
  (.*);
  
  
 // 接收数据要做pooling后再存储，所以生成组缓存内存，用于临时存储。
 // pooling ram 打多一拍后写入，改善时序性能 
  logic [BUffER_RAM_COUNT-1:0]pooling_wren_t[2] ;                                   
  logic [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] pooling_wr_addr_t[2] ;               
  logic [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] pooling_wr_data_t[2];  
  
  always_ff @(posedge clk or negedge rstn)
  begin 
  	if(rstn==0)
  			begin 
  				pooling_wren_t[0]<=0;
  				pooling_wren_t[1]<=0;
  				pooling_wr_addr_t[0]<=0;
  				pooling_wr_addr_t[1]<=0;
  				pooling_wr_data_t[0]<=0;
  				pooling_wr_data_t[1]<=0;
  		  end 
  	else 
  		begin 
  			pooling_wren_t<=pooling_wren;
  			pooling_wr_addr_t<=pooling_wr_addr;
        pooling_wr_data_t<=pooling_wr_data;
      end
  end 
 genvar n,m; 
    generate  // RAM width = LAST_Iw*8  Depth= LAST_N (writer中考虑向上取整)                   
  	for(m=0;m<2;m=m+1)                            
  		for(n=0;n<BUffER_RAM_COUNT;n=n+1)           
  		begin :fc_pooling_mem_loop   
  			user_ram #(
  			.RAM_DEPTH(LAST_N_UP+10),
  			.RAM_WIDTH(LAST_Iw*DATA_WIDTH)
  			)  pooling_ram_temp 
  			(
  			.clk(clk),                               
 			  .wea(pooling_wren_t[m][n]),                 
 			  .addra(pooling_wr_addr_t[m][n]),            
 			  .dina(pooling_wr_data_t[m][n]),             
 			                              
 			  .addrb(pooling_rd_addr[m][n]),            
 			  .doutb(pooling_rd_data[m][n])				      
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
