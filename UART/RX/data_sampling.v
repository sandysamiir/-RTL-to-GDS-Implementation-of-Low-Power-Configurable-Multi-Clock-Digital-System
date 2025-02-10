module data_sampling #(parameter DATA = 8)
(
	input wire       CLK,
	input wire       RST,
	
	input wire       RX_IN,
	input wire [5:0] prescale,
	input wire       data_sample_en,
	input wire [5:0] edge_cnt,
	
	output reg       sampled_bit,
	output reg       Done
);

reg bit1_sampled, bit2_sampled, bit3_sampled; 

always @(posedge CLK or negedge RST)
 begin
	if(!RST)
	 begin
	  sampled_bit <= 1'b1;
	  Done <= 1'b0;
	 end
	else if(data_sample_en)
	 begin
	  if(edge_cnt == (prescale/2)-1)
	   bit1_sampled <= RX_IN;
	  else if(edge_cnt == prescale/2)
	   bit2_sampled <= RX_IN;
	  else if(edge_cnt == (prescale/2)+1)
	   bit3_sampled <= RX_IN; 
	   
	  if(edge_cnt >= (prescale/2)+1 && edge_cnt != prescale)
	   begin
	    sampled_bit <= (bit1_sampled & bit2_sampled) | (bit1_sampled & bit3_sampled) | (bit2_sampled & bit3_sampled);
	    Done <= 1'b1;
	   end 
	  else
	   begin
	    sampled_bit <= 1'b1;
	    Done <= 1'b0;
	   end 
   end 
else
  begin
    sampled_bit <= 1'b1;
	  Done <= 1'b0;
	 end
	 
 end
endmodule