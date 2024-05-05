.section .data
    a: .word 3
    b: .word 4
    m: .word 10
    n: .word 0

.global _start

.section .text



_start:

    LDR R0, =b
    LDR R1, [R0]

    LDR R0, =m
    LDR R2, [R0]

    CMP R1, R2
    BGE else

    LDR R0, =n
    LDR R1, [R0]

    LDR R0, =a
    LDR R2, [R0]

    CMP R1, R2
    BGE else

    LDR R0, =n
    LDR R1, =b

    LDR R0, [R1]

    B end

    else:

    LDR R0, =n
    LDR R1, =m

    LDR R0, [R1]

    end:

    

    mov r0, #0  // Move o valor 0 para r0 (status de saída)
    mov r7, #1  // Move o valor 1 para r7 (número da chamada de sistema para exit)
    svc #0  // Realiza uma chamada de sistema para encerrar o programa
