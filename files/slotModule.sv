module slotModule(
	input clk,
	input reset,
	input run, 
	output [3:0] number
);

	localparam SEED = 4'b0100; //Seed value for the shift register

	logic [3:0] shift_reg; //holds value for shift register

	//compute next shift register value
	logic feedback;

	always_comb begin 
		feedback = shift_reg[3] ^ shift_reg[2];
	end

	always_ff @(posedge clk) begin
		if (run) begin
			shift_reg <= {feedback, shift_reg[3:1]};
			number <= shift_reg;
			//number <= 4'b0010;
		end else if (reset) begin 
			shift_reg <= SEED;
			number <= SEED;
		end
	end

endmodule