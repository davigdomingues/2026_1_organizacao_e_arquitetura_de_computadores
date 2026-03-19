.data
	numero1: .word 0
	numero2: .word 0
.text
	.globl main
	
main:
	li a7, 5
	ecall
	mv t0, a0
	
	li a7, 5
	ecall
	mv t1, a0
	
	bgt t0, t1, primeiroMaior
	
	mv a0, t1
	li a7, 1
	ecall
	
	j fim
	
primeiroMaior:
	mv a0, t0
	li a7, 1
	ecall

fim:
	li a7, 10
	ecall