module strt_check
(
	input wire CLK,
	input wire RST,

	input wire strt_chk_en,
	input wire sampled_bit,
	input wire Done,

	
	output reg strt_glitch 
);

always @(posedge CLK or negedge RST)
 begin
	if(!RST)
	 strt_glitch <= 1'b0;
	else if(strt_chk_en && sampled_bit != 1'b0 && Done)
	 begin
	  strt_glitch <= 1'b1;
	 end
	else
	  strt_glitch <= 1'b0;
 end
endmodule