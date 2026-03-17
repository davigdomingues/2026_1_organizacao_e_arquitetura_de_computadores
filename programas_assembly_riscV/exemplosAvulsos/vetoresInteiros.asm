.data
    vetor: .word 10, 20, 30  # Três números (total 12 bytes)
    soma:  .word 0
    
.text

.globl main

main:
    	la t0, vetor # Endereço do início do vetor
    	lw t1, 0(t0) # Carrega o 10
    	lw t2, 4(t0) # Carrega o 20 (pulou 4 bytes)
    	lw t3, 8(t0) # Carrega o 30 (pulou 8 bytes do início)
    
    	add t4, t1, t2 # Soma 10 + 20
    	add t4, t4, t3 # Soma o resultado com 30
    
    	la t5, soma
    	sw t4, 0(t5) # Salva 60 na memória
    	
    	# fim do programa
    	li a7, 10
	ecall