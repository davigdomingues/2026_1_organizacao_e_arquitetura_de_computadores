.data
	.align 0
	str_src: .asciz "Teste"
	str_dst: .space 6 # reserva 6 bytes na memória estática
	
.text
	.align 2
	.globl main
	
main:
	la t0, str_src # t0 = endereço/índice de str_src
	la t1, str_dst # t1 = endereço de str_dst
	
	jal ra, loop_copy # pula para loop_copy e salva o endereço em ra
	
	# imprime str_dest
	li a7, 4
	la a0, str_dst
	ecall
	
	# fim do programa
	li a7, 10
	ecall
	
loop_copy:
	lbu s0, 0(t0) # lê a posição apontada por t0 em s0
	sb s0, 0(t1) #  # escreve s0 na posição apontada por t1
	
	# ponteiros incrementados
	addi t1, t1, 1
	addi t0, t0, 1
	
	bnez s0, loop_copy # condição de parada	
	ret