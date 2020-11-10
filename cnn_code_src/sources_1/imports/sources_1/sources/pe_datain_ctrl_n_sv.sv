//////////////////////////////////////////////////////////////////////////////////
/*

pe_datain_ctrl_n_sv
1. 根据查找表生成RCC，发送RCC给row buffer 取回data
2. 实例化BI module ，将data和data在pe buffer 中的位置信息送入bi module并启动。

*/
//////////////////////////////////////////////////////////////////////////////////


/*

 version 1.1 without bi (bi is seperate module) bi=n;

 1. receive groupID and generate rowID
 2. send group id and rowid to LUT get (R,C,Channel);
 3. set ready and send (R,C,Channel) to if_buffer
 4. receive Hout x 1 data start one bi module(circulation) (n bi module at all) 
 5. send pe_buffer_switch signal to pe_buffer
 6. send row_ram_switch signal to row_ram

*/

module pe_datain_ctrl_n_sv#(
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
	parameter GROUPID_WIDTH=32,
	parameter ROWID_WIDTH=32,
	parameter HINT_PAD=HINT+K-1,
	parameter CKK=C*K*K,
	parameter RCC_WIDTH=3+2+10,   // row , col , channel 
	parameter ROW_WIDTH=10
)
(
	input wire clk,
	input wire rstn,
	
	// interface with row RAM
	input wire [HOUT-1:0][DATA_WIDTH-1:0] data_in,
	input wire row_valid,
	output wire [2:0][ROW_WIDTH-1:0]R_C_Channel, // row col Channel
	output reg row_ready,
	output reg row_RAM_switch,
	
	// interface with pe buffer
 (* MAX_FANOUT = 30 *)	output reg pe_buffer_switch,  //group switch
	input wire  buffer_ready,
	output wire [Bi-1:0]pe_buffer_fifo_we,
	output wire [ROWID_WIDTH-1:0]BI_rowID[Bi],
	output wire [DATA_WIDTH-1:0]pe_buffer_input[Bi][Iw],
		
	//test interface
	//input wire [RCC_WIDTH-1:0] rcc_in_for_test,
	output wire[GROUPID_WIDTH-1:0] groupID_o,
	output wire[ROWID_WIDTH-1:0]   rowID_o
) ;

  // interface with bi module
	reg [DATA_WIDTH-1:0] data_temp[HOUT];
	(* MAX_FANOUT = 50 *)	reg [RCC_WIDTH-1:0]R_C_Channel_r; // row col Channel
	(* MAX_FANOUT = 50 *)	reg [ROWID_WIDTH-1:0] rowID;
  (* MAX_FANOUT = 50 *)	 reg [GROUPID_WIDTH-1:0] groupID;
	reg [Bi-1:0] BI_valid;
	wire [Bi-1:0] BI_ready;
    // log2 constant function
  reg [ROWID_WIDTH-1:0] rowID_temp;
  logic [15:0] user_lut_out; 
  assign R_C_Channel[0]= {'0,R_C_Channel_r[2:0]};
  assign R_C_Channel[1]= {'0,R_C_Channel_r[4:3]};
  assign R_C_Channel[2]= {'0,R_C_Channel_r[14:5]};
  
 //1. 根据查找表生成RCC，发送RCC给row buffer 取回data 
  user_lut 
  #(.Ih(Ih),
    .CKK(CKK)
  ) user_lut_rom
  (
   .row(rowID),
   .group(groupID),
   .dout(user_lut_out)
  );
  
	
	localparam STATE1=4'd1,
	          STATE2=4'd2,
	          STATE3=4'd3,
	          STATE4=4'd4,
	          STATE5=4'd5,
	          STATE6=4'd6,
	          STATE7=4'd7;
	 
	     
	(* MAX_FANOUT = 30 *)	reg [3:0] current_state,next_state;
	
	always@(posedge clk or negedge rstn)
	begin 
		if(rstn==0)
			current_state<=STATE1;
		else 
			current_state<=next_state;          
	end 
	

	//localparam GROUP_MAX= $ceil(CKK/Ih)-1;    
localparam GROUP_MAX=ceil(CKK,Ih)/Ih-1;  // must use real  ,or that int/int=int, ceil is useless
  always@(*)
  begin 
  	if(rstn==0)
  		next_state=STATE1;
  	else 
  		case(current_state)
  			STATE1: //idle
  				next_state=STATE2;
  			STATE2: //wait
  				//if(data_valid && buffer_ready) 
  				if(row_valid)
  					next_state=STATE3;
  				else 
  					next_state=STATE2;
  			STATE3:
  					next_state=STATE4;
  			STATE4:
  					if(BI_ready==0)
  						next_state=STATE4;
  					else if (rowID<Ih-1)
  						next_state<=STATE2;
  					else 
  						next_state=STATE5;
  			STATE5:
  					if(rowID<Ih-1)
  						next_state=STATE3; // not use
  					else if ( rowID==Ih-1 && groupID<GROUP_MAX)
  						next_state=STATE6;
  					else 
  						next_state=STATE7;
  			STATE6:
  					if(buffer_ready==1 &&  (~BI_ready)=={Bi{1'b0}})
  						next_state=STATE3;
  					else 
  						next_state=STATE6;
  						
  			STATE7: //clear
  					if(buffer_ready==1 &&  (~BI_ready)=={Bi{1'b0}})
  					  next_state=STATE1;
  					else 
  						next_state=STATE7;
  			default: next_state=STATE1;
  		endcase
  end 
  
  
  integer n;
  always@(posedge clk or negedge rstn)
  	begin 
  		
  		if(rstn==0)
  		begin 
  					  //****reset value******
  						groupID<=0;
  						rowID<=0;  						
  						//GROUP_MAX<=CKK/Ih;  						
  						BI_valid<=0;
  						R_C_Channel_r<=0;
  						row_RAM_switch<=0; 						
  						pe_buffer_switch<=0;
  						row_ready<=0;
  						//**********************	
  		end 
  		else 
  			case(current_state)
  				STATE1:
  					begin 
  						//****reset value******
  						groupID<=0;
  						rowID<=0;  						
  						//GROUP_MAX<=CKK/Ih;  						
  						BI_valid<=0;
  						R_C_Channel_r<=0;
  						row_RAM_switch<=0; 						
  						pe_buffer_switch<=pe_buffer_switch;
  						row_ready<=0;
  						//**********************	
  					end 
  				STATE2:
  					begin 
  						row_ready<=1;
  						if(row_valid==1)
  							begin 
  								R_C_Channel_r<=user_lut_out; //1. 根据查找表生成RCC，发送RCC给row buffer 取回data
  							end  						
  					end 
  				STATE3:
  					begin 
  					//	pe_buffer_fifo_we<=0;
  				  end 
  				
  				STATE4:
  					begin 
  						if(BI_ready==0)
  							BI_valid<=0;  						 
  						else 
  						begin 
	
	  							for (n=0;n<Bi;n=n+1)
	  							begin : bi_valid_loop
	  								if(BI_ready[n]==1'b1)
	  									BI_valid<=1'b1<<n;  // Make the highest bit priority highest through language rules
	  							end 
	  							
	  				    rowID_temp<=rowID;
	  				    foreach (data_temp[n])
	  					     data_temp[n]<=data_in[n];	//1. 根据查找表生成RCC，发送RCC给row buffer 取回data
	  					     
	  					  if((rowID<Ih-1))
	  					  	begin 
	  					  	 // R_C_Channel_r<=rom_lut(groupID,rowID+1); //lut(groupID,rowID);
  								 rowID<=rowID+1;
  								end 	
	  					  
  					  end 
  						
  						
  						
  					end 
  				
  				STATE5:
  					begin 
  						BI_valid<=0;
  			     	if (rowID<Ih-1)
  						//next_state=STATE3; // not use
  							begin
  								 R_C_Channel_r<=rom_lut(groupID,rowID+1); //lut(groupID,rowID);
  								 rowID<=rowID+1;
  							end
  					  else if ( rowID==Ih-1 && groupID<GROUP_MAX)
  						//next_state=STATE6;
  							begin		
  								rowID<=0;	
  								groupID<=groupID+1;	
  								//R_C_Channel_r<=rom_lut(groupID+1,0);				 
  							end
  					  else 
  						//next_state=STATE7;
  						begin 
  						row_RAM_switch<=1;
  					  end 
  					end 
  				
  				STATE6:
  					begin 
  						
  						if(buffer_ready==1 && (~BI_ready)=={Bi{1'b0}})
  							begin 
  							// to STATE3
  							pe_buffer_switch<=!pe_buffer_switch;
  							R_C_Channel_r<=user_lut_out; //1. 根据查找表生成RCC，发送RCC给row buffer 取回data
  						  end 
  					end 
  				
  				STATE7:
  					begin 
  						
  						row_ready<=0;
  						row_RAM_switch<=0;
  						groupID<=0;
  						rowID<=0;
  						
  						if(buffer_ready==1 && (~BI_ready)=={Bi{1'b0}})
  							pe_buffer_switch<=~pe_buffer_switch;
  					end 
  				default:
  					begin 
  						//****reset value******
  						groupID<=0;
  						rowID<=0;  						
  						//GROUP_MAX<=CKK/Ih;  						
  						BI_valid<=0;
  						R_C_Channel_r<=0;
  						row_RAM_switch<=0; 						
  						pe_buffer_switch<=pe_buffer_switch;
  						row_ready<=0;
  						//**********************
  					end 
  			endcase
    end 
    
    
    
    
  //2. 实例化BI module ，将data和data在pe buffer 中的位置信息送入bi module并启动。  
  // bi module connect
  genvar i;
  generate 
  	for(i=0;i<Bi;i=i+1)
  	begin : bi_hardware_loop
  		bi_model_sv#(
  	 .DATA_WIDTH    ( DATA_WIDTH    ), 																																																																			
	   .HOUT          ( HOUT          ), 																																		
	   .K             ( K             ), 																																																																		
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
	   .CKK           ( CKK           ), 																																		
	   .RCC_WIDTH     ( RCC_WIDTH     )
  		) bi_u (
  		.clk(clk),
  		.rstn(rstn),
  		//input 
  		.rowID(rowID_temp),
  		.data_temp(data_temp),
  		.data_valid(BI_valid[i]),
  		
  		//output 
  		.ready(BI_ready[i]),
  		.pe_buffer_fifo_we(pe_buffer_fifo_we[i]),
  		.rowID_r(BI_rowID[i]),
  		.pe_buffer_input(pe_buffer_input[i])
  		
  		)	;
  	end 
  endgenerate					
  							
  
 	
 	// test interface
 	assign groupID_o=groupID;
 	assign rowID_o=rowID;
 	
 function [RCC_WIDTH-1:0 ]rom_lut;  // simulate rom LUT 
 input [GROUPID_WIDTH-1:0] groupID;
 input [ROWID_WIDTH-1:0] rowID; 
 begin 
 		rom_lut=groupID+rowID;
 end 
 endfunction
    
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
	
	
	
