.section .data
    message:
        .asciz "Hello, World!\n"
        message_len = .-message

.section .text
.global _start

_start:
    MOV r0, #1       
    LDR r1, =message 
    LDR r2, =message_len   
    MOV r7, #4       
    SVC 0          

exit:
    MOV r7, #1      
    MOV r0, #0      
    SVC 0           
