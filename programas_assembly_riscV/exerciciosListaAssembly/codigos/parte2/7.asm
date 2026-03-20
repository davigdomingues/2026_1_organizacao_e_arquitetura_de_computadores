.data
	.align 2
	
.text
	.globl main
	
main:
	li a7, 5
	ecall
	mv t0, a0 # guarda o valor do limite (N)
	
	li t1, 1 # contador inicializado em 1
	
loopSoma:
	bgt t1, t0, fim # condição de saída do loop
	
	# impressão e cópia para o acumulador
	li a7, 1
	mv a0, t1
	ecall
	
	addi t1, t1, 1 # incrementa o contador
	
	j loopSoma

fim:
	li a7, 10
	ecall