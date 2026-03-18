.data
    num: .word 3 # numero carregado com valor inteiro 3
    resultado: .word 0 # numero carregado com valor inteiro 0
    
.text

.globl main

main:
    la t0, num # carrega endereço relativo à num
    lw t1, 0(t0) # carrega conteudo relativo à num para t1
    la t2, resultado # carrega endereço relativo à resultado
    
    li t4, 10 # carrega valor imediato 10 (limite de comparação)
    
    ble t1, t4, else # se t1 <= t4, desvia para o rótulo 'else'
    
    addi t3, t1, -5 # subtrai 5 de t1 e armazena em t3 (caso t1 > 10)
    j fim # pula para o rótulo 'fim' para evitar o bloco else

else:
    addi t3, t1, 5 # adiciona 5 em t1 e armazena em t3 (caso t1 <= 10)

fim:
    sw t3, 0(t2) # conteúdo de t3 armazenado em resultado
    
    li a7, 10 # carrega valor imediato 10 (argumento para encerrar o programa)
    ecall # chama o sistema para encerrar