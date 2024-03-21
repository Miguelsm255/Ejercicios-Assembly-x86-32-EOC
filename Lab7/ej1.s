/*

                                --------------ENUNCIADO-------------------


    1.  Escriba la subrutina unsigned long int strtoul(char *) que devuelve el valor binario
        puro de una cadena de caracteres compuesta de cifras decimales, es decir, los caracteres ascii
        del ’0’ al ’9’; la cadena no puede contener espacios en blanco ni separadores, como carácter
        terminador tiene un NULL y se pasa por referencia; el valor devuelto es un tipo unsigned
        long int con el resultado de la codificación o 0xFFFFFFFF en caso de desbordamiento o de
        error causado por el uso de un carácter no numérico

*/


.data
    varerror: .long 0xFFFFFFFF
    len = 20
    buffer: .zero len

.text
.global _start
    _start:

        movl $3,        %eax            # LEER  
        movl $0,        %ebx            # DEL TECLADO
        movl $buffer,   %ecx            # GUARDANDOLO EN EL BUFFER
        movl $len,      %edx            # CON MÁXIMO LONGITUD LEN
        int  $0x80

        movl %eax, %esi                 # GUARDAMOS EL NÚMERO DE BYTES LEÍDOS

    comprobar:
        cmpb $'\n', buffer-1(%esi)      # COMPROBAMOS SI EL ÚLTIMO CARACTER ES UN SALTO DE LÍNEA
        je corregir                     # SI ES ASÍ, LO CAMBIAMOS POR UN 0

    purgar:
        movl $3, %eax                   # LEER
        movl $0, %ebx                   # DEL TECLADO
        movl $buffer+len-1, %ecx        # GUARDANDOLO EN LA ÚLTIMA POSICIÓN DEL BUFFER
        movl $1, %edx                   # CON MÁXIMO LONGITUD 1
        int  $0x80
        jmp  comprobar

    corregir:
        movl $0, buffer-1(%esi)         # CAMBIAMOS EL SALTO DE LÍNEA POR UN 0

        pushl $buffer                   # GUARDAR LA DIRECCIÓN DEL BUFFER EN LA PILA
        call  strtoul                   # LLAMAMOS A LA FUNCIÓN strtoul

        movl $1,    %eax                # DEVOLUCIÓN DEL CONTROL
        movl $0,    %ebx                # AL SISTEMA OPERATIVO
        int  $0x80


# strtoul: Convierte una cadena de caracteres en un número entero sin signo
.type strtoul, @function
strtoul:
    pushl %ebp                          # GUARDAR EL VALOR DEL REGISTRO BASE DE LA PILA
    movl  %esp,     %ebp                # ESTABLECER EL REGISTRO BASE DE LA PILA COMO CIMA DE LA PILA
    movl  8(%ebp),  %ecx                # GUARDAR LA DIRECCIÓN DE LA CADENA EN ECX
    movl $0,        %eax                # INICIALIZAR EL RESULTADO A 0

    bucle:
        movb (%ecx), %bl                # LEER EL CARACTER ACTUAL
        testb %bl,   %bl                # SI ES EL 0 DEL FINAL DE LA CADENA, SALIR DE LA SUBRUTINA
        jz hecho

        # Establecemos qué errores pueden ocurrir (si es menor que '0' o mayor que '9')
        subb $'0', %bl                  # SI ES MENOR QUE '0'
        jb error                        # ERROR
        cmpb $'9', %bl                  # SI ES MAYOR QUE '9'
        ja error                        # ERROR

        # Si hay overflow, error
        imull $10, %eax, %eax           # MULTIPLICAR EL RESULTADO ANTERIOR POR 10 (DESPLAZAR UNA POSICIÓN)
        jo error                        # SI HAY OVERFLOW, ERROR
        addl %ebx, %eax                 # SUMAR EL NUEVO DÍGITO
        jo error                        # SI HAY OVERFLOW, ERROR

        incl %ecx                       # AVANZAR AL SIGUIENTE CARACTER
        jmp bucle                       # REPETIR EL BUCLE

    error:
        movl varerror, %eax             # DEVOLVER EL VALOR DE ERROR

    hecho:
        movl %ebp, %esp                 # RESTAURAR EL REGISTRO BASE DE LA PILA
        popl %ebp                       # RESTAURAR EL VALOR DEL REGISTRO BASE DE LA PILA
        ret                             # DEVOLVER EL RESULTADO
