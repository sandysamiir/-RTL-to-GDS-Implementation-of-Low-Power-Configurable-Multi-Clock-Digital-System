module Serializer #(parameter DATA = 8)
(
   input wire            CLK,
   input wire            RST,
   input wire            Data_Valid,
   input wire            ser_en,
   input wire [DATA-1:0] P_DATA,
  
   output reg            ser_done,
   output reg            ser_data   
);

reg [DATA-1:0] IN_Data;
reg [7:0] Counter; 

always @(posedge CLK or negedge RST)
 begin
    if(!RST) begin
        ser_data <= 1'b0;
        ser_done <= 1'b0;
        Counter  <= 0;
        IN_Data  <= 0;
    end else begin
        if(Data_Valid) begin
            IN_Data <= P_DATA; 
        end
        
        if(ser_en) begin
            ser_data <= IN_Data[0];  // Output the LSB
            
            // Shift the data right by one bit
            IN_Data <= {1'b0, IN_Data[DATA-1:1]}; 
            
            if(Counter != DATA-1) begin
                Counter <= Counter + 1;
                ser_done <= 1'b0;
            end else begin
                ser_done <= 1'b1;
                Counter <= 0;
            end
        end else begin
            ser_data <= 1'b0;
            ser_done <= 1'b0;
        end
    end
end

endmodule

