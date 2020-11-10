//////////////////////////////////////////////////////////////////////////////////
/*
row_buffer_ctrl
1. 控制row buffer ram 切换
2. 控制writer 读写
3. 提供取值接口给pe top
*/
//////////////////////////////////////////////////////////////////////////////////
module row_buffer_ctrl #(
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
  
  
  // buffer_writer signal
  input logic buffer_writer_done,
  output logic buffer_writer_en,
  
  
  // buffer_writer ram write   ---interface with writer
  input logic  [BUffER_RAM_COUNT-1:0]buffer_writer_ram_wren,
  input logic  [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] buffer_writer_ram_wr_addr,
  input logic  [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] buffer_writer_ram_wr_data,
  
  //row buffer 0~K+S-1  read   ---interface with buffer ram 
  output logic [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] buffer_rd_addr[K+S],
  input  logic [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] buffer_rd_data[K+S],
  
  //row buffer 0~K+S-1write    ---interface with buffer ram
  output logic [BUffER_RAM_COUNT-1:0]buffer_wren[K+S],
  output logic [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] buffer_wr_addr[K+S],
  output logic [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] buffer_wr_data[K+S],
  
  // interface with pe_datain 
  output logic [HOUT-1:0][DATA_WIDTH-1:0]pe_ctrl_data,
  input logic  [2:0][ROW_WIDTH-1:0]R_C_Channel,
  output logic row_buffer_data_valid,
  input logic  pe_ctrl_ready,
  input logic  pe_buffer_switch

  //interface with pe_out 
  //input logic pe_out_data_valid

);

 (* MAX_FANOUT = 50 *) logic [10:0] row_counter;
 (* MAX_FANOUT = 50 *) logic [3:0]  buffer_shift_mark;
 (* MAX_FANOUT = 50 *)  logic[2:0]  buffer_writer_index;
 (* MAX_FANOUT = 50 *) logic[2:0]  R_RAM_index [K+1];  // 0-3 
  localparam 	 STATE1=4'd1,
	          STATE2=4'd2,
	          STATE3=4'd3,
	          STATE4=4'd4,
	          STATE5=4'd5,
	          STATE6=4'd6,
	          STATE7=4'd7,
	          STATE8=4'd8;    
   
 (* MAX_FANOUT = 50 *) logic [3:0] current_state,next_state;
   always_ff@(posedge clk or negedge rstn)
	begin 
		if(rstn==0)
			current_state<=STATE1;
		else 
			current_state<=next_state;          
	end 
	
	always_comb
	begin 
		if(rstn==0)
			next_state=STATE1;
		else 
			case(current_state)
				  STATE1:begin  // idle
				  		next_state=STATE2;
					end
					STATE2:begin 	// writer en ; write	0					
								next_state=STATE3;						
					end
					STATE3:begin  // writer en ; write	1			
							if(buffer_writer_done)
								next_state=STATE8;
							else 
								next_state=STATE3;
					end         
					STATE8:       // wait one  clock
							next_state=STATE4;
					STATE4:begin  // wait write 1 done
							if(buffer_writer_done==1)
								next_state=STATE5;
							else
								next_state=STATE4;
					end
					STATE5:begin  // start pe read data 
							if(pe_buffer_switch==1)
								next_state=STATE6;
							else 
								next_state=STATE5;
					end
					STATE6:begin // row buffer switch status update
							if(buffer_writer_done==1)
								next_state=STATE7;
							else 
								next_state=STATE6;
								
					end
					STATE7:begin // row buffer switch status update
							
								next_state=STATE5;
					end
					
					 
					default: next_state=STATE1;
			endcase
	end 
	
	always_ff@(posedge clk or negedge rstn)
	begin 
		if(rstn==0)
			begin // idle 
				  		 //next_state=STATE2;
				  		 row_counter<=0;
				  		 buffer_shift_mark<=0;
				  		 buffer_writer_en<=0;
				  		 buffer_writer_index<=0;
				  		 row_buffer_data_valid<=0;
				  		 R_RAM_index[0] <= 4;
				  		 R_RAM_index[1] <= 4;
				  		 R_RAM_index[2] <= 4;
				  		 R_RAM_index[3] <= 4;
				  		 
					end
	  else
	  	case(current_state)
	  		 STATE1:begin // idle 
				  		 //next_state=STATE2;
				  		 row_counter<=0;
				  		 buffer_shift_mark<=0;
				  		 buffer_writer_en<=0;
				  		 buffer_writer_index<=0;
				  		 row_buffer_data_valid<=0;
				  		 R_RAM_index[0] <= 4;
				  		 R_RAM_index[1] <= 4;
				  		 R_RAM_index[2] <= 4;
				  		 R_RAM_index[3] <= 4;
				  		 
					end
					STATE2:begin  // writer 0
               
               	buffer_writer_en<=1;
               	buffer_writer_index<=0;
               
               
					end
					STATE3:begin  // writer 1 
						  buffer_writer_en<=0;
						  if(buffer_writer_done)
						  	begin
               	buffer_writer_en<=1;
               	buffer_writer_index<=1;
               end
							
					end
					STATE8: ;// wait 1  clk
					
					STATE4:begin // writer 2 start
						  buffer_writer_en<=0;
						  if(buffer_writer_done)
						  	begin
               	buffer_writer_en<=1;
               	buffer_writer_index<=2;
               end 
							
					end
					STATE5:begin  // working // row buffer switch status update
						 buffer_writer_en<=0;
						 row_buffer_data_valid<=1;
						 if(row_counter==0)
						 	begin 
						 		R_RAM_index[0] <= 4; // x
						 		R_RAM_index[1] <= (row_counter+buffer_shift_mark)%4;
						 		R_RAM_index[2] <= (row_counter+buffer_shift_mark+1)%4;
						 	end
						 else if(row_counter==REAL_HOUT-1)
						 	begin 
						 		R_RAM_index[0] <=  (row_counter+buffer_shift_mark-1)%4;
						 		R_RAM_index[1] <= (row_counter+buffer_shift_mark)%4;
						 		R_RAM_index[2] <= 4;
						 	end 
						 else 
						 	begin 
						 		R_RAM_index[0] <=  (row_counter+buffer_shift_mark-1)%4;
						 		R_RAM_index[1] <= (row_counter+buffer_shift_mark)%4;
						 		R_RAM_index[2] <= (row_counter+buffer_shift_mark+1)%4;
						 	end 
						 	if(pe_buffer_switch==1)
						 		begin 
						 			row_buffer_data_valid<=0;
						 			row_counter<=row_counter+1;
						 		end 
						 	
					end
					STATE6:begin // buffer switch  ,writer next buffer // row buffer switch status update
							if(buffer_writer_done==1)
								begin 
								  buffer_writer_en<=1;
								  buffer_writer_index<=(row_counter+buffer_shift_mark+2)%4;
								end 
					end
					STATE7:begin // checking if 1 fm finnish // row buffer switch status update
						      buffer_writer_en<=0;
						      if(row_counter==REAL_HOUT)
						      	begin 
						      			buffer_shift_mark<=(row_counter+buffer_shift_mark)%4;
						      		  row_counter<=0;
						      	end						
						
					end
					
					
					default:  begin // idle 
				  		 //next_state=STATE2;
				  		 row_counter<=0;
				  		 buffer_shift_mark<=0;
				  		 buffer_writer_en<=0;
				  		 buffer_writer_index<=0;
				  		 R_RAM_index[0] <= 4;
				  		 R_RAM_index[1] <= 4;
				  		 R_RAM_index[2] <= 4;
				  		 R_RAM_index[3] <= 4;
				  		 
					end
      endcase
  end 
  
  //************  pe read data generate *************

                             
  logic [ADDR_WIDTH-1:0] data_in_rd_addr;
  logic [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] data_in_rd_data; 
  logic [REAL_HOUT-1:0][DATA_WIDTH-1:0] data_in_rd_data_temp; 
  
  
  logic [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] ram_rd_data_temp[K+S+1];
  logic [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] ram_rd_addr[K+S+1];
  integer i,j,k,l;

  always_comb  // read side connect
  begin 
  		foreach(ram_rd_data_temp[i,j,k])
  		if(i==K+S)
  			ram_rd_data_temp[i][j][k]=0;  // for row padding and ifmap group ceil
  		else 
  			ram_rd_data_temp[i][j][k]=buffer_rd_data[i][j][k]; 		
  		
  		
  		foreach(buffer_rd_addr[i,j])
  		  buffer_rd_addr[i][j]=ram_rd_addr[i][j];
  		  	
  			
  	
  end 
  //************** pe_datain connect ****************
  logic [ROW_WIDTH-1:0] ROW_new,COL_new,ROW_old,COL_old;
  logic [ADDR_WIDTH-1:0] channel;
  
  always_ff@(posedge clk or negedge rstn)
  begin 
  	if(rstn==0)
  		begin 
  			ROW_old<=0;
  			COL_old<=0;
  		end 
  	else 
  		begin 
        ROW_old<=R_C_Channel[0];
   			COL_old<=R_C_Channel[1];
   		end 
  end
  //新的立即数 用作 ram寻址输出，旧的reg数用作把输出处理(两个switch） 
  assign channel={32'd0,R_C_Channel[2]};   
  assign  ROW_new=R_C_Channel[0];
  assign  COL_new=R_C_Channel[1];
     
  integer index_temp_new,index_temp_old;
  
  always_comb //控制row buffer ram 切换
  begin // switch may need case 
  	  index_temp_new={'0,R_RAM_index[ROW_new]};    // ctrl index
  	  index_temp_old={'0,R_RAM_index[ROW_old]};
  	  data_in_rd_data=ram_rd_data_temp[index_temp_old]; //read  data switch
  	  
  	  data_in_rd_data_temp={{DATA_WIDTH{1'b0}} , data_in_rd_data, {DATA_WIDTH{1'b0}} } >>(COL_old*DATA_WIDTH); //col pading 
  	  
  	 
  	   pe_ctrl_data={'0,data_in_rd_data_temp};  // output,可能舍弃可能补全0
  	  
  	  
  	  data_in_rd_addr=pe_ctrl_ready&&row_buffer_data_valid ? channel:'1;    
  	  
  	  foreach(ram_rd_addr[i,j])  // addr switch 
  	  if(i==index_temp_new)
  	    ram_rd_addr[i][j]=data_in_rd_addr; // control all ram of 1 buffer
  	  else 
  	  	ram_rd_addr[i][j]='1;
  	   	  
  end 
  // buffer_writer connect with row buffer wr bus 
  always_comb //控制row buffer ram 切换
  begin 
  	foreach(buffer_wren[i,j])  
  	 	if(i==buffer_writer_index)
	  	 	begin 
	  	 	   buffer_wren[i]=	buffer_writer_ram_wren;
	  	 	   buffer_wr_addr[i]=buffer_writer_ram_wr_addr;  
	  	 	   buffer_wr_data[i]=  buffer_writer_ram_wr_data;
	  	 	end 
  	 	else 
	  	 	begin 
	           buffer_wren[i][j]=0;
	  	    buffer_wr_addr[i][j]=0; 
	        buffer_wr_data[i][j]=0; 	     	  	     
	      end     	                                       
  end 
  
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