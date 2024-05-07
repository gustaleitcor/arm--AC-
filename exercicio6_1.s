.section .data
    message:
        .asciz "Hello, World!\n" // Mensagem a ser exibida na saída padrão
        message_len = .-message  // Comprimento da mensagem

.section .text
.global _start

_start:
    MOV r0, #1            // File descriptor para a saída padrão (stdout)
    LDR r1, =message      // Endereço da mensagem a ser exibida
    LDR r2, =message_len  // Comprimento da mensagem
    MOV r7, #4            // Número da chamada do sistema para escrever na saída padrão
    SVC 0                 // Chamada do sistema

end:
    MOV r7, #1       // Número da chamada do sistema para encerrar o programa
    MOV r0, #0       // Código de saída do programa
    SVC 0            // Chamada do sistema
