module UART_RX #(parameter DATA = 8)
(
  input wire             CLK,
  input wire             RST,
  
  input wire             PAR_EN,
  input wire             PAR_TYP,
  input wire [5:0]       prescale,
  input wire             RX_IN,
  
  output wire [DATA-1:0] P_DATA,
  output wire            data_valid,
  output wire            parr_err,
  output wire            Framing_error
);

// Internal connections
wire            data_sample_en, enable, par_chk_en, strt_chk_en, stp_chk_en, deser_en;
wire            strt_glitch; 
wire [5:0]      edge_cnt;
wire [DATA-1:0] bit_cnt;
wire            sampled_bit;
wire            Done;


// FSM instantiation
RX_FSM #(.DATA(DATA)) DUT_fsm (
	.CLK                 (CLK),
	.RST                 (RST),
	.RX_IN               (RX_IN),
	.PAR_EN              (PAR_EN),
	.edge_cnt            (edge_cnt),        // Connected to edge_bit_counter
	.bit_cnt             (bit_cnt),         // Connected to edge_bit_counter	
	.parr_err            (parr_err),        // Connected to parity_check
	.strt_glitch         (strt_glitch),     // Connected to strt_check
	.stp_err             (Framing_error),   // Connected to stp_check
	.prescale            (prescale),
	.data_valid          (data_valid),
	.deser_en            (deser_en),        // Connected to deserializer
	.data_sample_en      (data_sample_en),  // Connected to data_sampling
	.enable              (enable),          // Connected to edge_bit_counter
	.par_chk_en          (par_chk_en),      // Connected to parity_check
	.strt_chk_en         (strt_chk_en),     // Connected to strt_check
	.stp_chk_en          (stp_chk_en)       // Connected to stp_check
 );
 

// edge_bit_counter instantiation
edge_bit_counter #(.DATA(DATA)) DUT_edge_bit_cnt (
	.CLK       (CLK),
	.RST       (RST),
	.enable    (enable),     // Connected to FSM
	.prescale  (prescale),
	.edge_cnt  (edge_cnt),   // Connected to FSM & data_sampling
	.bit_cnt   (bit_cnt)     // Connected to FSM
);


// data_sampling instantiation
data_sampling #(.DATA(DATA)) DUT_data_samp (
	.CLK            (CLK),
	.RST            (RST),
	.RX_IN          (RX_IN),
	.prescale       (prescale),
	.data_sample_en (data_sample_en), // Connected to FSM
	.edge_cnt       (edge_cnt),       // Connected to edge_bit_counter
	.sampled_bit    (sampled_bit),    // Connected to deserializer, parity_check, strt_check & stp_check
	.Done           (Done)            // Connected to parity_check, strt_check &  stp_check
);


// deserializer instantiation
deserializer #(.DATA(DATA)) DUT_deser (
	.CLK          (CLK),
	.RST          (RST),
	.deser_en     (deser_en),     // Connected to FSM
	.sampled_bit  (sampled_bit),  // Connected to data_sampling
	.edge_cnt     (edge_cnt),     // Connected to edge_bit_counter
	.prescale     (prescale),
	.P_DATA       (P_DATA)      
);

// parity_check instantiation
parity_check #(.DATA(DATA)) DUT_par_chk (
	.CLK          (CLK),
	.RST          (RST),
	.par_chk_en   (par_chk_en),   // Connected to FSM
	.sampled_bit  (sampled_bit),  // Connected to data_sampling
	.PAR_TYP      (PAR_TYP),
	.P_DATA       (P_DATA),       // Connected to deserializer
    .parr_err   (parr_err),	    // Connected to FSM
    .Done       (Done)          // Connected to data_sampling
);

// strt_check instantiation
strt_check DUT_strt_chk (
	.CLK          (CLK),
	.RST          (RST),
	.strt_chk_en  (strt_chk_en),   // Connected to FSM
	.sampled_bit  (sampled_bit),   // Connected to data_sampling
	.strt_glitch  (strt_glitch),   // Connected to FSM
	.Done         (Done)           // Connected to data_sampling
);

// stp_check instantiation
stp_check DUT_stp_chk (
	.CLK          (CLK),
	.RST          (RST),
	.stp_chk_en   (stp_chk_en),    // Connected to FSM
	.sampled_bit  (sampled_bit),   // Connected to data_sampling
	.stp_err      (Framing_error), // Connected to FSM
	.Done         (Done)           // Connected to data_sampling
);

endmodule