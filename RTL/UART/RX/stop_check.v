module stp_check
(
	input wire CLK,
	input wire RST,
	
	input wire stp_chk_en,
	input wire sampled_bit,
	input wire Done,
	
	output reg stp_err 
);

always @(posedge CLK or negedge RST)
 begin
	if(!RST)
	 stp_err <= 1'b0;
	else if(stp_chk_en && sampled_bit != 1'b1 && Done)
	 begin
	  stp_err <= 1'b1;
	 end
	else
	  stp_err <= 1'b0;
 end
endmodule