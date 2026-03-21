.data
	.align 2
	
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

loopLeitura:
	beq t0, s0, fim

	# leitura do número durante a interação com o usuário
	li a7, 5
	ecall
	
	slli t1, t0, 2 # deslocamento para salvar os dados no array
	add t1, s1, t1 # endereçoBase + deslocamento
	
	# armazenamento do valor no endereçø t1
	sw a0, 0(t1)	
	addi t0, t0, 1
	
	j loopLeitura
	
fim:
	li a7, 10
	ecall