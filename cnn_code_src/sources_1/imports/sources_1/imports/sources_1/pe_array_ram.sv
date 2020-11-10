`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
pe_array_ram
1. 接收 pe array 输出结果
2. 实例化 fifo接收， 并且采用 group 计数，进行 switch fifo0 和fifo1
3. 根据group判断是否输出data valid。
4. 根据group和输出fifo1判断是否流水线阻塞，停止前级的流水

*/
//////////////////////////////////////////////////////////////////////////////////


module pe_array_ram#(
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
	parameter RCC_WIDTH=2+6+9,   // row , col , channel 
	parameter PRECISION=4  //   DATA_WIDTH=8 = 1+3+4 SIGNED 
	
)
(
		input wire clk ,
		input wire rstn,
		//interface with pe_buffer_ctrl
		input wire [2*DATA_WIDTH-1:0]partial_sum [Iw][Wh],  // 16 = 1+7+8 
		input wire pe_out_fifo_wren[Iw][Wh],
		// interface with row rom
		input wire row_rom_ready,
		output wire [Wh-1:0][Iw-1:0][DATA_WIDTH-1:0]fifo_array1_dataout,
		output reg data_valid,
		input wire [Wh-1:0]fifo_array1_rden,    // pe result buffer out

		output wire ram_output_blocked
);

		//reg pe_out_fifo_rden[Iw][Wh];
		reg pe_out_fifo_wren_temp;

		wire [Wh-1:0]fifo_array0_wren;
		wire [Wh-1:0]fifo_array1_wren;
		wire [Wh-1:0]fifo_array0_rden;
		//wire [Wh-1:0]fifo_array1_rden;    // pe result buffer out



		reg [Iw-1:0][2*DATA_WIDTH-1:0]fifo_array0_datain[Wh];
		wire [Iw-1:0][2*DATA_WIDTH-1:0]fifo_array0_dataout[Wh];


		wire [Iw-1:0][DATA_WIDTH-1:0]fifo_array1_datain[Wh];
		//wire [Iw-1:0][DATA_WIDTH-1:0]fifo_array1_dataout[Wh];
		reg signed [Iw-1:0][DATA_WIDTH:0] data_temp[Wh];


		(* MAX_FANOUT = 10 *) reg [GROUPID_WIDTH-1:0] group_counter;


		// 0~max =max+1 group;
		localparam GROUP_MAX=ceil(CKK,Ih)/Ih-1;  // // must use real  ,or that int/int=int, ceil is useless  
		reg fifo_0_clr;
//**************************************************************//
		// counting the group ID 
		// 0-max mean a cycle
		// 计算pe array 结果 group，用于判断是否累加部分和， 和是否输出到下一层
		always@(posedge clk or negedge rstn)
		begin 
			if(rstn==0)
				begin 
					group_counter<=0;
					fifo_0_clr<=1;
				end 
			else 
				begin    // group_counter = 0-max 
					fifo_0_clr<=0;
					pe_out_fifo_wren_temp<=pe_out_fifo_wren[0][0];
					if(pe_out_fifo_wren_temp==1'b1 && pe_out_fifo_wren[0][0]==1'b0)//negedge 
							begin 
							group_counter<=group_counter+1;
							if(group_counter==GROUP_MAX)
								begin 
								group_counter<=0;
								fifo_0_clr<=1;     
							  end
							end 
			  end 
		end 

		 localparam  PRECISION_MAX=(2**(DATA_WIDTH-1)-1)*(2**PRECISION);//32bit
		 localparam  PRECISION_MIN=-PRECISION_MAX-1;             //32bit
		 
		 

///***********************connect fifo*****************************//
		// pe array 输出结果 使用fifo缓存 （虽然叫ram）
		genvar row,col ;
		generate 
			for(row=0;row<Iw;row=row+1) // row
				for(col=0;col<Wh;col=col+1)  //col
					begin : pe_result_array_loop
					 reg signed [DATA_WIDTH*2:0] fifo_array0_datain_temp;	  //要放在gennerate内部
		       // assign fifo_array0_datain[col][row]=group_counter==0       ? partial_sum[row][col]:partial_sum[row][col]+fifo_array0_dataout[col][row]; 
		       always_comb
		       begin
		       	   if(group_counter==0)
		       	   	   fifo_array0_datain[col][row]= partial_sum[row][col];
		       	   else 
		       	   		begin 
		       	   			 fifo_array0_datain_temp=$signed(partial_sum[row][col])+$signed(fifo_array0_dataout[col][row]);
		       	   			 if($signed(fifo_array0_datain_temp)>=2**(DATA_WIDTH*2-1))        
		       	   			 	  fifo_array0_datain[col][row]=2**(DATA_WIDTH*2-1)-1;                 
		       	   			 else if ($signed(fifo_array0_datain_temp)<-2**(DATA_WIDTH*2-1)) 
		       	   			    fifo_array0_datain[col][row]=-2**(DATA_WIDTH*2-1); 
		       	   			 else 
		       	   			 		fifo_array0_datain[col][row]=fifo_array0_datain_temp ;              
		       	   		end 	 
		       end   
		//  fifo array 1 Wh x  width:Iw*DATA_WIDTH depth: Ni/Wh * Hout/Iw =1024
		      // data PRECISION conversion 
		// 16bit -8bit 量化          
		       always_comb
		       begin 
		        if($signed(fifo_array0_datain[col][row])>PRECISION_MAX)
		            begin 
		            data_temp[col][row]=2**(DATA_WIDTH-1)-1;
		            
		            end 
		        else if ($signed(fifo_array0_datain[col][row])<PRECISION_MIN)
		            begin 
		            data_temp[col][row]=-2**(DATA_WIDTH-1);
		            end
		        else
		        	begin  
		        		data_temp[col][row]=$signed(fifo_array0_datain[col][row])>>PRECISION; //直接赋值二进制      		
		           
		       		end
		     	 end   
		       
		       assign  fifo_array1_datain[col][row]=data_temp[col][row];
		       
		       
		     
		       
		      end 
		endgenerate 
//**************************************************************// 
   // 实例化 fifo 并且 实现 fifo 连线 switch
		generate 
			for(col=0;col<Wh;col=col+1)  //col
			begin : col_loop

						assign fifo_array0_wren[col]=group_counter==GROUP_MAX ? 1'b0 :pe_out_fifo_wren[0][0];
		        assign fifo_array0_rden[col]=group_counter==0         ? 1'b0 :pe_out_fifo_wren[0][0]; 
				    assign fifo_array1_wren[col]=group_counter==GROUP_MAX ? pe_out_fifo_wren[0][0] : 1'b0;
				     
		    user_fifo  #(
		        .FIFO_WIDTH(Iw*2*DATA_WIDTH),
		  			.FIFO_DEPTH(N/Wh*HOUT/Iw)
		  			)pe_result_fifo0
		        (
		        .clk(clk),
		        .rstn(!fifo_0_clr),
		        .din(fifo_array0_datain[col]), 
		        .wr_en(fifo_array0_wren[col]),
		        .rd_en(fifo_array0_rden[col]),
		        .dout(fifo_array0_dataout[col]),
		        .full(),
		        .empty()  // empty output with the last data(count 0)

		        );
		  //  fifo array 1 Wh x  width:Iw*DATA_WIDTH depth: Ni/Wh * Hout/Iw =1024
		   user_fifo  #(
		        .FIFO_WIDTH(Iw*DATA_WIDTH),
		  			.FIFO_DEPTH(N/Wh*HOUT/Iw)
		  			) pe_result_fifo1
		  			(
		       .clk(clk),
		       .rstn(rstn),
		       .din(fifo_array1_datain[col]),
		       .wr_en(fifo_array1_wren[col]),
		       .rd_en(fifo_array1_rden[col]&&data_valid&&row_rom_ready),
		       .dout(fifo_array1_dataout[col]),
		       .full(),           
		       .empty()          
		    
		       );                          
		  end 
		 endgenerate
 
 
 
/*********************************************/
/************pe_array_ram_output ctrl*********/
/*********************************************/  
//用于产生 data valid 给下层使用     
   localparam 	STATE1=4'd1,
			          STATE2=4'd2,
			          STATE3=4'd3,
			          STATE4=4'd4,
			          STATE5=4'd5,
			          STATE6=4'd6,
			          STATE7=4'd7;    
   
   reg [3:0] current_state,next_state;
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
  				if(group_counter==GROUP_MAX)
  					next_state=STATE3;
  				else 
  					next_state=STATE2;
  			STATE3:
  				if(group_counter==0)
  					next_state=STATE4;
  				else 
  					next_state=STATE3;
  			STATE4:
  				if(row_rom_ready==1)
  					next_state=STATE5;
  				else 
  					next_state=STATE4;
  			STATE5:
  				if(row_rom_ready==0)
  					next_state=STATE2;
  				else 
  					next_state=STATE5;
  			
  			default:
  				  next_state=STATE1;
  		endcase
  end 
  

  
  // data valid output logic
  always@(posedge clk or negedge rstn)
  begin 
  		if(rstn==0)
  			begin 
  				data_valid<=0;
  			end 
  		else 
  			case(current_state)
  				STATE1:
							data_valid<=0;
					STATE2:
							;
					STATE3:
							;
					STATE4:
						data_valid<=1;
					STATE5:
						if(row_rom_ready==0)
						  data_valid<=0;
				default:
					data_valid<=0;
				endcase
	end 
	// output for buffer ready ,if data do not finish send to next layer,
	// datain ctrl should stop pushing data to pe buffer 
	assign ram_output_blocked=(group_counter>=GROUP_MAX-2)&&data_valid==1 ? 1:0;					

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








