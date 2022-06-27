module OR_operator
(
	input OR_data0_i,
	input OR_data1_i,
	
	output reg OR_result_o
);

	always@(*) begin
		OR_result_o = OR_data0_i | OR_data1_i;
	end

endmodule