.section .data
	a: .word 2        	// Declara uma variável 'a' e a inicializa com o valor 2
	b: .word -2      	// Declara uma variável 'b' e a inicializa com o valor -3
	result: .word 0   	// Declara uma variável 'result' e a inicializa com o valor 0

.global _start      	// Declara '_start' como um símbolo global

.section .text

_start:
	
	LDR R0, =a        	// Carrega o endereço de 'a' no registrador R0
	LDR R0, [R0]      	// Carrega o valor armazenado no endereço em R0 para R0
	
	LDR R1, =b        	// Carrega o endereço de 'b' no registrador R1
	LDR R1, [R1]      	// Carrega o valor armazenado no endereço em R1 para R1
	
	MOV R3, #0        	// Move o valor 0 para o registrador R3
	MOV R5, #0        	// Move o valor 0 para o registrador R5
	
	abs_R0:           	// Rótulo para o cálculo do valor absoluto de R0
		CMP R0, #0     	// Compara o valor em R0 com 0
		BGT abs_R0_end 	// Desvia para 'abs_R0_end' se R0 for maior que 0
		NEG R0, R0     	// Nega o valor em R0 (calcula o valor absoluto)

		ADD R5, R5, #1 	// Incrementa R5 em 1 (conta o número de valores absolutos calculados)
	abs_R0_end:
	
	abs_R1:           	// Rótulo para o cálculo do valor absoluto de R1
		CMP R1, #0     	// Compara o valor em R1 com 0
		BGT abs_R1_end 	// Desvia para 'abs_R1_end' se R1 for maior que 0
		NEG R1, R1     	// Nega o valor em R1 (calcula o valor absoluto)

		ADD R5, R5, #1 	// Incrementa R5 em 1 (conta o número de valores absolutos calculados)
	abs_R1_end:
	
	loop:             	// Rótulo para o loop
		CMP R0, #0     	// Compara o valor em R0 com 0
		BEQ loop_end   	// Desvia para 'loop_end' se R0 for igual a 0
		
		ADD R3, R3, R1 	// Adiciona o valor em R1 a R3
		SUB R0, R0, #1 	// Subtrai 1 de R0

		B loop         	// Desvia para 'loop' (repete o loop)
	loop_end:
	
	CMP R5, #1        	// Compara o valor em R5 com 1
	BNE end           	// Desvia para 'end' se R5 for diferente de 1
	NEG R3, R3        	// Nega o valor em R3
	
	end:              	// Rótulo para o final do programa
	
	LDR R0, =result   	// Carrega o endereço de 'result' no registrador R0
	STR R3, [R0]      	// Armazena o valor em R3 no endereço em R0

	mov r0, R3        	// Move o valor 0 para r0 (status de saída)
	mov r7, #1        	// Move o valor 1 para r7 (número da chamada de sistema para sair)
	svc #0            	// Realiza uma chamada de sistema para encerrar o programa
