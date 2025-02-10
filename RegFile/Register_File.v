module RegFile #(parameter WIDTH = 8, DEPTH = 16, ADDR = 4)
(
  input  wire             CLK,
  input  wire             RST,
  input  wire             RdEn,     // Read enable
  input  wire             WrEn,     // Write enable
  input  wire [ADDR-1:0]  Address,  // Address bus
  input  wire [WIDTH-1:0] WrData,   // Write data bus 
  
  output reg  [WIDTH-1:0] RdData,    // Read data bus 
  output reg              RdData_VLD,
  output wire [WIDTH-1:0] REG0,     
  output wire [WIDTH-1:0] REG1,      
  output wire [WIDTH-1:0] REG2,
  output wire [WIDTH-1:0] REG3
  );
  
  integer i;
  
  // 2D Array of registers
  reg [WIDTH-1:0] regArr [0:DEPTH-1];
  
  // Positive edge clock and asynchronous active low reset
  always @(posedge CLK or negedge RST)
  begin
    if (!RST)
      begin
        RdData_VLD <= 1'b0;
        RdData <= 'b0;
        for (i=0 ; i < DEPTH ; i = i +1)
         begin
		      if(i==2)
           regArr[i] <= 'b00100001 ; //prescale = 8, parity enable = 1, parity type = 0 (Even)
		      else if (i==3) 
           regArr[i] <= 'b00100000 ; //Division ratio = 32
          else
           regArr[i] <= 'b0 ;		 
        end
      end
    else if (WrEn && !RdEn) // Register Write Operation
     begin
       regArr[Address] <= WrData ;
     end
    else if (RdEn && !WrEn) // Register Read Operation
     begin    
       RdData <= regArr[Address] ;
	     RdData_VLD <= 1'b1 ;
     end  
    else
     begin
	     RdData_VLD <= 1'b0 ;
     end	 
  end

assign REG0 = regArr[0] ;
assign REG1 = regArr[1] ;
assign REG2 = regArr[2] ;
assign REG3 = regArr[3] ;
  
endmodule