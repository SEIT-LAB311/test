`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
fc_pe
1. fc 计算核心。
2. 2周期延迟
3. 乘法，加法树，量化


*/
// 
//////////////////////////////////////////////////////////////////////////////////


module vgg_fc_pe
#(
  parameter DATA_WIDTH=8,
	parameter WEIGHT_WIDTH=DATA_WIDTH,	
	parameter PARTIAL_SUM_WIDTH=WEIGHT_WIDTH+DATA_WIDTH,
	parameter PRECISION=4,
	parameter AF=3
)
(
	input wire rstn,
	input wire clk,
	
	input wire pe_run,
	input wire signed [WEIGHT_WIDTH-1:0] weight [AF],
	input wire signed [DATA_WIDTH-1:0] data[AF],
	
	output wire signed[DATA_WIDTH-1:0] partial_sum_quantification

    );
  reg signed [PARTIAL_SUM_WIDTH-1:0] partial_sum;  
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
  
  localparam MUL_2_WIDTH = 2**log2(AF);
  localparam SUM_COUNT= log2(AF) ;// 
   reg signed [DATA_WIDTH*2-1+SUM_COUNT:0] mul_temp[0:MUL_2_WIDTH-1];  
  wire signed [DATA_WIDTH*2-1+SUM_COUNT:0] mul_temp_t[0:MUL_2_WIDTH-1]; 
  reg signed [DATA_WIDTH*2-1+SUM_COUNT:0] partial_sum_t; 
  reg signed [DATA_WIDTH*2-1+SUM_COUNT+1:0] partial_sum_t2; 
  genvar i;
  generate 
  //调用乘法
  	for(i=0;i<AF;i++)
  		begin : mul_loop 
  			mul2  #(.DATA_WIDTH(DATA_WIDTH),
  			.SUM_COUNT(SUM_COUNT))
  			u_mul(
  			.ain($signed(data[i])),
  			.bin($signed(weight[i])),
  			.cout(mul_temp_t[i])
  			);
  		end 
  endgenerate
  
    integer n,m;
  integer k;
  always@(*)      // tree structure 加法树
  begin 
  	for(n=0;n<MUL_2_WIDTH;n=n+1)
  	begin 
  	   if(n<AF) 
  	   	mul_temp[n]=mul_temp_t[n];
  	   else 
  	    mul_temp[n]=0; 	      	    
  	end 
  	k=0;
  for(n=SUM_COUNT;n>0;n=n-1)
  	begin 
  		
  	 for(m=0;m<2**(n-1);m=m+1)
  	 begin 
  	   mul_temp[m]=$signed(mul_temp[m*2])+$signed(mul_temp[m*2+1]);
  	   
  	 end 
  	end   	
  end 
  
  
  // 寄存一级
  always@(posedge clk or negedge rstn )
  begin 
  	if (rstn==0)
  		begin 
  			partial_sum_t<=0;
  			
  		end  	
  	else 
  			partial_sum_t<=	mul_temp[0]   ;
  end  	 	
  
  // 量化 ：组合逻辑
  always@(*)
  begin 
  	partial_sum_t2=$signed(partial_sum_t)+$signed(partial_sum);
  	if($signed(partial_sum_t2)>=2**(DATA_WIDTH*2-1))
			  	   	  partial_sum_t2=2**(DATA_WIDTH*2-1)-1;
			  	   else if ($signed(partial_sum_t2)<-2**(DATA_WIDTH*2-1))
			  	      partial_sum_t2=-2**(DATA_WIDTH*2-1);
			  	   else 
			  				partial_sum_t2=partial_sum_t2;
  end 
  
  
  always@(posedge clk or negedge rstn )
  begin 
  	if (rstn==0)
  		begin 
  			partial_sum<=0;
  			
  		end  		
  	else 
	  		if(pe_run==1)  
	  			begin
			  		 
			  				partial_sum<=partial_sum_t2;
	  		  end
  			else
  				partial_sum<=0;  			
  end 	  
 // 数据量化 16-》8
 reg signed [DATA_WIDTH-1:0] data_temp;   
 localparam  PRECISION_MAX=(2**(DATA_WIDTH-1)-1)*(2**PRECISION);//32bit
 localparam  PRECISION_MIN=-PRECISION_MAX-1;             //32bit
 
  always@(*)
       begin 
        if($signed(partial_sum)>PRECISION_MAX)
            begin 
            data_temp=2**(DATA_WIDTH-1)-1;
            end 
        else if ($signed(partial_sum)<PRECISION_MIN)
            begin 
            data_temp=-2**(DATA_WIDTH-1);
            end
        else
        	begin  
        		data_temp=$signed(partial_sum)>>PRECISION;
       		end
     	 end   
       
 assign  partial_sum_quantification=data_temp;
       
  
  
    
    
endmodule
