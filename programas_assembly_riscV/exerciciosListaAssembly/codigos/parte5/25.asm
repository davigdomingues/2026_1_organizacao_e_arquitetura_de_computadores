.text
	.align 2
	.globl main
	
main:
	li a7, 5
	ecall
	mv s0, a0 # s0 = primeiro número
	
	li a7, 5
	ecall
	mv s1, a0 # s1 = segundo número

    	mv a0, s0 # prepara 1º argumento (a0)
    	mv a1, s1 # prepara 2º argumento (a1)
    
    	jal somar # "jump and link": pula para 'somar' e guarda o retorno em 'ra'
    
    	# o resultado voltou da função dentro de 'a0'
	li a7, 1
	ecall
	
	li a7, 10
	ecall

somar:
	add a0, a0, a1 # realiza a soma e guarda o resultado no próprio a0

	ret # "return": volta para a instrução logo após o 'jal'