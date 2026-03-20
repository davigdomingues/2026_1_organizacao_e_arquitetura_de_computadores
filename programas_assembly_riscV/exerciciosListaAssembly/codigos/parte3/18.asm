.data
	.align 2
	
.text
	.globl main
	
main:
	# leitura do dividendo (t0)
	li a7, 5
	ecall
	mv t0, a0
	
	# leitura do divisor (t1)
	li a7, 5
	ecall
	mv t1, a0
	
	li t4, 0 # MDC zerado por padrão

# o algoritmo é: "dividendo = divisor*quociente + resto", onde:
# se dividendo/divisor == 0, então MDC(dividendo, divisor) = divisor
# se dividendo/divisor != 0, então o resto vira o novo divisor e o divisor vira o novo dividendo (o processo original, então, se repete)

# nesse cenário, o algoritmo é tal que: t0 = t1*t2 + t3
loopDivisaoEuclidesMDC:
	rem t3, t0, t1 # resto atualizado
	beqz t3, fim # deve vir depois da operação módulo, porque, se não, quando o resto for zero ocorrerá exceção de divisão nula

	mv t0, t1 # novoDividendo = divisorAntigo
	mv t1, t3 # novoDivisor = restoAntigo

	j loopDivisaoEuclidesMDC

fim:
	mv t4, t1
	mv a0, t4
	li a7, 1
	ecall
	
	li a7, 10
	ecall