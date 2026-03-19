.data
	.align 0 # alinha para bytes (2^0 = 1 byte)
	prompt: .asciz "Digite uma frase: "
	msg: .asciz "\nCopiada para o heap: "

.text
	.align 2# alinha instruções em 4 bytes (2^2 = 4)
	.globl main

main:
    li a7, 4 # syscall 4: print_string
    la a0, prompt # carrega o prompt
    ecall # exibe o prompt

    li a7, 9 # syscall 9: sbrk (malloc)
    li a0, 64 # solicita 64 bytes para origem
    ecall # sistema retorna endereço em a0
    mv s1, a0 # s1 = endereço do buffer_src (dinâmico)

    li a7, 9 # syscall 9: sbrk (malloc)
    li a0, 64 # solicita 64 bytes para destino
    ecall # sistema retorna endereço em a0
    mv s2, a0 # s2 = endereço do buffer_dst (dinâmico)

    li a7, 8 # syscall 8: read_string
    mv a0, s1 # a0 = buffer de origem
    li a1, 64 # limite de leitura
    ecall # lê o input do usuário

    mv a0, s2# a0 = destino (argumento 1 do strcpy)
    mv a1, s1# a1 = origem (argumento 2 do strcpy)
    jal ra, strcpy# chama a função de cópia

    li a7, 4# syscall 4: print_string
    la a0, msg# exibe a mensagem de sucesso
    ecall

    li a7, 4 # syscall 4: print_string
    mv a0, s2 # exibe a string que está no destino
    ecall

    li a7, 10 # syscall 10: exit
    ecall

.align 2 # alinha a função em 4 bytes para execução eficiente
strcpy:
    lbu t1, 0(a1) # t1 = *src
    sb t1, 0(a0) # *dst = t1
    addi a0, a0, 1 # dst++
    addi a1, a1, 1 # src++
    bnez t1, strcpy # se t1 != \0, repete
    ret # retorna