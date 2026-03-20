.data
	.align 2
	
.text
	.globl main
	
main:
	li a7, 5
	ecall
	mv t0, a0 # número N declarado pelo usuário
	mv t1, a0 # N copiado em t1
	
	addi t0, t0, 1 # operação N+1
	mul t2, t1, t0 # operação N*(N+1)
	
	li t4, 2
	div t3, t2, t4 # operação (N*(N+1))/2
	
	# impressão do resultado
	li a7, 1
	mv a0, t3	
	ecall
	
	li a7, 10
	ecall