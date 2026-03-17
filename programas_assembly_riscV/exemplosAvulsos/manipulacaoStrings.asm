.data
	vetorCaracteres: .asciz  "hello world" # string genérica
	totalVetorCaracteres: .word 0 # contador de caracteres em uma string qualquer
.text

.globl main

main:
	la t0, vetorCaracteres # carrega o endereçø da String
	li t1, 0 # carrega um imediato em t2 (referente ao total de caracteres na String em si)

loop:
	lbu t2, 0(t0) # leitura do caractere da String
	beq t2, zero, fim # verificação de caractere nulo ('\0')
	
	addi t1, t1, 1 # incrementa o contador de total de palavras da String
	
	addi t0, t0, 1 # passagem para o próximo caractere
	j loop # retorno ao ciclo de execução da label "loop"
	
fim:
	la t3, totalVetorCaracteres # carrega o endereço do total de caracteres da String
	sw t1, 0(t3) # armazena o valor total da soma realizada no loop
	
	# estrutura para impressão do total de caracteres
	li a7, 1 # comando para imprimir resultado na tela
	mv a0, t1 # move o valor armazenado em t1 (o resultado em si) para o a0
	ecall
	
	# estrutura de finalização do programa
	li a7, 10
	ecall