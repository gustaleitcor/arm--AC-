.section .data
    input:
        .ascii "loira"
        input_len = .-input
    output:
        .space input_len
	c:
		.space 1

.global _start

.section .text

capitalize:
	ADD R5, R5, #32
	b store_char
lower:
	SUB R5, R5, #32
	b store_char
_start:
    LDR R1, =input_len
    LDR R2, =input
    LDR R3, =output
	LDR R4, =output

	ADD R3, R3, R1
	SUB R3, R3, #1
	
    loop:
        CMP R3, R4
        BLT end
		
		LDRB R5, [R2]
		
		CMP R5, #'a'
		BLT not_a_letter
		CMP R5, #'z'
		BLE lower
		
		CMP R5, #'A'
		BLT not_a_letter
		CMP R5, #'Z'
		BLE capitalize
		
		store_char:
		
        STRB R5, [R3]

        ADD R2, R2, #1
		SUB R3, R3, #1

        B loop
    end:
    not_a_letter:

    mov r0, #0  // Move o valor 0 para r0 (status de saída)
    mov r7, #1  // Move o valor 1 para r7 (número da chamada de sistema para exit)
    svc #0  // Realiza uma chamada de sistema para encerrar o programa
