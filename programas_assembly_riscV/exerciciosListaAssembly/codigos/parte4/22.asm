.data
	.align 2
	msgSomaFinal: .asciz "\nO valor da soma dos elementos é: "
	
.text
	.globl main
	
main:
	li a7, 5
	ecall
	mv s0, a0 # valor N armazenado
	
	# alocação dinâmica via sbrk + slli (shif left log. immediate)
	slli a0, s0, 2 # deslocamento de 4 bits
	li a7, 9
	ecall
	mv s1, a0
	
	li t0, 0 # contador do loop
	li t6, 0 # soma dos valores do vetor (zerado, por padrão)

loopLeitura:
	beq t0, s0, fim

	# leitura do número durante a interação com o usuário
	li a7, 5
	ecall
	
	slli t1, t0, 2 # deslocamento para salvar os dados no array
	add t1, s1, t1 # endereçoBase + deslocamento
	
	sw a0, 0(t1) # armazenamento do valor no endereçø t1
	add t6, t6, a0 # soma iterativa dos valores armazenados no vetor
	addi t0, t0, 1 # contador incrementado
	
	j loopLeitura

fim:
	li a7, 4
	la a0, msgSomaFinal
	ecall
	
	# impressão da soma dos valores armazenados no array
	mv a0, t6
	li a7, 1
	ecall
	
	li a7, 10
	ecall