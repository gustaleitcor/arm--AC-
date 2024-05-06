.section .data
    i:
        .word
    A:
        .space 40

.global _start

.section .text

division_by_2:
	MOV R4, #0
division_loop:
    cmp r2, #2
    blt division_end
    sub r2, r2, #2
    add r4, r4, #1
    b division_loop

division_end:
	BX LR

_start:
    LDR R0, =A
    LDR R1, =i

    MOV R2, #0
    STR R2, [R1]
    MOV R2, #-1

    loop:
        LDR R2, [R1]
        CMP R2, #10
        BEQ loop_end

        BL division_by_2
        MOV R5, #2
        MUL R6, R4, R5
        SUB R6, R2, R6

        CMP R6, #1
        BEQ if
        B else

        if:
            MOV R4, R2
            ADD R4, R4, #1
            LDR R3, [R0, R2]
            LDR R5, [R0, R4]
            ADD R3, R3, R5
            STR R3, [R0, R2]
            B next
        
        else:
            LDR R3, [R0, R2]
            MOV R4, #2
            MUL R3, R4, R3
            STR R3, [R0, R2]
            B next
        
        next:
            ADD R2, R2, #1
            STR R2, [R1]

    loop_end:

    mov r0, #0  // Move o valor 0 para r0 (status de saída)
    mov r7, #1  // Move o valor 1 para r7 (número da chamada de sistema para exit)
    svc #0  // Realiza uma chamada de sistema para encerrar o programa
