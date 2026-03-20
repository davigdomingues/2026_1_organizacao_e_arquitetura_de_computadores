.data
	.align 2
	
.text
	.globl main
	
main:
	li a7, 5
	ecall
	mv t0, a0 # contador inicializado em N
	
	li t1, 0 # condição de parada inicializada em 1
	
loopSoma:
	beq t0, t1, fim # condição de saída do loop
	
	# impressão e cópia para o acumulador
	li a7, 1
	mv a0, t0
	ecall
	
	li a7, 11 # serviço print_char
    	li a0, 32 # código ASCII para 'espaço'
    	ecall
	
	addi t0, t0, -1 # incrementa o contador
	
	j loopSoma

fim:
	li a7, 10
	ecall