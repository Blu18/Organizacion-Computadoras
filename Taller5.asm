section .data
  msg db 'Input: ', 'Imprimir input del teclado:  ' ; Mensaje que se mostrará antes de la entrada

section .bss
  input resb 15 ; Espacio para almacenar el carácter ingresado
  sum resb 15 ; Espacio para almacenar la suma

section .text
  global _start

_start:
  ; Mostrar mensaje en consola
  mov eax, 4
  mov ebx, 1
  mov ecx, msg ; dirección del mensaje
  mov edx, 36 ; longitud del mensaje
  int 0x80

  ; Leer un carácter desde el teclado
  
  mov eax, 3
  mov ebx, 0
  mov ecx, input ; dirección para almacenar la entrada
  mov edx, 14 ; leer 14 bytes (14 carácteres)
  int 0x80
  
  ; Mostrar el carácter ingresado
  mov eax, 4 ; syscall número 4 es write (sys_write)
  mov ebx, 1 ; descriptor de archivo 1 es stdout
  mov ecx, input ; dirección del carácter
  mov edx, 14 ; longitud del carácter
  int 0x80 ; llamada al sistema
  
  ; Calcular la suma de los caracteres
  mov al, [input]
  add al, [input]
  mov [sum], al ; almacenar la suma en la variable sum
  
  ; Mostrar la suma
  mov eax, 4
  
  mov ebx, 1
  mov ecx, sum ; dirección de la suma
  mov edx, 1 ; longitud de la suma
  int 0x80
  
  ; Terminar el programa
  mov eax, 1
  xor ebx, ebx ; código de salida 0
  int 0x80