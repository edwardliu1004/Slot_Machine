module sevenSegDigit(
	// TODO: define your input and output ports
	input [3:0] digit,
	output [7:0] displayBits
);

	// The following block contains the logic of your combinational circuit
	always_comb begin
		// TODO: fill out the case construct below to output the correct seven-segment display bits
		case (digit)
			4'd0: displayBits = 8'b11000000; // 0xC0 - Segments ABCDEF on, G off
         4'd1: displayBits = 8'b11111001; // 0xF9 - Segments BC on, rest off
         4'd2: displayBits = 8'b10100100; // 0xA4 - Segments ABDEG on, CF off
         4'd3: displayBits = 8'b10110000; // 0xB0 - Segments ABCDG on, EF off
         4'd4: displayBits = 8'b10011001; // 0x99 - Segments BCFG on, ADE of
			4'd5: displayBits = 8'b10010010; // 0x92 - Segments ACDGF on, BE off
         4'd6: displayBits = 8'b10000010; // 0x82 - Segments ACDEFG on, B off
         4'd7: displayBits = 8'b11111000; // 0xF8 - Segments ABC on, DEF off
         4'd8: displayBits = 8'b10000000; // 0x80 - All segments on
         4'd9: displayBits = 8'b10010000; // 0x90 - Segments ABCDFG on, E off
         default: displayBits = 8'b11111111; // All segments off for invalid input
		endcase
	end

endmodule