.data
    .align 2
    msgEntrada:   .asciz "Digite a quantidade N: "
    msgNumeros:   .asciz "Digite os números do vetor:\n"
    msgResultado: .asciz "\nVetor Ordenado: "

.text
    .globl main

main:
    # leitura do tamanho N
    li a7, 4
    la a0, msgEntrada
    ecall

    li a7, 5
    ecall
    mv s0, a0 # s0 = N (quantidade de elementos)


    # alocação dinâmica na heap
    slli a0, s0, 2 # calcula N*4 bytes (deslocamento de 2 bits)
    
    li a7, 9 # serviço sbrk
    ecall
    mv s1, a0 # s1 = endereçoBase do vetor


    # loop de preenchimento do vetor
    li a7, 4
    la a0, msgNumeros
    ecall

    li t0, 0 # t0 = contador i do loop de leitura

loopLeitura:
    beq t0, s0, iniciarSort

    li a7, 5
    ecall

    slli t1, t0, 2 # i * 4 para achar o deslocamento
    add t1, s1, t1 # endereçoBase + deslocamento
    
    sw a0, 0(t1) # armazena o valor lido na memória
    
    addi t0, t0, 1 # incrementa i
    j loopLeitura


# algoritmo bubble sort
iniciarSort:
    addi s2, s0, -1 # s2 = N - 1 (limite do loop externo)
    li t0, 0 # t0 = i (contador externo)

loopExterno:
    beq t0, s2, prepararImpressao
    
    li t1, 0 # t1 = j (contador interno)
    li t6, 0  # t6 = flag de troca (0 = falso)

loopInterno:
    sub t3, s2, t0 # t3 = (N - 1) - i (limite dinâmico do j)
    beq t1, t3, checarTroca

    # acessa os elementos adjacentes: vetor[j] e vetor[j+1]
    slli t4, t1, 2 # j*4
    add t4, s1, t4 # t4 = endereço de vetor[j]
    
    lw a0, 0(t4) # a0 = valor de vetor[j]
    lw a1, 4(t4) # a1 = valor de vetor[j+1]

    # condição de troca: se vetor[j] <= vetor[j+1], não troca
    ble a0, a1, semTroca

    # swap na memória
    sw a1, 0(t4) # vetor[j] = valor menor
    sw a0, 4(t4) # vetor[j+1] = valor maior
    
    li t6, 1 # t6 = 1 (sinaliza que houve troca nesta passada)

semTroca:
    addi t1, t1, 1 # j++
    j loopInterno

checarTroca:
    beqz t6, prepararImpressao # se não houve troca, o vetor já está ordenado
    
    addi t0, t0, 1 # i++
    j loopExterno


# impressão dos resultados
prepararImpressao:
    li a7, 4
    la a0, msgResultado
    ecall
    
    li t0, 0 # t0 = contador i de impressão

loopImpressao:
    beq t0, s0, fim
    
    slli t1, t0, 2
    add t1, s1, t1
    
    lw a0, 0(t1) # carregamento do valor ordenado na memória
    
    li a7, 1 # impressão do número
    ecall
    
    li a7, 11
    li a0, 32 # imprime espaço em branco (ASCII 32)
    ecall
    
    addi t0, t0, 1
    j loopImpressao

fim:
    li a7, 10
    ecall
