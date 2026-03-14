.data
    # Define a string na memória. O \n pula linha e o zero final é o terminador.
    mensagem: .asciz "Hello World\n"

.text
.globl main

main:
    # 1. Preparar os argumentos para a chamada de sistema
    li a7, 4            # O código 4 no registrador a7 diz ao sistema: "Vou imprimir uma string"
    la a0, mensagem     # O registrador a0 deve conter o endereço da string na memória
    
    # 2. Executar a chamada
    ecall               # "Ei, sistema operacional! Olha o a7 e faz o que eu pedi."

    # 3. Finalizar o programa (Boa prática para não travar o simulador)
    li a7, 10           # O código 10 encerra o programa com sucesso
    ecall