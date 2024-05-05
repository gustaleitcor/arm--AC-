.section .data
    string:
        .asciz "Hello World!!!\n"
        string_len = .-string

.global _start

.section .text

_start:
    mov r0, #1  // Move o valor 1 para r0 (descritor de arquivo para stdout)
    ldr r1, =string  // Carrega o endereço da string para r1
    ldr r2, =string_len  // Carrega o tamanho da string para r2
    mov r7, #4  // Move o valor 4 para r7 (número da chamada de sistema para write)
    svc #0  // Realiza uma chamada de sistema para escrever a string no stdout

    mov r0, #0  // Move o valor 0 para r0 (status de saída)
    mov r7, #1  // Move o valor 1 para r7 (número da chamada de sistema para exit)
    svc #0  // Realiza uma chamada de sistema para encerrar o programa
