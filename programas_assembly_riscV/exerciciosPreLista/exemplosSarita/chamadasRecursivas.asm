# PILHAS
# ponteiro para pilha: sp ("stack pointer")
# cresce no sentido contrário (subtraindo sp estou reservando espaço na pilha, o oposto estarei preenchendo a pilha)
#
# Empilhar (exemplo):
#
# 1) "reservar" espaço na pilha: 
# 	3 palavras => 12 bytes 
#	addi sp, sp, -12
#
# 2) armazenar os valores na pilha: 
# 	sw ra, 0(sp)
#	sw s0, 4(sp)
#	sw a0, 8(sp)
#
# Desempilhar (exemplo):
# 1) ler os conteúdos empilhados
#	lw s0, 4(sp)
#	lw a0, 8(sp)
#	lw ra, 0(sp)
#
# 2) atualizar o sp:
#	addi sp, sp, 12


# programa ilustrativo: fatorial recursivo!
.data
	.align 0
	msg_fatorial: .asciz "Informe o número: "
	msg_fatorialResultado: .asciz "\nO resultado é: "

.text
	.align 2
	.globl main

main:
	# impressão de mensagem
	li a7, 4
	la a0, msg_fatorial
	ecall

	# leitura de número N
	li a7, 5
	ecall
	mv s0, a0
	
	# chamada da função (salva em ra o endereço de chamada)
	jal fatorialRecursivo
	
	li a7, 4
	la a0, msg_fatorialResultado
	ecall
	
	# impressão de inteiro N!
	li a7, 1
	mv a0, a1 # a1: retorno de fatorialRecursivos
	ecall
	
	# saída do programa
	li a7, 10
	ecall
	
fatorialRecursivo:
	# empilhamento do ra e do a0
	addi sp, sp, -8
	sw ra, 0(sp)
	sw a0, 4(sp)
	
	beqz a0, retorna1 # condição de parada das chamadas recursivas
	addi a0, a0, -1 # decremento recursivo de a0
	jal fatorialRecursivo # chamada sequencial de fatorialRecursivo
	
	addi a0, a0, 1 # correção de valor decrementado na cadeia da recursão
	mul a1, a1, a0 # operação n! = n * (n - 1)!
	j retornaFatorial
	
	jr ra # "subida" da recursão
	
retorna1:
	addi a1, a1, 1 # adiciona 1 na saída da recursão
	
retornaFatorial:
	# desemplilhamento das variáveis da stack ("desemduracelibilizar")
	lw ra, 0(sp)
	lw a0, 4(sp)
	addi sp, sp, 8
	
	jr ra # "subida" da recursão