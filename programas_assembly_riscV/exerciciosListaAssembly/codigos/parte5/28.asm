.text
	.align 2

.globl main

main:
    # Exemplo: demonstrar salvamento e restauração de registradores usando a pilha
    # Resultado esperado: soma (a0) = 20 impresso, e s0 permanece 99 internamente.

    li s0, 99 # valor em s0 que deve ser preservado após chamadas
    li a0, 7 # argumento 1 para a função
    li a1, 13 # argumento 2 para a função

    jal soma_exemplo # chama a função que retorna (a0 <- a0 + a1)

    # Imprime o resultado em a0
    li a7, 1
    ecall

    # Encerra o programa
    li a7, 10
    ecall

#-----------------------------
# soma_exemplo(a0, a1) -> a0
# - demonstra salvar registradores callee-saved (s0) e o ra na pilha
# - realiza a soma de a0 + a1 e retorna em a0
#-----------------------------
soma_exemplo:
    # Reserva espaço na pilha e salva s0 e ra
    addi sp, sp, -8 # abrir 2 palavras (8 bytes)
    sw s0, 0(sp) # salva s0
    sw ra, 4(sp) # salva ra (endereço de retorno)

    # Usa registradores à vontade
    mv s0, a0 # usa s0 dentro da função
    add a0, s0, a1 # calcula a0 = a0 + a1

    # Restaura s0 e ra e desaloca a pilha
    lw ra, 4(sp) # restaura ra
    lw s0, 0(sp) # restaura s0
    addi sp, sp, 8 # fecha o espaço da pilha

    ret