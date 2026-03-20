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
	
loopTotalDigitos:
	beqz t0, fim

	div t0, t0, t4 # t0 = t0/10
	addi t1, t1, 1 # contador incrementado
	
	j loopTotalDigitos

fim:
	mv a0, t1
	li a7, 1
	ecall
	
	li a7, 10
	ecall