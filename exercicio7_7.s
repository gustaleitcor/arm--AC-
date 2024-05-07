.section .data 
    vetorX: 
        .space 64  // Espaço reservado para o vetorX com tamanho de 64 bytes
    numerosDe1: 
        .word 0  // Variável numerosDe1 inicializada com o valor 0

.global _start

.section .text

_start:
    LDR R0, =vetorX  // Carrega o endereço do vetorX no registrador R0
    MOV R1, #0  // Move o valor 0 para o registrador R1
    MOV R3, #0  // Move o valor 0 para o registrador R3

    loop:
        CMP R1, #64  // Compara o valor de R1 com 64
        BEQ loop_end  // Se forem iguais, vai para o rótulo loop_end

        LDRB R2, [R0, R1]  // Carrega um byte do endereço R0 + R1 para o registrador R2

        ADD R1, R1, #1  // Adiciona 1 ao valor de R1

        CMP R2, #1  // Compara o valor de R2 com 1
        BNE loop  // Se forem diferentes, volta para o rótulo loop

        ADD R3, R3, #1  // Adiciona 1 ao valor de R3

        B loop  // Volta para o rótulo loop

    loop_end:

    LDR R0, =numerosDe1  // Carrega o endereço de numerosDe1 no registrador R0
    STR R3, [R0]  // Armazena o valor de R3 no endereço apontado por R0

_end:
    B _end
    
    mov r0, R3  // Move o valor de R3 para r0 (status de saída)
    mov r7, #1  // Move o valor 1 para r7 (número da chamada de sistema para exit)
    svc #0  // Realiza uma chamada de sistema para encerrar o programa
