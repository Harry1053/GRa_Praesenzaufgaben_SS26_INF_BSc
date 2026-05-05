.data
points:	.word	300, 17, 4962, 256, 7, 133, 8192
length:	.word	7
w_zero: .word   0

.include "system.asm"

.text

avg:
	li t0, 0			# i fuer loop
	li t1, 1 			# 1 fuer if 
	b Lcond_faulty
	

	

Lbody_faulty:
	
	slli t6, t0, 2			# offset
	la t4, points			# t4: addr(points)
	add t4, t4, t6			# t5: offset von Startaddr
	lw t4, (t4)			# t4: points[]
	
	mv a0, t4
	
	syscall_print_int_from_a0
	
	# IF
	syscall_read_int_to_a0
	
	beq a0, t1, Lthen
	b Lend
	
	Lthen:
		la t5, w_zero
		lw t5, (t5)
		sw t4, -100(t5)
		
		# TODO: length fuer jede 1 minus 1 rechnen
		
	Lend:
	
	addi t0, t0, 1			# i++

Lcond_faulty:
	la t2, length			# t2: length
	lw t2, (t2)
	blt t0, t2, Lbody_faulty




#######################################
	# Implementierung beginnt hier
	li t0, 0			# int sum = 0
	li t1, 0			# i fuer for loop
	# li t6, 4			# fuer [i] * 4

	b Lcond				# for loop
	
	
Lbody:
	slli t6, t1, 2
	la t4, points			# t4: addr(points)
	add t4, t4, t6			# t5: offset von Startaddr
	lw t4, (t4)			# t4: points[]
	
	add t0, t0, t4
	
	addi t1, t1, 1			# i++

Lcond:
	la t2, length			# t2: length
	lw t2, (t2)
	blt t1, t2, Lbody		# i < length
	
	
	div a0, t0, t2
	
	# Implementierung endet hier
    syscall_print_int_from_a0
	syscall_exit
