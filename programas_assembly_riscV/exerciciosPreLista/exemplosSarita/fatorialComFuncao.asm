.data
	.align 0
	str_01: .asciz "Digite um número maior que zero: "
	str_res1: .asciz "O fatorial de "
	str_res2: .asciz " é "
	str_erro: .asciz "Entrada inválida!\n"
	
.text
	.align 2
	.globl main

# a0 a a7 (parâmetros), a0 e a1 (retorno)

main:
loop_leitura:
	li a7, 4
	la a0, str_01
	ecall
	
	# leitura do número a ser calculado o fatorial
	li a7, 5
	ecall
	
	bgez a0, continua
	
	li a7, 4
	la a0, str_erro
	ecall
	
	j loop_leitura
	
	li a7, 10
	ecall
	
continua:
	# chamada da função fatorial: a0 = número, retornando a1 (ao!)
	mv s0, a0
	jal fatorial
	
	li a7, 4
	la a0, str_res1
	ecall
	
	li a7, 1
	mv a0, s0
	ecall
	
	li a7, 4
	la a0, str_res2
	ecall
	
	li a7, 1
	mv a0, a1
	ecall
	
fatorial:	
	add t0, zero, a0 # contador zerado
	li a1, 1 # retorno inicializado com 1 (caso a0 == 0, já retorna valor válido)
	
loop_fat:
	beqz t0, sai
	
	mul a1, a1, t0
	addi t0, t0, -1
	
	j loop_fat
	
sai:
	jr ra