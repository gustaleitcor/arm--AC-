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
    STR R3, [R2] // i = 0

    MOV R6, #2 // C

    loop:
        LDR R3, [R2]
        CMP R3, #100
        BGT loop_end // i <= 100

        LDR R4, [R0, R3] // A[i]
        LDR R5, [R1, R3] // B[i]

        CMP R4, R5
        BGE else // A[i] < B[i]

        CMP R4, #0
        BEQ else // A[i] != 0

        if:
            ADD R5, R5, R6 // B[i] + C
            STR R5, [R0, R3] // A[i] = B[i] + C
            B next
        
        else:
            SUB R5, R5, R6 // B[i] - C
            STR R5, [R0, R3] // A[i] = B[i] - C
            B next
        
        next:
            ADD R2, R2, #1 // i++
            STR R2, [R1]

    loop_end:

    end:
        B end

    mov r0, #0  // Move o valor 0 para r0 (status de saída)
    mov r7, #1  // Move o valor 1 para r7 (número da chamada de sistema para exit)
    svc #0  // Realiza uma chamada de sistema para encerrar o programa
