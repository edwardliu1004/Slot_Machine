module buzzer (
	input clk,
	input win,
	output reg frequency_output
);

	logic [31:0] frequency = 1;
	logic rst = 0;
	
	always_ff @(posedge clk) begin
		if (win) begin
			frequency = 400;
			rst = 0;
      end else begin
			frequency = 1;
         rst = 1;
      end
	end
	
	clockDivider(clk, rst, frequency, frequency_output);
		

endmodule