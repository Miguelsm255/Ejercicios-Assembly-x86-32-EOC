/*

                                --------------ENUNCIADO-------------------


    1.  Realice un programa en ensamblador x86-32 que recupere los argumentos pasados en línea
        de comandos (9 como máximo en cada invocación) y los presente en la pantalla. Por ejemplo:


        ---------------------------------------------------
        $ ./arg_linea_comandos uno -l dos tres -o cuatro
        7
        ./arg_linea_comandos
        uno
        -l
        dos
        tres
        -o
        cuatro
        $
        ---------------------------------------------------

*/




.data

    argc:   .byte 0         # VARIABLE PARA GUARDAR EL NUMERO DE ARGUMENTOS

    LF:     .byte 0x0A      # SALTO DE LINEA

.text
    .global _start
    _start:

        popl %esi                           # SACA EL NUMERO DE ARGUMENTOS EN ESI

        movl %esi,      %ecx                # GUARDO EL NUMERO DE ARGUMENTOS EN ECX
        orb  $0x30,     %cl                 # CONVIERTO EL NUMERO DE ARGUMENTOS A ASCII
        movb %cl,       argc                # GUARDO EL NUMERO DE ARGUMENTOS EN argc

        movl $4,        %eax                # ESCRIBIR
        movl $1,        %ebx                # EN PANTALLA
        movl $argc,     %ecx                # EL NUMERO DE ARGUMENTOS
        movl $1,        %edx                # CANTIDAD DE BYTES A ESCRIBIR
        int  $0x80

        movl $4,        %eax                # ESCRIBIR
        movl $1,        %ebx                # EN PANTALLA
        movl $LF,       %ecx                # EL SALTO DE LINEA
        movl $1,        %edx                # CANTIDAD DE BYTES A ESCRIBIR
        int  $0x80

        movl %esi,      %ecx                # GUARDO EL NUMERO DE ARGUMENTOS EN ECX PARA EL BUCLE
        
        argumentos:

            popl  %edi                      # SACA EL ARGUMENTO EN EDI
            pushl %ecx                      # GUARDO TEMPORALMENTE EN CONTADOR DE BUCLE EN LA PILA
            movl  $0,   %esi         

            argumento:

                cmpb $0, (%edi, %esi)       # SI EL CARACTER DEL ARGUMENTO ES 0 (FIN DE ARGUMENTO)
                je   escribir               # ESCRIBIR EL CARACTER
                incl %esi                   # SI NO, AUMENTAR EL ÍNDICE
                jne  argumento              # Y REPETIR

                escribir:
                    movl $4,    %eax        # ESCRIBIR
                    movl $1,    %ebx        # EN PANTALLA
                    movl %edi,  %ecx        # EL ARGUMENTO
                    movl %esi,  %edx        # CANTIDAD DE BYTES A ESCRIBIR
                    int  $0x80

                    movl $4,    %eax        # ESCRIBIR
                    movl $1,    %ebx        # EN PANTALLA
                    movl $LF,   %ecx        # SALTO DE LINEA
                    movl $1,    %edx        # EN 1 BYTE
                    int $0x80

            popl %ecx                       # RECUPERO EL NUMERO DE ARGUMENTOS

            loop argumentos                 # REPETIR POR CADA ARGUMENTO

    salir:
        movl $1,    %eax                    # DEVOLUCIÓN DEL
        movl $0,    %ebx                    # CONTROLAL SISTEMA
        int  $0x80
