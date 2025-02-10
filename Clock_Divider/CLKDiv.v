module CLKDiv #(parameter RATIO_WD = 8)
  (
    input  wire                I_ref_clk,     //Reference frequency
    input  wire                I_rst_n,       //Active low asynchronous reset
    input  wire                I_clk_en,      //Clock divider block enable
    input  wire [RATIO_WD-1:0] I_div_ratio,   //The divided ratio
    output reg                 O_div_clk      //Output frequency
  );
  
reg  [RATIO_WD-2 : 0]  count ;
wire [RATIO_WD-2 :0]   edge_flip_half ;  
wire [RATIO_WD-2 :0]   edge_flip_full ;                                                                        
reg                    div_clk ;
reg                    odd_edge_tog ;               
wire                   is_one ;
wire                   is_zero;
wire                   clk_en;
wire                   is_odd;



always @(posedge I_ref_clk or negedge I_rst_n)               // counter reset condition 
 begin : counter_proc
  if(!I_rst_n)
   begin
    count <= 0 ;
	div_clk <= 0 ;	
    odd_edge_tog <= 1 ;
   end
    else if(clk_en) 
     begin
      if(!is_odd && (count == edge_flip_half))              // even edge flip condition 
       begin
        count <= 0 ;                                        // reset counter
        div_clk <= ~div_clk ;                               // clock inversion		
       end
      else if((is_odd && (count == edge_flip_half) && odd_edge_tog ) || (is_odd && (count == edge_flip_full) && !odd_edge_tog ))  // odd edge flip condition
       begin  
        count <= 0 ;                                        // reset counter
        div_clk <= ~div_clk ;		                        // clock inversion
        odd_edge_tog <= ~odd_edge_tog ;                      
       end
    else
     count <= count + 1'b1 ;
   end
 end



assign is_odd = I_div_ratio[0] ;
assign edge_flip_half = ((I_div_ratio >> 1) - 1 ) ;
assign edge_flip_full = (I_div_ratio >> 1) ;

assign is_zero = ~|I_div_ratio ;                               // check if ratio equals to 0 
assign is_one  = (I_div_ratio == 1'b1) ;                       // check if ratio equals to 1 
assign clk_en = I_clk_en & !is_one & !is_zero;                 // Enable if div_ratio not equal to 0 or 1 and block is enabled

always @(*)
begin
 O_div_clk = clk_en ? div_clk : I_ref_clk ;              // if clock divider is disabled : generated clock is the reference clock
end

endmodule