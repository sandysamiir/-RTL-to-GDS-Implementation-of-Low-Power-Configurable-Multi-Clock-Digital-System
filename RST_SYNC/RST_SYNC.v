module RST_SYNC # ( parameter NUM_STAGES = 2 ) // Number of synchronization stages (flip-flops)
(
   input    wire CLK,      // Clock input
   input    wire RST,      // Asynchronous reset input (active low)
   output   reg  SYNC_RST  // Synchronized reset output (active low)
);

reg [NUM_STAGES-1:0] sync_reg; // Register array for synchronization stages

//----------------- Multi-flop synchronizer --------------
always @(posedge CLK or negedge RST)
begin
  if(!RST)  // Active-low asynchronous reset
    sync_reg <= 'b0;  // Set all synchronization registers to 0
  else
    sync_reg <= {sync_reg[NUM_STAGES-2:0], 1'b1};  // Shift in 1 to synchronize the reset
end

always @(*)
  SYNC_RST = sync_reg[NUM_STAGES-1]; 
endmodule
