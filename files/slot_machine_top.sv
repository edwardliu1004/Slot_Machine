module slot_machine_top (
	input clk,
	input rst,
	input start_stop,
	output [7:0] outputBits [5:0],
	output buzzer
);

    logic slow_clk;            // Slower clock for FSM and slot modules
    logic [1:0] state;         // Current FSM state
    logic win_flag;            // Indicates a winning condition
    logic [3:0] slot1, slot2, slot3; // Outputs from slot modules

    clockDivider(clk, rst, 2, slow_clk_1);
	 clockDivider(clk, rst, 3, slow_clk_2);
	 clockDivider(clk, rst, 4, slow_clk_3);
	 
	 slot_machine_fsm (slow_clk_1, rst, start_stop, win_flag, state);
	 
	 slotModule (slow_clk_1, state == 2'b00, state == 2'b01, slot1);
	 slotModule (slow_clk_2, state == 2'b00, state == 2'b01, slot2);
	 slotModule (slow_clk_3, state == 2'b00, state == 2'b01, slot3);

    assign win_flag = (slot1 == slot2) && (slot2 == slot3); //all outputs are the same from the slots

	 logic [3:0] digits_slot1[1:0];
	 logic [3:0] digits_slot2[1:0];
	 logic [3:0] digits_slot3[1:0];
	
	 displayEncoder(slot1, digits_slot1[1:0]);
	 displayEncoder(slot2, digits_slot2[1:0]);
	 displayEncoder(slot3, digits_slot3[1:0]);
	 
    sevenSegDigit(digits_slot1[1], outputBits[5]);
	 sevenSegDigit(digits_slot1[0], outputBits[4]);
	 sevenSegDigit(digits_slot2[1], outputBits[3]);
	 sevenSegDigit(digits_slot2[0], outputBits[2]);
	 sevenSegDigit(digits_slot3[1], outputBits[1]);
	 sevenSegDigit(digits_slot3[0], outputBits[0]);
	 
	 buzzer(slow_clk_1, state == 2'b11, buzzer);

endmodule
