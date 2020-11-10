`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/04 20:50:47
// Design Name: 
// Module Name: bi_model
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


module bi_model_sv#(
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
	parameter Bi=1,
	parameter GROUPID_WIDTH=8,
	parameter ROWID_WIDTH=6,
	parameter HINT_PAD=HINT+K-1,
	parameter CKK=C*K*K,
	parameter RCC_WIDTH=2+6+9
)
(
	input wire  clk ,
	input wire  rstn,
	
	input wire  [ROWID_WIDTH-1:0] rowID,
	input wire  [DATA_WIDTH-1:0] data_temp[HOUT],
	input wire  data_valid,
	
	(* max_fanout = 30 *)output reg  ready,
	(* MAX_FANOUT = 30 *)	output reg  pe_buffer_fifo_we,
	(* MAX_FANOUT = 30 *)	output reg  [ROWID_WIDTH-1:0]rowID_r,
	output wire [DATA_WIDTH-1:0] pe_buffer_input[Iw]

    );
    
  localparam STATE1=4'd1,
	          STATE2=4'd2,
	          STATE3=4'd3;
	(* MAX_FANOUT = 30 *)	reg [3:0] current_state,next_state;
	(* MAX_FANOUT = 30 *)reg [log2(HOUT/Iw):0]T_counter;
		
	
	always@(posedge clk or negedge rstn)
	begin 
		if(rstn==0)
			current_state<=STATE1;
		else 
			current_state<=next_state;          
	end 
	       
  always@(*)
  begin
  	case(current_state)
  		STATE1: 
  			next_state=STATE2;
  		STATE2:
  			if(data_valid==0)
  				next_state=STATE2;
  			else 
  				next_state=STATE3;
  		STATE3:
  			if(T_counter<HOUT/Iw-1)
  				next_state=STATE3;
  			else 
  				next_state=STATE2;
  		default:
  				next_state=STATE1;
  	endcase 
  end 
  
  always@(posedge clk or negedge rstn )
  begin 
  		if(rstn==0)
  		begin 
				rowID_r<=0;
				pe_buffer_fifo_we<=0;
				ready<=0;
				T_counter<=0;
			end 
			else 
				case(current_state)
					STATE1:
						begin 
							rowID_r<=0;
				      pe_buffer_fifo_we<=0;
				      ready<=0;
				      T_counter<=0;
				    end 
				  STATE2:
				  	begin 
				  		ready<=1;
				  		if(data_valid==1)
				  			begin 
				  				T_counter<=0;
				  				pe_buffer_fifo_we<=1;
				  				rowID_r<=rowID;
				  				ready<=0;
				  			end 
				  	end 
				  STATE3:
				  	begin 
				  		T_counter<=T_counter+1;
				  		if(T_counter==HOUT/Iw-1)
				  			pe_buffer_fifo_we<=0;
				  	end 
				  default:
				  	begin 
				  		rowID_r<=0;
							pe_buffer_fifo_we<=0;
							ready<=0;
							T_counter<=0;
						end 
				endcase
	end 
				  
(* max_fanout = "10" *)  reg[DATA_WIDTH-1:0] register [0:Iw-1][0:HOUT/Iw];
  
  genvar i,j;
  generate
  	for(i=0;i<=Iw-1;i=i+1)
  	begin : clr
  		always@(posedge clk or negedge rstn)
  				begin 
  					if(rstn==0)
  						register[i][HOUT/Iw]<=0;
  				end 
  				
  		assign pe_buffer_input[i]=register[i][0];
    end 
   endgenerate
  
  
     // reg receive
  generate
  	for(i=0;i<=Iw-1;i=i+1)
  		for(j=0;j<=HOUT/Iw-1;j=j+1)
  			begin : Bi
  				always@(posedge clk or negedge rstn)
  				begin 
  					if(rstn==0)
  						register[i][j]<=0;
  					else if (pe_buffer_fifo_we==0)
  						register[i][j]<=data_temp[i+Iw*j];
  					else if (pe_buffer_fifo_we==1)
  						register[i][j]<=register[i][j+1];
  					else 
  						;
  				end 
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
