.data
	.align 2
	fatorialNulo: .asciz "O fatorial vale: 1 (definição)"
	fatorialValorFinal: .asciz "\nO fatorial vale: "
	
.text
	.globl main
	
main:
	li a7, 5
	ecall
	mv a0, a0 # valor N lido em a0
	
	beqz a0, fatorialZero
	
	jal fatorialRecursivo # chamada da função recursiva
	mv t3, a0 # move o resultado final para t3
	
	j fatorialResultado # pula para a impressão do resultado

fatorialRecursivo:
	addi sp, sp, -8 # reserva espaço na pilha
	sw ra, 4(sp) # salva o endereço de retorno
	sw a0, 0(sp) # salva o valor de N atual
	
	li t0, 1 # constante para comparação
	ble a0, t0, fim_recursao # caso base: se N <= 1, para de chamar

	addi a0, a0, -1 # decrementa N para a próxima chamada
	jal fatorialRecursivo # chamada recursiva
	
	lw t1, 0(sp) # recupera o N desta chamada
	mul a0, a0, t1 # multiplica: N * fatorial(N - 1)
	
	lw ra, 4(sp) # recupera o endereço de retorno ra
	addi sp, sp, 8 # limpa a pilha
	ret # retorna para a chamada anterior

fim_recursao:
	li a0, 1 # o fatorial de 1 é 1
	lw ra, 4(sp) # recupera ra antes de subir
	addi sp, sp, 8 # limpa a pilha
	ret # inicia a subida da recursão

fatorialZero:
	li a7, 4
	la a0, fatorialNulo
	ecall
	
	j fim

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