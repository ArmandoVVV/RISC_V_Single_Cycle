/******************************************************************
* Description
*	This is an 32-bit arithetic logic unit that can execute the next set of operations:
*		add

* This ALU is written by using behavioral description.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	16/08/2021
******************************************************************/

module ALU 
(
	input [3:0] ALU_Operation_i,
	input signed [31:0] A_i,
	input signed [31:0] B_i,
	input [31:0] pc_plus_4_i,			//agregado para el caso de jal
	output reg Zero_o,
	output reg [31:0] ALU_Result_o
);

localparam ADD = 4'b0000;
localparam LUI = 4'b0001;
localparam ORI = 4'b0010;
localparam SLLI = 4'b0011;
localparam SRLI = 4'b0100;
localparam SUB = 4'b0101;
localparam AND = 4'b0111;
localparam XOR = 4'b1000;
localparam BEQ = 4'b1001;
localparam BNE = 4'b1010;
localparam BLT = 4'b1011;
localparam BGE = 4'b1100;
localparam JAL = 4'b1101;
   
   always @ (A_i or B_i or ALU_Operation_i or pc_plus_4_i)
     begin
		case (ALU_Operation_i)
		ADD:	// Add
			ALU_Result_o = A_i + B_i;
		LUI:
			ALU_Result_o = B_i << 12;
		ORI:
			ALU_Result_o = A_i | B_i;
		SLLI:
			ALU_Result_o = A_i << B_i;
		SRLI:
			ALU_Result_o = A_i >> B_i;
		SUB:
			ALU_Result_o = A_i - B_i;
		AND:
			ALU_Result_o = A_i & B_i;
		XOR:
			ALU_Result_o = A_i ^ B_i;
		BEQ:
			ALU_Result_o = (A_i == B_i) ? 0 : 1;
		BNE:
			ALU_Result_o = (A_i != B_i) ? 0 : 1;
		BLT:
			ALU_Result_o = (A_i < B_i) ? 0 : 1;
		BGE:
			ALU_Result_o = (A_i >= B_i) ? 0 : 1;
		JAL:
			ALU_Result_o = pc_plus_4_i;

	
		default:
			ALU_Result_o = 0;
		endcase // case(control)
		
		if(ALU_Operation_i == 4'b1101)
			Zero_o = 1'b1;
		else if(ALU_Result_o == 0)
			Zero_o = 1'b1;
		else
			Zero_o = 1'b0;
		
		//Zero_o = (ALU_Result_o == 0) ? 1'b1 : 1'b0;
		//Zero_o = (ALU_Operation_i == 4'b1101) ? 1'b1 : 1'b0;	// para saltar si es jal
		
     end // always @ (A or B or control)
endmodule // ALU