module SYS_CTRL 
(
	input  wire        CLK,                 //Clock signal
	input  wire        RST,                 //Active low reset
	input  wire [15:0] ALU_OUT,             //ALU Result
	input  wire        OUT_Valid,           //ALU Result valid
	input  wire [7:0]  RdData,              //Read data bus
	input  wire        RdData_Valid,        //Read data valid 
	input  wire [7:0]  RX_P_DATA,           //UART_RX Data   
	input  wire        RX_D_VLD,            //RX Data Valid
	input  wire        FIFO_FULL,           //ASYNC_FIFO FULL Flag
	input  wire        parity_error,        //UART_RX parity error signal 
	input  wire        Framing_error,       //UART_RX framing error signal
	
	output reg  [3:0]  ALU_FUN,             //ALU Function signal
	output reg         ALU_EN,              //ALU Enable signal
	output reg         CLK_EN,              //Clock gate enable
	output reg  [3:0]  Address,             //Address bus
	output reg         WrEn,                //Write Enable
	output reg         RdEn,                //Read Enable
	output reg  [7:0]  WrData,              //Write data bus
	output reg  [7:0]  TX_P_DATA,           //UART_TX Data
	output reg         TX_D_VLD,            //TX Data Valid
	output reg         clk_div_en           //Clock divider enable
);

reg [3:0] Temp_Address;
reg [15:0] ALU_RESULT;
reg Receiving_error;


assign Receiving_error = (parity_error | Framing_error);

//State encoding
typedef enum {
        IDLE,
        RF_WR_CMD,
		    RF_WR_ADDR,
		    RF_WR_DATA,
        RF_RD_CMD,
		    RF_RD_ADDR,
        ALU_OP_CMD,
		    OPERAND_A,
		    WRITE_A,
		    OPERAND_B,
		    WRITE_B,
		    ALU_OPERATION,
		    ALU_NOP_CMD,
		    SEND_RESULT,
		    SEND_RESULT_Part2
} state_t;

state_t Current_State, Next_State;


/////////////////////// STATE TRANSITION /////////////////////////////	
always @(posedge CLK or negedge RST)
begin
 if(!RST)
	Current_State <= IDLE;
 else
	Current_State <= Next_State;
end

/////////////////////// NEXT STATE LOGIC /////////////////////////////
always @(*)
begin
    case(Current_State)
	   IDLE: begin
			      if(RX_D_VLD)
			       begin
				      case(RX_P_DATA)
					     8'hAA:   Next_State = RF_WR_CMD;
               8'hBB:   Next_State = RF_RD_CMD;
               8'hCC:   Next_State = ALU_OP_CMD;
               8'hDD:   Next_State = ALU_NOP_CMD;
               default: Next_State = IDLE;
		          endcase
			       end 
			      else
			       Next_State = IDLE;
	         end
		  
 RF_WR_CMD: begin
              if (Receiving_error)
               Next_State = IDLE;
				      else if (RX_D_VLD) 
				       begin
					      Next_State = RF_WR_ADDR;
               end 
				      else 
				       begin
				       	Next_State = RF_WR_CMD;
	             end
			        end
			   
	RF_WR_ADDR: begin
	             if (Receiving_error)
                Next_State = IDLE;
				       else if (RX_D_VLD) 
				        begin
					       Next_State = RF_WR_DATA;
                end 
				       else 
				        begin
					       Next_State = RF_WR_ADDR;
	              end
			        end	

  RF_WR_DATA: begin
					     Next_State = IDLE;
			        end					
		  
	RF_RD_CMD: begin
	            if (Receiving_error)
               Next_State = IDLE;
	            else if (RX_D_VLD) 
				       begin
					      Next_State = RF_RD_ADDR;
               end 
				      else 
				       begin
				        Next_State = RF_RD_CMD;
	             end
	           end
			   
	RF_RD_ADDR: begin
	             if (Receiving_error)
                Next_State = IDLE;
	             else if(RdData_Valid)
			          Next_State = SEND_RESULT;
				       else 
	              Next_State = RF_RD_ADDR;
	            end
		  
  ALU_OP_CMD: begin
               if (Receiving_error)
                Next_State = IDLE;
				       else if (RX_D_VLD) 
				        begin
					       Next_State = OPERAND_A;
                end 
			         else 
			          begin
 					       Next_State = ALU_OP_CMD;
	              end	
	            end
					   
	OPERAND_A: begin
	            if (Receiving_error)
               Next_State = IDLE;
              else   
			         Next_State = WRITE_A;
	           end
	           
	WRITE_A: begin
	          if (Receiving_error)
             Next_State = IDLE;
	          else if (RX_D_VLD) 
				     begin
				      Next_State = OPERAND_B;
             end 
				    else 
				     begin
					    Next_State = WRITE_A;
	           end	
	         end
			   
	OPERAND_B: begin
	            if (Receiving_error)
               Next_State = IDLE;
              else   
			         Next_State = WRITE_B;	
	           end
	           
	WRITE_B: begin
	          if (Receiving_error)
             Next_State = IDLE;
	          else if (RX_D_VLD) 
				     begin
				      Next_State = ALU_OPERATION;
             end 
				    else 
				     begin
					    Next_State = WRITE_B;
	           end	
	         end

  ALU_OPERATION: begin
                  if (Receiving_error)
                   Next_State = IDLE;
	                else if(OUT_Valid)
			             Next_State = SEND_RESULT;
					        else 
			             Next_State = ALU_OPERATION;	
	               end

  ALU_NOP_CMD: begin
                if (Receiving_error)
                 Next_State = IDLE;
				        else if (RX_D_VLD) 
				         begin
					        Next_State = ALU_OPERATION;
                 end 
				        else 
				         begin
					         Next_State = ALU_NOP_CMD;
                  end	
	              end				   
		  
 SEND_RESULT: begin
                if(!FIFO_FULL && OUT_Valid)
			           Next_State = SEND_RESULT_Part2;
			          else if(!FIFO_FULL && RdData_Valid) 
			           Next_State = IDLE;
			          else
			           Next_State =	SEND_RESULT;
	             end
	               
	SEND_RESULT_Part2: begin
			                  Next_State = IDLE; 	
	                   end             
		  
	default: Next_State = IDLE;	  
 endcase

end

/////////////////////// OUTPUT LOGIC /////////////////////////////	
always @(*)
begin 
  //Default
			      ALU_FUN    = 4'b0;            
            ALU_EN     = 1'b0;              
            CLK_EN     = 1'b0;                     
            WrEn       = 1'b0;               
            RdEn       = 1'b0;        
            WrData     = 8'b0;            
            TX_P_DATA  = 8'b0;           
            TX_D_VLD   = 1'b0;            
            clk_div_en = 1'b1; 
            Address    = Temp_Address;
         
 case(Current_State)
	IDLE: begin
			      ALU_FUN    = 4'b0;            
            ALU_EN     = 1'b0;              
            CLK_EN     = 1'b0;
            Address    = 4'b0;                     
            WrEn       = 1'b0;               
            RdEn       = 1'b0;        
            WrData     = 8'b0;            
            TX_P_DATA  = 8'b0;           
            TX_D_VLD   = 1'b0;            
            clk_div_en = 1'b1; 
            ALU_RESULT = 16'b0;        
	      end
	
	RF_WR_ADDR: begin
	             ALU_RESULT = 16'b0;          
	            end
	
	RF_WR_DATA: begin
	              WrData = RX_P_DATA;
	              Address = Temp_Address;;
				        WrEn = 1'b1;
	              ALU_RESULT = 16'b0;			        
	            end
	
	RF_RD_ADDR: begin
	               ALU_RESULT = 16'b0;
	               Address = RX_P_DATA[3:0];
				         RdEn = 1'b1; 
	            end
	
	OPERAND_A: begin
	             ALU_RESULT = 16'b0;
	             Address = 4'b0000; 
				       WrData = RX_P_DATA;
			         WrEn = 1'b1; 
	           end
	           
	WRITE_A: begin
	           ALU_RESULT = 16'b0;
	           WrEn = 1'b0;
	         end
         
	
	OPERAND_B: begin
	             ALU_RESULT = 16'b0;
	             Address = 4'b0001;
				       WrData = RX_P_DATA;
				       WrEn = 1'b1;
	           end
	           
	WRITE_B: begin
	           ALU_RESULT = 16'b0;
	           WrEn = 1'b0;
	         end
	           
	
	ALU_OPERATION: begin
	                 ALU_RESULT = 16'b0;
	                 ALU_FUN    = RX_P_DATA[3:0];            
                   ALU_EN     = 1'b1;              
                   CLK_EN     = 1'b1;           
	               end
			 
	SEND_RESULT: begin
	              ALU_RESULT = 16'b0;
                if(RdData_Valid)
				         begin
				          TX_P_DATA = RdData;
					        TX_D_VLD = 1'b1;
				         end
				        if(OUT_Valid)
                 begin
                  ALU_RESULT = ALU_OUT;
                  TX_P_DATA  = ALU_RESULT[7:0];   // Send lower 8 bits
				          TX_D_VLD   = 1'b1;
				          ALU_EN     = 1'b1;
				          CLK_EN     = 1'b1; 	
                 end				   
              end	
              
	SEND_RESULT_Part2: begin
                       TX_P_DATA = ALU_RESULT[15:8];  // Send upper 8 bits
				               TX_D_VLD  = 1'b1;
				               CLK_EN    = 1'b1;
	                     ALU_RESULT = 16'b0; 	
                     end              
		  
	default: begin
	           ALU_FUN    = 4'b0;            
             ALU_EN     = 1'b0;              
             CLK_EN     = 1'b0;              
             Address    = 4'b0;       
             WrEn       = 1'b0;               
             RdEn       = 1'b0;        
             WrData     = 8'b0;            
             TX_P_DATA  = 8'b0;           
             TX_D_VLD   = 1'b0;            
             clk_div_en = 1'b1;
             ALU_RESULT = 16'b0;
           end	
 endcase
end


always @(posedge CLK  or negedge RST)
begin
 if(!RST)
   Temp_Address <= 4'b0;
 else if(Current_State == RF_WR_ADDR && !RX_D_VLD)
   Temp_Address <= RX_P_DATA[3:0];
 else
   Temp_Address <= Temp_Address;
end

endmodule