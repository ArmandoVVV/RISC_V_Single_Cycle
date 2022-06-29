MAIN:
	#addi t1,zero,3		# 0 + 3 = 3
	#addi t2,zero,7		# 0 + 7 = 7
	#addi t3,zero,1		# 0 + 1 = 1
	
	#add t1,t1,t1		# 3 + 3 = 6
	#add t2,t2,t1		# 7 + 6 = 13
	#add t3,t2,t1		# 13 + 6 = 19
	
	################################################################
	
	#lui s0, 0x10010		# s0 = 268500992
	#ori s1, s0, 0x24	# s1 = 268500992 or 36 = 268501028
	#addi s2, zero, 1	# s2 = 0 + 1
	#addi s3, zero 32	# s3 = 0 + 32
	#slli t0, s2, 4		# t0 = 1 << 4 = 16
	#srli t1, s3, 4		# t1 = 32 >> 4 = 2
	#sub t2, t0, t1		# t2 = 16 - 2
	
	#################################################################
	
	#addi t0, zero, 14	# t0 = 0 + 14
	#addi t1, zero, 13	# t1 = 0 + 13
	#and t2, t0, t1		# t2 = 12
	#andi t3, t2, 5		# t3 = 4
	#or t0, t0, t1		# t0 = 15
	#xor t0, t0, t1		# t0 = 2
	#xori t0, t0, 5		# t0 = 7
	#addi t5, zero, 70	# t5 = 70
	#srl t0, t5, t3		# t0 = 4
	#sll t0, t2, t3		# t0 = 192
	
	#################################################################
	
main:
	#lui t0, 0x10010	# t0 = 0 + 14
	#addi t1, t1, 1	# t1 = 0 + 5
	#addi t2, zero, 2	# t2 = 0 + 5
	#addi t3, zero, 3
	
	#sw t1, 0(t0)
	#sw t2, 4(t0)
	#sw t3, 8(t0)
	
	#lw t2, 0(t0)
	#lw t2, 4(t0)
	#lw t2, 8(t0)
	
	#addi zero, zero, 0
	
	#################################################################
	
	addi t1, t1, 1	# t1 = 0 + 5
	addi t2, zero, 2	# t2 = 0 + 5
	addi t3, zero, 3
	
	jal t1, jump
	
	addi t3, t3, 3
	jal t1, end
	
jump:	
	jalr t2, t1, 4
	addi t2, t2, 2
end:
	add zero,zero,zero
	
	
	
