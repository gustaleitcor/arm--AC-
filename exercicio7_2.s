.section .data
    a: .word 3          // Declaração da variável 'a' com o valor 3
    b: .word 4          // Declaração da variável 'b' com o valor 4
    x: .word 0          // Declaração da variável 'x' com o valor 0

.global _start

.section .text

_start:

    LDR R0, =a          
    LDR R1, [R0] // int a = 3      

    LDR R0, =b          
    LDR R2, [R0] // int b = 4

    CMP R1, #0        
    BLE end      // a < 0

    CMP R2, #50          
    BGT end      // b > 50      
    
    LDR R0, =x         
    MOV R1, #1         
    STR R1, [R0] // x = 1

    B end             

end:
    B end

    mov r0, #0          // Move o valor 0 para r0 (status de saída)
    mov r7, #1          // Move o valor 1 para r7 (número da chamada de sistema para exit)
    svc #0              // Realiza uma chamada de sistema para encerrar o programa
