.data
	.align 0
	str_src: .asciz "Teste"
	.align 2
	p_str_dst: .word # ponteiro para o destino da string -> está no primeiro endereço múltiplo de 4 bytes livre na memória
	
.text
	.align 2
	.globl main

main:
	# necessidade de calcular strlen() de str_src
	la t0, str_src # t0 = endereço da string
	li t3, 0 # contador zerado, por padrão (conteúdo)

# loop "do ... while"
loop_tamanho:
	lb s0, 0(t0) # registrador s0: inteiro de propósito geral
	addi t0, t0, 1 # incrementa o endereço
	addi t3, t3, 1 # incrementa o contador
	bnez s0, loop_tamanho
	
	# alocação na heap de t3 bytes (malloc)
	# a0 = quantidade de bytes a ser alocada, retorno a0 = endereço do primeiro byte alocado
	li a7, 9 # sbrk
	mv a0, t3
	ecall
	
	# salvamento do a0 em p_str_dst
	la t1, p_str_dst # aponta para o endereço da heap da memória
	sw a0, 0(t1)

	# procedimento de cópia, t0 = endereço de str_src, t2 = endereço da string de destino
	la t0, str_src
	la t1, p_str_dst
	lw t2, 0(t1)
	
loop_copia:
	lb s0, 0(t0)
	sb s0, 0(t2)
	
	addi t0, t0, 1
	addi t2, t2, 1
	
	bnez s0, loop_copia

fim:
	# impressão da string copiada
	li a7, 4
	la t1, p_str_dst
	lw a0, 0(t1)
	ecall
	
	li a7, 10
	ecall