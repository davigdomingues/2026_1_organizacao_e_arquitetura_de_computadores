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
	beq t0, s0, impressaoZerarContador

	# leitura do número durante a interação com o usuário
	li a7, 5
	ecall
	
	slli t1, t0, 2 # deslocamento para salvar os dados no array
	add t1, s1, t1 # endereçoBase + deslocamento
	
	sw a0, 0(t1) # armazenamento do valor no endereçø t1
	addi t0, t0, 1 # contador incrementado
	
	j loopLeitura
	
impressaoZerarContador:
	li t0, 0
	
loopImpressao:
	beq t0, s0, fim
	
	slli t1, t0, 2
	add t1, s1, t1
	
	# carrega o valor armazenado na memória
	lw a0, 0(t1)
	
	# impressão do número
	li a7, 1
	ecall
	
	# impressão de espaço (ASCII 32) para separar os números
    	li a7, 11
    	li a0, 32
    	ecall
	
	addi t0, t0, 1
	
	j loopImpressao
	
fim:
	li a7, 10
	ecall