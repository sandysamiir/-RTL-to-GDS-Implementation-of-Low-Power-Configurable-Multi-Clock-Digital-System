module edge_bit_counter #(parameter DATA = 8)
(
	input wire            CLK,
	input wire            RST,
	
	input wire            enable,
	input wire [5:0]      prescale,
	
	output reg [5:0]      edge_cnt,
	output reg [DATA-1:0] bit_cnt
);


always @(posedge CLK or negedge RST)
 begin
	if(!RST)
	 begin
		edge_cnt <= 0;
		bit_cnt  <= 0;
	 end 
	else if(enable)
	 begin
	  edge_cnt <= edge_cnt + 1;
	  if(edge_cnt == 0 || edge_cnt == prescale)
	   begin
		  bit_cnt <= bit_cnt + 1;
		 end
    if(edge_cnt == prescale)
     begin
      edge_cnt <= 1;
     end
	 end
  else
   begin
	  edge_cnt <= 0;
	  bit_cnt  <= 0;
   end	 
 end
endmodule