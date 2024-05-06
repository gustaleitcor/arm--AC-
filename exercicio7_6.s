.section .data
	number:
        .asciz "00000000000000000000000001000110"
        number_len = .-number
    output:
        .space 1
        output_len = .-output

.global _start      	// Declara '_start' como um símbolo global

.section .text

to_binary:
	SUB R3, R3, #1
	MOV R0, #-1
	EOR R3, R3, R0
	BX LR

_start:

LDR R0, =number
MOV R1, #-1
MOV R3, #0
LDR R4, =number_len

SUB R4, R4, #1

loop:

	ADD R1, R1, #1
	
    CMP R1, R4
    BEQ loop_end

    LDRB R2, [R0, R1]
    CMP R2, #'1'
    BEQ is_1
    CMP R2, #'0'
    BEQ is_0
    B _end

    is_1:
        LSL R3, R3, #1
        ADD R3, R3, #1
        B loop
    is_0:
        LSL R3, R3, #1
        B loop
		
	B invalid

loop_end:

@ LDRB R2, [R0, #0]
@ CMP R2, #'1'
@ BLEQ to_binary

@ CMP R2, #255
@ BGT invalid

@ LDR R5, =output
@ LSR R2, R2, #24 
@ STRB R2, [R5]   

@ mov r0, #1  
@ ldr r1, =output  
@ ldr r2, =output_len
@ mov r7, #4 
@ svc #0  

invalid:


_end:

mov r0, R3  // Move o valor 0 para r0 (status de saída)
mov r7, #1  // Move o valor 1 para r7 (número da chamada de sistema para exit)
svc #0  // Realiza uma chamada de sistema para encerrar o programa
