/*

                                --------------ENUNCIADO-------------------


    2.  Escriba un programa que lea una cadena desde el teclado de un m´aximo de 20 caracteres y
        luego la copie en el monitor.

*/


.data
    len = 20                    # LONGITUD MÁXIMA DE LA CADENA
    buf: .zero len              # BUFFER PARA ALMACENAR LA CADENA CON LONGITUD LEN

.text
    .global _start
    _start:
        movl $3,    %eax        # LEER
        movl $0,    %ebx        # DEL TECLADO
        movl $buf,  %ecx        # COPIANDOLO EN BUF
        movl $len,  %edx        # CON MÁXIMO LONGITUD LEN
        int  $0x80

        movl $4,    %eax        # ESCRIBIR
        movl $1,    %ebx        # EN PANTALLA
        movl $buf,  %ecx        # LO QUE HAY EN BUF
        movl $len,  %edx        # CON MÁXIMO LONGITUD LEN
        int  $0x80

        movl $1,   %eax         # DEVOLUCIÓN DEL CONTROL
        movl $0,   %ebx         # AL SISTEMA OPERATIVO
        int  $0x80
