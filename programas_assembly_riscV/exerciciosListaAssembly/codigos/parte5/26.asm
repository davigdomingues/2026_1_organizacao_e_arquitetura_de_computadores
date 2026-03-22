.data
	.align 2
	fatorialNulo: .asciz "O fatorial vale: 1 (definição)"
	fatorialValorFinal: .asciz "\nO fatorial vale: "
	
.text
	.globl main
	
main:
	li a7, 5
	ecall
	mv t0, a0 # valor N declarado
	
	beqz t0, fatorialZero
	
	jal fatorialFuncao
	
	j fatorialResultado
	
fatorialFuncao:
	li t1, 1 # contador valendo 1, para não zerar a multiplicação
	li t3, 1 # valor inicial para o fatorial de N!
	
loopFatorial:
	mul t3, t3, t1 # N! calculado durante o loop
	beq t1, t0, fimFuncao

	addi t1, t1, 1 # contador incrementado
	
	j loopFatorial

fatorialZero:
	li a7, 4
	la a0, fatorialNulo
	ecall
	
	j fim

fimFuncao:
	ret # return de fatorialFuncao

fatorialResultado:
	li a7, 4
	la a0, fatorialValorFinal
	ecall
	
	li a7, 1
	mv a0, t3
	ecall

fim:	
	li a7, 10
	ecall