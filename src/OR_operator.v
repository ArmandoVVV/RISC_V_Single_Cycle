module AND_operator
(
	input AND_data0_i,
	input AND_data1_i,
	
	output reg AND_result_o
);

	always@(*) begin
		AND_result_o = AND_data0_i & AND_data1_i;
	end

endmodule