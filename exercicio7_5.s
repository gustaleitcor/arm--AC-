.section .data
	n: .word 0  // Declaração da variável n com valor inicial 0
	s: .word 3  // Declaração da variável s com valor inicial 3
	comb: .word  // Declaração da variável comb sem valor inicial

.global _start

.section .text

s_GT_n:
	MOV R1, #1  // Move o valor 1 para o registrador R1
	b end  // Salta para o rótulo end

s_or_n_NEG:
	MOV R1, #2  // Move o valor 2 para o registrador R1
	b end  // Salta para o rótulo end

s_EQ_n:
	MOV R1, #3  // Move o valor 3 para o registrador R1
	b end  // Salta para o rótulo end
	
s_or_n_ZERO:
	MOV R1, #4  // Move o valor 4 para o registrador R1
	b end  // Salta para o rótulo end

factorial:
	POP {R3}  // Desempilha o valor do topo da pilha para o registrador R3
	
factorial_loop: 
	push {LR}  // Empilha o valor do registrador LR
	
	CMP R3, #1  // Compara o valor do registrador R3 com 1
	BEQ factorial_end  // Salta para o rótulo factorial_end se forem iguais
	
	PUSH {R3}  // Empilha o valor do registrador R3
	SUB R3, R3, #1  // Subtrai 1 do valor do registrador R3
	
	BL factorial_loop  // Chama recursivamente o rótulo factorial_loop
	
	POP {R4}  // Desempilha o valor do topo da pilha para o registrador R4
	
	MUL R3, R4, R3  // Multiplica os valores dos registradores R4 e R3 e armazena o resultado em R3
	
factorial_end:
	POP {PC}  // Desempilha o valor do topo da pilha para o registrador PC (Program Counter)

division:
	MOV R2, #0  // Move o valor 0 para o registrador R2
division_loop:
	cmp r0, r1  // Compara os valores dos registradores r0 e r1
	blt division_end  // Salta para o rótulo division_end se r0 for menor que r1
	sub r0, r0, r1  // Subtrai o valor de r1 do valor de r0 e armazena o resultado em r0
	add r2, r2, #1  // Adiciona 1 ao valor do registrador R2
	b division_loop  // Salta para o rótulo division_loop

division_end:
	BX LR  // Salta para o endereço armazenado no registrador LR

_start:
	LDR R0, =n  // Carrega o endereço da variável n para o registrador R0
	LDR R0, [R0]  // Carrega o valor da variável n para o registrador R0

	LDR R1, =s  // Carrega o endereço da variável s para o registrador R1
	LDR R1, [R1]  // Carrega o valor da variável s para o registrador R1

	CMP R1, R0  // Compara os valores dos registradores R1 e R0
	BGT s_GT_n  // Salta para o rótulo s_GT_n se R1 for maior que R0
	BEQ s_EQ_n  // Salta para o rótulo s_EQ_n se R1 for igual a R0
	
	CMP R0, #0  // Compara o valor do registrador R0 com 0
	BLT s_or_n_NEG  // Salta para o rótulo s_or_n_NEG se R0 for menor que 0
	BEQ s_or_n_ZERO  // Salta para o rótulo s_or_n_ZERO se R0 for igual a 0
	
	CMP R1, #0  // Compara o valor do registrador R1 com 0
	BLT s_or_n_NEG  // Salta para o rótulo s_or_n_NEG se R1 for menor que 0
	BEQ s_or_n_ZERO  // Salta para o rótulo s_or_n_ZERO se R1 for igual a 0
	
	SUB R2, R0, R1  // Subtrai o valor de R1 do valor de R0 e armazena o resultado em R2
	
	PUSH {R0}  // Empilha o valor do registrador R0
	BL factorial  // Chama o rótulo factorial
	MOV R0, R3  // Move o valor do registrador R3 para o registrador R0
	
	PUSH {R1}  // Empilha o valor do registrador R1
	BL factorial  // Chama o rótulo factorial
	MOV R1, R3  // Move o valor do registrador R3 para o registrador R1
	
	PUSH {R2}  // Empilha o valor do registrador R2
	BL factorial  // Chama o rótulo factorial
	MOV R2, R3  // Move o valor do registrador R3 para o registrador R2
	
	MUL R1, R2, R1  // Multiplica os valores dos registradores R2 e R1 e armazena o resultado em R1
	
	BL division  // Chama o rótulo division

	@SDIV R2, R0, R1
	
	LDR R0, =comb  // Carrega o endereço da variável comb para o registrador R0
	STR R2, [R0]  // Armazena o valor do registrador R2 na variável comb

end:

	mov r0, R2  // Move o valor de R2 para r0 (status de saída)
	mov r7, #1  // Move o valor 1 para r7 (número da chamada de sistema para exit)
	svc #0  // Realiza uma chamada de sistema para encerrar o programa
