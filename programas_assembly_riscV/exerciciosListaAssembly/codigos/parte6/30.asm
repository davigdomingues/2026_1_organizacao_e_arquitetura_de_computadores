.data
	.align 0
	buffer: .space 256 # string de tamanho fixo
	mensagem: .asciz "Digite a string: "
	saida: .asciz "\nString invertida: "
	
.text
	.globl main
	
main:
	li a7, 4
	la a0, mensagem
	ecall

	li a7, 8
	la a0, buffer
	li a1, 256 # tamanho máximo da string determinado
	ecall
	
	la t0, buffer # registrador para indicar o fim do vetor e retirar o '\n'
	
acharFim:
	lb t1, 0(t0) # carrega o byte atual
	beqz t1, comprimentoFim # se o caractere for nulo, quer dizer que se foi achado o fim da string declarada
	li t2, 10 # ASCII para quebra de linha
	beq t1, t2, removerQuebraDeLinha # troca'\n' por nulo
	addi t0, t0, 1 # avança o ponteiro
	
	j acharFim
	
removerQuebraDeLinha:
	sb zero, 0(t0)

comprimentoFim:
	# configura ponteiros para inversão
	la t1, buffer # t1 = ponteiro para o início da string
	addi t2, t0, -1 # t2 = ponteiro para o último caractere válido da string
	
loopInversao:
	bge t1, t2, fim # se os ponteiros dos extremos se encontrarem, a inversão encerrou
	lb t3, 0(t1) # carrega o caractere do começo
	lb t4, 0(t2) # carrega o caractere do fim
	
	# lógica de inversão propriamente dita, via "two pointers"
	sb t4, 0(t1) # escreve o caractere do fim no começo
	sb t3, 0(t2) # escreve o caractere do começo no fim
	
	# atualização de ponteiros
	addi t1, t1, 1 # ponteiro do início incrementado
	addi t2, t2, -1 # ponteiro do fim decrementado
	
	j loopInversao

fim:
	li a7, 4
	la a0, saida
	ecall
	
	li a7, 4
	la a0, buffer
	ecall
	
	li a7, 10
	ecall