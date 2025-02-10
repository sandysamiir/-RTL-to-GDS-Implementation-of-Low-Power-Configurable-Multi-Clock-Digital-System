module PULSE_GEN 
(
input    wire                      CLK,
input    wire                      RST,
input    wire                      LVL_SIG,
output   wire                      PULSE_SIG
);


reg              rcv_flop  , 
                 pls_flop  ;
					 
					 
always @(posedge CLK or negedge RST)
 begin
  if(!RST)      // active low
   begin
    rcv_flop <= 1'b0 ;
    pls_flop <= 1'b0 ;	
   end
  else
   begin
    rcv_flop <= LVL_SIG;   
    pls_flop <= rcv_flop;
   end  
 end
 
//----------------- pulse generator --------------------

assign PULSE_SIG = rcv_flop && !pls_flop ;


endmodule