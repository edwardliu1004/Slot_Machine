module displayEncoder(
	input [3:0] result, 
	output [3:0] displayNumbers [1:0]
);
	logic[3:0] temp_result;
	// The following block contains the logic of your combinational circuit
	always_comb begin
		  temp_result = result;
		
        displayNumbers[0] = temp_result % 10;        
        temp_result = temp_result / 10;     

        displayNumbers[1] = temp_result % 10;          
	end

endmodule