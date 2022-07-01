#MAIN:
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
	
#main:
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

# practica 1 Torres de Hanoi
# Armando Cabrales

.eqv discos 3
.data
.text

main:
	lui s11, 0x10010
	addi s0, zero, discos
	addi t6, zero, 1	 	# valor para comparar
	addi a1, s0, 0
	
crear_torres:				# s11 torre 1		s1 torre 2	s2 torre 3
	addi t1, t1, 1
	sw t1, 0(s11)
	addi s11, s11, 32		# se usan 32 por el acomodo de las torres
	bne t1, s0, crear_torres
	
	addi s11, s11, -32
	addi s1, s11, 4			# acomodo de la torre 1 y 2
	addi s2, s11, 8
	
	addi s11, zero, 0
	lui s11, 0x10010
	addi s11, s11, -32
	
	jal, ra, hanoi
	jal zero, exit


hanoi:
	addi sp, sp -4		
	sw ra, 0(sp)
	bne a1, t6, else	# salta si a1 no es igual a 1
	
	# caso base
	addi s11, s11, 32		
	sw zero, 0(s11)		# remueve el disco de arriba de la torre de origen
	sw a1, 0(s2)		# añade el disco a la torre destino actual
	addi s2, s2, -32
	
	jal zero, return_hanoi	# carga a ra el valor de retorno
	
else:
	add t2, zero, s1	# intercambia la direccion de memoria de las torres
	add s1, zero, s2	# torre auxiliar = torre destino
	add s2, zero, t2	# torre destino = torre auxiliar
	
	addi a1, a1, -1
	jal ra, hanoi		# vuelve a llamar con n - 1
				
	addi a1, a1, 1		
	add t2, zero, s1	# intercambia la direccion de memoria de las torres
	add s1, zero, s2	# torre auxiliar = torre destino
	add s2, zero, t2	# torre destino = torre auxiliar
				
	# regresa a la normalidad
	
	addi s11, s11, 32
	sw zero, 0(s11)		# remueve el disco de arriba de la torre de origen
	sw a1, 0(s2)		# añade el disco a la torre auxiliar actual
	addi s2, s2, -32
	
	
	add t0, zero, s11	# intercambia la direccion de memoria de las torres
	add s11, zero, s1	# torre inicial = torre auxiliar
	add s1, zero, t0	# torre auxiliar = torre inicial
	
	addi a1, a1, -1
	jal ra, hanoi		# vuelve a llamar con n - 1
	
	addi a1, a1, 1
	add t0, zero, s11	# intercambia la direccion de memoria de las torres
	add s11, zero, s1	# torre inicial = torre auxiliar
	add s1, zero, t0	# torre auxiliar = torre inicial
	
	# regresa a la normalidad

return_hanoi:
	lw ra, 0(sp)		# carga a ra el valor de retorno almacenado en el stack
	addi sp, sp, 4		
	jalr zero, ra, 0

exit:
	
