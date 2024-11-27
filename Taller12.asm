section .data
    msg1 db "Es una letra", 0
    msg2 db "No es una letra", 0
    msg3 db "Codigo ASCII: ", 0
    newline db 10, 0    

section .bss
    num1 resb 1    ; Reservar 1 byte para el carácter ingresado
    buffer resb 4

section .text
    global _start

%macro PRINT_STR 2
    mov eax, 4          ; Llamada al sistema para escribir
    mov ebx, 1          ; Salida estándar
    mov ecx, %1         ; Dirección del mensaje
    mov edx, %2         ; Longitud del mensaje
    int 0x80            ; Llamada al sistema
%endmacro

%macro PRINT_NUMBER 0
    ; Convierte un número en eax a caracteres ASCII y lo imprime
    mov ecx, buffer            ; Usamos el buffer para guardar el resultado
    mov ebx, 10                ; Divisor para obtener dígitos decimales

.next_digit:
    xor edx, edx               ; Limpia edx para la división
    div ebx                    ; Divide eax entre 10, cociente en eax, residuo en edx
    add dl, '0'                ; Convierte el dígito a ASCII
    dec ecx                    ; Mueve hacia atrás en el buffer
    mov [ecx], dl              ; Almacena el dígito en el buffer
    test eax, eax              ; Verifica si quedan dígitos
    jnz .next_digit            ; Si quedan dígitos, continúa

    ; Imprime el número
    mov eax, 4                 ; Syscall para write
    mov ebx, 1                 ; Salida estándar
    mov edx, buffer + 4        ; Dirección del final del buffer
    sub edx, ecx               ; Longitud real calculada
    mov ecx, ecx               ; Comienza en el primer dígito
    int 0x80
%endmacro

_start:
    ; Leer entrada del usuario
    mov eax, 3          ; Llamada al sistema para leer
    mov ebx, 0          ; Entrada estándar
    mov ecx, num1       ; Dirección para almacenar la entrada
    mov edx, 1          ; Leer 1 byte (1 carácter)
    int 0x80

    ; Verificar si el carácter es una letra
    mov al, byte [num1] ; Cargar el valor leído en `al`
    cmp al, 'A'         ; Comparar con 'A'
    jl no_letra         ; Si es menor, no es letra
    cmp al, 'Z'         ; Comparar con 'Z'
    jle es_letra        ; Si está en rango, es letra

    cmp al, 'a'         ; Comparar con 'a'
    jl no_letra         ; Si es menor, no es letra
    cmp al, 'z'         ; Comparar con 'z'
    jle es_letra        ; Si está en rango, es letra

  no_letra:
    PRINT_STR msg2, 15
    jmp print_ascii

  es_letra:
    PRINT_STR msg1, 12
      

  print_ascii:
    PRINT_STR newline, 1 ; Salto de linea
    ; Imprimir el código ASCII del carácter
    PRINT_STR msg3, 14
    movzx eax, byte [num1] ; Cargar el código ASCII en `eax`
    PRINT_NUMBER           ; Imprimir el valor en `eax`

exit_program:
    ; Salir del programa
    mov eax, 1          ; Llamada al sistema para salir
    xor ebx, ebx        ; Código de salida 0
    int 0x80
