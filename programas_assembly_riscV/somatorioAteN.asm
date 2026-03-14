.data
    number: .word 5 # exemplo de valor a ser somado (N)
    resultado: .word 0 # numero carregado com valor inteiro 0
    
.text

.globl main

main:
    la t0, number  # carrega endereço relativo à number
    lw t1, 0(t0) # carrega o valor de N para t1 (contador)
    li t2, 0 # inicializa t2 com 0 (acumulador da soma)

loop:
    blez t1, fim # se t1 <= 0, desvia para o rótulo 'fim' (condição de parada)
    add t2, t2, t1 # adiciona o valor atual de t1 ao acumulador t2
    
    addi t1, t1, -1 # decrementa o contador t1 em 1 unidade
    
    j loop # pula incondicionalmente de volta para o início do loop
    
fim:
    la t3, resultado # carrega endereço relativo à resultado
    sw t2, 0(t3) # armazena o valor final da soma (t2) na memória

    li a7, 10 # carrega valor imediato 10 (argumento para encerrar o programa)
    ecall # chama o sistema para encerrar