.data
	.align 2
	termof0: .word 0 
	termof1: .word 1 
	
.text
	.globl main

main:
	# valores carregados da memória para os registradores
	la t5, termof0
	lw t3, 0(t5)
	la t5, termof1
	lw t4, 0(t5)

	# leitura do input N
	li a7, 5
	ecall
	mv t0, a0 
	
	# testes de condição inicial
	beqz t0, fim0
	beq t0, t4, fim1
	
	li t1, 1# se N=2, o loop deve rodar para calcular o próximo termo

loopSerieFibonacci:
	beq t1, t0, fim # verificação final ou ajuste do contador
	
	# lógica de soma e swap
	add t2, t3, t4
	mv t3, t4 
	mv t4, t2 
	
	addi t1, t1, 1
	
	# impressão do termo atual
	mv a0, t4
	li a7, 1
	ecall
	
	# impressão de espaço em branco
	li a0, 32
	li a7, 11
	ecall

	j loopSerieFibonacci

fim0:
	li a0, 0
	li a7, 1
	ecall
	j fim
	
fim1:
	li a0, 0
	li a7, 1
	ecall
	
	li a0, 1
	li a7, 1
	ecall

fim:
	li a7, 10
	ecall