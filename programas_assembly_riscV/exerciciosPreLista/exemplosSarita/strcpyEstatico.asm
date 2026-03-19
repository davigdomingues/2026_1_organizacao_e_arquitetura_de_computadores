.data
    prompt: .asciz "Digite uma frase: "
    msg_copiada: .asciz "\nString copiada para o destino: "
    
    # Reservando 64 bytes para cada buffer
    input_buffer: .space 64
    output_buffer: .space 64
    
    .align 0 # alinha o conteúdo das memórias para caracteres

.text
	.align 2 # alinha words ("inteiros")
	.globl main

main:
    # 1. Mostra o prompt para o usuário
    li a7, 4 # syscall 4: print_string
    la a0, prompt
    ecall

    # 2. Lê a string do teclado (input do usuário)
    li a7, 8 # syscall 8: read_string
    la a0, input_buffer # onde salvar o que o usuário digitar
    li a1, 64 # limite de bytes
    ecall

    # 3. Prepara os argumentos para o strcpy
    la a0, output_buffer # a0 = destino (dst)
    la a1, input_buffer # a1 = origem (src)
    
    # 4. Chama a função strcpy
    jal ra, strcpy

    # 5. Mostra mensagem de confirmação
    li a7, 4 # syscall 4: print_string
    la a0, msg_copiada
    ecall

    # 6. Mostra a string que agora está no output_buffer
    li a7, 4 # syscall 4: print_string
    la a0, output_buffer
    ecall

    # 7. Finalizar o programa
    li a7, 10 # syscall 10: exit
    ecall

# --- Função strcpy ---
# a0: ponteiro para destino (dst)
# a1: ponteiro para origem (src)
strcpy:
    lbu t1, 0(a1) # Carrega byte da origem
    sb t1, 0(a0) # Salva byte no destino
    addi a0, a0, 1 # Avança ponteiro destino
    addi a1, a1, 1 # Avança ponteiro origem
    bnez t1, strcpy # Se o byte não for '\0', repete (recursivo ou loop)
    ret # Retorna