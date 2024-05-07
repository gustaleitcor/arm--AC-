.section .data
    i:
        .word
    A:
        .space 40

.global _start

.section .text

_start:
    LDR R0, =A  // Carrega o endereço de memória da variável A em R0
    LDR R1, =i  // Carrega o endereço de memória da variável i em R1

    MOV R2, #0  // Move o valor 0 para R2
    STR R2, [R1]  // i = 0

    loop:

        LDR R2, [R1]  // Carrega o valor do endereço de memória apontado por R1 em R2

        CMP R2, #10  // Compara o valor de R2 (i) com 10
        BEQ loop_end  // i < 10

        LDR R3, [R0, R2]  // A[i]
        ADD R3, R3, #1  // A[i] + 1
        STR R3, [R0, R2]  // A[i] = A[i]+1

        ADD R2, R2, #1  // i++
        STR R2, [R1] 

        B loop  // Salta para o rótulo loop

    loop_end:

    mov r0, #0  // Move o valor 0 para r0 (status de saída)
    mov r7, #1  // Move o valor 1 para r7 (número da chamada de sistema para exit)
    svc #0  // Realiza uma chamada de sistema para encerrar o programa
