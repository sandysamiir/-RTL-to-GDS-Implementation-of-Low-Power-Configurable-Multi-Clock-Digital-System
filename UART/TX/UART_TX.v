module UART_TX #(parameter DATA = 8)
(
  input wire            CLK,
  input wire            RST,
  input wire            PAR_EN,
  input wire            PAR_TYP,
  input wire            Data_Valid,
  input wire [DATA-1:0] P_DATA,
  
  output wire            TX_OUT,
  output wire            busy
);

// Internal connections
wire       ser_done;
wire       ser_en;
wire       par_en;
wire [1:0] mux_sel;
wire       ser_data;
wire       par_bit;

// FSM instantiation
TX_FSM DUT_fsm (
	.CLK         (CLK),
	.RST         (RST),
	.Data_Valid  (Data_Valid),
	.PAR_EN      (PAR_EN),
	.busy        (busy),
	.ser_done    (ser_done),  // Connected to serializer	
	.mux_sel     (mux_sel),   // Connected to multiplexer
	.ser_en      (ser_en),    // Connected to serializer
	.par_en      (par_en)     // Connected to Parity_Calc
 );
 

// Serializer instantiation
Serializer #(.DATA(DATA)) DUT_ser (
	.CLK         (CLK),
	.RST         (RST),
	.Data_Valid  (Data_Valid),
	.P_DATA      (P_DATA),
	.ser_done    (ser_done),  // Connected to FSM
	.ser_en      (ser_en),    // Connected to FSM
	.ser_data    (ser_data)   // Connected to MUX
);


// Parity Calc instantiation
Parity_Calc #(.DATA(DATA)) DUT_par (
	.CLK         (CLK),
	.RST         (RST),
	.Data_Valid  (Data_Valid),
	.P_DATA      (P_DATA),
	.PAR_TYP     (PAR_TYP),
	.par_bit     (par_bit),  // Connected to MUX
	.par_en      (par_en)    // Connected to FSM
);


// MUX instantiation
MUX DUT_mux (
	.CLK         (CLK),
	.RST         (RST),
	.mux_sel     (mux_sel),   // Connected to FSM
	.ser_data    (ser_data),  // Connected to serializer
	.par_bit     (par_bit),   // Connected to parity calc
	.TX_OUT      (TX_OUT)
);

endmodule