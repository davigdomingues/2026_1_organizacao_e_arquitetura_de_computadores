.data
	.align 2
	fraseEhPrimo: .asciz "O numero informado é primo!"
	fraseNaoEhPrimo: .asciz "O numero informado não é primo!"
	
.text
	.globl main

main:
	li a7, 5
	ecall
	mv t0, a0 # número inteiro lido
	
	li t1, 2 # contador iterativo do loopPrimo
	blt t0, t1, naoEhPrimo # 0 e 1 não são primos!
	
	beq t0, t1, ehPrimo # primo automático, se for 2
	
loopPrimo:
	beq t0, t1, ehPrimo
	
	rem t2, t0, t1
	
	beqz t2, naoEhPrimo
	
	addi t1, t1, 1
	j loopPrimo
	
ehPrimo:
	li a7, 4
	la a0, fraseEhPrimo
	ecall
	
	j fim
	
naoEhPrimo:
	li a7, 4
	la a0, fraseNaoEhPrimo
	ecall

fim:
	li a7, 10
	ecall