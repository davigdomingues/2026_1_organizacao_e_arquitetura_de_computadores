.data
    .align 2
    termof0: .word 0 
    termof1: .word 1 

.text
    .globl main

main:
    # leitura do input N
    li a7, 5
    ecall
    mv a0, a0 # valor N passado como argumento para a0
    
    # chamada da função via jump and link
    jal imprimir_fibonacci
    
    # encerramento do programa
    li a7, 10
    ecall

imprimir_fibonacci:
    # verificação de caso base (N <= 0)
    blez a0, fim_func # se N <= 0, retorna ao main
    
    # carregamento dos valores iniciais da memória
    la t5, termof0
    lw t3, 0(t5) # t3 = F0 (0)
    la t5, termof1
    lw t4, 0(t5) # t4 = F1 (1)
    
    mv t0, a0 # t0 = limite N
    li t1, 0 # t1 = contador i do loop

loop:
    beq t1, t0, fim_func # condição de saída do loop (i == N)
    
    # impressão do termo atual (t3)
    li a7, 1
    mv a0, t3 # move o termo atual para impressão
    ecall
    
    # impressão de espaço em branco (ASCII 32)
    li a7, 11
    li a0, 32
    ecall

    # lógica de soma e swap da série
    add t2, t3, t4 # t2 = Próximo termo
    mv t3, t4 # t3 (anterior) recebe o atual
    mv t4, t2 # t4 (atual) recebe o próximo
    
    addi t1, t1, 1 # incremento do contador i
    
    j loop

fim_func:
    ret # retorno para o endereço armazenado em ra