module deserializer #(parameter DATA = 8)
(
	input wire            CLK,
	input wire            RST,
	input wire            deser_en,
	input wire            sampled_bit,
	input wire [5:0]      edge_cnt,
	input wire [5:0]      prescale,
	
	output reg [DATA-1:0] P_DATA
);

reg [$clog2(DATA)-1:0] i;  // Counter for bits

always @(posedge CLK or negedge RST)
begin
	if (!RST)
	begin
		P_DATA <= 'd0;
		i <= 0;
	end
	else
	begin
		if (deser_en && edge_cnt == prescale)
		begin
			if (i < DATA)
			begin
				P_DATA[i] <= sampled_bit;
				i <= i + 1;
			end
		end
		
		if (i == DATA)
		begin
			i <= 0;
		end
	end
end

endmodule

