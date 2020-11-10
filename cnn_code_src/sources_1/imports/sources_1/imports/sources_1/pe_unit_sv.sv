`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 中间打了3拍，延迟3clk输出结果
//////////////////////////////////////////////////////////////////////////////////


module pe_unit_sv#
(	parameter DATA_WIDTH=8,
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
	)(

  input wire clk,
  input wire rstn,
  
  input wire run,
  input wire signed[DATA_WIDTH-1:0] I_data[0:Ih-1],
  input wire signed[DATA_WIDTH-1:0] W_data[0:Ww-1],
  
  output reg signed[2*DATA_WIDTH-1:0] partial_sum,
  output reg fifo_wren,
  output reg fifo_rden

    );
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
  
  localparam MUL_2_WIDTH = 2**log2(Ww);
  localparam SUM_COUNT= log2(Ww) ;// 
  reg signed [DATA_WIDTH*2-1+SUM_COUNT:0] mul_temp[0:MUL_2_WIDTH-1];  
  wire signed [DATA_WIDTH*2-1+SUM_COUNT:0] mul_temp_t[Ww];  
  reg signed [DATA_WIDTH*2-1+SUM_COUNT:0] mul_temp_t2[Ww]; 
  reg signed [DATA_WIDTH*2-1+SUM_COUNT:0] partial_sum_t; 
  genvar i;
  generate 
  	for(i=0;i<Ww;i++)
  		begin : mul_loop 
  			mul2  #(.DATA_WIDTH(DATA_WIDTH),
  			.SUM_COUNT(SUM_COUNT))
  			u_mul(
  			.ain(I_data[i]),
  			.bin(W_data[i]),
  			.cout(mul_temp_t[i])
  			); 
  		
   //dsp 输出打第一拍
		   always@(posedge clk or negedge rstn)
		   begin 
		   		if(rstn==0)
		   			mul_temp_t2[i]<=0;
		   	  else 
		   	  	mul_temp_t2[i]<=mul_temp_t[i];
		   
		   end 
		  end 
  endgenerate
  
  integer n,m;
  integer k;
  always@(*)      // tree structure
  begin 
  	for(n=0;n<MUL_2_WIDTH;n=n+1)
  	begin 
  	   if(n<Ww) 
      	mul_temp[n]=mul_temp_t2[n];
  	   else 
  	    mul_temp[n]=0; 	      	    
  	end 
  	k=0;
  	for(n=SUM_COUNT;n>0;n=n-1)
  	begin 
  		
  	 for(m=0;m<2**(n-1);m=m+1)
  	 begin 
  	 //  mul_temp[m]=$signed(mul_temp[m*2])+$signed(mul_temp[m*2+1]);
  	    mul_temp[m]=mul_temp[m*2]+mul_temp[m*2+1];
  	 end 
  	end   	
  end 
 // 加法树后打第二拍   
  always@(posedge clk or negedge rstn )
  begin 
      if (rstn==0)
          begin 
              partial_sum_t<=0;
              
          end      
      else 
              partial_sum_t<=mul_temp[0]   ;
  end           	
 // 16bit-8bit 量化打第三拍
  always@(posedge clk or negedge rstn )
  begin 
  	if (rstn==0)
  		begin 
  			partial_sum<=0;
  			
  			fifo_rden<=0;
  			fifo_wren<=0;
  		end  		
  	else 
  		if(run==1)  
  		begin  
  			  	if($signed(partial_sum_t)>=2**(DATA_WIDTH*2-1))
                                partial_sum<=2**(DATA_WIDTH*2-1)-1;
                 else if ($signed(partial_sum_t)<-2**(DATA_WIDTH*2-1))
                                partial_sum<=-2**(DATA_WIDTH*2-1);
                  else 
                                partial_sum<=partial_sum_t;
  				
  			fifo_wren<=1;
  
  			
  		end 
  		else
  		begin  
  			partial_sum<=0;
  			fifo_wren<=0;
  		end 
  			
  end 	  
  
  
endmodule
