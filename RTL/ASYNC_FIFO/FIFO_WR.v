module FIFO_WR #(parameter DEPTH = 8,
                 parameter P_SIZE = 4 )
(
    input  wire               W_CLK,
    input  wire               W_RST,
    input  wire               Winc,
    input  wire [P_SIZE-1:0]  wq2_rptr,
    output reg [P_SIZE-1:0]   Wptr,
	  output reg [P_SIZE-1:0]   Waddr,
    output reg                FULL
);

    reg [P_SIZE-1:0] gray_wr_ptr, gray_wr_ptr_next;
    
	
    always @(posedge W_CLK or negedge W_RST) 
     begin
      if (!W_RST) 
		   begin
			   Waddr <= 0;
         gray_wr_ptr <= 0;
       end 
		  else if (Winc && !FULL) 
		   begin
		    if(Waddr == DEPTH-1) 
			    Waddr <= 0;
			  else
			    Waddr <=  Waddr + 1; 
        gray_wr_ptr <= gray_wr_ptr_next;
       end
      end

     always @(*) 
      begin  
        gray_wr_ptr_next = (Waddr + 1) ^ ((Waddr + 1) >> 1);
        Wptr = gray_wr_ptr;
        FULL = ((gray_wr_ptr[P_SIZE-1] != wq2_rptr[P_SIZE-1])&&(gray_wr_ptr[P_SIZE-2] != wq2_rptr[P_SIZE-2])&&(gray_wr_ptr[P_SIZE-3:0] == wq2_rptr[P_SIZE-3:0]));
      end

endmodule