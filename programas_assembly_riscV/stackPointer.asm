.text

.globl main

main:
    li s0, 99 # main usa o registrador s0 para guardar o valor 99
    
    jal funcao_soma # pula para a função (salva a linha atual em 'ra')
    
    # Quando voltar para cá, s0 deve continuar sendo 99!
    li a7, 10 # carrega o código para encerrar o programa
    ecall

# Início da Função
funcao_soma:
    # 1. Guarda as coisas na pilha
    addi sp, sp, -4 # abre espaço de 1 palavra (4 bytes) na pilha
    sw s0, 0(sp) # guarda o valor original de s0 (99) na pilha
    
    # 2. Faz o trabalho
    li s0, 5 # agora se pode usar s0 à vontade na função
    li t1, 10 # temporários (t0-t6) não precisam ir pra pilha
    add t2, s0, t1 # faz uma conta qualquer
    
    # 3. Devolve as coisas e limpa a sujeira
    lw s0, 0(sp) # recupera o valor original de s0 (99) da pilha
    addi sp, sp, 4 # fecha o espaço na pilha
    
    ret # retorna para a main (pula para o endereço em 'ra')