module slot_machine_fsm(
	input clk,
	input rst,
	input start_stop,
	input win_flag,
	output reg [1:0] state
);

	typedef enum logic [1:0] {
		SET = 2'b00,
		RUN = 2'b01,
		STOP = 2'b10,
		WIN = 2'b11
	} fsm_state_t;
	
	localparam SEED = 2'b11; //Seed value for the shift register
	logic [1:0] ss_shift_reg = SEED; //holds value for shift register
	logic [1:0] rst_shift_reg = SEED;
	logic ss_feedback;
	logic rst_feedback;
	
	fsm_state_t current_state = SET;
	fsm_state_t next_state = SET;
	
	always_ff @(posedge clk) begin
		ss_shift_reg <= {ss_feedback, ss_shift_reg[1]};
		rst_shift_reg <= {rst_feedback, rst_shift_reg[1]};
		
		if (rst_shift_reg == 2'b01) begin
			current_state <= SET;
			state <= SET;
		end
		else begin
			current_state <= next_state;
			state <= next_state;
		end
	end
	
	always_comb begin 
		
		ss_feedback = start_stop;
		rst_feedback = rst;
		
		case (current_state)
			SET: begin
				if (ss_shift_reg == 2'b01) 
					next_state = RUN;
				else 
					next_state = SET;
			end
			RUN: begin
				if (ss_shift_reg == 2'b01)
					next_state = STOP;
				else 
					next_state = RUN;
			end
			STOP: begin
				if (win_flag)
					next_state = WIN;
				else 
						next_state = STOP;
			end
			WIN: begin 
				if (rst_shift_reg == 2'b01)
					next_state = SET;
				else 
					next_state = WIN;
			end
			default: begin
					next_state = SET;
			end
		endcase
	end
		
endmodule






