.text

.globl main

main:
    jal funcao_A # pula para funcao_A (salva volta para main em 'ra')
    
    li a7, 10 # encerra o programa
    ecall

funcao_A:
    addi sp, sp, -4 # abre espaço na pilha
    sw ra, 0(sp)  # salva o caminho de volta para a main na pilha
    
    li t0, 1
    jal funcao_B # pula para funcao_B (isso sobrescreve o 'ra' atual)
    
    lw ra, 0(sp) # recupera o caminho de volta para a main
    addi sp, sp, 4 # fecha o espaço na pilha
    
    ret # volta para a main

funcao_B:
    # Como a funcao_B não chama mais ninguém, o 'ra' dela está seguro.
    # Não se precisa salvar 'ra' na pilha ("Leaf Function" - função folha).
    
    li t1, 2
    
    ret # volta para a funcao_A (usando o 'ra' que o jal gerou)