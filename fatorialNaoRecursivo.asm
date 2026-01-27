.data
    msg_prompt: .asciz "Digite um numero (0 a 12): "
    msg_result: .asciz "O fatorial e: "
    msg_erro:   .asciz "Erro: O numero e muito grande! O limite para 32 bits e 12.\n"
    msg_neg:    .asciz "Erro: Nao existe fatorial de numero negativo.\n"
    newline:    .asciz "\n"

.text
.globl main

main:
    # --- 1. Imprimir mensagem de prompt ---
    li a7, 4
    la a0, msg_prompt
    ecall

    # --- 2. Ler o número inteiro (n) ---
    li a7, 5
    ecall
    mv t0, a0           # t0 = n (input do usuário)

    # ==========================================
    # --- VALIDAÇÃO DE ENTRADA (O SEGREDO) ---
    # ==========================================
    
    # Verificação 1: Número Negativo?
    # Se t0 < 0, vai para erro de negativo
    li t2, 0
    blt t0, t2, erro_negativo

    # Verificação 2: Overflow (Maior que 12)?
    # Se t0 > 12, vai para erro de tamanho
    li t2, 12
    bgt t0, t2, erro_overflow

    # ==========================================
    # --- LÓGICA DO FATORIAL (Se passou nos testes) ---
    # ==========================================

    li t1, 1            # t1 = acumulador (resultado), inicia em 1

loop_fatorial:
    # Condição de parada: Se n <= 1, terminamos
    li t2, 1
    ble t0, t2, exibir_resultado

    # Multiplicação
    mul t1, t1, t0      # resultado = resultado * n
    addi t0, t0, -1     # n = n - 1
    
    j loop_fatorial     # Repete

exibir_resultado:
    # Imprimir texto "O fatorial e: "
    li a7, 4
    la a0, msg_result
    ecall

    # Imprimir o número calculado
    mv a0, t1
    li a7, 1
    ecall

    # Pular linha
    li a7, 4
    la a0, newline
    ecall
    
    j fim_programa      # Pula os blocos de erro para encerrar

# ==========================================
# --- TRATAMENTO DE ERROS ---
# ==========================================

erro_overflow:
    li a7, 4
    la a0, msg_erro     # Carrega mensagem de erro de tamanho
    ecall
    j fim_programa

erro_negativo:
    li a7, 4
    la a0, msg_neg      # Carrega mensagem de erro de negativo
    ecall
    j fim_programa

# ==========================================
# --- FIM ---
# ==========================================
fim_programa:
    li a7, 10           # Exit
    ecall