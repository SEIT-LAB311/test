`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/23 18:56:53
// Design Name: 
// Module Name: VGG_CONV
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


module VGG_CONV
(  conv_top.row_buffer_in conv_data_in, 
   conv_top.pe_out       conv_result_out,
   conv_top.pe_weight_in conv_weight_1,
   conv_top.pe_weight_in conv_weight_2,
   conv_top.pe_weight_in conv_weight_3,
   conv_top.pe_weight_in conv_weight_4,
   conv_top.pe_weight_in conv_weight_5,
   conv_top.pe_weight_in conv_weight_6,
   conv_top.pe_weight_in conv_weight_7,
   conv_top.pe_weight_in conv_weight_8   ,
   conv_top.pe_weight_in conv_weight_9   ,
   conv_top.pe_weight_in conv_weight_10  ,
   conv_top.pe_weight_in conv_weight_11  ,
   conv_top.pe_weight_in conv_weight_12  ,
   conv_top.pe_weight_in conv_weight_13  ,
   input logic clkin,
   input logic rstn 
    );
import parameter_package::*;
logic clk; 
// clk_wiz_1 u_clk1 
// (
// .clk_in1(clkin),
// .resetn(rstn),
// .clk_out1(clk)
// );
  
  assign clk=clkin;  
    
//genvar m;
//generate 
//	for(m=0;m<=TEST_LAYER_COUNT;m=m+1)
//  begin : if_loop
//  	 conv_top #            
//  	 (                     
//  	 .Wh(CONV_Wh[m]),     
//  	 .Iw(CONV_Iw[m]),     
//     .Ww(CONV_Ww[m])      
//     )                     
//     conv_interface_temp (  
//     .clk(conv_data_in.clk),            
//     .rstn(conv_data_in.rstn)           
//     );                    
//  
//  end 
//endgenerate

conv_top #            
  	 (                     
  	 .Wh(CONV_Wh[1]),     
  	 .Iw(CONV_Iw[1]),     
     .Ww(CONV_Ww[1])      
     )                     
     conv_interface_1 (           
     );                    
conv_top #            
  	 (                     
  	 .Wh(CONV_Wh[2]),     
  	 .Iw(CONV_Iw[2]),     
     .Ww(CONV_Ww[2])      
     )                     
     conv_interface_2 (           
     ); 
conv_top #            
  	 (                     
  	 .Wh(CONV_Wh[3]),     
  	 .Iw(CONV_Iw[3]),     
     .Ww(CONV_Ww[3])      
     )                     
     conv_interface_3 (           
     ); 
conv_top #            
  	 (                     
  	 .Wh(CONV_Wh[4]),     
  	 .Iw(CONV_Iw[4]),     
     .Ww(CONV_Ww[4])      
     )                     
     conv_interface_4 (           
     ); 
conv_top #            
  	 (                     
  	 .Wh(CONV_Wh[5]),     
  	 .Iw(CONV_Iw[5]),     
     .Ww(CONV_Ww[5])      
     )                     
     conv_interface_5 (           
     ); 
conv_top #            
  	 (                     
  	 .Wh(CONV_Wh[6]),     
  	 .Iw(CONV_Iw[6]),     
     .Ww(CONV_Ww[6])      
     )                     
     conv_interface_6 (           
     );      
conv_top #            
  	 (                     
  	 .Wh(CONV_Wh[7]),     
  	 .Iw(CONV_Iw[7]),     
     .Ww(CONV_Ww[7])      
     )                     
     conv_interface_7 (           
     );      
conv_top #                      
  	 (                          
  	 .Wh(CONV_Wh[8]),           
  	 .Iw(CONV_Iw[8]),           
     .Ww(CONV_Ww[8])            
     )                          
     conv_interface_8 (         
        
     );                         
conv_top #                      
  	 (                          
  	 .Wh(CONV_Wh[9]),           
  	 .Iw(CONV_Iw[9]),           
     .Ww(CONV_Ww[9])            
     )                          
     conv_interface_9 (         
        
     );                         
conv_top #                      
  	 (                          
  	 .Wh(CONV_Wh[10]),           
  	 .Iw(CONV_Iw[10]),           
     .Ww(CONV_Ww[10])            
     )                          
     conv_interface_10 (         
        
     );                         
conv_top #                      
  	 (                          
  	 .Wh(CONV_Wh[11]),           
  	 .Iw(CONV_Iw[11]),           
     .Ww(CONV_Ww[11])            
     )                          
     conv_interface_11 (         
        
     );                         
conv_top #                      
  	 (                          
  	 .Wh(CONV_Wh[12]),           
  	 .Iw(CONV_Iw[12]),           
     .Ww(CONV_Ww[12])            
     )                          
     conv_interface_12 (         
        
     );                         
conv_top #                      
  	 (                          
  	 .Wh(CONV_Wh[13]),           
  	 .Iw(CONV_Iw[13]),           
     .Ww(CONV_Ww[13])            
     )                          
     conv_interface_13 (         
        
     );                         
   

    
    
//    if_loop[0].conv_interface_temp.row_buffer_in= row_data_in ; 
//    if_loop[3].conv_interface_temp.pe_out       =  pe_data_out ;  
//    
//    if_loop[1].conv_interface_temp.pe_weight_in=  pe_weight_conv_1 ;
//    if_loop[2].conv_interface_temp.pe_weight_in=  pe_weight_conv_2 ;  
//    if_loop[3].conv_interface_temp.pe_weight_in=  pe_weight_conv_3 ;  
//    
//   if_loop[0].conv_interface_temp.fifo_array1_dataout=fifo_array1_dataout;
//   if_loop[0].conv_interface_temp.pe2row_data_valid=pe2row_data_valid;
//   
//   pe2row_fifo_array1_rden=if_loop[0].conv_interface_temp.pe2row_fifo_array1_rden;
//   pe2row_ready=if_loop[0].conv_interface_temp.pe2row_ready;
   
   
    
    
    
   conv #(
    .DATA_WIDTH       ( DATA_WIDTH       ),
    .K                ( K                ),
    .S                ( S                ),
    .ADDR_WIDTH       ( ADDR_WIDTH       ),
    .ROW_WIDTH        ( ROW_WIDTH        ),
    .PRECISION        ( PRECISION        ),
            
    .LAST_C           ( CONV_C[0]          ),
    .LAST_N           ( CONV_N[0]          ),
    .LAST_Wh          ( CONV_Wh[0]         ),
    .LAST_Ww          ( CONV_Ww[0]         ),
    .LAST_Ih          ( CONV_Ih[0]         ),
    .LAST_Iw          ( CONV_Iw[0]         ),
    .LAST_Bi          ( CONV_BI[0]         ),
    .REAL_HINT        ( CONV_REAL_HOUT[1]  ),
    .REAL_HOUT        ( CONV_REAL_HINT[1]  ),
    .NEXT_C           ( CONV_C[1]         ),
    .NEXT_N           ( CONV_N[1]         ),
    .NEXT_Wh          ( CONV_Wh[1]        ),
    .NEXT_Ww          ( CONV_Ww[1]        ),
    .NEXT_Ih          ( CONV_Ih[1]        ),
    .NEXT_Iw          ( CONV_Iw[1]        ),
    .NEXT_Bi          ( CONV_BI[1]        ))
    
                      u_conv_1 (
     .pe_weight_data_in(conv_weight_1),   
     .pe_data_out      (conv_interface_1.pe_out),                             
     .row_data_in      (conv_data_in) ,  
     .clk(clk),
     .rstn(rstn)
); 
   
      conv #(                                                
    .DATA_WIDTH       ( DATA_WIDTH       ),               
    .K                ( K                ),               
    .S                ( S                ),               
    .ADDR_WIDTH       ( ADDR_WIDTH       ),               
    .ROW_WIDTH        ( ROW_WIDTH        ),               
    .PRECISION        ( PRECISION        ),               
                                                          
    .LAST_C           ( CONV_C[1]          ),              
    .LAST_N           ( CONV_N[1]          ),              
    .LAST_Wh          ( CONV_Wh[1]         ),              
    .LAST_Ww          ( CONV_Ww[1]         ),              
    .LAST_Ih          ( CONV_Ih[1]         ),              
    .LAST_Iw          ( CONV_Iw[1]         ),              
    .LAST_Bi          ( CONV_BI[1]         ),              
    .REAL_HINT        ( CONV_REAL_HOUT[2]  ),              
    .REAL_HOUT        ( CONV_REAL_HINT[2]  ),              
    .NEXT_C           ( CONV_C[2]         ),               
    .NEXT_N           ( CONV_N[2]         ),               
    .NEXT_Wh          ( CONV_Wh[2]        ),               
    .NEXT_Ww          ( CONV_Ww[2]        ),               
    .NEXT_Ih          ( CONV_Ih[2]        ),               
    .NEXT_Iw          ( CONV_Iw[2]        ),               
    .NEXT_Bi          ( CONV_BI[2]        ))               
                      u_conv_2 (                          
     .pe_weight_data_in(conv_weight_2),   
     .pe_data_out      (conv_interface_2.pe_out),         
     .row_data_in      (conv_interface_1.row_buffer_in),   
     .clk(clk),
     .rstn(rstn)
); 
   conv_pooling #(                                                
    .DATA_WIDTH       ( DATA_WIDTH       ),               
    .K                ( K                ),               
    .S                ( S                ),               
    .ADDR_WIDTH       ( ADDR_WIDTH       ),               
    .ROW_WIDTH        ( ROW_WIDTH        ),               
    .PRECISION        ( PRECISION        ),               
                                                          
    .LAST_C           ( CONV_C[2]          ),              
    .LAST_N           ( CONV_N[2]          ),              
    .LAST_Wh          ( CONV_Wh[2]         ),              
    .LAST_Ww          ( CONV_Ww[2]         ),              
    .LAST_Ih          ( CONV_Ih[2]         ),              
    .LAST_Iw          ( CONV_Iw[2]         ),              
    .LAST_Bi          ( CONV_BI[2]         ),              
    .REAL_HINT        ( CONV_REAL_HOUT[3]  ),              
    .REAL_HOUT        ( CONV_REAL_HINT[3]  ),                                                                     
    .NEXT_C           ( CONV_C[3]         ),               
    .NEXT_N           ( CONV_N[3]         ),                   
    .NEXT_Wh          ( CONV_Wh[3]        ),               
    .NEXT_Ww          ( CONV_Ww[3]        ),               
    .NEXT_Ih          ( CONV_Ih[3]        ),               
    .NEXT_Iw          ( CONV_Iw[3]        ),               
    .NEXT_Bi          ( CONV_BI[3]        ))               
                      u_conv_pool_3 (                          
     .pe_weight_data_in(conv_weight_3),   
     .pe_data_out      (conv_interface_3.pe_out),         
     .row_data_in      (conv_interface_2.row_buffer_in),      
     .clk(clk),
     .rstn(rstn)
);                                                         
     conv #(                                                
    .DATA_WIDTH       ( DATA_WIDTH       ),               
    .K                ( K                ),               
    .S                ( S                ),               
    .ADDR_WIDTH       ( ADDR_WIDTH       ),               
    .ROW_WIDTH        ( ROW_WIDTH        ),               
    .PRECISION        ( PRECISION        ),               
                                                          
    .LAST_C           ( CONV_C [3]          ),              
    .LAST_N           ( CONV_N [3]          ),              
    .LAST_Wh          ( CONV_Wh[3]         ),              
    .LAST_Ww          ( CONV_Ww[3]         ),              
    .LAST_Ih          ( CONV_Ih[3]         ),              
    .LAST_Iw          ( CONV_Iw[3]         ),              
    .LAST_Bi          ( CONV_BI[3]         ),              
    .REAL_HINT        ( CONV_REAL_HOUT[4]  ),              
    .REAL_HOUT        ( CONV_REAL_HINT[4]  ),              
    .NEXT_C           ( CONV_C        [4]         ),               
    .NEXT_N           ( CONV_N        [4]         ),               
    .NEXT_Wh          ( CONV_Wh       [4]        ),               
    .NEXT_Ww          ( CONV_Ww       [4]        ),               
    .NEXT_Ih          ( CONV_Ih       [4]        ),               
    .NEXT_Iw          ( CONV_Iw       [4]        ),               
    .NEXT_Bi          ( CONV_BI       [4]        ))               
                      u_conv_4 (                          
     .pe_weight_data_in(conv_weight_4),   
     .pe_data_out      (conv_interface_4.pe_out),         
     .row_data_in      (conv_interface_3.row_buffer_in) ,  
     .clk(clk),
     .rstn(rstn)
);  
   conv_pooling #(                                                
    .DATA_WIDTH       ( DATA_WIDTH       ),               
    .K                ( K                ),               
    .S                ( S                ),               
    .ADDR_WIDTH       ( ADDR_WIDTH       ),               
    .ROW_WIDTH        ( ROW_WIDTH        ),               
    .PRECISION        ( PRECISION        ),               
                                                          
    .LAST_C           ( CONV_C [4]          ),              
    .LAST_N           ( CONV_N [4]          ),              
    .LAST_Wh          ( CONV_Wh[4]         ),              
    .LAST_Ww          ( CONV_Ww[4]         ),              
    .LAST_Ih          ( CONV_Ih[4]         ),              
    .LAST_Iw          ( CONV_Iw[4]         ),              
    .LAST_Bi          ( CONV_BI[4]         ),              
    .REAL_HINT        ( CONV_REAL_HOUT[5]  ),              
    .REAL_HOUT        ( CONV_REAL_HINT[5]  ),                                                                     
    .NEXT_C           ( CONV_C        [5]         ),               
    .NEXT_N           ( CONV_N        [5]         ),                   
    .NEXT_Wh          ( CONV_Wh       [5]        ),               
    .NEXT_Ww          ( CONV_Ww       [5]        ),               
    .NEXT_Ih          ( CONV_Ih       [5]        ),               
    .NEXT_Iw          ( CONV_Iw       [5]        ),               
    .NEXT_Bi          ( CONV_BI       [5]        ))               
                      u_conv_pool_5 (                          
     .pe_weight_data_in(conv_weight_5),   
     .pe_data_out      (conv_interface_5.pe_out),         
     .row_data_in      (conv_interface_4.row_buffer_in),   
     .clk(clk),
     .rstn(rstn)
);  

     conv #(                                                
    .DATA_WIDTH       ( DATA_WIDTH       ),               
    .K                ( K                ),               
    .S                ( S                ),               
    .ADDR_WIDTH       ( ADDR_WIDTH       ),               
    .ROW_WIDTH        ( ROW_WIDTH        ),               
    .PRECISION        ( PRECISION        ),               
                                                          
    .LAST_C           ( CONV_C [5]          ),              
    .LAST_N           ( CONV_N [5]          ),              
    .LAST_Wh          ( CONV_Wh[5]         ),              
    .LAST_Ww          ( CONV_Ww[5]         ),              
    .LAST_Ih          ( CONV_Ih[5]         ),              
    .LAST_Iw          ( CONV_Iw[5]         ),              
    .LAST_Bi          ( CONV_BI[5]         ),              
    .REAL_HINT        ( CONV_REAL_HOUT[6]  ),              
    .REAL_HOUT        ( CONV_REAL_HINT[6]  ),              
    .NEXT_C           ( CONV_C        [6]         ),               
    .NEXT_N           ( CONV_N        [6]         ),               
    .NEXT_Wh          ( CONV_Wh       [6]        ),               
    .NEXT_Ww          ( CONV_Ww       [6]        ),               
    .NEXT_Ih          ( CONV_Ih       [6]        ),               
    .NEXT_Iw          ( CONV_Iw       [6]        ),               
    .NEXT_Bi          ( CONV_BI       [6]        ))               
                      u_conv_6 (                          
     .pe_weight_data_in(conv_weight_6),   
     .pe_data_out      (conv_interface_6.pe_out),         
     .row_data_in      (conv_interface_5.row_buffer_in),   
     .clk(clk),
     .rstn(rstn)
);  
     conv #(                                                
    .DATA_WIDTH       ( DATA_WIDTH       ),               
    .K                ( K                ),               
    .S                ( S                ),               
    .ADDR_WIDTH       ( ADDR_WIDTH       ),               
    .ROW_WIDTH        ( ROW_WIDTH        ),               
    .PRECISION        ( PRECISION        ),               
                                                          
    .LAST_C           ( CONV_C [6]          ),              
    .LAST_N           ( CONV_N [6]          ),              
    .LAST_Wh          ( CONV_Wh[6]         ),              
    .LAST_Ww          ( CONV_Ww[6]         ),              
    .LAST_Ih          ( CONV_Ih[6]         ),              
    .LAST_Iw          ( CONV_Iw[6]         ),              
    .LAST_Bi          ( CONV_BI[6]         ),              
    .REAL_HINT        ( CONV_REAL_HOUT[7]  ),              
    .REAL_HOUT        ( CONV_REAL_HINT[7]  ),              
    .NEXT_C           ( CONV_C        [7]         ),               
    .NEXT_N           ( CONV_N        [7]         ),               
    .NEXT_Wh          ( CONV_Wh       [7]        ),               
    .NEXT_Ww          ( CONV_Ww       [7]        ),               
    .NEXT_Ih          ( CONV_Ih       [7]        ),               
    .NEXT_Iw          ( CONV_Iw       [7]        ),               
    .NEXT_Bi          ( CONV_BI       [7]        ))               
                      u_conv_7 (                          
     .pe_weight_data_in(conv_weight_7),   
     .pe_data_out      (conv_interface_7.pe_out),         
     .row_data_in      (conv_interface_6.row_buffer_in),   
     .clk(clk),
     .rstn(rstn)
);  
                              
     conv_pooling #(                                                
    .DATA_WIDTH       ( DATA_WIDTH       ),               
    .K                ( K                ),               
    .S                ( S                ),               
    .ADDR_WIDTH       ( ADDR_WIDTH       ),               
    .ROW_WIDTH        ( ROW_WIDTH        ),               
    .PRECISION        ( PRECISION        ),               
                                                          
    .LAST_C           ( CONV_C [7]          ),              
    .LAST_N           ( CONV_N [7]          ),              
    .LAST_Wh          ( CONV_Wh[7]         ),              
    .LAST_Ww          ( CONV_Ww[7]         ),              
    .LAST_Ih          ( CONV_Ih[7]         ),              
    .LAST_Iw          ( CONV_Iw[7]         ),              
    .LAST_Bi          ( CONV_BI[7]         ),              
    .REAL_HINT        ( CONV_REAL_HOUT[8]  ),              
    .REAL_HOUT        ( CONV_REAL_HINT[8]  ),              
    .NEXT_C           ( CONV_C        [8]         ),               
    .NEXT_N           ( CONV_N        [8]         ),               
    .NEXT_Wh          ( CONV_Wh       [8]        ),               
    .NEXT_Ww          ( CONV_Ww       [8]        ),               
    .NEXT_Ih          ( CONV_Ih       [8]        ),               
    .NEXT_Iw          ( CONV_Iw       [8]        ),               
    .NEXT_Bi          ( CONV_BI       [8]        ))               
                      u_conv_pool_8 (                          
     .pe_weight_data_in(conv_weight_8),   
     .pe_data_out      (conv_interface_8.pe_out),         
     .row_data_in      (conv_interface_7.row_buffer_in),   
     .clk(clk),
     .rstn(rstn)
);  

     conv #(                                                
    .DATA_WIDTH       ( DATA_WIDTH       ),               
    .K                ( K                ),               
    .S                ( S                ),               
    .ADDR_WIDTH       ( ADDR_WIDTH       ),               
    .ROW_WIDTH        ( ROW_WIDTH        ),               
    .PRECISION        ( PRECISION        ),               
                                                          
    .LAST_C           ( CONV_C [8]          ),              
    .LAST_N           ( CONV_N [8]          ),              
    .LAST_Wh          ( CONV_Wh[8]         ),              
    .LAST_Ww          ( CONV_Ww[8]         ),              
    .LAST_Ih          ( CONV_Ih[8]         ),              
    .LAST_Iw          ( CONV_Iw[8]         ),              
    .LAST_Bi          ( CONV_BI[8]         ),              
    .REAL_HINT        ( CONV_REAL_HOUT[9]  ),              
    .REAL_HOUT        ( CONV_REAL_HINT[9]  ),              
    .NEXT_C           ( CONV_C        [9]         ),               
    .NEXT_N           ( CONV_N        [9]         ),               
    .NEXT_Wh          ( CONV_Wh       [9]        ),               
    .NEXT_Ww          ( CONV_Ww       [9]        ),               
    .NEXT_Ih          ( CONV_Ih       [9]        ),               
    .NEXT_Iw          ( CONV_Iw       [9]        ),               
    .NEXT_Bi          ( CONV_BI       [9]        ))               
                      u_conv_9 (                          
     .pe_weight_data_in(conv_weight_9),   
     .pe_data_out      (conv_interface_9.pe_out),         
     .row_data_in      (conv_interface_8.row_buffer_in),   
     .clk(clk),
     .rstn(rstn)
);  

     conv #(                                                
    .DATA_WIDTH       ( DATA_WIDTH       ),               
    .K                ( K                ),               
    .S                ( S                ),               
    .ADDR_WIDTH       ( ADDR_WIDTH       ),               
    .ROW_WIDTH        ( ROW_WIDTH        ),               
    .PRECISION        ( PRECISION        ),               
                                                          
    .LAST_C           ( CONV_C [9]          ),              
    .LAST_N           ( CONV_N [9]          ),              
    .LAST_Wh          ( CONV_Wh[9]         ),              
    .LAST_Ww          ( CONV_Ww[9]         ),              
    .LAST_Ih          ( CONV_Ih[9]         ),              
    .LAST_Iw          ( CONV_Iw[9]         ),              
    .LAST_Bi          ( CONV_BI[9]         ),              
    .REAL_HINT        ( CONV_REAL_HOUT[10]  ),              
    .REAL_HOUT        ( CONV_REAL_HINT[10]  ),              
    .NEXT_C           ( CONV_C        [10]         ),               
    .NEXT_N           ( CONV_N        [10]         ),               
    .NEXT_Wh          ( CONV_Wh       [10]        ),               
    .NEXT_Ww          ( CONV_Ww       [10]        ),               
    .NEXT_Ih          ( CONV_Ih       [10]        ),               
    .NEXT_Iw          ( CONV_Iw       [10]        ),               
    .NEXT_Bi          ( CONV_BI       [10]        ))               
                      u_conv_10 (                          
     .pe_weight_data_in(conv_weight_10),   
     .pe_data_out      (conv_interface_10.pe_out),         
     .row_data_in      (conv_interface_9.row_buffer_in),   
     .clk(clk),
     .rstn(rstn)
);  

     conv_pooling #(                                                
    .DATA_WIDTH       ( DATA_WIDTH       ),               
    .K                ( K                ),               
    .S                ( S                ),               
    .ADDR_WIDTH       ( ADDR_WIDTH       ),               
    .ROW_WIDTH        ( ROW_WIDTH        ),               
    .PRECISION        ( PRECISION        ),               
                                                          
    .LAST_C           ( CONV_C [10]          ),              
    .LAST_N           ( CONV_N [10]          ),              
    .LAST_Wh          ( CONV_Wh[10]         ),              
    .LAST_Ww          ( CONV_Ww[10]         ),              
    .LAST_Ih          ( CONV_Ih[10]         ),              
    .LAST_Iw          ( CONV_Iw[10]         ),              
    .LAST_Bi          ( CONV_BI[10]         ),              
    .REAL_HINT        ( CONV_REAL_HOUT[11]  ),              
    .REAL_HOUT        ( CONV_REAL_HINT[11]  ),              
    .NEXT_C           ( CONV_C        [11]         ),               
    .NEXT_N           ( CONV_N        [11]         ),               
    .NEXT_Wh          ( CONV_Wh       [11]        ),               
    .NEXT_Ww          ( CONV_Ww       [11]        ),               
    .NEXT_Ih          ( CONV_Ih       [11]        ),               
    .NEXT_Iw          ( CONV_Iw       [11]        ),               
    .NEXT_Bi          ( CONV_BI       [11]        ))               
                      u_conv_pool_11 (                          
     .pe_weight_data_in(conv_weight_11),   
     .pe_data_out      (conv_interface_11.pe_out),         
     .row_data_in      (conv_interface_10.row_buffer_in),   
     .clk(clk),
     .rstn(rstn)
);  

     conv #(                                                
    .DATA_WIDTH       ( DATA_WIDTH       ),               
    .K                ( K                ),               
    .S                ( S                ),               
    .ADDR_WIDTH       ( ADDR_WIDTH       ),               
    .ROW_WIDTH        ( ROW_WIDTH        ),               
    .PRECISION        ( PRECISION        ),               
                                                          
    .LAST_C           ( CONV_C [11]          ),              
    .LAST_N           ( CONV_N [11]          ),              
    .LAST_Wh          ( CONV_Wh[11]         ),              
    .LAST_Ww          ( CONV_Ww[11]         ),              
    .LAST_Ih          ( CONV_Ih[11]         ),              
    .LAST_Iw          ( CONV_Iw[11]         ),              
    .LAST_Bi          ( CONV_BI[11]         ),              
    .REAL_HINT        ( CONV_REAL_HOUT[12]  ),              
    .REAL_HOUT        ( CONV_REAL_HINT[12]  ),              
    .NEXT_C           ( CONV_C        [12]         ),               
    .NEXT_N           ( CONV_N        [12]         ),               
    .NEXT_Wh          ( CONV_Wh       [12]        ),               
    .NEXT_Ww          ( CONV_Ww       [12]        ),               
    .NEXT_Ih          ( CONV_Ih       [12]        ),               
    .NEXT_Iw          ( CONV_Iw       [12]        ),               
    .NEXT_Bi          ( CONV_BI       [12]        ))               
                      u_conv_12 (                          
     .pe_weight_data_in(conv_weight_12),   
     .pe_data_out      (conv_interface_12.pe_out),         
     .row_data_in      (conv_interface_11.row_buffer_in),   
     .clk(clk),
     .rstn(rstn)
);  

     conv #(                                                
    .DATA_WIDTH       ( DATA_WIDTH       ),               
    .K                ( K                ),               
    .S                ( S                ),               
    .ADDR_WIDTH       ( ADDR_WIDTH       ),               
    .ROW_WIDTH        ( ROW_WIDTH        ),               
    .PRECISION        ( PRECISION        ),               
                                                          
    .LAST_C           ( CONV_C [12]          ),              
    .LAST_N           ( CONV_N [12]          ),              
    .LAST_Wh          ( CONV_Wh[12]         ),              
    .LAST_Ww          ( CONV_Ww[12]         ),              
    .LAST_Ih          ( CONV_Ih[12]         ),              
    .LAST_Iw          ( CONV_Iw[12]         ),              
    .LAST_Bi          ( CONV_BI[12]         ),              
    .REAL_HINT        ( CONV_REAL_HOUT[13]  ),              
    .REAL_HOUT        ( CONV_REAL_HINT[13]  ),              
    .NEXT_C           ( CONV_C        [13]         ),               
    .NEXT_N           ( CONV_N        [13]         ),               
    .NEXT_Wh          ( CONV_Wh       [13]        ),               
    .NEXT_Ww          ( CONV_Ww       [13]        ),               
    .NEXT_Ih          ( CONV_Ih       [13]        ),               
    .NEXT_Iw          ( CONV_Iw       [13]        ),               
    .NEXT_Bi          ( CONV_BI       [13]        ))               
                      u_conv_13 (                          
     .pe_weight_data_in(conv_weight_13),   
     .pe_data_out      (conv_result_out),         
     .row_data_in      (conv_interface_12.row_buffer_in),   
     .clk(clk),
     .rstn(rstn)
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
