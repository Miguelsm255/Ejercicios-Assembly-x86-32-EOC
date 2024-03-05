
.data
    len = 21
    buf: .zero len
    argc:   .byte 0
    LF:     .byte 0x0A

.text
    .global _start
    _start:
        movl $3,            %eax            # LEER
        movl $0,            %ebx            # DEL TECLADO
        movl $buf,          %ecx            # ESCRIBIENDOLO EN BUF
        movl $len,          %edx            # CON MÁXIMO ESTA LONGITUD
        int  $0x80

        movl %eax, %esi                     # GUARDAR NUMERO DE CARACTERES INTRODUCIDOS EN ESI

        movl %esi,      %ecx                # GUARDO EL NUMERO DE ARGUMENTOS EN ECX
        decl %ecx                           
        orb  $0x30,     %cl                 # CONVIERTO EL NUMERO DE ARGUMENTOS A ASCII
        movb %cl,       argc


        movl $4, %eax
        movl $1, %ebx
        movl $argc, %ecx
        movl $1, %edx
        int $0x80

        movl $4, %eax
        movl $1, %ebx
        movl $LF, %ecx
        movl $1, %edx
        int $0x80


        movl $1,     %eax                   # DEVOLUCIÓN DEL CONTROL
        movl $0,     %ebx                   # AL SISTEMA OPERATIVO
        int  $0x80
