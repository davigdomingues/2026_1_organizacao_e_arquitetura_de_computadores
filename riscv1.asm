.data
    # No Venus, usamos .string ou .asciiz para strings com terminador nulo
    msg_input:  .string "Calculando fatorial de 5 (recursivo)...\n"
    msg_res:    .string "Resultado: "
    newline:    .string "\n"

.text
    .globl main

main:
    # 1. Imprime mensagem inicial
    li a7, 4
    la a0, msg_input
    ecall

    # 2. Prepara o argumento
    li a0, 5

    # 3. Chama a função recursiva
    jal ra, factorial

    # --- Retorno ao main ---
    mv t0, a0           # Salva resultado em t0

    # 4. Imprime "Resultado: "
    li a7, 4
    la a0, msg_res
    ecall

    # 5. Imprime o inteiro resultante
    li a7, 1
    mv a0, t0
    ecall

    # 6. Pula linha
    li a7, 4
    la a0, newline
    ecall

    # 7. Encerra o programa
    li a7, 10
    ecall

# -----------------------------------------------------------
# Função Fatorial
# -----------------------------------------------------------
factorial:
    li t1, 1
    bgt a0, t1, recursive_step
    
    li a0, 1
    ret

recursive_step:
    addi sp, sp, -8     # Abre espaço na pilha
    sw ra, 4(sp)        # Salva endereço de retorno
    sw a0, 0(sp)        # Salva n

    addi a0, a0, -1     # n = n - 1
    jal ra, factorial   # Chama recursão

    lw t1, 0(sp)        # Restaura n antigo
    lw ra, 4(sp)        # Restaura endereço de retorno
    addi sp, sp, 8      # Fecha pilha

    mul a0, a0, t1      # Multiplica
    ret