.section .data
    string:
        .asciz "Sobstitoi"  // Define uma string chamada "string" com o valor "Sobstitoi"
        string_len = .-string  // Calcula o tamanho da string "string"
    x:
        .ascii "o"  // Define uma string chamada "x" com o valor "o"
    y:
        .ascii "u"  // Define uma string chamada "y" com o valor "u"

.global _start

.section .text

_start:

    LDR R0, =string  // Carrega o endereço da string "string" para o registrador R0
    
    LDR R1, =x  // Carrega o endereço da string "x" para o registrador R1
    LDRB R1, [R1, #0]  // Carrega o primeiro caractere da string "x" para o registrador R1

    LDR R2, =y  // Carrega o endereço da string "y" para o registrador R2
    LDRB R2, [R2, #0]  // Carrega o primeiro caractere da string "y" para o registrador R2

    MOV R3, #-1  // Move o valor -1 para o registrador R3

    LDR R5, =string_len  // Carrega o tamanho da string "string" para o registrador R5

    loop:
        ADD R3, R3, #1  // Incrementa o valor do registrador R3 em 1

        CMP R3, R5  // Compara o valor do registrador R3 com o valor do registrador R5
        BEQ loop_end  // Se forem iguais, vai para o rótulo "loop_end"

        LDRB R4, [R0, R3]  // Carrega o caractere da posição R3 da string "string" para o registrador R4
        CMP R4, R1  // Compara o valor do registrador R4 com o valor do registrador R1

        BNE loop  // Se forem diferentes, volta para o rótulo "loop"

        STRB R2, [R0, R3]  // Armazena o valor do registrador R2 na posição R3 da string "string"

        B loop  // Volta para o rótulo "loop"

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
