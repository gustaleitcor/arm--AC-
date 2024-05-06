.section .data
    i:
        .word 0
    A:
        .space 40

.global _start

.section .text

_start:
    LDR R0, =A
    LDR R1, =i

    MOV R2, #0
    STR R2, [R1]

    loop:

    LDR R2, [R1]
    CMP R2, #10
    BGE loop_end
	
	MOV R5, #4
	MUL R4, R5, R2
	
    LDR R3, [R0, R4]
    ADD R3, R3, #1
    STR R3, [R0, R4]

    ADD R2, R2, #1
    STR R2, [R1]
	
	B loop
	
    loop_end:
	B loop_end

    mov r0, #0  // Move o valor 0 para r0 (status de saída)
    mov r7, #1  // Move o valor 1 para r7 (número da chamada de sistema para exit)
    svc #0  // Realiza uma chamada de sistema para encerrar o programa
