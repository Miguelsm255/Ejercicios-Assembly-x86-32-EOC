/*

                                --------------ENUNCIADO-------------------


    2.  Escriba un programa con un bucle que solicite una cadena de caracteres de longitud máxima
        20 bytes, conteniendo espacios en blanco, números, etc. Si la cadena es la letra ’S’, entonces
        el programa finaliza, pero en caso contrario cambia la caja de los caracteres alfabéticos a
        minúsculas, escribe la nueva cadena en pantalla y vuelve a empezar.

*/



.data
    len = 21                                # 20 CARACTERES + 1 PARA EL SALTO DE LÍNEA
    buf: .zero len
    maskMin = 0x20

.text
    .global _start
    _start:
        movl $3,            %eax            # LEER
        movl $0,            %ebx            # DEL TECLADO
        movl $buf,          %ecx            # ESCRIBIENDOLO EN BUF
        movl $len,          %edx            # CON MÁXIMO ESTA LONGITUD
        int  $0x80

        movl %eax, %esi                     # GUARDAR NUMERO DE CARACTERES INTRODUCIDOS EN ESI

        cmpl $1, %esi                       # COMPROBAR SI NO SE HA INTRODUCIDO NINGÚN CARACTER
        je _start                           # SI NO SE HA INTRODUCIDO NINGÚN CARACTER, VOLVER A EMPEZAR
        
    comprobar:

        cmpb $'\n', buf-1(%esi)             # SI EL ÚLTIMO CARACTER ES UN SALTO DE LÍNEA
        je fixed                            # SALTAR PURGA. SI NO, PURGAR

    purgue:
        movl $3,            %eax            # LEER
        movl $0,            %ebx            # DEL TECLADO
        movl $buf+len-1,    %ecx            # ESCRIBIENDOLO EN LA ÚLTIMA POSICIÓN DE BUF
        movl $1,            %edx            # SOLO UN CARACTER
        int  $0x80

        jmp comprobar                       # SI NO LO ES, SEGUIR PURGANDO

    fixed:

        cmpb $'S', buf                      # COMPROBAR SI LA CADENA INTRODUCIDA ES "S"
        je fin                              # SI ES, TERMINAR EL PROGRAMA

        movl %esi,   %ecx                   # GUARDAR NUMERO DE CARACTERES INTRODUCIDOS EN ECX
        movl %esi,   %edi
        decl %ecx                           # DECREMENTARLO EN 1
        movl $0,     %esi                   # INICIALIZAR ESI A 0

        bucleMin:                           # BUCLE PARA CAMBIAR A MINÚSCULAS, RECORRIENDO CADA CARACTER

            movb buf(%esi),    %al          # GUARDAR EL CARACTER EN AL
            orb  $maskMin,     %al          # HACER OR CON LA MÁSCARA PARA CAMBIAR A MINÚSCULAS
            movb %al,          buf(%esi)    # GUARDAR EL CARACTER MODIFICADO EN SU POSICIÓN EN BUF
            incl %esi                       # INCREMENTAR ESI
            loop bucleMin                   # REPETIR EL BUCLE HASTA QUE ECX SEA 0

        movl $4,     %eax                   # ESCRIBIR
        movl $1,     %ebx                   # EN PANTALLA
        movl $buf,   %ecx                   # LA CADENA MODIFICADA
        movl %edi,   %edx                   # CON MÁXIMO ESTA LONGITUD
        int  $0x80

        jmp _start                          # VOLVER A EMPEZAR

    fin:
        movl $1,     %eax                   # DEVOLUCIÓN DEL CONTROL
        movl $0,     %ebx                   # AL SISTEMA OPERATIVO
        int  $0x80
