.data
	.align 0
	msg_dest: .asciz "Digite a primeira string: "
	msg_src:  .asciz "Digite a segunda string: "
	msg_res:  .asciz "Resultado concatenado: "
	
	dest: .space 256 # Espaço genérico para a primeira string + resultado
	src: .space 256 # Espaço genérico para a segunda string

.text
	.globl main

main:
	li a7, 4
	la a0, msg_dest
	ecall

	li a7, 8
	la a0, dest
	li a1, 128 # Limita a leitura a 128 caracteres
	ecall

	# Remove o '\n' da primeira string para a concatenação não quebrar a linha
	la t0, dest
	
remover_nl_dest:
	lb t1, 0(t0)
	
	beqz t1, ler_src # Se achou o fim (\0), vai ler a próxima
	li t2, 10 # ASCII do '\n'
	
	beq t1, t2, achou_nl_dest
	addi t0, t0, 1
	
	j remover_nl_dest

achou_nl_dest:
	sb zero, 0(t0)      # Substitui o '\n' por '\0'

ler_src:
	li a7, 4
	la a0, msg_src
	ecall

	li a7, 8
	la a0, src
	li a1, 128
	ecall

	# Remove o '\n' da segunda string (opcional, mas limpa a saída final)
	la t0, src
	
remover_nl_src:
	lb t1, 0(t0)
	
	beqz t1, chamar_strcat
	li t2, 10
	
	beq t1, t2, achou_nl_src
	addi t0, t0, 1
	
	j remover_nl_src

achou_nl_src:
	sb zero, 0(t0)

chamar_strcat:
	# Chama a função strcat genérica
	la a0, dest
	la a1, src
	jal ra, strcat

	li a7, 4
	la a0, msg_res
	ecall

	li a7, 4
	la a0, dest
	ecall

	# Fim do programa
	li a7, 10
	ecall

# a0 = endereço destino (dest), a1 = endereço origem (src)
strcat:
	mv t0, a0

acharFimDest:
	lb t1, 0(t0)
	
	beqz t1, copiarSrc
	addi t0, t0, 1
	
	j acharFimDest

copiarSrc:
	lb t1, 0(a1)
	sb t1, 0(t0)
	
	beqz t1, fimStrcat
	
	addi t0, t0, 1
	addi a1, a1, 1
	
	j copiarSrc

fimStrcat:
	ret