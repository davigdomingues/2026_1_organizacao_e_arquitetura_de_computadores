.data
.text
	.align 2
.globl main

main:
	li a7, 5 # leitura de número inteiro
	ecall
	
	mv s0, a0 # copia conteúdo de a0 em s0
	mv t0, s0 # armazena em temporário t0
	addi t1, zero, 1
	
loop:
	beqz t0 the_end
	mul t1, t0, t1 # t0: valor decrementado, t1: valor acumulado
	addi t0, t0, -1
	
	j loop # volta para o começo da label
	
the_end:
	# imprime número
	li a7, 1
	mv a0, t1
	ecall
	
	# fim do programa
	li a7, 10
	ecall