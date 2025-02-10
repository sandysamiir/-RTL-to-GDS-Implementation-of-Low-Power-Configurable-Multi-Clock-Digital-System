module FIFO_MEM_CNTRL #( parameter DATA_WIDTH = 8 ,
                         parameter DEPTH      = 8,
                         parameter P_SIZE     = 4 )
(
	input  wire [DATA_WIDTH-1:0]  Wdata,
  input  wire                   Winc,
  input  wire                   Rinc,
	input  wire                   W_CLK,
	input  wire                   W_RST,
	input  wire                   Wfull,
  input  wire [P_SIZE-1:0]      W_addr,
  input  wire [P_SIZE-1:0]      R_addr,
  output reg  [DATA_WIDTH-1:0]  Rdata
);

wire Wclken;
integer i;

assign Wclken = Winc & !(Wfull);

// 2D Array of 8 registers, each 8-bit wide
  reg [DATA_WIDTH-1:0] FIFO_MEM [0:DEPTH-1];
  
 
 // Write operation
  always @(posedge W_CLK or negedge W_RST)
   begin
    if(!W_RST)
      begin
  //   Rdata = 'b0; 
       for(i=0;i<DEPTH;i=i+1) 
        FIFO_MEM[i] <= {DATA_WIDTH{1'b0}} ;
      end
    else if(Wclken)
      begin
        FIFO_MEM[W_addr] <= Wdata;
      end
   end
   
// Read operation
always @(*)
 begin  
   Rdata = FIFO_MEM[R_addr];
 end
  
endmodule