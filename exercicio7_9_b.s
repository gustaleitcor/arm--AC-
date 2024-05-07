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
    STR R2, [R1] // i = 0

    loop:
        LDR R2, [R1]

        CMP R2, #10 // Compara o valor de R2 com 10
        BEQ loop_end // i < 10

        BL division_by_2 // Calculo o resto
        MOV R5, #2
        MUL R6, R4, R5
        SUB R6, R2, R6 // i % 2

        CMP R6, #1 // i % 2 == 0

        BEQ else

        if:
            MOV R4, R2 // [i] 
            ADD R4, R4, #1 // [i + 1]
            LDR R3, [R0, R2] // A[i]
            LDR R5, [R0, R4] // A[i + 1]
            ADD R3, R3, R5 // A[i] + A[i+1]
            STR R3, [R0, R2] // A[i] = A[i] + A[i+1]
            B next
        
        else:
            LDR R3, [R0, R2] // A[i]
            MOV R4, #2
            MUL R3, R4, R3 // A[i] * 2
            STR R3, [R0, R2] // A[i] = A[i] * 2
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
