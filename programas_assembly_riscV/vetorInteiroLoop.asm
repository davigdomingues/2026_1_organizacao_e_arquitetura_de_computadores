.data
    vetor: .word 10, 20, 30  # Três números (total 12 bytes)
    soma:  .word 0
    
.text

.globl main

main:
    	la t0, vetor # Endereço do início do vetor
    	li t1, 3 # contador para o total de números
    	li t2, 0 # acumulador da soma
	
loop:
	lw t3, 0(t0) # carrega o valor atual do vetor na memória
	add t2, t2, t3 # adiciona o valor carregado na variável de soma
	
	addi t0, t0, 4 # processo de percorrimento do vetor
	addi t1, t1, -4 # decréscimo no total de números a serem percorridos
	
	bgtz t1, loop # retorna ao loop, se t1 > 0
	
fim:
	# carrega o resultado da soma
	la t4, soma
	sw t2. 0(t4)
	
	# fim do programa
	li a7, 10
	ecall