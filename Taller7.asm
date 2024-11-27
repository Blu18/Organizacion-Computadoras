section .data
; Se definen variables
    num1 db 0 
    num2 db 1
    result db 0
    msg db 'Resultado: ', 0

section .bss
    buffer resb 4 ; Reserva 4 bytes en el buffer

section .text
    global _start

_start:

    mov al, 32 ; Se mueve el valor 32 al registro al
    add al, 32 ; Se suma el valor 32 al registro al
    mov [result], al ; Se almacena el valor de al en 'result'
; Convertir el resultado a ASCII
    
    mov [buffer], al ; Almacenar el carácter ASCII en el buffer


; Imprimir 'Resultado: '
    mov eax, 4 ; Carga una instrucción del syscall la cual es sys_write y se usa para escribir.
    mov ebx, 1 ; Indica al descriptor de archivo 1 que es stdout esto devuelve los datos del programa.
    mov ecx, msg ; Mueve la cadena que se encuentra en msg al registro ecx
    mov edx, 11 ; Longitud del mensaje
    int 0x80 

; Imprimir el caracter ASCII que se almaceno en el buffer anteriormente
    mov eax, 4 ; Carga una instrucción del syscall la cual es sys_write y se usa para escribir.
    mov ebx, 1 ; Indica al descriptor de archivo 1 que es stdout esto devuelve los datos del programa.
    mov ecx, buffer ; Mueve el caracter que se encuentra en el buffer al registro ecx
    mov edx, 1 ; Longitud del mensaje
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80


