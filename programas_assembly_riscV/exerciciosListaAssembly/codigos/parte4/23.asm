.data
    .align 2
    nmrNoVetor: .asciz "\nO numero informado está no vetor!"
    nmrNaoEstaNoVetor: .asciz "\nO numero informado não está no vetor!"
		
.text
    .globl main
	
main:
	# leitura de N
    	li a7, 5
    	ecall
    	mv s0, a0 # s0 = N
	
    	# leitura do número a ser buscado
   	li a7, 5
    	ecall
    	mv s2, a0
	
    	# alocação dinâmica
    	slli a0, s0, 2
    	li a7, 9
    	ecall
    	mv s1, a0 # s1 = Endereço base do vetor
	
    	li t0, 0 # contador i = 0
    	li t6, 0 # valor "booleano" (0 = não encontrado, 1 = encontrado)

loopLeitura:
    	beq t0, s0, resultado

	# leitura do número do vetor
    	li a7, 5
    	ecall
    
    	# armazenamento na memória
    	slli t1, t0, 2
    	add t1, s1, t1
    	sw a0, 0(t1)
    
    	# comparação do valor digitado (a0) com o buscado (s2)
    	beq a0, s2, encontrou
    
    	addi t0, t0, 1
    	j loopLeitura

encontrou:
    	li t6, 1 # iguala o booleano para 1
    	addi t0, t0, 1
    	j loopLeitura

resultado:
    	# verifica o valor de t6 para imprimir a frase correta
    	beqz t6, imprimirNao
    
    	la a0, nmrNoVetor
    	li a7, 4
    	ecall
    	
    	j fim

imprimirNao:
    	la a0, nmrNaoEstaNoVetor
    	li a7, 4
    	ecall

fim:
    	li a7, 10
    	ecall