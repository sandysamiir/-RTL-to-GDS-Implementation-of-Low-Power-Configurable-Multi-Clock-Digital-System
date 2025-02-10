module DATA_SYNC # ( 
   parameter NUM_STAGES = 2 ,
   parameter BUS_WIDTH = 8 
)(
input    wire                      CLK,
input    wire                      RST,
input    wire                      bus_enable,
input    wire    [BUS_WIDTH-1:0]   Unsync_bus,
output   reg     [BUS_WIDTH-1:0]   sync_bus,
output   reg                       enable_pulse
);


reg   [NUM_STAGES-1:0] sync_reg;     // Register for synchronizing bus_enable
reg   [BUS_WIDTH-1:0]  bus_reg;      // Register to hold synchronized bus data
wire                   sync_enable;  // Synchronized enable signal
reg                   pulse;
					 
//----------------- Synchronizing bus_enable signal --------------
always @(posedge CLK or negedge RST) begin
  if (!RST)
    sync_reg <= 'b0;
  else
    sync_reg <= {sync_reg[NUM_STAGES-2:0], bus_enable};
end

assign sync_enable = sync_reg[NUM_STAGES-1];

//----------------- Pulse Gen ------------------------------------  
always @(posedge CLK or negedge RST) begin
  if (!RST)
    pulse <= 1'b0;
  else if (sync_enable && !sync_reg[NUM_STAGES-2])
    pulse <= 1'b1;
  else
    pulse <= 1'b0;
end

//----------------- Multiplexer and output registers -------------
always @(posedge CLK or negedge RST) begin
  if (!RST)
    begin
     sync_bus <= 'b0;
     enable_pulse <= 1'b0;
    end 
  else if (pulse)
    begin
     sync_bus <= Unsync_bus;
     enable_pulse <= 1'b1;
    end
  else
   enable_pulse <= 1'b0;   
end

endmodule