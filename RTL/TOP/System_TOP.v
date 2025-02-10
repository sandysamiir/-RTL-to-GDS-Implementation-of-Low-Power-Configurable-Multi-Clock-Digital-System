module System_TOP #(parameter BUS_WIDTH = 8, RF_ADDR = 4)
  (
     input   wire                          RST,
     input   wire                          UART_CLK,
     input   wire                          REF_CLK,
     input   wire                          RX_IN,
     output  wire                          TX_OUT,
     output  wire                          parity_error,
     output  wire                          framing_error
    
  );

//Internal connections
wire                                   SYNC_UART_RST,
                                       SYNC_REF_RST;
									   
wire					                             UART_TX_CLK;
wire					                             UART_RX_CLK;


wire      [BUS_WIDTH-1:0]              Operand_A,
                                       Operand_B,
									                     UART_Config,
									                     DIV_RATIO;
									   
wire      [BUS_WIDTH-1:0]              DIV_RATIO_RX;
									   
wire      [BUS_WIDTH-1:0]              UART_RX_OUT;
wire         						                    UART_RX_V_OUT;
wire      [BUS_WIDTH-1:0]			           UART_RX_SYNC;
wire                                   UART_RX_V_SYNC;

wire      [BUS_WIDTH-1:0]              UART_TX_IN;
wire        						                     UART_TX_VLD;
wire      [BUS_WIDTH-1:0]              UART_TX_SYNC;
wire        						                     UART_TX_V_SYNC;

wire                                   UART_TX_Busy;	
wire                                   UART_TX_Busy_PULSE;	
									   
wire                                   RF_WrEn;
wire                                   RF_RdEn;
wire      [RF_ADDR-1:0]                RF_Address;
wire      [BUS_WIDTH-1:0]              RF_WrData;
wire      [BUS_WIDTH-1:0]              RF_RdData;
wire                                   RF_RdData_VLD;									   

wire                                   CLKG_EN;
wire                                   ALU_EN;
wire      [3:0]                        ALU_FUN; 
wire      [BUS_WIDTH*2-1:0]            ALU_OUT;
wire                                   ALU_OUT_VLD; 
									   
wire                                   ALU_CLK ;								   

wire                                   FIFO_FULL ;
	
wire                                   CLKDIV_EN ;

///////////////////////////////////////////// UART instantiation /////////////////////////////////

UART #(.DATA_WIDTH(BUS_WIDTH)) DUT_UART (
.PAR_EN (UART_Config[0]),      //connected to register file
.PAR_TYP (UART_Config[1]),     //connected to register file
.RST (SYNC_UART_RST),          //connected to Rst_Sync_2
.TX_CLK (UART_TX_CLK),         //connected to clock divider
.TX_IN_VLD (!UART_TX_V_SYNC),  //connected to ASYNC_FIFO
.TX_IN_P (UART_TX_SYNC),       //connected to ASYNC_FIFO
.TX_OUT_S (TX_OUT),            //Output port
.TX_OUT_VLD (UART_TX_Busy),    //connected to pulse generator
.RX_CLK (UART_RX_CLK),         //connected to clock divider
.prescale (UART_Config[7:2]),  //connected to register file
.RX_IN_S (RX_IN),              //Input port
.RX_OUT_P (UART_RX_OUT),       //connected to Data_Sync
.RX_OUT_VLD (UART_RX_V_OUT),   //connected to Data_Sync
.parr_err (parity_error),      //Output port
.Framing_error (framing_error) //Output port
  );
  
////////////////////////////////////////////// DATA_SYNC instantiation ////////////////////////////

DATA_SYNC #(.NUM_STAGES(2), .BUS_WIDTH(BUS_WIDTH)) DUT_DATA_SYNC (
.CLK (REF_CLK),                //Input port
.RST (SYNC_REF_RST),           //connected to Rst_Sync_1
.bus_enable (UART_RX_V_OUT),   //connected to UART
.Unsync_bus (UART_RX_OUT),     //connected to UART
.sync_bus (UART_RX_SYNC),      //connected to system control
.enable_pulse (UART_RX_V_SYNC) //connected to system control
 ); 
 
/////////////////////////////////////////// Pulse Generator instantiation /////////////////////////
 
PULSE_GEN DUT_PULSE_GEN (
.CLK(UART_TX_CLK),                 //connected to clock divider
.RST(SYNC_UART_RST),               //connected to Rst_Sync_2
.LVL_SIG(UART_TX_Busy),            //connected to UART
.PULSE_SIG(UART_TX_Busy_PULSE)     //connected to ASYNC_FIFO
);

  
 
////////////////////////////////////////// System Control instantiation ////////////

SYS_CTRL DUT_SYS_CTRL (
.CLK (REF_CLK),                 //Input port
.RST (SYNC_REF_RST),            //connected to Rst_Sync_1
.ALU_OUT (ALU_OUT),             //connected to ALU
.OUT_Valid (ALU_OUT_VLD),       //connected to ALU
.RdData (RF_RdData),            //connected to register file
.RdData_Valid (RF_RdData_VLD),  //connected to register file
.RX_P_DATA (UART_RX_SYNC),      //connected to Data_Sync   
.RX_D_VLD (UART_RX_V_SYNC),     //connected to Data_Sync
.FIFO_FULL (FIFO_FULL),         //connected to ASYNC_FIFO
.parity_error (parity_error),   //connected to UART
.Framing_error (framing_error), //connected to UART
.ALU_FUN (ALU_FUN),             //connected to ALU
.ALU_EN (ALU_EN),               //connected to ALU
.CLK_EN (CLKG_EN),              //connected to Clock Gate
.Address (RF_Address),          //connected to register file
.WrEn (RF_WrEn),                //connected to register file
.RdEn (RF_RdEn),                //connected to register file
.WrData (RF_WrData),            //connected to register file
.TX_P_DATA (UART_TX_IN),        //connected to ASYNC_FIFO
.TX_D_VLD (UART_TX_VLD),        //connected to ASYNC_FIFO
.clk_div_en (CLKDIV_EN)         //connected to Clock divider 
);
 
 
///////////////////////////// Register File instantiation //////////////////////////

RegFile #(.WIDTH(BUS_WIDTH), .DEPTH(16), .ADDR(RF_ADDR)) DUT_REGFILE (
 .CLK (REF_CLK),               //Input port
 .RST (SYNC_REF_RST),          //connected to Rst_Sync_1
 .RdEn (RF_RdEn),              //connected to System Control
 .WrEn (RF_WrEn),              //connected to System Control
 .Address (RF_Address),        //connected to System Control
 .WrData (RF_WrData),          //connected to System Control
 .RdData (RF_RdData),          //connected to System Control
 .RdData_VLD (RF_RdData_VLD),  //connected to System Control
 .REG0 (Operand_A),            //connected to ALU  
 .REG1 (Operand_B),            //connected to ALU 
 .REG2 (UART_Config),          //connected to UART 
 .REG3 (DIV_RATIO)             //connected to Clock divider 
 ); 
  
 
///////////////////////////// ALU instantiation ////////////////////////////////////

ALU #(.OPER_WIDTH(BUS_WIDTH), .OUT_WIDTH(BUS_WIDTH*2)) DUT_ALU (
 .CLK (ALU_CLK),          //connected to Clock Gating
 .RST (SYNC_REF_RST),     //connected to Rst_Sync_1
 .A (Operand_A),          //connected to Register File
 .B (Operand_B),          //connected to Register File
 .EN (ALU_EN),            //connected to System Control
 .ALU_FUN (ALU_FUN),      //connected to System Control
 .ALU_OUT (ALU_OUT),      //connected to System Control
 .OUT_VALID (ALU_OUT_VLD) //connected to System Control
 );


///////////////////////////// Clock Gating instantiation ///////////////////////////

CLK_GATE DUT_CLK_GATE (
 .CLK_EN (CLKG_EN),       //connected to System Control
 .CLK (REF_CLK),          //Input port
 .GATED_CLK (ALU_CLK)     //connected to ALU
 );

  
///////////////////////////// RST_SYNC instantiation ///////////////////////////////

RST_SYNC #(.NUM_STAGES(2)) DUT_RST_SYNC_1 (
 .CLK(REF_CLK),             //Input port   
 .RST(RST),                 //Input port 
 .SYNC_RST(SYNC_REF_RST) 
 );
 
RST_SYNC #(.NUM_STAGES(2)) DUT_RST_SYNC_2 (
 .CLK(UART_CLK),             //Input port   
 .RST(RST),                 //Input port 
 .SYNC_RST(SYNC_UART_RST) 
 ); 
 
 
///////////////////////////// Async FIFO instantiation /////////////////////////////

ASYNC_FIFO #(.DATA_WIDTH(BUS_WIDTH), .P_SIZE(4), .DEPTH(8)) DUT_FIFO (
 .W_CLK(REF_CLK),            //Input port
 .W_RST(SYNC_REF_RST),      //connected to Rst_Sync_1
 .W_INC(UART_TX_VLD),        //connected to System Control
 .WR_DATA(UART_TX_IN),        //connected to System Control         
 .R_CLK(UART_TX_CLK),        //connected to Clock divider      
 .R_RST(SYNC_UART_RST),     //connected to Rst_Sync_2         
 .R_INC(UART_TX_Busy_PULSE), //connected to Pulse Generator             
 .RD_DATA(UART_TX_SYNC),      //connected to UART       
 .FULL(FIFO_FULL),           //connected to System Control    
 .EMPTY(UART_TX_V_SYNC)      //connected to UART           
 );
 
 
 
///////////////////////////// Clock Divider for TX /////////////////////////////////

CLKDiv DUT_CLKDIV_TX (
 .I_ref_clk (UART_CLK),     //Input port
 .I_rst_n (SYNC_UART_RST),  //connected to Rst_Sync_2 
 .I_clk_en (CLKDIV_EN),     //connected to System Control
 .I_div_ratio (DIV_RATIO),  //connected to Register File
 .O_div_clk (UART_TX_CLK)   //connected to UART
 ); 
 
 
///////////////////////////// Clock Divider for RX /////////////////////////////////

CLKDiv DUT_CLKDIV_RX (
 .I_ref_clk (UART_CLK),        //Input port
 .I_rst_n (SYNC_UART_RST),     //connected to Rst_Sync_2 
 .I_clk_en (CLKDIV_EN),        //connected to System Control
 .I_div_ratio (DIV_RATIO_RX),  //connected to ClockDiv Multiplexer
 .O_div_clk (UART_RX_CLK)      //connected to UART
 ); 
 
 
///////////////////////////// Custom MUX ///////////////////////////////////////////

CLKDIV_MUX DUT_CLKDIV_MUX (
 .IN(UART_Config[7:2]),      //connected to Register File (Prescale)
 .OUT(DIV_RATIO_RX)          //connected to RX Clock divider
 );
 
endmodule 