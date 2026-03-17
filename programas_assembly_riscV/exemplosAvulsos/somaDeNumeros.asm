.data
    num1: .word 1 # numero carregado com valor inteiro 1
    num2: .word 2 # numero carregado com valor inteiro 1
    resultado: .word 0 # numero carregado com valor inteiro 0
    
.text

.globl main

main:
    la t0, num1 # carrega endereço relativo à num1
    la t1, num2 # carrega endereço relativo à num1
    la t2, resultado # carrega endereço relativo à num1
    
    lw t3, 0(t0) # carrega conteudo relativo à num1
    lw t4, 0(t1) # carrega conteudo relativo à num2
    
    add t5, t3, t4 # adiciona num1 e num2, armazenando em t5
    
    sw t5, 0(t2) # conteúdo de t5 armazenado em resultado
    
    li a7, 10 # carrega valor imediato 10 (argumento para encerrar o programa via ecall)
    ecall