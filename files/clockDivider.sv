module clockDivider #(parameter BASE_SPEED = 50_000_000)(
	input clk, 
	input rst, 
	input [31:0] speed,
	output reg outClk
);

	logic [31:0] div_ratio;
	logic [31:0] counter = 0;
	
	always_comb begin 
			div_ratio = BASE_SPEED/speed;
	end
	
	always_ff @(posedge clk) begin 
		if (rst) begin
			counter <= 0;
			outClk <= 0;
      end else begin
          if (counter == ((div_ratio / 2) - 1)) begin
              counter <= 0;  
              outClk <= ~outClk;
          end else begin
              counter <= counter + 1;   
          end
      end
	end

endmodule