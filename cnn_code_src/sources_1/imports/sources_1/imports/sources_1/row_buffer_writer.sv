`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
row_buffer_writer
1. 基础模块：对接conv输出数据，按一定格式读取conv输出数据，并按照设定好的规律往ROW buffer中写入
2. 有限制：IW*WH《= HOUT（》的时候，是另外一种规律，这里不实现）
*/
//////////////////////////////////////////////////////////////////////////////////





module row_buffer_writer#(
parameter DATA_WIDTH=8,
	parameter REAL_HINT=56,
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
	parameter PE_RAM_DEPTH=HINT/LAST_Iw* ceil(LAST_N,LAST_Wh)/LAST_Wh, // 对LAST_Iw 向上取整；
	parameter ADDR_WIDTH=32,
	parameter RCC_WIDTH=10+10+10,   // row , col , channel 
  parameter ROW_WIDTH=10

)
(
  input  logic clk,
  input  logic rstn,
  //对接data buffer 写入总线
  output logic  [BUffER_RAM_COUNT-1:0]buffer_writer_ram_wren, // ceil(hout /IW)
  output logic  [BUffER_RAM_COUNT-1:0][ADDR_WIDTH-1:0] buffer_writer_ram_wr_addr,
  output logic  [BUffER_RAM_COUNT-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0] buffer_writer_ram_wr_data,
  //控制信号
 (* max_fanout = 50 *) output logic buffer_writer_done,
  input  logic buffer_writer_en,
 //对接上层conv 输出总线 
  output logic [LAST_Wh-1:0]pe2row_fifo_array1_rden, 
  output logic pe2row_ready,                                    
  input  logic [LAST_Wh-1:0][LAST_Iw-1:0][DATA_WIDTH-1:0]fifo_array1_dataout,             
  input  logic pe2row_data_valid 
  
);

 localparam STATE1=4'd1,
	          STATE2=4'd2,
	          STATE3=4'd3,
	          STATE4=4'd4,
	          STATE5=4'd5,
	          STATE6=4'd6,
	          STATE7=4'd7,
	          STATE8=4'd8;    
 //减少扇出  
 (* max_fanout = 50 *) logic [3:0] current_state,next_state;
 (* max_fanout = 50 *) logic [LAST_Wh-1:0] rden;
 (* max_fanout = 50 *) logic [LAST_Wh-1:0] wren_temp;
 (* max_fanout = 50 *) logic [BUffER_RAM_COUNT-1:0] wren;// ram count 
 (* max_fanout = 50 *) logic[log2(PE_RAM_DEPTH):0] counter;
 (* max_fanout = 50 *) logic [0:LAST_Wh-1][LAST_Iw-1:0][DATA_WIDTH-1:0]data;
  
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
				  STATE1:begin 
				  	next_state=STATE2;
				  		
					end
					STATE2:begin 							
						if(buffer_writer_en==1)
							next_state=STATE3;
			      else
			      	next_state=STATE2;			
					end
					STATE3:begin 
						 if(pe2row_data_valid==1)
						 	next_state=STATE4;
						 else
						  next_state=STATE3;
					end
					STATE4:begin 
						if(counter== PE_RAM_DEPTH-1)
							next_state=STATE5;
						else
							next_state=STATE4;						 
					end
					STATE5:begin 
						if(wren_temp==0)
							next_state=STATE6;
						else 
							next_state=STATE5;
					end
					STATE6:begin 
						 next_state=STATE2;
						 
					end

					 
					default: next_state=STATE1;
			endcase
	end 
	
	always_ff@(posedge clk or negedge rstn)  // rden rd_data
	begin 
		if(rstn==0)
			begin 
				  counter<=0;
	  		 	rden<='0;	  	
	  		 	pe2row_ready<=0;	 	
				  buffer_writer_done<=0;		 		
		end 
	  else
	 begin 
	  	case(current_state)
	  		 STATE1:begin 
	  		 	counter<=0;
	  		 	rden<='0;
	  		 	pe2row_ready<=0;
				  buffer_writer_done<=0;		 				  		 
					end
					STATE2:begin 
						if(buffer_writer_en==1) 
							buffer_writer_done<=0;
						
						
					end
					STATE3:begin 
						pe2row_ready<=1; 
						if(pe2row_data_valid==1)
							begin 
								rden[0]<=1;
								counter<=0;
							end 
						
					end
					STATE4:begin 
						counter<=counter+1;						
						if(counter== PE_RAM_DEPTH-1)
							rden[0]<=0;
						
					end
					STATE5:begin   
						 		
					end
					STATE6:begin 
						 pe2row_ready<=0;
						buffer_writer_done<=1;
					end
										
						
					
					
					
					default:   begin                  
                    counter<=0;
	  		 	rden<='0;
	  		 	pe2row_ready<=0;
				  buffer_writer_done<=0;		 		
                     end 
      endcase
     
     if(LAST_Wh>1) 
      rden[LAST_Wh-1:1]<={rden[LAST_Wh-1:1],rden[0]};
    end
  end 
 


// timming optimized ********************
  (* MAX_FANOUT = 50 *)  logic[log2(PE_RAM_DEPTH):0] data_mux;
  (* MAX_FANOUT = 50 *)  logic[log2(BUffER_RAM_COUNT):0] data_mux_0; //提前计算，减少延迟
  (* MAX_FANOUT = 50 *)  logic[log2(BUffER_RAM_COUNT):0] data_mux_wh;//提前计算，减少延迟
  
  
// 出入和输出总线switch 中使用的偏移量 data mux 控制  
		always_ff@(posedge clk or negedge rstn) // wren  
	begin 
		if(rstn==0)
			begin 
				wren_temp<='0;
		    wren<='0;
		    data_mux<=0;
		  end 
	  else 
	  		begin   			
	  			wren_temp<=rden;
	  			if(rden[0]==1 && wren_temp!={LAST_Wh{1'b1}})
	  			  begin 
	  				wren<={'0,rden};
	  				data_mux<=data_mux+1;
	  				data_mux_0<=(0+data_mux+1)%BUffER_RAM_COUNT;
	  				data_mux_wh<=(LAST_Wh-1+data_mux+1)%BUffER_RAM_COUNT;
	  			 end 
	  			  
	  			else if (rden[0]==1 && wren_temp=={LAST_Wh{1'b1}})
	  			 begin 
	  				wren<={wren,wren[BUffER_RAM_COUNT-1]};
	  			  data_mux<=data_mux+1;
	  			  data_mux_0<=(0+data_mux+1)%BUffER_RAM_COUNT;
	  				data_mux_wh<=(LAST_Wh-1+data_mux+1)%BUffER_RAM_COUNT;
	  			 end 
	  			else   
	  			begin 
	  				wren<={wren,1'b0};
	  				data_mux<=data_mux+1;
	  				data_mux_0<=(0+data_mux+1)%BUffER_RAM_COUNT;
	  				data_mux_wh<=(LAST_Wh-1+data_mux+1)%BUffER_RAM_COUNT;
	  				if(wren==0)
	  			   data_mux<=BUffER_RAM_COUNT-LAST_Wh;
	  			end 
	  		end 
	end 
	
//************************	
	
	always_comb
		foreach(buffer_writer_ram_wren[i])
			buffer_writer_ram_wren[i]  = wren[i];
	
			
	assign pe2row_fifo_array1_rden=rden;
	
	
// 输出总线地址计算
  integer i,j,k;
  always_ff@(posedge clk or negedge rstn) // wr addr 
  begin 
  	if(rstn==0)
		  	begin 
		  		foreach(buffer_writer_ram_wr_addr[i])
		  			buffer_writer_ram_wr_addr[i]<=0;
		    end 
    else 
		  	begin 
		  	foreach(wren[i])
		  		if(wren[i]==0)
		  			buffer_writer_ram_wr_addr[i]<=buffer_writer_ram_wr_addr[i];
		  		else
		  			buffer_writer_ram_wr_addr[i]<=buffer_writer_ram_wr_addr[i]+1;
		  	
		  	if(wren=={BUffER_RAM_COUNT{1'b0} })
		  		foreach(buffer_writer_ram_wr_addr[i])
		  			buffer_writer_ram_wr_addr[i]<=0;
		  	end 
	end 
	
//输入数据缓存
genvar g;

 always_ff@(posedge clk or negedge rstn) // wr data   
 begin                                                
 	if(rstn==0)                                         
 	  	begin  
 	  		foreach(data[i])
 	  		data[i]<='0;
 	    end 
 	else 
 	  data<=fifo_array1_dataout;
 end 
 	
 	
// 总线 switch 对接。  	                                         
generate   // wr data
	for(g=0;g<BUffER_RAM_COUNT;g=g+1)
	begin : wr_data_mux
    always_comb
    begin    
    //	if((0+data_mux)%BUffER_RAM_COUNT!=(LAST_Wh-1+data_mux)%BUffER_RAM_COUNT) 
    		
    		 if(data_mux_0<=g && g<=data_mux_wh)
    		
    			 buffer_writer_ram_wr_data[g]=data[g-data_mux_0];
    		
    		  else if (data_mux_0>data_mux_wh && data_mux_0<=g)
    		
    		   buffer_writer_ram_wr_data[g]=data[g-data_mux_0]; 
    		
    		  else if (data_mux_0>data_mux_wh&&g<=data_mux_wh)
    	
    	     buffer_writer_ram_wr_data[g]=data[LAST_Wh-1-data_mux_wh+g]; 
    	
    	    else 
    	
    	     buffer_writer_ram_wr_data[g]='0;

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
