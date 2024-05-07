.section .data
	contra_barra:
		.ascii "\n"  // Define uma sequência de caracteres representando uma quebra de linha
		contra_barra_len = .-contra_barra  // Calcula o tamanho da sequência de caracteres "contra_barra"
	input:
		.ascii "HArdwArE"  // Define uma string chamada "input" com o valor "HArdwArE"
		input_len = .-input  // Calcula o tamanho da string "input"
	output:
		.space input_len  // Define um espaço de memória para armazenar a string de saída
	aviso:
		.asciz "String Invalida\n"  // Define uma string chamada "aviso" com o valor "String Invalida" seguido de uma quebra de linha
		aviso_len = .-aviso  // Calcula o tamanho da string "aviso"

.global _start

.section .text

capitalize:
	ADD R5, R5, #32  // Adiciona 32 ao valor de R5 (conversão para maiúscula)
	b store_char  // Salta para a função "store_char"
lower:
	SUB R5, R5, #32  // Subtrai 32 do valor de R5 (conversão para minúscula)
	b store_char  // Salta para a função "store_char"
	
_start:
	LDR R1, =input_len  // Carrega o valor de "input_len" em R1
	LDR R2, =input  // Carrega o endereço de "input" em R2
	LDR R3, =output  // Carrega o endereço de "output" em R3
	LDR R4, =output  // Carrega o endereço de "output" em R4

	ADD R3, R3, R1  // Adiciona o valor de R1 a R3
	SUB R3, R3, #1  // Subtrai 1 do valor de R3
	
	loop:
		CMP R3, R4  // Compara R3 com R4
		BLT end_loop  // Salta para o rótulo "end" se R3 for menor que R4
		
		LDRB R5, [R2]  // Carrega um byte do endereço em R2 para R5
		
		CMP R5, #'A'  // Compara R5 com o valor ASCII de 'A'
		BLT not_a_letter  // Salta para o rótulo "not_a_letter" se R5 for menor que 'A'
		CMP R5, #'Z'  // Compara R5 com o valor ASCII de 'Z'
		BLE capitalize  // Salta para o rótulo "capitalize" se R5 for menor ou igual a 'Z'

		CMP R5, #'a'  // Compara R5 com o valor ASCII de 'a'
		BLT not_a_letter  // Salta para o rótulo "not_a_letter" se R5 for menor que 'a'
		CMP R5, #'z'  // Compara R5 com o valor ASCII de 'z'
		BLE lower  // Salta para o rótulo "lower" se R5 for menor ou igual a 'z'
		
		store_char:
		
		STRB R5, [R3]  // Armazena o valor de R5 no endereço em R3

		ADD R2, R2, #1  // Adiciona 1 ao valor de R2
		SUB R3, R3, #1  // Subtrai 1 do valor de R3

		B loop  // Salta para o rótulo "loop"
	end_loop:

	b end  // Salta para o rótulo "end"

	not_a_letter:

	end:
		B end // A string invertida deve estar na variável output

	mov r0, #0  // Move o valor 0 para r0 (status de saída)
	mov r7, #1  // Move o valor 1 para r7 (número da chamada de sistema para exit)
	svc #0  // Realiza uma chamada de sistema para encerrar o programa
