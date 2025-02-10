module parity_check #(parameter DATA = 8)
(
	input wire            CLK,
	input wire            RST,
	
	input wire            par_chk_en,
	input wire            sampled_bit,
	input wire            PAR_TYP,
	input wire [DATA-1:0] P_DATA,
	input wire            Done,
	
	output reg            parr_err
);


/* If PAR_TYP = 1 : Odd parity
   If PAR_TYP = 0 : Even parity */
   
   
reg par_bit;   

always @(posedge CLK or negedge RST)
 begin
  if(!RST)
	 parr_err <= 1'b0;
	else if(par_chk_en && Done)
	 begin
	  par_bit = (PAR_TYP) ? (~^P_DATA) : (^P_DATA);  
	  if(par_bit != sampled_bit)
	   parr_err <= 1'b1;
	  else 
	   parr_err <= 1'b0; 
	 end
 end
endmodule