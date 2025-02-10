module UART # ( parameter DATA_WIDTH = 8)

(
 input wire                   PAR_EN,
 input wire                   PAR_TYP,
 input wire                   RST,
 
 // Transmitter
 input wire                   TX_CLK,
 input wire                   TX_IN_VLD,
 input wire [DATA_WIDTH-1:0]  TX_IN_P,
  
 output wire                  TX_OUT_S,
 output wire                  TX_OUT_VLD,
 
 //Receiver
 input wire                   RX_CLK,
 input wire [5:0]             prescale,
 input wire                   RX_IN_S,
  
 output wire [DATA_WIDTH-1:0] RX_OUT_P,
 output wire                  RX_OUT_VLD,
 output wire                  parr_err,
 output wire                  Framing_error
);


UART_TX  #(.DATA(DATA_WIDTH)) U0_UART_TX (
.CLK        (TX_CLK),
.RST        (RST),
.P_DATA     (TX_IN_P),
.Data_Valid (TX_IN_VLD),
.PAR_EN     (PAR_EN),
.PAR_TYP    (PAR_TYP), 
.TX_OUT     (TX_OUT_S),
.busy       (TX_OUT_VLD)
);
 
 
UART_RX #(.DATA(DATA_WIDTH)) U0_UART_RX (
.CLK           (RX_CLK),
.RST           (RST),
.RX_IN         (RX_IN_S),
.prescale      (prescale),
.PAR_EN        (PAR_EN),
.PAR_TYP       (PAR_TYP),
.P_DATA        (RX_OUT_P), 
.data_valid    (RX_OUT_VLD),
.parr_err      (parr_err),
.Framing_error (Framing_error)
);
 

endmodule
 
