.data

    argc:   .byte 0
            .byte 0x0A

    LF:     .byte 0x0A

.text
    .global _start
    _start:

        popl %esi                   # SACA EL NUMERO DE ARGUMENTOS EN ESI

        movl %esi, %ecx             # GUARDO EL NUMERO DE ARGUMENTOS EN ECX
        orb $0x30, %cl              # CONVIERTO EL NUMERO DE ARGUMENTOS A ASCII
        movb %cl, argc              # GUARDO EL NUMERO DE ARGUMENTOS EN argc

        movl $4, %eax               # ESCRIBIR
        movl $1, %ebx               # EN PANTALLA
        movl $argc, %ecx            # EL NUMERO DE ARGUMENTOS
        movl $2, %edx               # CANTIDAD DE BYTES A ESCRIBIR
        int $0x80

        movl %esi, %ecx             # GUARDO EL NUMERO DE ARGUMENTOS EN ECX
        
        argumentos:

            popl %edi               # GUARDO EL ARGUMENTO EN EBX
            pushl %ecx              # GUARDO EL NUMERO DE ARGUMENTOS EN ECX
            movl $0, %esi         

            argumento:

                cmpb $0, (%edi, %esi)     # SI EL ARGUMENTO ES 0 (FIN DE ARGUMENTO)
                je escribir                # ESCRIBIR EL ARGUMENTO
                incl %esi                 
                jne argumento

                escribir:
                    movl $4, %eax               # ESCRIBIR
                    movl $1, %ebx               # EN PANTALLA
                    movl %edi, %ecx             # EL ARGUMENTO
                    movl %esi, %edx             # CANTIDAD DE BYTES A ESCRIBIR
                    int $0x80

                    movl $4, %eax               # ESCRIBIR
                    movl $1, %ebx               # EN PANTALLA
                    movl $LF, %ecx              # SALTO DE LINEA
                    movl $1, %edx               # EN 1 BYTE
                    int $0x80

            popl %ecx

        loop argumentos

    salir:
        movl $1,   %eax
        movl $0,   %ebx
        int  $0x80
