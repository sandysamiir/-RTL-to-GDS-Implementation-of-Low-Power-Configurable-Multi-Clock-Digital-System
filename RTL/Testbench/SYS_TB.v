`timescale 1us/1ps

module SYS_TB ();

  // Parameters
  parameter BUS_WIDTH = 8;
  parameter RF_ADDR = 4;
  parameter REF_PERIOD = 0.02;
  parameter UART_PERIOD = 0.2712673611;
  parameter TX_PERIOD = 8.68; 

  // Inputs
  reg RST;
  reg UART_CLK;
  reg REF_CLK;
  reg RX_IN;

  // Outputs
  wire TX_OUT;
  wire parity_error;
  wire framing_error;

  // DUT instantiation
  System_TOP #(BUS_WIDTH, RF_ADDR) DUT (
    .RST(RST),
    .UART_CLK(UART_CLK),
    .REF_CLK(REF_CLK),
    .RX_IN(RX_IN),
    .TX_OUT(TX_OUT),
    .parity_error(parity_error),
    .framing_error(framing_error)
  );

  // Clock generation
  always #(REF_PERIOD/2)   REF_CLK = ~REF_CLK ;   //Frequency = 50 MHz
  always #(UART_PERIOD/2)  UART_CLK = ~UART_CLK ;   //Frequency = 3.6864 MHz
  
  
  
  // Initial block
  initial 
   begin
   
    //System Functions
	$dumpfile("Final_System_DUMP.vcd");       
	$dumpvars; 

	//Initialization
	Initialize();
  Reset();

  // Apply test vectors
  
     // Test 1: Write to Register File 
    send_uart_frame(8'hAA,calc_even_parity(8'hAA)); // RF_WR_CMD
    send_uart_frame(8'h04,calc_even_parity(8'h04)); // RF_WR_ADDR
    send_uart_frame(8'h12,calc_even_parity(8'h12)); // RF_WR_DATA
    #100;
    
     // Test 2: Write to Register File with error 
    send_uart_frame(8'hAA,calc_even_parity(8'hAA)); // RF_WR_CMD
    send_uart_frame(8'h05,calc_even_parity(8'h05)); // RF_WR_ADDR
    send_uart_frame(8'h12,!calc_even_parity(8'h12)); // RF_WR_DATA --> Parity error 
    #100;
    
     // Test 3: Write to Register File 
    send_uart_frame(8'hAA,calc_even_parity(8'hAA)); // RF_WR_CMD
    send_uart_frame(8'h05,calc_even_parity(8'h05)); // RF_WR_ADDR
    send_uart_frame(8'h5F,calc_even_parity(8'h5F)); // RF_WR_DATA  
    #100;
    
    // Test 4: Read from Register File
    send_uart_frame(8'hBB,calc_even_parity(8'hBB)); // RF_RD_CMD
    send_uart_frame(8'h04,calc_even_parity(8'h04)); // RF_RD_ADDR
    #100;
    
    // Test 5: Read from Register File
    send_uart_frame(8'hBB,calc_even_parity(8'hBB)); // RF_RD_CMD
    send_uart_frame(8'h05,calc_even_parity(8'h05)); // RF_RD_ADDR
    #100;
    
    // Test 6: ALU Operation with operand
    send_uart_frame(8'hCC,calc_even_parity(8'hCC)); // ALU_OP_CMD
    send_uart_frame(8'h56,calc_even_parity(8'h56)); // OPERAND_A
    send_uart_frame(8'h34,calc_even_parity(8'h34)); // OPERAND_B
    send_uart_frame(8'h00,calc_even_parity(8'h00)); // Addition 
    #100;
    
    // Test 7: ALU Operation with no perand
    send_uart_frame(8'hDD,calc_even_parity(8'hDD)); // ALU_OP_CMD
    send_uart_frame(8'h01,calc_even_parity(8'h01)); // Subtraction
    #100;
    
    // Test 8: ALU Operation with operand
    send_uart_frame(8'hCC,calc_even_parity(8'hCC)); // ALU_OP_CMD
    send_uart_frame(8'hC2,calc_even_parity(8'hC2)); // OPERAND_A
    send_uart_frame(8'h08,calc_even_parity(8'h08)); // OPERAND_B
    send_uart_frame(8'h02,calc_even_parity(8'h02)); // Multiplication 
    #100;
    
    // Test 9: ALU Operation with no operand
    send_uart_frame(8'hDD,calc_even_parity(8'hDD)); // ALU_OP_CMD
    send_uart_frame(8'h03,calc_even_parity(8'h03)); // Division 
    #100;
    
    // Test 10: ALU Operation with operand
    send_uart_frame(8'hCC,calc_even_parity(8'hCC)); // ALU_OP_CMD
    send_uart_frame(8'h6E,calc_even_parity(8'h6E)); // OPERAND_A
    send_uart_frame(8'h6E,calc_even_parity(8'h6E)); // OPERAND_B
    send_uart_frame(8'h09,calc_even_parity(8'h09)); // XNOR 
    #100;
    
    // Test 11: ALU Operation with no operand
    send_uart_frame(8'hDD,calc_even_parity(8'hDD)); // ALU_OP_CMD
    send_uart_frame(8'h0A,calc_even_parity(8'h0A)); // Compare 
    #100;
    
    // Test 12: ALU Operation with no operand
    send_uart_frame(8'hDD,calc_even_parity(8'hDD)); // ALU_OP_CMD
    send_uart_frame(8'h0D,calc_even_parity(8'h0D)); // Shift A>>1 

    // Wait for operations to complete
    #100;

    // Stop the simulation
    $stop;

 end
 
 ////////////////////////////////// TASKS //////////////////////////////////

//Signals initialization
task Initialize;
 begin
   RST = 1'b1;
   UART_CLK = 1'b0;
   REF_CLK = 1'b0;
   RX_IN = 1'b1;
 end
endtask

//Reset
task Reset ;
 begin
  RST = 0;
  #10;
  RST = 1;
  #50;
 end
endtask


 // Task to send a frame
 task send_uart_frame(input [BUS_WIDTH-1:0] data, input Par_bit);
   integer i;
    begin
      RX_IN = 1'b0; // Start bit
      #(TX_PERIOD);
      for (i = 0; i < BUS_WIDTH; i = i + 1) begin
        RX_IN = data[i];
        #(TX_PERIOD);
      end
      RX_IN = Par_bit; // Parity bit
      #(TX_PERIOD);
      RX_IN = 1'b1; // Stop bit
      #(TX_PERIOD);
      #10;
    end
  endtask
  
  // Function to calculate even parity 
  function  calc_even_parity;
    input [BUS_WIDTH-1:0] data;  
    integer i;
    begin
      calc_even_parity = 0;  // Initialize parity bit to 0
      for (i = 0; i < BUS_WIDTH; i = i + 1) begin
        calc_even_parity = calc_even_parity ^ data[i];  // XOR each bit
      end
    end
  endfunction


/*  

ALU operations:
8'h00: Addition
8'h01: Subtraction
8'h02: Multiplication
8'h03: Division
8'h04: AND
8'h05: OR
8'h06: NAND
8'h07: NOR    
8'h08: XOR
8'h09: XNOR          
8'h0A: CMP A = B
8'h0B: CMP A > B 
8'h0C: CMP A < B     
8'h0D: Shift A>>1
8'h0E: Shift A<<1

*/


endmodule
