.section .data
    number:
        .asciz "00000000000000000000000001000110"  // Define uma string contendo um número binário
        number_len = .-number  // Calcula o tamanho da string "number"

.global _start      	

.section .text

to_binary:
    SUB R3, R3, #1  // Subtrai 1 de R3
    MOV R0, #-1  // Move -1 para R0
    EOR R3, R3, R0  // Realiza uma operação XOR entre R3 e R0
    BX LR  // Retorna para o endereço de retorno

_start:

LDR R0, =number  // Carrega o endereço da string "number" em R0
MOV R1, #-1  // Move -1 para R1
MOV R3, #0  // Move 0 para R3
LDR R4, =number_len  // Carrega o tamanho da string "number" em R4

SUB R4, R4, #1  // Subtrai 1 de R4

loop:

    ADD R1, R1, #1  // Adiciona 1 a R1
    
    CMP R1, R4  // Compara R1 com R4
    BEQ loop_end  // Se forem iguais, vai para loop_end

    LDRB R2, [R0, R1]  // Carrega o byte apontado por R0 + R1 em R2
    
    CMP R2, #'1'  // Compara R2 com o caractere '1'
    BEQ is_1  // Se forem iguais, vai para is_1

    CMP R2, #'0'  // Compara R2 com o caractere '0'
    BEQ is_0  // Se forem iguais, vai para is_0

    B _end  // Vai para _end

    is_1:
        LSL R3, R3, #1  // Desloca R3 para a esquerda por 1 bit
        ADD R3, R3, #1  // Adiciona 1 a R3
        B loop  // Vai para loop
    is_0:
        LSL R3, R3, #1  // Desloca R3 para a esquerda por 1 bit
        B loop  // Vai para loop
        
    B invalid  // Vai para invalid

loop_end:

LDRB R2, [R0, #0]  // Carrega o primeiro byte da string "number" em R2
CMP R2, #'1'  // Compara R2 com o caractere '1'
BLEQ to_binary  // Se R2 for menor ou igual a '1', vai para to_binary

CMP R2, #255  // Compara R2 com o valor 255
BGT invalid  // Se R2 for maior que 255, vai para invalid

invalid: // Label para caso a string seja invalida

_end:
    B _end // A variável deve estar carregada no registrador R3

mov r0, R3  // Move o valor de R3 para r0
mov r7, #1  // Move o valor 1 para r7
svc #0  // Chama o serviço do sistema operacional
