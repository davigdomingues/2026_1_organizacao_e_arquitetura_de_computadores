.data
	.align 2

.text
	.globl main

main:
	# leitura do primeiro número
	li a7, 5
	ecall

	# multiplicação por 2 e impressão
	li t0, 2
	mul t1, a0, t0
	li a7, 1
	mv a0, t1 # valor copiado para o acumulador, a fim de ser impresso
	ecall

	# leitura do segundo número
	li a7, 5
	ecall

	# multiplicação por 3 e impressão
	li t0, 3
	mul t1, a0, t0
	li a7, 1
	mv a0, t1
	ecall

	# fim do programa
	li a7, 10
	ecall