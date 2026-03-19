.data
	numero1: .word 0
	numero2: .word 0
	.align 2
	
.text
	.globl main
	
main:
	li a7, 5
	ecall
	mv t0, a0
	
	li a7, 5
	ecall
	mv t1, a0
	
	add t2, t0, t1
	
	li a7, 1
	mv a0, t2
	ecall
	
	li a7, 10
	ecall