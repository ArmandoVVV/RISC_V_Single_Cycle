/******************************************************************
* Description
*	This is the top-level of a RISC-V Microprocessor that can execute the next set of instructions:
*		add
*		addi
* This processor is written Verilog-HDL. It is synthesizabled into hardware.
* Parameter MEMORY_DEPTH configures the program memory to allocate the program to
* be executed. If the size of the program changes, thus, MEMORY_DEPTH must change.
* This processor was made for computer organization class at ITESO.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	16/08/2021
******************************************************************/

module RISC_V_Single_Cycle
#(
	parameter PROGRAM_MEMORY_DEPTH = 64,
	parameter DATA_MEMORY_DEPTH = 256,
	parameter DATA_WIDTH = 32
)

(
	// Inputs
	input clk,
	input reset,
	
	output [31:0] alu_result	// para calculo de la frecuencia

);
//******************************************************************/
//******************************************************************/

//******************************************************************/
//******************************************************************/
/* Signals to connect modules*/

/**Control**/
wire imm_plus_reg_w;		// agregado
wire branch_w;				// agregado
wire alu_src_w;
wire reg_write_w;
wire mem_to_reg_w;
wire mem_write_w;
wire mem_read_w;
wire [2:0] alu_op_w;

/** Program Counter**/
wire [31:0] pc_plus_4_w;
wire [31:0] pc_w;


/**Register File**/
wire [31:0] read_data_1_w;
wire [31:0] read_data_2_w;

/**Inmmediate Unit**/
wire [31:0] inmmediate_data_w;

/**ALU**/
wire [31:0] alu_result_w;
wire zero_w;	// agregado

/**Multiplexer MUX_DATA_OR_IMM_FOR_ALU**/
wire [31:0] read_data_2_or_imm_w;

/**ALU Control**/
wire [3:0] alu_operation_w;

/**Instruction Bus**/	
wire [31:0] instruction_bus_w;

/**Data Memory**/
wire [DATA_WIDTH-1:0] read_data_w;

/**PC_PLUS_IMM**/
wire [31:0] pc_plus_imm_w;

/**PC_PLUS_4_OR_PC_PLUS_IMM**/
wire [31:0] pc_mux_result_w;

/**AND_operator**/
wire PCSrc_w;

/**READ_DATA_OR_ALU_RESULT**/
wire [31:0] alu_or_read_data_w;

/**REG_OR_PC**/
wire [31:0] reg_or_pc_w;

//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Control
CONTROL_UNIT
(
	/****/
	.OP_i(instruction_bus_w[6:0]),
	/** outputus**/
	.Imm_plus_reg_o(imm_plus_reg_w),	// agregado
	.Branch_o(branch_w),					// agregado
	.ALU_Op_o(alu_op_w),
	.ALU_Src_o(alu_src_w),
	.Reg_Write_o(reg_write_w),
	.Mem_to_Reg_o(mem_to_reg_w),
	.Mem_Read_o(mem_read_w),
	.Mem_Write_o(mem_write_w)
);

PC_Register
PROGRAM_COUNTER
(
	.clk(clk),
	.reset(reset),
	.Next_PC(pc_mux_result_w),
	.PC_Value(pc_w)
);


Data_Memory 
#(	
	.DATA_WIDTH(DATA_WIDTH),
	.MEMORY_DEPTH(DATA_MEMORY_DEPTH)

)
DATA_MEMORY
(
	.clk(clk),
	.Mem_Write_i(mem_write_w),
	.Mem_Read_i(mem_read_w),
	.Write_Data_i(read_data_2_w),
	.Address_i(alu_result_w),
	
	.Read_Data_o(read_data_w)
);


Program_Memory
#(
	.MEMORY_DEPTH(PROGRAM_MEMORY_DEPTH)
)
PROGRAM_MEMORY
(
	.Address_i(pc_w),
	.Instruction_o(instruction_bus_w)
);


Adder_32_Bits
PC_PLUS_4
(
	.Data0(pc_w),
	.Data1(4),
	
	.Result(pc_plus_4_w)
);

Adder_32_Bits		// modulo nuevo adder de pc + immediate
PC_PLUS_IMM
(
	.Data0(reg_or_pc_w),
	.Data1(inmmediate_data_w),
	.Result(pc_plus_imm_w)
);


//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/



Register_File
REGISTER_FILE_UNIT
(
	.clk(clk),
	.reset(reset),
	.Reg_Write_i(reg_write_w),
	.Write_Register_i(instruction_bus_w[11:7]),
	.Read_Register_1_i(instruction_bus_w[19:15]),
	.Read_Register_2_i(instruction_bus_w[24:20]),
	.Write_Data_i(alu_or_read_data_w),
	.Read_Data_1_o(read_data_1_w),
	.Read_Data_2_o(read_data_2_w)

);



Immediate_Unit
IMM_UNIT
(  .op_i(instruction_bus_w[6:0]),
   .Instruction_bus_i(instruction_bus_w),
   .Immediate_o(inmmediate_data_w)
);



Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_DATA_OR_IMM_FOR_ALU
(
	.Selector_i(alu_src_w),
	.Mux_Data_0_i(read_data_2_w),
	.Mux_Data_1_i(inmmediate_data_w),
	
	.Mux_Output_o(read_data_2_or_imm_w)

);

Multiplexer_2_to_1		// nuevo modulo
#(
	.NBits(32)
)
PC_PLUS_4_OR_PC_PLUS_IMM
(
	.Selector_i(PCSrc_w),
	.Mux_Data_0_i(pc_plus_4_w),
	.Mux_Data_1_i(pc_plus_imm_w),
	
	.Mux_Output_o(pc_mux_result_w)

);

ALU_Control
ALU_CONTROL_UNIT
(
	.funct7_i(instruction_bus_w[30]),
	.ALU_Op_i(alu_op_w),
	.funct3_i(instruction_bus_w[14:12]),
	.ALU_Operation_o(alu_operation_w)

);



ALU
ALU_UNIT
(
	.Zero_o(zero_w), // agregado
	.ALU_Operation_i(alu_operation_w),
	.A_i(read_data_1_w),
	.B_i(read_data_2_or_imm_w),
	.pc_plus_4_i(pc_plus_4_w),
	.ALU_Result_o(alu_result_w)
);

AND_operator					// nuevo modulo
AND_OPERATOR_UNIT
(
	.AND_data0_i(branch_w),
	.AND_data1_i(zero_w),
	
	.AND_result_o(PCSrc_w)
);

Multiplexer_2_to_1		// nuevo modulo
#(
	.NBits(32)
)
READ_DATA_OR_ALU_RESULT
(
	.Selector_i(mem_to_reg_w),
	.Mux_Data_0_i(alu_result_w),
	.Mux_Data_1_i(read_data_w),
	
	.Mux_Output_o(alu_or_read_data_w)

);

Multiplexer_2_to_1		// nuevo modulo
#(
	.NBits(32)
)
REG_OR_PC
(
	.Selector_i(imm_plus_reg_w),
	.Mux_Data_0_i(pc_w),
	.Mux_Data_1_i(read_data_1_w),
	
	.Mux_Output_o(reg_or_pc_w)

);

assign alu_result = alu_result_w;
endmodule

