.data
    fraseBoasVindas: .string "Seja bem vindo!"
    .align 0

.text
    .globl main

main:
    li a7, 4
    la a0, fraseBoasVindas
    ecall

    li a7, 10
    ecall