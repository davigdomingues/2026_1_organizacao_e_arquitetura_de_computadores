.data
	# Buffer para receber a string do usuário
    	input_user: .space 256
    
    	# Buffer de destino para a cópia (strcpy)
    	dest: .space 256 
    
    	prompt: .asciz "Digite uma string: "
    	msg: .asciz "Resultado strcpy: "

.text
	.globl main

main:
    	# Imprime o prompt para o usuário
    	li a7, 4
    	la a0, prompt
    	ecall

    	# Lê a string do teclado (Input)
    	li a7, 8 # Serviço 8: read_string
    	la a0, input_user # Onde salvar a string
    	li a1, 256 # Tamanho máximo do buffer
    	ecall

    	# Prepara argumentos para o strcpy
    	la a0, dest # Destino da cópia
    	la a1, input_user # Origem (o que o usuário digitou)
    	jal ra, strcpy

    	# Imprime o rótulo da mensagem
    	li a7, 4
    	la a0, msg
    	ecall

    	# Imprime o buffer de destino (a cópia)
    	li a7, 4
    	la a0, dest
    	ecall

    	# Encerra o programa
    	li a7, 10
    	ecall

# Função strcpy(dest, src)
strcpy:
    	mv t0, a0 # t0 percorre o destino

loopCopia:
    	lb t1, 0(a1) # Carrega caractere da origem
    	sb t1, 0(t0) # Salva no destino
    	beqz t1, fimStrcpy # Se for '\0', encerra
    
    	addi t0, t0, 1     
    	addi a1, a1, 1     
    	j loopCopia

fimStrcpy:
    	ret