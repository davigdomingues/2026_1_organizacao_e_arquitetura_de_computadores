.data
    msg_prompt: .asciz "Digite um numero (0 a 12): "
    msg_res:    .asciz "Fatorial (Iterativo): "
    msg_err:    .asciz "Erro: Limite 12.\n"
    newline:    .asciz "\n"

.text
.globl main

# --- FUNÇÃO PRINCIPAL (MAIN) ---
main:
    # Prompt
    li a7, 4
    la a0, msg_prompt
    ecall

    # Ler Inteiro
    li a7, 5
    ecall
    
    # Validação de Limite (Segurança)
    li t0, 12
    bgt a0, t0, erro_limite
    
    # CHAMADA DO PROCEDIMENTO
    # O argumento 'n' já está em a0 (padrão RISC-V)
    jal fatorial_proc   # Pula para o procedimento e salva o retorno em ra
    
    # Ao voltar, o resultado estará em a0. Salvamos em t0 para imprimir texto antes
    mv t0, a0

    # Imprimir Texto Resultado
    li a7, 4
    la a0, msg_res
    ecall

    # Imprimir Valor (que estava salvo em t0)
    mv a0, t0
    li a7, 1
    ecall
    
    j fim

# --- PROCEDIMENTO FATORIAL (ITERATIVO) ---
# Entrada: a0 (n)
# Saída:   a0 (n!)
# Suja:    t0, t1
fatorial_proc:
    li t0, 1            # t0 será o acumulador (resultado)
    mv t1, a0           # t1 será o contador (copia de n)

loop_calc:
    li t2, 1
    ble t1, t2, fim_proc # Se contador <= 1, termina
    
    mul t0, t0, t1      # acumulador = acumulador * contador
    addi t1, t1, -1     # decrementa contador
    j loop_calc

fim_proc:
    mv a0, t0           # Move o resultado final para a0 (registrador de retorno)
    ret                 # Retorna para quem chamou (usa o endereço em ra)

# --- TRATAMENTO DE ERRO E FIM ---
erro_limite:
    li a7, 4
    la a0, msg_err
    ecall

fim:
    li a7, 10
    ecall