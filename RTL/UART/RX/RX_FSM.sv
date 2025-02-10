module RX_FSM #(parameter DATA = 8)
(
	input wire            CLK,
	input wire            RST,
	
	input wire            RX_IN,
	input wire            PAR_EN,
	input wire [5:0]      edge_cnt,
	input wire [DATA-1:0] bit_cnt,
	input wire            parr_err,
	input wire            strt_glitch,
	input wire            stp_err,
	input wire [5:0]      prescale,
	
	output reg            data_valid,
	output reg            deser_en,
	output reg            data_sample_en, 
	output reg            enable,
	output reg            par_chk_en, 
	output reg            strt_chk_en, 
	output reg            stp_chk_en
);

typedef enum {
        IDLE,
        START,
        DATA_BITS,
        PARITY,
        STOP,
		    CHECK_ERR
} state_;

state_ Current_State, Next_State;
				
/////////////////////// STATE TRANSITION /////////////////////////////		
always @(posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
     Current_State  <= IDLE;
   end
  else
   begin
     Current_State <= Next_State;
   end
 end
 
/////////////////////// NEXT STATE LOGIC /////////////////////////////		
always @(*)
 begin
  case(Current_State)
  
  IDLE       : begin
                if(!RX_IN)
				         Next_State = START;
			          else 
				         Next_State = IDLE;
               end				
  
  START      : begin
                if(strt_glitch)  
				         Next_State = IDLE;
                else if(bit_cnt == 1 &&  edge_cnt == prescale)
				         Next_State = DATA_BITS;
                else
				          Next_State = START;			
               end
 
  DATA_BITS  : begin
                if(bit_cnt == DATA+1 &&  edge_cnt == prescale)
                 begin
				          if(PAR_EN)
					         Next_State = PARITY;
			            else
					         Next_State = STOP;	
                 end
                else
                 Next_State = DATA_BITS;		  
               end
			 
  PARITY     : begin
                if(bit_cnt == DATA+2 &&  edge_cnt == prescale)
				         Next_State = STOP;
				        else	
				         Next_State = PARITY;   
               end
			 
  STOP       : begin
                if(bit_cnt == DATA+3 &&  edge_cnt == prescale && PAR_EN)
			           Next_State = CHECK_ERR; 
			          else if(bit_cnt == DATA+2 &&  edge_cnt == prescale && !PAR_EN)
			           Next_State = CHECK_ERR;  
			          else
			           Next_State = STOP; 
               end
			 
  CHECK_ERR  : begin
                if(!RX_IN)
                 Next_State = START;
                else  
	               Next_State = IDLE;	   
               end
  
  default    : Next_State = IDLE;		 
  
  endcase
end	

/////////////////////// OUTPUT LOGIC /////////////////////////////		
always @(*)
 begin
  case(Current_State)
  
  IDLE       : begin
                data_valid     = 1'b0;
	              deser_en       = 1'b0;
	              data_sample_en = 1'b0;
	              enable         = 1'b0;
	              par_chk_en     = 1'b0;
	              strt_chk_en    = 1'b0;
	              stp_chk_en     = 1'b0;	
               end				
  
  START      : begin
                data_valid     = 1'b0;
	              deser_en       = 1'b0;
	              data_sample_en = 1'b1;
	              enable         = 1'b1;
	              par_chk_en     = 1'b0;
	              strt_chk_en    = 1'b1;
	              stp_chk_en     = 1'b0;		  
               end
 
  DATA_BITS  : begin
                data_valid     = 1'b0;
	              deser_en       = 1'b1;
	              data_sample_en = 1'b1;
	              enable         = 1'b1;
	              par_chk_en     = 1'b0;
	              strt_chk_en    = 1'b0;
	              stp_chk_en     = 1'b0;			  
               end
			 
  PARITY     : begin	
                data_valid     = 1'b0;
	              deser_en       = 1'b0;
	              data_sample_en = 1'b1;
	              enable         = 1'b1;
	              par_chk_en     = 1'b1;
	              strt_chk_en    = 1'b0;
	              stp_chk_en     = 1'b0;	  
               end
			 
  STOP       : begin
                data_valid     = 1'b0;
	              deser_en       = 1'b0;
	              data_sample_en = 1'b1;
	              enable         = 1'b1;
	              par_chk_en     = 1'b0;
	              strt_chk_en    = 1'b0;
	              stp_chk_en     = 1'b1;			  
               end
			 
  CHECK_ERR  : begin
                if(!parr_err && !stp_err)
			           data_valid = 1'b1;
			          else
			           data_valid = 1'b0;
	               deser_en       = 1'b0;
	               data_sample_en = 1'b0;
	               enable         = 1'b0;
	               par_chk_en     = 1'b0;
	               strt_chk_en    = 1'b0;
	               stp_chk_en     = 1'b0;
               end
  
  default    : begin
                data_valid     = 1'b0;
	              deser_en       = 1'b0;
	              data_sample_en = 1'b0;
	              enable         = 1'b0;
	              par_chk_en     = 1'b0;
	              strt_chk_en    = 1'b0;
	              stp_chk_en     = 1'b0;
               end		 
  
  endcase
 end	
		
		
endmodule	
