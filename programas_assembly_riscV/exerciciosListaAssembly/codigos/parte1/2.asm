.data
	# numero: .word 0
	.align 2
.text
	.globl main

main:
	li a7, 5
	# li a0, numero -> NÃO PRECISA, porque o comando já vai reservar em a0 automaticamente
	ecall
	
	li a7, 1
	ecall
	
	li a7, 10
	ecall