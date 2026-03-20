.data
	.align 2
	limiteTabuada: .word 10
	
.text
	.globl main
	
main:
	li a7, 5
	ecall
	mv t0, a0 # valor a se calcular a tabuada
	
	li t1, 1 # contador de múltiplo
	
	# carregamento do limite da tabuada
	la t3, limiteTabuada
	lw t4, 0(t3)
	
loopTabuada:
	bgt t1, t4, fim
	
	# multiplicação da tabuada
	mul t2, t0, t1
	li a7, 1
	mv a0, t2
	ecall
	
	# impressão de espaço em branco
	li a7, 11
    	li a0, 32
    	ecall
	
	addi t1, t1, 1 # incrementa o múltiplo de N a ser calculado (processo iterativo da tabuada)

	j loopTabuada

fim:
	li a7, 10
	ecall