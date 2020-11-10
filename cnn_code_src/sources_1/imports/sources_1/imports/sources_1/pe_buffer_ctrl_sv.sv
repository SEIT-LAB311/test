`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*

pe_buffer_ctrl_sv
1. bi model switch to  pe buffer interface 
2. 控制pe buffer 乒乓切换
3. 准备pe array 计算用的data和weight数据（并启动）

*/
//////////////////////////////////////////////////////////////////////////////////


module pe_buffer_ctrl_sv
#(
	parameter DATA_WIDTH=8,
	parameter HINT=56,
	parameter HOUT=56,
	parameter K=3,
	parameter PK=2,
	parameter C=256,
	parameter N=256,
	parameter S=1,
	parameter Wh=2,
	parameter Ww=29,
	parameter Ih=29,
	parameter Iw=7,
	parameter Bi=4,
	parameter GROUPID_WIDTH=8,
	parameter ROWID_WIDTH=6,
	parameter HINT_PAD=HINT+K-1,
	parameter CKK=C*K*K,
	parameter RCC_WIDTH=2+6+9   // row , col , channel 
)
(

  input clk,
  input rstn,
   
  // pe_datain_ctrl   fifo write  (fifo is in this module)
 	input wire  pe_buffer_switch,  //group switch
	output reg  buffer_ready,
	input  wire [Bi-1:0]pe_buffer_fifo_we,
	input  wire [ROWID_WIDTH-1:0]BI_rowID[Bi],
	input  wire [DATA_WIDTH-1:0]pe_buffer_input[Bi][Iw],
	
	// interface with weight buffer  fifo
	input wire [Wh-1:0][Ww-1:0][DATA_WIDTH-1:0] weight_buffer,
	input wire weight_buffer_valid,
	output reg weight_buffer_rden,
	////interface with  pe ram ctrl  (pe array is in this module)
	output wire [2*DATA_WIDTH-1:0]partial_sum [Iw][Wh],
	output wire pe_out_fifo_wren[Iw][Wh],
  output wire pe_out_fifo_rden[Iw][Wh],
  
  
  input wire  ram_output_blocked
    );

  // fifo
  integer n,m,p;
  reg [DATA_WIDTH-1:0] buffer_input [2][Ih][Iw] ;
  reg [Ih-1:0] fifo_wren [2];
  reg [Ih-1:0] fifo_rden [2];
  reg [DATA_WIDTH-1:0] buffer_output [2][Ih][Iw] ;
  wire [Ih-1:0] full [2];
  wire [Ih-1:0] empty [2];
  
   //**************  fifo output and pe_array  
   reg I_data_valid;                           
  (* max_fanout =100 *) reg fifo_output_select;
  
  // state mechine
  (* max_fanout =100 *) reg [3:0] current_state,next_state;
  (* max_fanout =50 *) reg [log2(N/Wh):0] W_counter;
  (* max_fanout =50 *) reg [log2(HOUT/Iw):0] I_counter;
	(* max_fanout =50 *) reg pe_array_run; 
	(* max_fanout =20 *) reg [DATA_WIDTH-1:0]pe_datain_I[Ih][Iw];   // from pe buffer to pe array
	(* max_fanout =20 *) reg [Wh-1:0][Ww-1:0][DATA_WIDTH-1:0]pe_datain_W; 
	 // hand over cntrol to pe array from pe datain                                                    
	 reg [Ih-1:0] fifo_wren_r;  // for pe array control
	 reg [Ih-1:0] fifo_rden_r;
 
	
	reg [Iw*DATA_WIDTH-1:0] buffer_input_temp [2][Ih] ;
	reg [Iw*DATA_WIDTH-1:0] buffer_output_temp [2][Ih];
	
	
	// for array to vector for ip interface  接口一维和多维转换，这是旧版代码，没写好，用好合并数组是不需要的
	always@(*)
	begin 
		
		for (n=0;n<2;n=n+1)  
			for(m=0;m<Ih;m=m+1)
				for(p=0;p<Iw;p=p+1)
		   		begin    
		   			buffer_input_temp  [n][m]=buffer_input_temp[n][m] <<DATA_WIDTH;  
		   			buffer_input_temp  [n][m][DATA_WIDTH-1:0]=buffer_input [n][m][Iw-1-p];						
						buffer_output[n][m][p]=buffer_output_temp[n][m] >>(p*DATA_WIDTH);
	        end 
	end 
	
	// 实例化 pe buffer 使用fifo实现
  genvar i,j;
   generate 
  	for(j=0;j<2;j=j+1)
  	for(i=0;i<Ih;i=i+1)
  		begin : fifo_connect_loop
  			user_fifo #(
  			.FIFO_WIDTH(Iw*DATA_WIDTH),
  			.FIFO_DEPTH(HOUT/Iw+8)
  			) f_pe_buffer_fifo
  			 (
  			.clk(clk),
  			.rstn(rstn),
  			.din(buffer_input_temp[j][i]),//
  			.wr_en(fifo_wren[j][i]),//
  			.rd_en(fifo_rden[j][i]),
  			.dout(buffer_output_temp[j][i]),
  			.full(full[j][i]),
  			.empty(empty[j][i])  			
  			);
  		end 
  endgenerate 
  

// bi input mux with bi_rowID , connect to fifo input 
 //BI MODEL switch to  pe buffer interface 
  always@(*)
  begin 
  	 if(pe_buffer_switch==0)
  	 	begin 
  	 		for(n=0;n<Ih;n=n+1)
          // interface with pe_datain_ctrl  Bi  	 		
  	 			for(m=0;m<Bi;m=m+1)     
	  	 			begin   	 	  	 			
		  	 			if(BI_rowID[m]==n&&pe_buffer_fifo_we[m]==1)  // bi module select
		  	 				begin 
		  	 					buffer_input[0][n]=pe_buffer_input[m];
		  	 					fifo_wren[0][n]=pe_buffer_fifo_we[m];
		  	 					break;
		  	 	      end 
		  	 	    else  
		  	 	    	begin 
			  	 	    	for(p=0;p<Iw;p=p+1)	
			  	 	    	begin 
			  	 	    		buffer_input[0][n][p]={DATA_WIDTH{1'b0}};
			  	 	    	end 
			  	 	    	
			  	 	    	fifo_wren[0][n]=1'b0;   
		  	 	      end 	  	 	      	  	 	      
	          end  
	          
          // interface with pe_array
       buffer_input[1]=pe_datain_I;
       fifo_wren[1]= fifo_wren_r;
       fifo_rden[0]= {Ih{1'b0}};
       fifo_rden[1]= fifo_rden_r;
      end 
      
      
     else 
     	begin 
  	 		for(n=0;n<Ih;n=n+1)
          // interface with pe_datain_ctrl  Bi  	 		
  	 			for(m=0;m<Bi;m=m+1)
	  	 			begin   	 	  	 			
		  	 			if(BI_rowID[m]==n&&pe_buffer_fifo_we[m]==1)  // or bi_rowID==0 will cause error 
		  	 				begin 
		  	 					buffer_input[1][n]=pe_buffer_input[m];
		  	 					fifo_wren[1][n]=pe_buffer_fifo_we[m];
		  	 					break;
		  	 	      end 
		  	 	    else 
		  	 	    	begin 
			  	 	    	for(p=0;p<Iw;p=p+1)	
			  	 	    	begin 
			  	 	    		buffer_input[1][n][p]={DATA_WIDTH{1'b0}};
			  	 	    	end 
			  	 	    	fifo_wren[1][n]=1'b0;   
		  	 	     end 
	          end 
          // interface with pe_array
       buffer_input[0]=pe_datain_I;
       fifo_wren[0]= fifo_wren_r;
       fifo_rden[1]= {Ih{1'b0}};
       fifo_rden[0]= fifo_rden_r;
      end   

  end 




  // buffer_ready logic (comb), 指示pe datain ctrl 启动bi传输
  always@(posedge clk or negedge rstn)  
  begin 
  	if(rstn == 0)
  		begin 
  			buffer_ready<=0;
  		end 
  	else 
  	//blocked : conv result has not sent to next layer
  	//so reset buffer ready to  stop datain flow
  		if(pe_buffer_switch==0 && empty[1]== {Ih{1'b1}}&& ram_output_blocked==0)  
  			buffer_ready<=1;
  		else if (pe_buffer_switch==1 && empty[0]== {Ih{1'b1}}&& ram_output_blocked==0)
  			buffer_ready<=1;
  		else 
  			buffer_ready<=0;
  end 
  
  //**************  fifo output and pe_array 

  always@(posedge clk or negedge rstn)  // data_valid logic (comb)
  begin 
  	if(rstn == 0)
  		begin
  			I_data_valid<=0;
  		end 
  	else 
  		if(pe_buffer_switch==0 && empty[1]== {Ih{1'b0}}) 
  		begin 
  			I_data_valid<=1;
  			fifo_output_select<=1;
  		end 
  		else if (pe_buffer_switch==1 && empty[0]== {Ih{1'b0}}) 
  		begin 
  			I_data_valid<=1;
  			fifo_output_select<=0;
  		end 
  		else 
  			I_data_valid<=0;
  end 
  
  localparam 	 STATE1=4'd1,
	          STATE2=4'd2,
	          STATE3=4'd3,
	          STATE4=4'd4,
	          STATE5=4'd5,
	          STATE6=4'd6,
	          STATE7=4'd7;

	always@(posedge clk or negedge rstn)
	begin 
		if(rstn==0)
			current_state<=STATE1;
		else 
			current_state<=next_state;          
	end      
	
	always@(*)
  begin 
  	if(rstn==0)
  		next_state=STATE1;
  	else 
  		case(current_state)
  			STATE1: //idle
  				next_state=STATE2;
  			STATE2: //wait
  				if(I_data_valid && weight_buffer_valid)
  					next_state=STATE3;
  			STATE3:
  				 next_state=STATE4;
  			STATE4:
  					if(W_counter==N/Wh-2&&I_counter==HOUT/Iw)
  						next_state=STATE5;
  					else 
  						next_state=STATE4;
  			STATE5:
  					if(I_counter<HOUT/Iw)
  						next_state=STATE5;
  					else 
  						next_state=STATE1;
  			default: next_state=STATE1;
  		endcase
  end 
  
  always@(posedge clk or negedge rstn)
	begin 
		if(rstn==0)
			begin
				fifo_rden_r<={Ih{1'b0}};    
				fifo_wren_r<={Ih{1'b0}};    
				for(n=0;n<Ih;n=n+1)      
					for(m=0;m<Iw;m=m+1)    
					begin                  
						pe_datain_I[n][m]<=0;
				//		pe_datain_W[n][m]<=0;
					end 
				pe_datain_W<='0;                                       
				I_counter<=0;                                   
				weight_buffer_rden<=0;                          
				W_counter<=0;                         
		  end
		else
			case (current_state)
				STATE1:
					begin 
						//pe_array_run<=0;
						W_counter<=0;
						I_counter<=0;
						for(n=0;n<Ih;n=n+1)
							for(m=0;m<Iw;m=m+1)
							begin 
								pe_datain_I[n][m]<=0;
							//	pe_datain_W[n][m]<=0;
							end 
					 pe_datain_W<='0;		
					 fifo_rden_r<={Ih{1'b0}};    
					 fifo_wren_r<={Ih{1'b0}};
					 weight_buffer_rden<=0;
					end 
				STATE2:
					begin 
						//W_counter<=0;
					end 
				
				STATE3:
					begin 
						fifo_rden_r<={Ih{1'b1}};
					//	fifo_wren_r<={Ih{1'b1}};
						weight_buffer_rden<=1;
					  pe_datain_W<=weight_buffer;
					  
					end 
				STATE4:
					begin 
						 
							if(I_counter<HOUT/Iw)
								begin 
									fifo_rden_r<={Ih{1'b1}};
									fifo_wren_r<={Ih{1'b1}};
									pe_datain_I<=buffer_output[fifo_output_select];
									I_counter<=I_counter+1;
			            weight_buffer_rden<=0;
		            end 
	            else 
	            	begin 
	            	 if(W_counter<N/Wh-2)
										begin
		            		fifo_rden_r<={Ih{1'b1}};
										fifo_wren_r<={Ih{1'b1}};
										pe_datain_I<=buffer_output[fifo_output_select];
										pe_datain_W<=weight_buffer;
										I_counter<=1;
				            weight_buffer_rden<=1;
				            W_counter<=W_counter+1;
				            end
			            else 
		            			begin 
			            		fifo_rden_r<={Ih{1'b1}};
											fifo_wren_r<={Ih{1'b0}};
											pe_datain_I<=buffer_output[fifo_output_select];
											pe_datain_W<=weight_buffer;
											I_counter<=1;
					            weight_buffer_rden<=1;
					            W_counter<=W_counter+1;
					        		end   
			          end 
            
            end 
         
   
        STATE5:
        	begin 
        	 	  if(I_counter<HOUT/Iw)
								begin 
									fifo_rden_r<={Ih{1'b1}};
									fifo_wren_r<={Ih{1'b0}};
									pe_datain_I<=buffer_output[fifo_output_select];
									I_counter<=I_counter+1;
			            weight_buffer_rden<=0;
			            if(I_counter==HOUT/Iw-1)
			            	fifo_rden_r<={Ih{1'b0}};
		            end 
	            else 
	            	begin 
	            		fifo_rden_r<={Ih{1'b0}};
									fifo_wren_r<={Ih{1'b0}};
									pe_datain_I<=buffer_output[fifo_output_select];
									//pe_datain_W<=weight_buffer;
									I_counter<=0;
			            weight_buffer_rden<=0;
			            W_counter<=0;
			          end 	
          end  
      endcase
  end 
    
  // pe_ram run   pe延迟3周期出结果
 (* max_fanout = 50 *) reg[1:0] pe_array_run_t;
  
  always@(posedge clk or negedge rstn)     
   begin                                     
   	if(rstn==0)       
   		begin                        
      pe_array_run<=0;
      pe_array_run_t<=0;
      end 
   	else
   	begin 
   		pe_array_run<=fifo_rden_r[0];
   		pe_array_run_t[0]<=pe_array_run;
   		pe_array_run_t[1]<=pe_array_run_t[0];
   	end 
   end  
  
   reg signed [DATA_WIDTH-1:0] I_data[Iw][Wh][Ih];
   reg signed [DATA_WIDTH-1:0] W_data[Iw][Wh][Ww];
   
 // sperate wire for  pe array ( there are data reuse)  数据准备，用好合并数组就不需要这块
   always@(*)
   begin 
   	for (n=0;n<Iw;n=n+1)  
    	for (m=0;m<Wh;m=m+1)
    		for(p=0;p<Ih;p=p+1)
        begin 
        	I_data[n][m][p]=pe_datain_I[p][n];
          W_data[n][m][p]=pe_datain_W[m][p];
        end 
   end 
   
  
  // init pe array 
  generate
  	for (i=0;i<Iw;i=i+1)
  		for (j=0;j<Wh;j=j+1) 	  
  		begin: pe_array_loop                               
			  	pe_unit_sv #(
			    .DATA_WIDTH    ( DATA_WIDTH    ),
			    .HINT          ( HINT          ),
			    .HOUT          ( HOUT          ),
			    .K             ( K             ),
			    .PK            ( PK            ),
			    .C             ( C             ),
			    .N             ( N             ),
			    .S             ( S             ),
			    .Wh            ( Wh            ),
			    .Ww            ( Ww            ),
			    .Ih            ( Ih            ),
			    .Iw            ( Iw            ),
			    .Bi            ( Bi            ),
			    .GROUPID_WIDTH ( GROUPID_WIDTH ),
			    .ROWID_WIDTH   ( ROWID_WIDTH   ),
			    .HINT_PAD      ( HINT_PAD      ),
			    .CKK           ( CKK           ),
			    .RCC_WIDTH     ( RCC_WIDTH     ))
			 u_pe_unit_sv (
			    .clk                                    ( clk       ),
			    .rstn                                   ( rstn      ),
			    .run                                    ( pe_array_run_t[1]  ),
			    .I_data (  I_data[i][j]  ),
			    .W_data (  W_data[i][j]  ),

			    .partial_sum   ( partial_sum[i][j]    ),
			    .fifo_wren                              ( pe_out_fifo_wren[i][j]),
			    .fifo_rden                              ( pe_out_fifo_rden[i][j])
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