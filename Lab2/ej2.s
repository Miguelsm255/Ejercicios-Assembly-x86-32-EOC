/*

                                --------------ENUNCIADO-------------------


    2.  Repita el programa anterior capturando la cadena, pero ahora escribirá 3 versiones diferentes
    de la misma: la primera contendrá todos los caracteres en minúsculas, la segunda todos en
    mayúsculas y la tercera conmutará las mayúsculas por minúsculas y viceversa.
    Se recomienda que la cadena de entrada no contenga ni caracteres numéricos ni espacios.
    También es conveniente añadir el carácter line feed (LF = 10 = 0xA) al final de cada nueva
    cadena.

*/


.data
    len     = 20
    buf:     .zero len
    buf2:    .zero len
    maskMin = 0x20
    maskMax = 0xDF
    LF:      .byte 0x0A

.text
    .global _start
    _start:
        movl $3,    %eax                # LEER
        movl $0,    %ebx                # DEL TECLADO
        movl $buf,  %ecx                # COPIÁNDOLO EN BUF
        movl $len,  %edx                # DE TAMAÑO LEN
        int  $0x80

        decl  %eax                      # QUITAR EL LF
        movl  %eax, %edi                # GUARDAR EL TAMAÑO DE LA CADENA EN EDI

    minusculas:

        movl  %edi, %ecx                # GUARDAR EL TAMAÑO DE LA CADENA EN ECX
        movl  $0,   %esi                # INICIALIZAR EL CONTADOR

        bucleMin:                       

            movb buf(%esi), %al         # COPIAR EL CARACTER A AL
            orb  $maskMin,  %al         # HACER OR CON LA MÁSCARA
            movb %al,       buf2(%esi)  # COPIAR EL RESULTADO EN BUF2
            incl %esi                   # INCREMENTAR EL CONTADOR
            loop bucleMin               # REPETIR HASTA QUE ECX SEA 0

        movl $4,    %eax                # ESCRIBIR
        movl $1,    %ebx                # EN PANTALLA
        movl $buf2, %ecx                # LA CADENA EN MINÚSCULAS
        movl %edi,  %edx                # DE TAMAÑO DEL BUF INTRODUCIDO
        int  $0x80

        movl $4,    %eax                # ESCRIBIR
        movl $1,    %ebx                # EN PANTALLA
        movl $LF,   %ecx                # EL CARÁCTER DE SALTO DE LÍNEA
        movl $1,    %edx                # DE TAMAÑO 1
        int  $0x80

    mayusculas:

        movl  %edi, %ecx                # GUARDAR EL TAMAÑO DE LA CADENA EN ECX
        movl  $0,   %esi                # INICIALIZAR EL CONTADOR

        bucleMax:

            movb buf(%esi), %al         # COPIAR EL CARACTER A AL
            andb $maskMax,  %al         # HACER AND CON LA MÁSCARA
            movb %al,       buf2(%esi)  # COPIAR EL RESULTADO EN BUF2
            incl %esi                   # INCREMENTAR EL CONTADOR
            loop bucleMax               # REPETIR HASTA QUE ECX SEA 0

        movl $4,    %eax                # ESCRIBIR
        movl $1,    %ebx                # EN PANTALLA
        movl $buf2, %ecx                # LA CADENA EN MAYÚSCULAS
        movl %edi,  %edx                # DE TAMAÑO DEL BUF INTRODUCIDO
        int  $0x80 

        movl $4,    %eax                # ESCRIBIR
        movl $1,    %ebx                # EN PANTALLA
        movl $LF,   %ecx                # EL CARÁCTER DE SALTO DE LÍNEA
        movl $1,    %edx                # DE TAMAÑO 1
        int  $0x80
    
    conmutado:

        movl  %edi, %ecx                # GUARDAR EL TAMAÑO DE LA CADENA EN ECX
        movl  $0,   %esi                # INICIALIZAR EL CONTADOR

        bucleCom:

            movb buf(%esi), %al         # COPIAR EL CARACTER A AL
            andb $maskMin,  %al         # HACER AND CON LA MÁSCARA PARA VER SI ES O NO MINÚSCULA
            cmpb $0,        %al         # SI AL ES 0, ES MAYÚSCULA
            je   esMinuscula            # SI ES MAYÚSCULA, SALTAR A ES MAYÚSCULA

            esMayuscula:
                movb buf(%esi), %al         # COPIAR EL CARACTER A AL
                andb  $maskMax, %al         # HACER OR CON LA MÁSCARA MAYÚSCULA
                movb %al,       buf2(%esi)  # COPIAR EL RESULTADO EN BUF2
                incl %esi                   # INCREMENTAR EL CONTADOR
                jmp comprobado

            esMinuscula:
                movb buf(%esi), %al         # COPIAR EL CARACTER A AL
                orb $maskMin,   %al         # HACER OR CON LA MÁSCARA MINÚSCULA
                movb %al,       buf2(%esi)  # COPIAR EL RESULTADO EN BUF2
                incl %esi                   # INCREMENTAR EL CONTADOR
                jmp comprobado
            
            comprobado:
                loop bucleCom               # REPETIR HASTA QUE ECX SEA 0

        movl $4,    %eax                # ESCRIBIR
        movl $1,    %ebx                # EN PANTALLA
        movl $buf2, %ecx                # LA CADENA CONMUTADA
        movl %edi,  %edx                # DE TAMAÑO DEL BUF INTRODUCIDO
        int  $0x80

        movl $4,    %eax                # ESCRIBIR
        movl $1,    %ebx                # EN PANTALLA
        movl $LF,   %ecx                # EL CARÁCTER DE SALTO DE LÍNEA
        movl $1,    %edx                # DE TAMAÑO 1
        int  $0x80

    
    fin:
        movl $1,   %eax                 # DEVOLUCIÓN DEL CONTROL
        movl $0,   %ebx                 # AL SISTEMA OPERATIVO
        int  $0x80
