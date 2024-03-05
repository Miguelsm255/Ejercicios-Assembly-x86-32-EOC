/*

                                --------------ENUNCIADO-------------------


    1.  Escriba un programa con un bucle en el que se le pida, en cada iteración, que introduzca
        una carácter desde el teclado. Si el carácter leído es ’S’, entonces el programa finaliza, pero
        para cualquier otro caso, escribe el caracter en la pantalla, avanza línea y vuelve a pedir
        otro carácter.

*/


.data
    len = 2
    buf: .zero len

.text
    .global _start
    _start:
        movl $3,   %eax                 # LEER
        movl $0,   %ebx                 # DEL TECLADO
        movl $buf, %ecx                 # GUARDÁNDOLO EN BUF
        movl $len, %edx                 # CON MÁXIMO ESTE TAMAÑO
        int  $0x80

    comprobar:
        cmpb $'\n', buf + len-1         # SI EL SEGUNDO CARACTER ES UN SALTO DE LÍNEA
        je seguir                       # SALTAR PURGA. SI NO, PURGAR

    purgar:
        movl $3,            %eax        # LEER
        movl $0,            %ebx        # DEL TECLADO
        movl $buf+ len-1,   %ecx        # GUARDÁNDOLO EN LA ÚLTIMA POSICIÓN DE BUF
        movl $1,            %edx        # CON TAMAÑO 1
        int  $0x80

        jmp comprobar                   # VOLVER A COMPROBAR

    seguir:
        movl $4,   %eax                 # ESCRIBIR 
        movl $1,   %ebx                 # EN LA PANTALLA
        movl $buf, %ecx                 # EL CONTENIDO DE BUF
        movl $len, %edx                 # CON MÁXIMO ESTE TAMAÑO
        int  $0x80

        cmpb $'S', buf                  # COMPROBAR SI EL PRIMER CARACTER ES UNA S
        jne _start                      # SI NO, VOLVER A PEDIR UN CARACTER


        movl $1,   %eax                 # DEVOLUCIÓN DEL 
        movl $0,   %ebx                 # CONTROL AL SISTEMA
        int  $0x80
