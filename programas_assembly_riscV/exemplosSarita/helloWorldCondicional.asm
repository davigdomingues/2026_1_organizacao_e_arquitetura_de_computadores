.data
	.align 0 # alinha dados para byte
	str1: .asciz "Hello World ++ !"
	str2: .asciz "Hello Wordl -- !"

.text
	.align 2 # alinha dados para 32 its

.globl main

main:
	# lê o valor digitado e salva em a0
	li a7, 5
	ecall
	
	mv s0, a0 # ou add s0, a0, zero ou addi s0, a0, zero
	blt s0, zero, print_neg # condicional
	
	# impressão de str1
	la a0, str1
	li a7, 4
	ecall
	
	j the_end # GOTO para o fim
	
print_neg: # impressão de str2
	la a0, str2
	li a7, 4
	ecall
	
the_end: 
	# impressão de número declarado
	li a7, 1
	add a0, zero, s0
	ecall
	
	# fim do programa
	li a7, 10
	ecall