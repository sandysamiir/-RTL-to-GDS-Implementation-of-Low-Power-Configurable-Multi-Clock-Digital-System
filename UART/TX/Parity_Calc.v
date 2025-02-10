module Parity_Calc #(parameter DATA = 8)
(
  input wire            CLK,
  input wire            RST,
  input wire            PAR_TYP,
  input wire            Data_Valid,
  input wire            par_en,
  input wire [DATA-1:0] P_DATA,
  output reg            par_bit
);

/* If PAR_TYP = 1 : Odd parity
   If PAR_TYP = 0 : Even parity */
   
reg [DATA-1:0] IN_Data;

always @(posedge CLK or negedge RST)
 begin
    if (!RST) begin
        par_bit <= 1'b0;
        IN_Data <= {DATA{1'b0}};
    end else begin
        if (Data_Valid) begin
            IN_Data <= P_DATA;
        end
        
        if (par_en) begin
            par_bit <= (PAR_TYP) ? (~^IN_Data) : (^IN_Data);
        end else begin
            par_bit <= par_bit;
        end
    end
end

endmodule

