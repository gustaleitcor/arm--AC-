.section .data
    n: .word 5
    s: .word 2
	comb: .word

.global _start

.section .text

s_GT_n:
	MOV R1, #1
	b end

s_or_n_NEG:
	MOV R1, #2
	b end

s_EQ_n:
	MOV R1, #3
	b end
	
s_or_n_ZERO:
	MOV R1, #4
	b end

factorial:
	POP {R3}
	
factorial_loop:
	push {LR}
	
	CMP R3, #1
	BEQ factorial_end
	
	PUSH {R3}
	SUB R3, R3, #1
	
	BL factorial_loop
	
	POP {R4}
	
	MUL R3, R4, R3
	
factorial_end:
	POP {PC}

division:
	MOV R2, #0
division_loop:
    cmp r0, r1
    blt division_end
    sub r0, r0, r1
    add r2, r2, #1
    b division_loop

division_end:
	BX LR
	
_start:
    LDR R0, =n
    LDR R0, [R0]

    LDR R1, =s
    LDR R1, [R1]

    CMP R1, R0
	BGT s_GT_n
	BEQ s_EQ_n
	
	CMP R0, #0
	BLT s_or_n_NEG
	BEQ s_or_n_ZERO
	
	CMP R1, #0
	BLT s_or_n_NEG
	BEQ s_or_n_ZERO
	
	SUB R2, R0, R1
	
	PUSH {R0}
	BL factorial
	MOV R0, R3
	
	PUSH {R1}
	BL factorial
	MOV R1, R3
	
	PUSH {R2}
	BL factorial
	MOV R2, R3
	
	MUL R1, R2, R1
	
	BL division

	@SDIV R2, R0, R1
	
	LDR R0, =comb
	STR R2, [R0]

end:

    mov r0, R2  // Move o valor 0 para r0 (status de saída)
    mov r7, #1  // Move o valor 1 para r7 (número da chamada de sistema para exit)
    svc #0  // Realiza uma chamada de sistema para encerrar o programa
