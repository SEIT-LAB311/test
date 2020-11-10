`timescale  1ns / 1ps

module tb_row_buffer_ctrl;

// row_buffer_ctrl Parameters
parameter PERIOD            = 10                      ;
parameter DATA_WIDTH        = 8                       ;
parameter REAL_HINT         = 10                      ;
parameter REAL_HOUT         = 10                      ;
parameter K                 = 3                       ;
parameter S                 = 1                       ;
parameter LAST_PK           = 2                       ;
parameter LAST_C            = 16                     ;
parameter LAST_N            = 16                     ;
parameter LAST_Wh           = 2                       ;
parameter LAST_Ww           = 29                      ;
parameter LAST_Ih           = 29                      ;
parameter LAST_Iw           = 7                       ;
parameter LAST_Bi           = 4                       ;
parameter LAST_CKK          = LAST_C*K*K              ;
parameter NEXT_PK           = 2                       ;
parameter NEXT_C            = 16                     ;
parameter NEXT_N            = 16                     ;
parameter NEXT_Wh           = 2                       ;
parameter NEXT_Ww           = 29                      ;
parameter NEXT_Ih           = 29                      ;
parameter NEXT_Iw           = 7                       ;
parameter NEXT_Bi           = 4                       ;
parameter NEXT_CKK          = NEXT_C*K*K              ;
parameter HOUT=int'($ceil(real'(REAL_HOUT)/NEXT_Iw)*NEXT_Iw);  // hout is not divisible , need adding 0  // must use real'  ,or that int'/int'=int', ceil is useless
parameter HINT=int'($ceil(real'(REAL_HINT)/LAST_Iw)*LAST_Iw);
parameter BUffER_RAM_COUNT=int'($ceil(real'(REAL_HINT)/LAST_Iw));
parameter ADDR_WIDTH        = 32                      ;
parameter RCC_WIDTH         = 10+10+10                ;
parameter ROW_WIDTH         = 10                      ;

// row_buffer_ctrl Inputs
    logic clk                            = 0 ;
    logic rstn                           = 0 ;
    logic buffer_writer_done            ;
    logic  [BUffER_RAM_COUNT-1:0 ]buffer_writer_ram_wren ;
    logic  [BUffER_RAM_COUNT-1:0 ][ADDR_WIDTH-1:0] buffer_writer_ram_wr_addr ;
    logic  [BUffER_RAM_COUNT-1:0 ][LAST_Iw-1:0][DATA_WIDTH-1:0] buffer_writer_ram_wr_data ;
    logic [BUffER_RAM_COUNT-1:0 ][LAST_Iw-1:0][DATA_WIDTH-1:0] buffer_rd_data[K+S] ;
    logic  pe_ctrl_ready                 = 0 ;
    logic  pe_buffer_switch              = 0 ;

// row_buffer_ctrl Outputs
   logic buffer_writer_en               ;
   logic [BUffER_RAM_COUNT-1:0 ][ADDR_WIDTH-1:0] buffer_rd_addr[K+S] ;
   logic [BUffER_RAM_COUNT-1:0 ]buffer_wren[K+S] ;
   logic [BUffER_RAM_COUNT-1:0 ][ADDR_WIDTH-1:0] buffer_wr_addr[K+S] ;
   logic [BUffER_RAM_COUNT-1:0 ][LAST_Iw-1:0][DATA_WIDTH-1:0] buffer_wr_data[K+S] ;
   logic [HOUT-1:0][DATA_WIDTH-1:0]pe_ctrl_data ;
   logic [2:0][ROW_WIDTH-1:0]R_C_Channel  ;
   logic row_buffer_data_valid          ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

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
    .ROW_WIDTH        ( ROW_WIDTH        ))
 u_row_buffer_ctrl (
    .*);


integer i,j,k;
initial
begin
   addr_data_init;
   #(2*PERIOD) ;
   forever addr_data;
end

initial 
begin 
	
	forever writer_done;

end      

initial 
begin 
//	pe_buffer_switch=0;
//	#(150*PERIOD)
//	pe_buffer_switch=1;
//  #(PERIOD)
//  pe_buffer_switch=0;
//  forever pe_b_switch;    
forever pe_addr_data;
end 




task addr_data;  // 使用全局的变量

@(negedge clk )
	begin 
	foreach(buffer_writer_ram_wr_addr[i])
		buffer_writer_ram_wr_addr[i]=buffer_writer_ram_wr_addr[i]+1;
	foreach(buffer_writer_ram_wr_data[i,j])
		buffer_writer_ram_wr_data[i][j]=buffer_writer_ram_wr_data[i][j]+1;
	foreach(buffer_writer_ram_wren[i])
		buffer_writer_ram_wren[i]=1;
	end 
endtask
task addr_data_init;

  begin 
	foreach(buffer_writer_ram_wr_addr[i])
		buffer_writer_ram_wr_addr[i]=0;
	foreach(buffer_writer_ram_wr_data[i,j])
		buffer_writer_ram_wr_data[i][j]=0;
	foreach(buffer_writer_ram_wren[i])
		buffer_writer_ram_wren[i]=1;
	end 
endtask		


task writer_done;

@(negedge clk )
	if(buffer_writer_en==1) 
		begin 
			#(PERIOD)
		  buffer_writer_done=0;
		  #(50*PERIOD) buffer_writer_done=1;
		end 
  else 
 		 buffer_writer_done=buffer_writer_done;
endtask

task pe_b_switch;
begin 
	#(50*PERIOD)
	pe_buffer_switch=1;
	#(PERIOD)
	pe_buffer_switch=0;
end 
endtask

task pe_addr_data;
begin 
	wait(row_buffer_data_valid==1);	
		begin 
		 #(PERIOD/2);
		 pe_ctrl_ready=1;
		 for(i=0;i<3;i=i+1)
		 	for(j=0;j<LAST_N;j=j+1)
		 	begin
		 		#(PERIOD); 
		 		R_C_Channel[0]=i;
		 		R_C_Channel[1]=0;
		 		R_C_Channel[2]=j;
		  end 
		  #(PERIOD*2);
		  pe_buffer_switch=1;
		  #(PERIOD)          
		  pe_buffer_switch=0;
		end 
		
end 
endtask
			



endmodule