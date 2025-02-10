module FIFO_RD #(parameter DEPTH = 8,
                parameter P_SIZE = 4 )
(
    input  wire               R_CLK,
    input  wire               R_RST,
    input  wire               Rinc,
    input  wire [P_SIZE-1:0]  rq2_wptr,
    output reg [P_SIZE-1:0]   rptr,
	  output reg [P_SIZE-1:0]   raddr,
    output reg                EMPTY
);

    reg [P_SIZE-1:0] gray_rd_ptr, gray_rd_ptr_next;
	
    always @(posedge R_CLK or negedge R_RST) 
	   begin
       if (!R_RST) 
		    begin
			    raddr <= 0;
          gray_rd_ptr <= 0;  
        end 
		   else if (Rinc && !EMPTY) 
		    begin
		      if(raddr == DEPTH-1)
		        raddr <= 0;
		      else  
		        raddr <= raddr + 1;
          gray_rd_ptr <= gray_rd_ptr_next;
        end
     end

    always @(*) 
	   begin
       gray_rd_ptr_next = (raddr + 1) ^ ((raddr + 1) >> 1);
       rptr = gray_rd_ptr_next;
       EMPTY = (gray_rd_ptr == rq2_wptr);
     end

endmodule