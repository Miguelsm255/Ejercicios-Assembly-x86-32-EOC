###################################
#    CONTADOR DE CARACTERES       #
#                                 #
# Cuenta el número de caracteres  #
#  introducidos por terminal al   #
#      ejecutar el programa.      #
# (inestable, sin comprobaciones) #
###################################

.data
    len  =   10
    buf:    .zero len
    argc:   .byte 0
    LF:     .byte 0x0A

.text
    .global _start
    _start:
        movl $3,        %eax            # LEER
        movl $0,        %ebx            # DEL TECLADO
        movl $buf,      %ecx            # ESCRIBIENDOLO EN BUF
        movl $len,      %edx            # CON MÁXIMO ESTA LONGITUD
        int  $0x80

        movl %eax,      %esi            # GUARDAR NUMERO DE CARACTERES INTRODUCIDOS EN ESI

        movl %esi,      %ecx            # GUARDAR NUMERO DE CARACTERES INTRODUCIDOS EN ECX
        decl %ecx                       # DECREMENTO EL NÚMERO PARA ELIMINAR EL LF
        orb  $0x30,     %cl             # CONVIERTO EL NUMERO DE ARGUMENTOS A ASCII
        movb %cl,       argc            # GUARDO EL NUMERO DE ARGUMENTOS EN ARGC


        movl $4,        %eax            # ESCRIBIR
        movl $1,        %ebx            # EN PANTALLA
        movl $argc,     %ecx            # EL NUMERO DE CARACTERES INTRODUCIDOS
        movl $1,        %edx            # CON MÁXIMO ESTA LONGITUD
        int  $0x80

        movl $4,        %eax            # ESCRIBIR
        movl $1,        %ebx            # EN PANTALLA
        movl $LF,       %ecx            # EL SALTO DE LINEA
        movl $1,        %edx            # CON LONGITUD 1
        int  $0x80


        movl $1,     %eax               # DEVOLUCIÓN DEL CONTROL
        movl $0,     %ebx               # AL SISTEMA OPERATIVO
        int  $0x80
