.data
	.align 2
	msgMaior: .asciz "\nMaior valor: "

.text
	.globl main
	
main:
	li a7, 5
	ecall
	mv s0, a0 # s0 = N (quantidade)
	
	# Alocação dinâmica
	slli a0, s0, 2 
	li a7, 9
	ecall
	mv s1, a0 # s1 = Endereço base do vetor
	
	li t0, 0 

loopLeitura:
	beq t0, s0, buscarMaior
	li a7, 5
	ecall
	
	slli t1, t0, 2 
	add t1, s1, t1 
	
	sw a0, 0(t1) # Salva no vetor
	addi t0, t0, 1 
	j loopLeitura

buscarMaior:
	lw s2, 0(s1) # s2 = Inicializa o 'maior' com o primeiro elemento (índice 0)
	li t0, 1 # Começa a comparar a partir do segundo elemento (índice 1)

loopComparar:
	beq t0, s0, impressaoZerarContador # Se percorreu tudo, vai imprimir
	
	slli t1, t0, 2
	add t1, s1, t1
	lw t2, 0(t1) # t2 = elemento atual
	
	ble t2, s2, proximo # Se atual <= maior, não faz nada
	mv s2, t2 # Se atual > maior, atualiza s2

proximo:
	addi t0, t0, 1
	j loopComparar

impressaoZerarContador:
	li t0, 0
	
loopImpressao:
	beq t0, s0, imprimirResultadoFinal
	
	slli t1, t0, 2
	add t1, s1, t1
	lw a0, 0(t1)
	
	li a7, 1
	ecall
	
    	li a7, 11
    	li a0, 32
    	ecall
	
	addi t0, t0, 1
	j loopImpressao

imprimirResultadoFinal:
	# Imprime a string de legenda
	li a7, 4
	la a0, msgMaior
	ecall
	
	# Imprime o maior valor encontrado (que ficou em s2)
	li a7, 1
	mv a0, s2
	ecall

fim:
	li a7, 10
	ecall