module DF_SYNC #(parameter DEPTH = 8,
                 parameter P_SIZE = 4)
(
    input wire              CLK,
    input wire              RST,
    input wire [P_SIZE-1:0] ASYNC_IN,
    output reg [P_SIZE-1:0] SYNC_OUT
);

reg [1:0] sync_reg [P_SIZE-1:0]; 

integer I;

always @(posedge CLK or negedge RST) 
 begin
  if (!RST)
    begin
     for (I=0; I<=(P_SIZE-1); I=I+1)
      sync_reg[I] <= 'b0 ;
    end
  else
    for (I=0; I<=(P_SIZE-1); I=I+1)
     sync_reg[I] <= {sync_reg[I][0],ASYNC_IN[I]};
 end

always @(*)
 begin
   for (I=0; I<=(P_SIZE-1); I=I+1)
    SYNC_OUT[I] = sync_reg[I][1] ; 
 end
endmodule