.section .data
    a: .word 3
    b: .word 4
    x: .word 0

.global _start

.section .text

_start:

    LDR R0, =a
    LDR R1, [R0]

    LDR R0, =b
    LDR R2, [R0]

    CMP R1, #0
    BLE end

    CMP R2, #0
    BLE end
	
	LDR R0, =x
	MOV R1, #1
    STR R1, [R0]

    B end

    end:

    mov r0, #0  // Move o valor 0 para r0 (status de saída)
    mov r7, #1  // Move o valor 1 para r7 (número da chamada de sistema para exit)
    svc #0  // Realiza uma chamada de sistema para encerrar o programa
