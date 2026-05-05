.data
points:	.half	300, 17, 4962, 256, 7, 133, 8192
length:	.word	7

.include "system.asm"

.text
avg:
	# Implementierung beginnt hier
	li t0, 0			# int sum = 0
	li t1, 0			# i fuer for loop
	# li t6, 4			# fuer [i] * 4


	b Lcond				# for loop
	
Lbody:
	slli t6, t1, 1
	la t4, points			# t4: addr(points)
	add t4, t4, t6			# t5: offset von Startaddr
	lh t4, (t4)			# t4: points[]
	
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
