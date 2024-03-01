/*

                                --------------ENUNCIADO-------------------


    2.  Escriba un programa que lea una cadena desde el teclado de un m´aximo de 20 caracteres y
        luego la copie en el monitor.

*/


.data
    len = 20
    buf: .zero len

.text
    .global _start
    _start:
        movl $len, %edx
        movl $buf, %ecx
        movl $0,   %ebx
        movl $3,   %eax
        int  $0x80

        movl $len, %edx
        movl $buf, %ecx
        movl $1,   %ebx
        movl $4,   %eax
        int  $0x80

        movl $0,   %ebx
        movl $1,   %eax
        int  $0x80
