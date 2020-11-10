`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
 全连接层top （可以被仿真）
 1. 定义参数（fc层的参数使用原始的参数传递方式）
 2. 定义信号
 3. 定义主模块 vgg_fc
 4. 定义weight fifo
 5. 定义负责乒乓切换的fc_switch
 6. 


*/
//////////////////////////////////////////////////////////////////////////////////

// chinese GBK 936 
module vgg16_fc_top
#(
	parameter AF=3,
  parameter BATCH=9,
  parameter FOUT1=4096,
	parameter FOUT2=4096,
	parameter FOUT3=1000,
  parameter FIN1=8379,          // 注意，这里的FOUT不能整除AF     
  parameter FIN2=1366,        // 如FOUT1，在fin2中会被补全，计算的数据会多出几个
  parameter FIN3=1366,       // 所以weight也要做类似的处理，最后AF组数据用0补全
  parameter FIN4=1002 ,      // 这样，就算计算数据多几个，因为weight=0，不影响结果
	parameter WEIGHT_WIDTH=8,
	parameter DATA_WIDTH=8,
	parameter PRECISION=4,  // 1+3+4,  4 decimal
	parameter ADDR_WIDTH=32,
	
	parameter REAL_HINT=14,       // 被 ctrl 连接时注意 大小
	parameter REAL_HOUT=7,	  
	
	parameter K=3,
	parameter S=1,
	
	//last conv configuration
	parameter LAST_PK=2,

	parameter LAST_N=512,
	parameter LAST_Wh=6,
	parameter LAST_Ww=17,
	parameter LAST_Ih=17,
	parameter LAST_Iw=1,
	parameter LAST_Bi=1

  
)(
  input logic clkin,
  input logic rstn,
	// 数据输入接口：与conv13层数据对接接入。
  output logic [LAST_Wh-1:0]pe2row_fifo_array1_rden,                      
  output logic pe2row_ready,                                              
  input  logic [LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0]fifo_array1_dataout, 
  input  logic pe2row_data_valid,
	
	//全连接层结果输出。
  output logic [AF-1:0][DATA_WIDTH-1:0] result_data[BATCH],
  input logic [ADDR_WIDTH-1:0] result_rd_ADDR, // 0- $ceil(real(FOUT3)/AF)-1
  output logic result_valid,
  input logic result_ready,


  //全连接层权重数据输入接口。
  input logic weight_fifo_wren,
  input logic [AF-1:0][DATA_WIDTH-1:0] weight_fifo_din,
  output logic weight_fifo_full


    );                                                                                               

    logic clk; 
//     clk_wiz_0 u_clk1 
//     (
//     .clk_in1(clkin),
//     .reset(!rstn),
//     .clk_out1(clk)
//     );

//********************初始化RAM接口*********************//

  assign clk=clkin;
  // ram 0 read
    logic  [ADDR_WIDTH-1:0] RAM0_rd_ADDR[BATCH];                                                                                                           // 统一控制Batch个ram                                                                                      
    logic   [AF-1:0][DATA_WIDTH-1:0] RAM0_rd_data[BATCH];     
                                                                               
  // ram 0 write                                                                                                                                                                                                                                                                        
    logic  [ADDR_WIDTH-1:0] RAM0_wr_ADDR[BATCH];                                                                                                                                                                                     
    logic  [AF-1:0]RAM0_byte_en[BATCH];   // 写入时是一个数据一个数据写入，所以一个addr需要通过byte选通写入AF次                                                             
    logic  [AF-1:0][DATA_WIDTH-1:0] RAM0_wr_data[BATCH];
  
  
   // ram 1 read                                                                                                                          
    logic  [ADDR_WIDTH-1:0] RAM1_rd_ADDR[BATCH];                                                                                                                                                                                
   logic   [AF-1:0][DATA_WIDTH-1:0] RAM1_rd_data[BATCH];     
                                                                               
   // ram 1 write                                                                                                                                                                                                                                                                        
    logic  [ADDR_WIDTH-1:0] RAM1_wr_ADDR[BATCH];                                                                                                                                                                                     
    logic  [AF-1:0]RAM1_byte_en[BATCH];   // 写入时是一个数据一个数据写入，所以一个addr需要通过byte选通写入AF次                                                             
    logic  [AF-1:0][DATA_WIDTH-1:0] RAM1_wr_data[BATCH];
  
 
	  // FC_ram read 
	  logic  [ADDR_WIDTH-1:0] FC_ram_rd_ADDR;                                                                                                                                                                                
	  logic  [AF-1:0][DATA_WIDTH-1:0] FC_ram_rd_data[BATCH];     
	  
	  // FC_ram write
	  logic   [ADDR_WIDTH-1:0] FC_ram_wr_ADDR;                                                                                                                                                                                     
	  logic  [AF-1:0]FC_ram_byte_en;   // 写入时是一个数据一个数据写入，所以一个addr需要通过byte选通写入AF次 ;一次读batch                                                            
	  logic  [AF-1:0][DATA_WIDTH-1:0] FC_ram_wr_data[BATCH]	  ;

                                                                                                                                             
	  //ram2 read                                                                                                                               
	  logic [ADDR_WIDTH-1:0] RAM2_rd_ADDR;                                                                                                
	  logic RAM2_rden;              // 统一控制Batch个ram                                                                                      
	  logic [AF-1:0][DATA_WIDTH-1:0] RAM2_rd_data[BATCH];                                                                                 
                                                                                                                                             
    //ram2 write                                                                                                                             
    logic  [ADDR_WIDTH-1:0] RAM2_wr_ADDR;                                                                                                
    logic  RAM2_wren;              // 统一控制Batch个ram                                                                                      
    logic  [AF-1:0]RAM2_byte_en;  // 写入时是一个数据一个数据写入，所以一个addr需要通过byte选通写入AF次                                                              
    logic  [AF-1:0][DATA_WIDTH-1:0] RAM2_wr_data[BATCH];                                                                                 
                                                                                                                                             
    //  weight fifo read                                                                                                                       
    logic    weight_fifo_rden;                                                                                                              
    logic [AF-1:0][DATA_WIDTH-1:0] fifo_weight; //一个数据复用给batch个输入data                                                                    
    logic [ADDR_WIDTH-1:0] prog_empty_thresh;                                                                                           
    logic prog_empty;                         //设置programeble empty用于valid，即weight counter 为fin_max时才取消empty(即满足一次计算)                    
    
    logic FC_data_valid;
    logic FC_PE_ready; 
    logic FC_buffer_switch;
    
    
    logic buffer_writer_done; 
    logic buffer_writer_en;  
    logic  [ADDR_WIDTH-1:0] RAM_writer_wr_ADDR[BATCH];                                                               
    logic  [AF-1:0]RAM_writer_byte_en[BATCH];   // 写入时是一个数据一个数据写入，所以一个addr需要通过byte选通写入AF次                            
    logic  [AF-1:0][DATA_WIDTH-1:0] RAM_writer_wr_data[BATCH];  
  
  //FC主模块，负责fc层计算，还有计算数据的读入和写出。
  vgg_fc #(
    .AF           ( AF           ),
    .BATCH        ( BATCH        ),
    .FIN1         ( FIN1         ),
    .FIN2         ( FIN2         ),
    .FIN3         ( FIN3         ),
    .FOUT1        ( FOUT1        ),
    .FOUT2        ( FOUT2        ),
    .FOUT3        ( FOUT3        ),
    .WEIGHT_WIDTH ( WEIGHT_WIDTH ),
    .DATA_WIDTH   ( DATA_WIDTH   ),
    .PRECISION    ( PRECISION    ),
    .ADDR_WIDTH ( ADDR_WIDTH )) 
    u_vgg_fc(
    .clk(clk),                                                               //   input logic clk,                                                                                                        
    .rstn(rstn),                                                             //  	input logic rstn,                                                                                                      
                                                                             //  	                                                                                                                      
                                                                             //  	// interface with FC_BUFFER_WRITER                                                                                    
    .FC_data_valid           (FC_data_valid),                                           //  	input logic FC_data_valid,                                                                                             
    .FC_PE_ready             ( FC_PE_ready                           ),      //  	output logic FC_PE_ready,                                                                                               
    .FC_buffer_switch        ( FC_buffer_switch                      ),      //  	output logic FC_buffer_switch, // 维持一个clk周期                                                                             
                                                                             //  	                                                                                                                      
                                                                             //  	// Ram1 read                                                                                                          
    .RAM1_rd_ADDR            ( FC_ram_rd_ADDR                          ),      //  	output logic  [ADDR_WIDTH-1:0] RAM1_rd_ADDR,                                                                            
    .RAM1_rden               (                                     ),      //  	output logic  RAM1_rden,              // 统一控制Batch个ram                                                                  
    .RAM1_rd_data            ( FC_ram_rd_data                      ),      //  	input logic  [AF-1:0][DATA_WIDTH-1:0] RAM1_rd_data[BATCH],                                                             
                                                                             //  	                                                                                                                      
                                                                             //  	//ram1 write                                                                                                          
    .RAM1_wr_ADDR            ( FC_ram_wr_ADDR                          ),      //   output logic  [ADDR_WIDTH-1:0] RAM1_wr_ADDR,                                                                           
    .RAM1_wren               (                                       ),      //  	output logic  RAM1_wren,              // 统一控制Batch个ram                                                                  
    .RAM1_byte_en            ( FC_ram_byte_en                         ),      //  	output logic  [AF-1:0]RAM1_byte_en,   // 写入时是一个数据一个数据写入，所以一个addr需要通过byte选通写入AF次                                         
    .RAM1_wr_data            ( FC_ram_wr_data                          ),      //  	output logic  [AF-1:0][DATA_WIDTH-1:0] RAM1_wr_data[BATCH],                                                             
                                                                             //  	                                                                                                                      
                                                                             //  	//ram2 read                                                                                                           
    .RAM2_rd_ADDR            ( RAM2_rd_ADDR                          ),      //  	output logic  [ADDR_WIDTH-1:0] RAM2_rd_ADDR,                                                                            
    .RAM2_rden               ( RAM2_rden                             ),      //  	output logic  RAM2_rden,              // 统一控制Batch个ram                                                                  
    .RAM2_rd_data            ( RAM2_rd_data                          ),      //   input  logic [AF-1:0][DATA_WIDTH-1:0] RAM2_rd_data[BATCH],                                                            
                                                                             //                                                                                                                         
                                                                             //    //ram2 write                                                                                                         
    .RAM2_wr_ADDR            ( RAM2_wr_ADDR                          ),      //   output logic  [ADDR_WIDTH-1:0] RAM2_wr_ADDR,                                                                           
    .RAM2_wren               ( RAM2_wren                             ),      //  	output logic  RAM2_wren,              // 统一控制Batch个ram                                                                  
    .RAM2_byte_en            ( RAM2_byte_en                          ),      //  	output logic  [AF-1:0]RAM2_byte_en,  // 写入时是一个数据一个数据写入，所以一个addr需要通过byte选通写入AF次                                          
    .RAM2_wr_data            ( RAM2_wr_data                          ),      //  	output logic  [AF-1:0][DATA_WIDTH-1:0] RAM2_wr_data[BATCH],                                                             
                                                                             //  	                                                                                                                      
                                                                             //  	// weight fifo read                                                                                                   
    .fifo_weight             ( fifo_weight                           ),      //  	output logic weight_fifo_rden,                                                                                          
    .prog_empty              ( prog_empty                            ),      //  	input logic [AF-1:0][DATA_WIDTH-1:0] fifo_weight, //一个数据复用给batch个输入data                                                
    .weight_fifo_rden        ( weight_fifo_rden                      ),      //  	output logic [ADDR_WIDTH-1:0] prog_empty_thresh,                                                                       
    .prog_empty_thresh       ( prog_empty_thresh                     ),      //  	input logic prog_empty,                         //设置programeble empty用于valid，即weight counter 为fin_max时才取消empty(即满足一次计算)
                                                                             //                                                                                                              
                                                                             //    // result output                                                                                                     
    .result_rd_ADDR          ( result_rd_ADDR                        ),      //    output logic [AF-1:0][DATA_WIDTH-1:0] result_data[BATCH],                                                              
    .result_ready            ( result_ready                          ),      //    input logic [ADDR_WIDTH-1:0] result_rd_ADDR, // 0- $ceil(real(FOUT3)/AF)-1                                            
    .result_data             ( result_data                           ),      //    output logic result_valid,                                                                                             
    .result_valid            ( result_valid                          )       //    input logic result_ready                                                                                              
    
);
    

                                         
  user_fifo_prog_empty #(
  .FIFO_WIDTH(AF*DATA_WIDTH),
  .FIFO_DEPTH(16384),
  .FIFO_READ_LATANCY(1)
  ) u_weight_fifo
  (
  .clk (clk ),
  .rstn (rstn),
  .din(weight_fifo_din),
  .wr_en(weight_fifo_wren),
  .rd_en(weight_fifo_rden),
  .user_prog_empty_thresh({32'd0,prog_empty_thresh}),    // 如果不不满，高位为Z，输出会有问题  。ram同理
  
  .dout(fifo_weight),
  .full(weight_fifo_full),
  .empty(weight_fifo_empty),
  //.data_count(data_count),
  .user_prog_empty(prog_empty)
  
  );
  

 // 负责 乒乓切换数据接收存储器。（接收conv输出数据，每组batch个fm） 
  FC_switch #(
   .AF           ( AF           ),
    .BATCH        ( BATCH        ),
    .FIN1         ( FIN1         ),
    .FIN2         ( FIN2         ),
    .FIN3         ( FIN3         ),
    .FOUT1        ( FOUT1        ),
    .FOUT2        ( FOUT2        ),
    .FOUT3        ( FOUT3        ),
    .WEIGHT_WIDTH ( WEIGHT_WIDTH ),
    .DATA_WIDTH   ( DATA_WIDTH   ),
    .PRECISION    ( PRECISION    ),
    .ADDR_WIDTH   (ADDR_WIDTH)      
  ) u_fc_swtich
  ( 
   .clk(clk),
   .rstn(rstn),
   
   .writer_done(buffer_writer_done),
   .writer_en(buffer_writer_en),
   
   .FC_data_valid(FC_data_valid),
   .FC_buffer_switch,
    
   .RAM0_rd_ADDR       (RAM0_rd_ADDR        ),
   .RAM0_rd_data       (RAM0_rd_data        ),
                      
   .RAM0_wr_ADDR       (RAM0_wr_ADDR        ),
   .RAM0_byte_en       (RAM0_byte_en        ),
   .RAM0_wr_data       (RAM0_wr_data        ),
                      
   .RAM1_rd_ADDR       (RAM1_rd_ADDR        ),
   .RAM1_rd_data       (RAM1_rd_data        ),
                      
   .RAM1_wr_ADDR       (RAM1_wr_ADDR        ),
   .RAM1_byte_en       (RAM1_byte_en        ),
   .RAM1_wr_data       (RAM1_wr_data        ),
                      
   .RAM_writer_wr_ADDR (RAM_writer_wr_ADDR  ),
   .RAM_writer_byte_en (RAM_writer_byte_en  ),
   .RAM_writer_wr_data (RAM_writer_wr_data  ),   
                       
   .FC_ram_rd_ADDR     (FC_ram_rd_ADDR      ),
   .FC_ram_rd_data     (FC_ram_rd_data      ),
                    
   .FC_ram_wr_ADDR     (FC_ram_wr_ADDR      ),
   .FC_ram_byte_en     (FC_ram_byte_en      ),
   .FC_ram_wr_data     (FC_ram_wr_data      )
  
  );
  //与conv对接，读取pe out 的数据，写入fc data buffer
  fc_writer #(
    .AF(AF),
    .BATCH(BATCH),
    .DATA_WIDTH       ( DATA_WIDTH       ),
    .REAL_HINT        ( REAL_HINT        ),  
    .REAL_HOUT        ( REAL_HOUT        ),
    .K                ( K                ),
    .S                ( S                ),
    .LAST_N           ( LAST_N        ),  //  补0影响到上下界。需要向上取整
    .LAST_Wh          ( LAST_Wh          ),
    .LAST_Ww          ( LAST_Ww          ),
    .LAST_Ih          ( LAST_Ih          ),
    .LAST_Iw          ( LAST_Iw          ),
    .LAST_Bi          ( LAST_Bi          ),  
    .ADDR_WIDTH       ( ADDR_WIDTH       )
   ) u_fc_writer
   (.*);
  
  genvar i;
  generate
  	for(i=0;i<BATCH;i=i+1)
  	   begin : batch_Ram0
  	   	 user_ram_byte_en #(
  	   	 .RAM_DEPTH(FIN1+100),
  	   	 .RAM_WIDTH(AF*DATA_WIDTH)
  	   	 ) RAM_0
  	   	 (
  	   	 .clk(clk),
  	   	 .wea  (RAM0_byte_en[i]),
  	   	 .addra(RAM0_wr_ADDR[i]),  // 如果不不满，高位为Z，输出会有问题  
  	   	 .dina (RAM0_wr_data[i]),
  	   	   	   	
  	   	 .addrb(RAM0_rd_ADDR[i]),
  	   	 .doutb(RAM0_rd_data[i])
  	   	 );

  	   end 
  endgenerate
  
  // batch ram 1 
  
  generate
  	for(i=0;i<BATCH;i=i+1)
  	   begin : batch_Ram1
  	   	user_ram_byte_en #(
  	   	 .RAM_DEPTH(FIN1+100),
  	   	 .RAM_WIDTH(AF*DATA_WIDTH)
  	   	 ) RAM_1
  	   	 (
  	   	 .clk(clk),    
  	   	 .rstn(rstn),
  	   	 .wea  (RAM1_byte_en[i]),
  	   	 .addra(RAM1_wr_ADDR[i]),  // 如果不不满，高位为Z，输出会有问题  
  	   	 .dina (RAM1_wr_data[i]),
  	   	   	   	
  	   	 .addrb(RAM1_rd_ADDR[i]),
  	   	 .doutb(RAM1_rd_data[i])
  	   	 );

  	   end 
  endgenerate
  
  
  generate                         
  	for(i=0;i<BATCH;i=i+1)         
  	   begin : batch_Ram2 
  	   	user_ram_byte_en #(
  	   	 .RAM_DEPTH(FIN2+100),
  	   	 .RAM_WIDTH(AF*DATA_WIDTH)
  	   	 ) RAM_2
  	   	 (
  	   	 .clk(clk), 
  	   	 .rstn(rstn),
  	   	 .wea  (RAM2_byte_en),
  	   	 .addra(RAM2_wr_ADDR),  // 如果不不满，高位为Z，输出会有问题  
  	   	 .dina (RAM2_wr_data[i]),
  	   	   	   	
  	   	 .addrb(RAM2_rd_ADDR),
  	   	 .doutb(RAM2_rd_data[i])
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
endmodule
