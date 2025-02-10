module ASYNC_FIFO #( parameter DATA_WIDTH = 8 ,
                    parameter DEPTH      = 8,
                    parameter P_SIZE     = 4 )
(
	input  wire                   W_CLK,
	input  wire                   W_RST,
	input  wire                   W_INC,
	input  wire                   R_CLK,
	input  wire                   R_RST,
	input  wire                   R_INC,
	input  wire [DATA_WIDTH-1:0]  WR_DATA,
	
	output wire                   FULL,
	output wire  [DATA_WIDTH-1:0] RD_DATA,
	output wire                   EMPTY
);

//Internal connections
wire [P_SIZE-1:0] W_addr;
wire [P_SIZE-1:0] R_addr;
wire [P_SIZE-1:0] W_ptr;
wire [P_SIZE-1:0] R_ptr;
wire [P_SIZE-1:0] sync_Wr_ptr;
wire [P_SIZE-1:0] sync_Rd_ptr;

// FIFO Memory instantiation
FIFO_MEM_CNTRL #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH), .P_SIZE(P_SIZE)) 
DUT_fifo_mem 
(
	.Wdata   (WR_DATA),
  .Winc    (W_INC),
  .Rinc    (R_INC),
	.W_CLK   (W_CLK),
	.W_RST   (W_RST),
	.Wfull   (FULL),
  .W_addr  (W_addr),   //Connected to FIFO_WR
  .R_addr  (R_addr),   //Connected to FIFO_RD
  .Rdata   (RD_DATA)
);

// FIFO Write instantiation
FIFO_WR #(.DEPTH(DEPTH), .P_SIZE(P_SIZE)) 
DUT_fifo_wr 
(
	.W_CLK      (W_CLK),
  .W_RST      (W_RST),
  .Winc       (W_INC),
  .wq2_rptr   (sync_Rd_ptr),  //Connected to R2W Sync
	.Wptr       (W_ptr),        //Connected to W2R Sync
	.Waddr      (W_addr),       //Connected to FIFO_MEM_CNTRL
  .FULL       (FULL)
);

// FIFO Read instantiation
FIFO_RD #(.DEPTH(DEPTH), .P_SIZE(P_SIZE)) 
DUT_fifo_rd 
(
	.R_CLK      (R_CLK),
  .R_RST      (R_RST),
  .Rinc       (R_INC),
  .rq2_wptr   (sync_Wr_ptr),  //Connected to W2R Sync
  .rptr       (R_ptr),        //Connected to R2W Sync
	.raddr      (R_addr),       //Connected to FIFO_MEM_CNTRL
  .EMPTY      (EMPTY)
);

// W2R Synchronizer instantiation
DF_SYNC #(.DEPTH(DEPTH), .P_SIZE(P_SIZE))  
DUT_W2R
(
	.CLK          (R_CLK),
  .RST          (R_RST),
  .ASYNC_IN     (W_ptr),      //Connected to FIFO_WR
  .SYNC_OUT     (sync_Wr_ptr) //Connected to FIFO_RD
);

// R2W Synchronizer instantiation
DF_SYNC #(.DEPTH(DEPTH), .P_SIZE(P_SIZE))  
DUT_R2W
(
	.CLK          (W_CLK),
  .RST          (W_RST),
  .ASYNC_IN     (R_ptr),      //Connected to FIFO_RD
  .SYNC_OUT     (sync_Rd_ptr) //Connected to FIFO_WR
);

endmodule