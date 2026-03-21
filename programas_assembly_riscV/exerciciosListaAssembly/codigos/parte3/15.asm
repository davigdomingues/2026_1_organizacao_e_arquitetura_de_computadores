.data
	.align 2
	
.text
	.globl main
	
main:
	li a7, 5
	ecall
	mv t0, a0 # valor N declarado
	
	li t1, 0 # numero invertido
	li t2, 10 # constante 10 para operações

loopInverter:
	beqz t0, fim
	
	rem t3, t0, t2 # pega o último dígito de N
	mul t1, t1, t2 # deslocamento de casa, base 10
	add t1, t1, t3 # adiciona o dígito obtido na operação de módulo (linha 18)
	div t0, t0, t2 # elimina o último dígito de N
	
	j loopInverter

fim:
	# impressão do resultado final
	mv a0, t1
	li a7, 1
	ecall
	
	li a7, 10
	ecall