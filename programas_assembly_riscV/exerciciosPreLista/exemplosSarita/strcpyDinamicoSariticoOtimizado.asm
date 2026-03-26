.data
    str_src: .asciz "Teste"

.text
.globl main
main:
    la t0, str_src
    li a0, 0 # Contador (t3) opcional: usaremos o próprio a0 para o sbrk

loop_tamanho:
    lb   t1, 0(t0)
    addi t0, t0, 1
    addi a0, a0, 1
    bnez t1, loop_tamanho

    # Alocação
    li a7, 9
    ecall # a0 agora contém o endereço da heap
    mv s1, a0 # s1 guarda o início da nova string para a impressão final

    # Cópia
    la t0, str_src # Reinicia fonte
    mv t1, s1 # t1 percorre o destino (heap)

loop_copia:
    lb   t2, 0(t0)
    sb   t2, 0(t1)
    addi t0, t0, 1
    addi t1, t1, 1
    bnez t2, loop_copia

fim:
    li a7, 4
    mv a0, s1 # Move o endereço salvo em s1 para a0
    ecall
    
    li a7, 10
    ecall