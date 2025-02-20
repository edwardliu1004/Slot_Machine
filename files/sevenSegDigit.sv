module sevenSegDigit(
    input [3:0] digit,
    input win, 
    input clk, 
    output logic [7:0] displayBits
);
    
    logic [7:0] normalDisplay;
    logic flashToggle;

    always_ff @(posedge clk) begin
        if (win)
            flashToggle <= ~flashToggle;
        else
            flashToggle <= 1'b0; 
    end

    always_comb begin
        case (digit)
            4'd0: normalDisplay = 8'b11000000; // 0
            4'd1: normalDisplay = 8'b11111001; // 1
            4'd2: normalDisplay = 8'b10100100; // 2
            4'd3: normalDisplay = 8'b10110000; // 3
            4'd4: normalDisplay = 8'b10011001; // 4
            4'd5: normalDisplay = 8'b10010010; // 5
            4'd6: normalDisplay = 8'b10000010; // 6
            4'd7: normalDisplay = 8'b11111000; // 7
            4'd8: normalDisplay = 8'b10000000; // 8
            4'd9: normalDisplay = 8'b10010000; // 9
            default: normalDisplay = 8'b11111111; // All segments off
        endcase
    end

    always_comb begin
        if (win && flashToggle)
            displayBits = 8'b11111111; // Turn off display during flash cycle
        else
            displayBits = normalDisplay; // Normal digit display
    end
    
endmodule
