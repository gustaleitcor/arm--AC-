.section .data
    i:
        .word
    A:
        .space 400
    B:
        .space 400

.global _start

.section .text

_start:
    LDR R0, =A
    LDR R1, =B
    LDR R2, =i

    MOV R3, #0
    STR R3, [R2]
    MOV R3, #-1

    loop:
        LDR R3, [R2]
        CMP R3, #100
        BGT loop_end

        LDR R4, [R0, R3]
        LDR R5, [R1, R3]

        CMP R4, R5
        BGE else

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
