.data
	.align 2
	fraseEhIgual: .asciz "O número informado é igual ao seu inverso!"
	fraseNaoEhIgual: .asciz "O número informado não é igual ao seu inverso!"
	
.text
	.globl main
	
main:
	li a7, 5
	ecall
	mv t0, a0 # valor N declarado
	mv t5, t0  # cópia do valor N
	
	li t1, 0 # numero invertido
	li t2, 10 # constante 10 para operações

loopInverter:
	beqz t0, comparar
	
	rem t3, t0, t2 # pega o último dígito de N
	mul t1, t1, t2 # deslocamento de casa, base 10
	add t1, t1, t3 # adiciona o dígito obtido na operação de módulo (linha 18)
	div t0, t0, t2 # elimina o último dígito de N
	
	
	j loopInverter

comparar:
	beq t5, t1, iguais
	
	la a0, fraseNaoEhIgual
	li a7, 4
	ecall
	
	j fim
	
iguais:
	la a0, fraseEhIgual
	li a7, 4
	ecall

fim:
	li a7, 10
	ecall