.data
    	# Buffers para as entradas do usuário
    	str1: .space 256
    	str2: .space 256

    	prompt1: .asciz "Digite a primeira string: "
    	prompt2: .asciz "Digite a segunda string: "
    	msg: .asciz "Resultado strcmp (0 = Iguais): "

.text
	.globl main

main:
    	# Lê a primeira string
    	li a7, 4
    	la a0, prompt1
    	ecall
    	
    	li a7, 8
    	la a0, str1
    	li a1, 256
    	ecall
    	
    	jal ra, remove_newline # Remove o \n do final

   	 # Lê a segunda string
    	li a7, 4
    	la a0, prompt2
    	ecall
    	
    	li a7, 8
    	la a0, str2
    	li a1, 256
    	ecall
    	
    	jal ra, remove_newline # Remove o \n do final

    	# Prepara argumentos e chama strcmp
    	la a0, str1
    	la a1, str2
    	jal ra, strcmp

    	# Salva o retorno para a impressão
    	mv t0, a0

    	# Imprime a mensagem de resultado
    	li a7, 4
    	la a0, msg
    	ecall

    	# Imprime o número inteiro (a0)
    	li a7, 1
    	mv a0, t0
    	ecall

    	# Encerra o programa
	li a7, 10
	ecall

# Função strcmp
strcmp:
loopCompara:
    	lb t0, 0(a0)
    	lb t1, 0(a1)
    	
    	bne t0, t1, stringsDiferentes 
    	beqz t0, stringsIguais
    	
    	addi a0, a0, 1 
    	addi a1, a1, 1 
    	
    	j loopCompara

stringsDiferentes:
    	sub a0, t0, t1 
    	ret

stringsIguais:
    	li a0, 0 
    	ret

# Função auxiliar para limpar o '\n' do ecall 8
remove_newline:
    	mv t2, a0
    	
loop_nl:
    	lb t3, 0(t2)
    	li t4, 10 # ASCII para '\n'
    	
    	beq t3, t4, fix_nl
    	beqz t3, end_nl
    	
    	addi t2, t2, 1
    	
    	j loop_nl
    	
fix_nl:
    sb zero, 0(t2) # Substitui '\n' por '\0'
    
end_nl:
    ret