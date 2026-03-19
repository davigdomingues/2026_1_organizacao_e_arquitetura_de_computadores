.data
    msg: .asciz "O resultado da soma (10 + 25) e: "

.text
.globl main

main:
    # 1. Imprime a mensagem de texto
    la a0, msg
    li a7, 4
    ecall

    # 2. Carrega números nos registradores
    li t0, 10 # t0 = 10
    li t1, 25 # t1 = 25

    # 3. Soma os valores e guarda em a0
    # Usamos a0 porque o serviço de impressão de inteiro (a7=1) lê de a0
    add a0, t0, t1 # a0 = 10 + 25

    # 4. Imprime o número inteiro que está em a0
    li a7, 1
    ecall

    # 5. Encerra o programa corretamente
    li a7, 10
    ecall
