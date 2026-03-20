.data
	.align 2
	modulo10: .word 10

.text
	.globl main
	
main:
	# t4 vai guardar o valor 10
	la t3, modulo10
	lw t4, 0(t3)
	
	li a7, 5
	ecall
	mv t0, a0 # valor N declarado
	
	li t1, 0 # contador zerado
	li t5, 0 # soma total dos dígitos do número zerada
	
loopSomaTotalDigitos:
	beqz t0, fim

	rem t5, t0, t4 # t5 = t0 mod(10)
	div t0, t0, t4 # t0 = t0/10
	add t1, t1, t5 # contador incrementado
	
	j loopSomaTotalDigitos

fim:
	mv a0, t1
	li a7, 1
	ecall
	
	li a7, 10
	ecall