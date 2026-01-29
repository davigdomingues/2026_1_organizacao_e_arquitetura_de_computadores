.data
    msg_prompt: .asciz "Digite um numero (0 a 12): "
    msg_res:    .asciz "Fatorial (Recursivo): "
    msg_err:    .asciz "Erro: Limite 12.\n"
    newline:    .asciz "\n"

.text
.globl main

# --- MAIN ---
main:
    li a7, 4
    la a0, msg_prompt
    ecall

    li a7, 5
    ecall
    
    # Validação
    li t0, 12
    bgt a0, t0, erro_limite

    # Chamada Recursiva
    jal fatorial_rec    # a0 já tem o 'n'. Vai para a função.

    # Imprimir Resultado
    mv t0, a0           # Salva resultado
    li a7, 4
    la a0, msg_res
    ecall

    mv a0, t0
    li a7, 1
    ecall
    
    j fim

# --- PROCEDIMENTO RECURSIVO ---
# Entrada: a0 (n)
# Saída:   a0 (n!)
fatorial_rec:
    # 1. PRÓLOGO (Abrir espaço na pilha)
    addi sp, sp, -8     # Decrementa o Stack Pointer (abre 8 bytes)
    sw ra, 4(sp)        # Salva o Endereço de Retorno
    sw a0, 0(sp)        # Salva o argumento 'n' atual (ex: 4)

    # 2. CASO BASE (Critério de Parada)
    li t0, 1
    ble a0, t0, base_case # Se n <= 1, vai para o caso base

    # 3. PASSO RECURSIVO
    addi a0, a0, -1     # Prepara n-1 (ex: 4 vira 3)
    jal fatorial_rec    # CHAMA A SI MESMO! (Recursão)
    
    # --- PONTO DE RETORNO (UNWINDING) ---
    # Quando chegamos aqui, a0 contém o resultado de (n-1)!
    # Precisamos recuperar o nosso 'n' original que estava na pilha

    lw t1, 0(sp)        # Recupera o 'n' antigo da pilha para t1
    mul a0, a0, t1      # a0 = resultado_filho * meu_n
    
    j epilogo           # Vai para o epílogo

base_case:
    li a0, 1            # Fatorial de 0 ou 1 é 1. Retorna 1.

    # 4. EPÍLOGO (Fechar a pilha e retornar)
epilogo:
    lw ra, 4(sp)        # Restaura o endereço de retorno original
    addi sp, sp, 8      # Devolve o espaço da pilha
    ret                 # Retorna para o nível acima

# --- ERRO E FIM ---
erro_limite:
    li a7, 4
    la a0, msg_err
    ecall

fim:
    li a7, 10
    ecall