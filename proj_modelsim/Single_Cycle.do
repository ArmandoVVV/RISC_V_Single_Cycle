onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /RISC_V_Single_Cycle_TB/clk_tb
add wave -noupdate /RISC_V_Single_Cycle_TB/reset_tb
add wave -noupdate -expand -group ALU /RISC_V_Single_Cycle_TB/DUV/ALU_UNIT/A_i
add wave -noupdate -expand -group ALU /RISC_V_Single_Cycle_TB/DUV/ALU_UNIT/B_i
add wave -noupdate -expand -group ALU /RISC_V_Single_Cycle_TB/DUV/ALU_UNIT/Zero_o
add wave -noupdate -expand -group ALU -radix decimal /RISC_V_Single_Cycle_TB/DUV/ALU_UNIT/ALU_Result_o
add wave -noupdate -expand -group {CONTROL UNIT} /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/OP_i
add wave -noupdate -expand -group {CONTROL UNIT} /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/Branch_o
add wave -noupdate -expand -group {CONTROL UNIT} /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/Mem_Read_o
add wave -noupdate -expand -group {CONTROL UNIT} /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/Mem_to_Reg_o
add wave -noupdate -expand -group {CONTROL UNIT} /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/Mem_Write_o
add wave -noupdate -expand -group {CONTROL UNIT} /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/ALU_Src_o
add wave -noupdate -expand -group {CONTROL UNIT} /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/Reg_Write_o
add wave -noupdate -expand -group {ALU CONTROL} /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/ALU_Op_o
add wave -noupdate -expand -group {ALU CONTROL} /RISC_V_Single_Cycle_TB/DUV/ALU_CONTROL_UNIT/funct7_i
add wave -noupdate -expand -group {ALU CONTROL} /RISC_V_Single_Cycle_TB/DUV/ALU_CONTROL_UNIT/ALU_Op_i
add wave -noupdate -expand -group {ALU CONTROL} /RISC_V_Single_Cycle_TB/DUV/ALU_CONTROL_UNIT/funct3_i
add wave -noupdate -expand -group {ALU CONTROL} /RISC_V_Single_Cycle_TB/DUV/ALU_CONTROL_UNIT/ALU_Operation_o
add wave -noupdate -expand -group {PROGRAM MEMORY} /RISC_V_Single_Cycle_TB/DUV/PROGRAM_MEMORY/Address_i
add wave -noupdate -expand -group {PROGRAM MEMORY} /RISC_V_Single_Cycle_TB/DUV/PROGRAM_MEMORY/Instruction_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 140
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {19 ps}
