.data
	.align 2
	frasePAR: .asciz "O numero informado é par!"
	fraseIMPAR: .asciz "O numero informado é ímpar!"

.text
	.globl main
	
main:
	li a7, 5	
	ecall
	mv t0, a0 # deve ser sempre depois de ecall, se não será sempre nulo ou lixo de memória
	
	li t1, 2
	rem t2, t0, t1
	
	beqz t2, ehPar
	
	li a7, 4
	la a0, fraseIMPAR
	ecall
	
	j fim
	
ehPar:
	li a7, 4
	la a0, frasePAR
	ecall
	
fim:
	li a7, 10
	ecall