.data
	.align 0
	str_src: .asciz "Teste"
	
	.align 2
	str_dst: .word 0 # posição para o ponteiro da string destino

.text
	.align 2
	.globl main
	
main:
	# comando de alocação dinâmica para a ORIGEM
	li a7, 9
	li a0, 64 # solicita 64 bytes para o sistema
	ecall
	mv s1, a0 # s1 armazena o endereço do buffer de origem (retornado em a0)
	
	# mesma estrutura para o destino
	li a7, 9
	li a0, 64 # solicita 64 bytes para o sistema
	ecall
	
	mv s2, a0 # s2 armazena o endereço do buffer de destino
	la t0, str_dst # carrega endereço do rótulo str_dst
	sw s2, 0(t0) # guarda o endereço do buffer dinâmico em str_dst

	# copiar a string constante "Teste" para o buffer dinâmico s1
	la t0, str_src # t0 = endereço da string "Teste"
	mv t1, s1 # t1 = destino (nosso heap s1)
	jal ra, loop_copy

	# agora executar o strcpy de s1 para s2
	mv t0, s1 # t0 = origem (s1)
	mv t1, s2 # t1 = destino (s2)
	jal ra, loop_copy

	# imprime o resultado que está em s2
	li a7, 4
	mv a0, s2 # a0 recebe o endereço guardado em s2
	ecall
	
	# fim do programa
	li a7, 10
	ecall
	
loop_copy:
	lbu t2, 0(t0) # lê a posição apontada por t0 em t2
	sb t2, 0(t1) # escreve t2 na posição apontada por t1
	
	# ponteiros incrementados
	addi t1, t1, 1
	addi t0, t0, 1
	
	bnez t2, loop_copy # condição de parada (enquanto não for \0)
	ret