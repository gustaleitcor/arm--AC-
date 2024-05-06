.section .data 
    vetorX: 
        .space 64 
    numerosDe1: 
        .word 0 

.global _start

.section .text

_start:
    LDR R0, =vetorX
    MOV R1, #0
    MOV R3, #0

    loop:
        CMP R1, #64
        BEQ loop_end
		
		ADD R1, R1, #1

        LDRB R2, [R0, R1]

        CMP R2, #1
        BNE loop

        ADD R3, R3, #1

        B loop

    loop_end:

    LDR R0, =numerosDe1
    STR R3, [R0]

_end:
    mov r0, R3  // Move o valor 0 para r0 (status de saída)
    mov r7, #1  // Move o valor 1 para r7 (número da chamada de sistema para exit)
    svc #0  // Realiza uma chamada de sistema para encerrar o programa

