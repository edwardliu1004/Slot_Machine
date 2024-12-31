module slot_machine_fsm(
	input clk,
	input rst,
	input start_stop,
	input win_flag,
	output [1:0] state
);

	typedef enum logic [1:0] {
		SET = 2'b00,
		RUN = 2'b01,
		STOP = 2'b10,
		WIN = 2'b11
	} fsm_state_t;
	
	fsm_state_t current_state = SET;
	fsm_state_t next_state = SET;
	
	always_ff @(posedge clk or negedge rst) begin
		if (!rst)
			current_state <= SET;
		else 
			current_state <= next_state;
	end
	
	always_comb begin 
		next_state = current_state;
		case (current_state)
			SET: begin
				if (!start_stop)
					next_state = RUN;
			end
			RUN: begin
				if (!start_stop)
					next_state = STOP;
			end
			STOP: begin
				if (win_flag)
					next_state = WIN;
			end
			WIN: begin
				if (!rst)
					next_state = SET;
			end
		endcase
	end
	
	assign state = current_state;
	
endmodule







