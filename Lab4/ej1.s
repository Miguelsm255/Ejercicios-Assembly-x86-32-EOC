.data
    lenBuf = 11

    msg1:       .ascii  "\nEscribe el nombre \n"
                lenMsg1 = . - msg1

    msg2:       .ascii  "\nEscribe la edad \n"
                lenMsg2 = . - msg2
    
    msg3:       .ascii  "\nDesea salir? [S/n] \n"
                lenMsg3 = . - msg3
    
    buf:        .zero   lenBuf
    descriptor: .int    0
    path:       .ascii  "personal.txt"

.text
    .global _start
    _start:
        movl $5,                %eax    # ABRIR / CREAR FICHERO
        movl $path,             %ebx    # EN ESTA RUTA
        movl $(01|02000|0100),  %ecx    # ASÍ
        movl $0666,             %edx    # CON ESTOS PERMISOS
        int  $0x80

        movl %eax, descriptor           # GUARDAR "ID" DEL FICHERO ABIERTO

    mensaje1:
        movl $4,                %eax    # ESCRIBIR
        movl $1,                %ebx    # EN LA PANTALLA
        movl $msg1,             %ecx    # ESTE MENSAJE
        movl $lenMsg1,          %edx    # CON ESTA LONGITUD
        int  $0x80


    leer1:
        movl $3,                %eax    # LEER
        movl $0,                %ebx    # DEL TECLADO
        movl $buf,              %ecx    # GUARDÁNDOLO AQUÍ
        movl $lenBuf,           %edx    # CON MÁXIMO ESTA LONGITUD
        int  $0x80

        movl %eax, %esi                 # GUARDAR EL NÚMERO DE BYTES LEÍDOS
    
    comprobarLF1:
        cmpb  $'\n',  buf-1(%esi)       # EL ÚLTIMO CARÁCTER ES UN LF?
        je  escribir1                   # SI ES ASÍ, ESCRIBIR
        jne purgar1                     # SI NO, PURGAR

    purgar1:
        movl $3,                %eax    # LEER
        movl $0,                %ebx    # DEL TECLADO
        movl $buf + lenBuf-1,   %ecx    # GUARDÁNDOLO AQUÍ
        movl $1,                %edx    # ESTE CARACTER
        int  $0x80

        jmp comprobarLF1                # VOLVER A COMPROBAR

    escribir1:

        movb $'\t', buf-1(%esi)         # SOBREESCRIBIR EL LF POR UN TABULADOR

        movl $4,                %eax    # ESCRIBIR
        movl descriptor,        %ebx    # EN EL FICHERO CON ESTE ID
        movl $buf,              %ecx    # LO QUE HAY AQUÍ
        movl %esi,              %edx    # CON MÁXIMO ESTA LONGITUD
        int  $0x80



    # ------------------MENSAJE 2------------------

    mensaje2:
        movl $4,                %eax    # ESCRIBIR
        movl $1,                %ebx    # EN LA PANTALLA
        movl $msg2,             %ecx    # ESTE MENSAJE
        movl $lenMsg2,          %edx    # CON ESTA LONGITUD
        int  $0x80


    leer2:
        movl $3,                %eax    # LEER
        movl $0,                %ebx    # DEL TECLADO
        movl $buf,              %ecx    # GUARDÁNDOLO AQUÍ
        movl $lenBuf,           %edx    # CON MÁXIMO ESTA LONGITUD
        int  $0x80

        movl %eax, %esi                 # GUARDAR EL NÚMERO DE BYTES LEÍDOS
    
    comprobarLF2:
        cmpb  $'\n',  buf-1(%esi)       # EL ÚLTIMO CARÁCTER ES UN LF?
        je  escribir2                   # SI ES ASÍ, ESCRIBIR
        jne purgar2                     # SI NO, PURGAR

    purgar2:
        movl $3,                %eax    # LEER
        movl $0,                %ebx    # DEL TECLADO
        movl $buf + lenBuf-1,   %ecx    # GUARDÁNDOLO AQUÍ
        movl $1,                %edx    # ESTE CARACTER
        int  $0x80

        jmp comprobarLF2                # VOLVER A COMPROBAR

    escribir2:

        movl $4,                %eax    # ESCRIBIR
        movl descriptor,        %ebx    # EN EL FICHERO CON ESTE ID
        movl $buf,              %ecx    # LO QUE HAY AQUÍ
        movl %esi,              %edx    # CON MÁXIMO ESTA LONGITUD
        int  $0x80


    # ------------------REPETIR PROCESO?------------------

    repetir:
        movl $4,                %eax    # ESCRIBIR
        movl $1,                %ebx    # EN LA PANTALLA
        movl $msg3,             %ecx    # ESTE MENSAJE
        movl $lenMsg3,          %edx    # CON ESTA LONGITUD
        int  $0x80

        movl $3,                %eax    # LEER
        movl $0,                %ebx    # DEL TECLADO
        movl $buf,              %ecx    # GUARDÁNDOLO AQUÍ
        movl $lenBuf,           %edx    # CON MÁXIMO ESTA LONGITUD
        int  $0x80

        cmpb $'S', buf                  # EL USUARIO QUIERE SALIR?
        je cerrar                       # SI ES ASÍ, CERRAR
        jne mensaje1                    # SI NO, VOLVER A PEDIR NOMBRE



    # ----------CERRAR FICHERO Y FIN DE EJECUCIÓN----------

    cerrar:
        movl $6,                %eax    # CERRAR FICHERO
        movl descriptor,        %ebx    # EN ESTA RUTA
        int  $0x80

    fin:
        movl $1,                %eax    # DEVOLUCIÓN DEL
        movl $0,                %ebx    # CONTROL AL SISTEMA
        int  $0x80
