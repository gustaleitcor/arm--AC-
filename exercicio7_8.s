.section .data
    string:
        .asciz "Sobstitoi"
        string_len = .-string
    x:
        .ascii "o"
    y:
        .ascii "u"

.global _start

.section .text

_start:

    LDR R0, =string
    
    LDR R1, =x
    LDRB R1, [R1, #0]

    LDR R2, =y
    LDRB R2, [R2, #0]

    MOV R3, #-1

    LDR R5, =string_len

    loop:
        ADD R3, R3, #1

        CMP R3, R5
        BEQ loop_end

        LDRB R4, [R0, R3]
        CMP R4, R1

        BNE loop

        STRB R2, [R0, R3]

        B loop

    loop_end:

_end:

    mov r0, #1  // Move o valor 1 para r0 (descritor de arquivo para stdout)
    ldr r1, =string  // Carrega o endereço da string para r1
    ldr r2, =string_len  // Carrega o tamanho da string para r2
    mov r7, #4  // Move o valor 4 para r7 (número da chamada de sistema para write)
    svc #0  // Realiza uma chamada de sistema para escrever a string no stdout

    mov r0, #0  // Move o valor 0 para r0 (status de saída)
    mov r7, #1  // Move o valor 1 para r7 (número da chamada de sistema para exit)
    svc #0  // Realiza uma chamada de sistema para encerrar o programa
