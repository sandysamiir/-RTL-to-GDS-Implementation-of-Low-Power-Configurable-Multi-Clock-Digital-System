module MUX 
(
  input wire       CLK,
  input wire       RST,
  input wire [1:0] mux_sel,
  input wire       ser_data,
  input wire       par_bit,
  output reg       TX_OUT
);

always @(posedge CLK or negedge RST)
 begin
	if(!RST)
	 begin
	  TX_OUT <= 1'b1;
	 end
	else
	 begin
	  case(mux_sel)
	 
	   2'b00    : begin
	               TX_OUT <= 1'b0; // Start bit
                end
		 	   
	   2'b01    : begin
	               TX_OUT <= 1'b1; // Stop bit
                end
			   
	   2'b10    : begin
	               TX_OUT <= ser_data; 
                end
			   
	   2'b11    : begin
	               TX_OUT <= par_bit;
                end
			   
	   default  : begin
	               TX_OUT <= 1'b1;
                end
				 
	  endcase
     end
 end
endmodule 
