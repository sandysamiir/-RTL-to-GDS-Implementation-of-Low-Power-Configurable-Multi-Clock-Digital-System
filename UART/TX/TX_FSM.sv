module TX_FSM 
(
	input wire       CLK,
	input wire       RST,
	input wire       Data_Valid,
	input wire       PAR_EN,
	input wire       ser_done,
	
	output reg       busy,
	output reg [1:0] mux_sel,
	output reg       ser_en,
	output reg       par_en
);

/* MUX selection:
   00 --> start bit
   01 --> stop bit
   10 --> serial data
   11 --> parity bit */
   
   
typedef enum {
        IDLE,
        STR,
        DATA,
        PAR,
        STP
} state_;

state_ Current_State, Next_State;
				
//State transition 		
always @(posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
     Current_State <= IDLE;
   end
  else
   begin
     Current_State <= Next_State;
   end
 end
 
//Next state logic
always @(*)
 begin
  case(Current_State)
  
  IDLE     : begin
              if(Data_Valid)
			         Next_State = STR;
			        else
			         Next_State = IDLE;
             end				
  
  STR      : begin
               Next_State = DATA;  
             end
 
  DATA     : begin
              if(ser_done)
               begin
			          if(PAR_EN)
                 Next_State = PAR;
			          else
                 Next_State = STP;	
               end
              else
               Next_State = DATA;		  
             end
			 
  PAR      : begin
              Next_State = STP;	   
             end
			 
  STP      : begin
             // if(Data_Valid)
			       //  Next_State = STR;
			       // else
			         Next_State = IDLE;	   
             end
  
 default   :  Next_State = IDLE;		 
  
  endcase
end	

//Output logic
always @(*)
 begin
  //Default
  busy    = 1'b0;
  mux_sel = 2'b01;  //stop bit = 1
	ser_en  = 1'b0;
	par_en  = 1'b0; 
  
  case(Current_State)
  
  IDLE     : begin
              busy    = 1'b0;
			        mux_sel = 2'b01;  //stop bit = 1
			        ser_en  = 1'b0;	
			        par_en  = 1'b0;
             end				
  
  STR      : begin
              busy    = 1'b1;
			        mux_sel = 2'b00;	
              ser_en  = 1'b1;	
              par_en  = 1'b1;		  
             end
 
  DATA     : begin
              busy    = 1'b1;
              mux_sel = 2'b10;
              par_en  = 1'b0;	 
              if(ser_done)
               ser_en = 1'b0;
              else
               ser_en = 1'b1;		 				
             end
			 
  PAR      : begin	
              busy    = 1'b1;
			        mux_sel = 2'b11;	
			        ser_en  = 1'b0;	
			        par_en  = 1'b0;	  
             end
			 
  STP      : begin
              busy    = 1'b1;
			        mux_sel = 2'b01;	
			        ser_en  = 1'b0;
			        par_en  = 1'b0;		  
             end
  
 default   : begin
              busy    = 1'b0;
			        mux_sel = 2'b01;	 
			        ser_en  = 1'b0; 
			        par_en  = 1'b0;	 
             end		 
  
  endcase
 end	
		
		
endmodule					  
