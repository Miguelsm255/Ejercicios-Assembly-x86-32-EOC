/*

                                --------------ENUNCIADO-------------------


    1.  Modifique el código propuesto en el ejemplo anterior para que trate el caso de 
        desbordamiento de la siguiente manera: si la función int suma(int, int) devuelve -1 se emite
        un mensaje por pantalla anunciando que se ha producido un desbordamiento. Cambie los
        inmediatos de entrada para que se dé el caso y se emita el correspondiente mensaje.

*/


.data

    msg_desbordamiento: .ascii "Se ha producido un desbordamiento\n"
    len_msg_desbordamiento = . - msg_desbordamiento

    msg_positivo: .ascii "El número es positivo\n"
    len_msg_positivo = . - msg_positivo

    msg_negativo: .ascii "El número es negativo\n"
    len_msg_negativo = . - msg_negativo



.text
    .global _start
    _start:
        pushl %eax # salvo %eax puesto que se va a devolver un valor en él

        pushl $0x7fffffff # 2º argumento (tamaño 4 bytes)
        pushl $0x7fffffff # 1er argumento (tamaño 4 bytes)

        call suma # llamo a la subrutina suma
        movl %eax, %ebx # salvo el valor devuelto en %ebx

        addl $(2*4), %esp # limpio los argumentos

        popl %eax # recupero %eax

        movl %ebx, %esi

        cmpl $-1, %esi # comparo el valor devuelto con -1
        jne continua

        movl $4, %eax
        movl $1, %ebx
        movl $msg_desbordamiento, %ecx
        movl $len_msg_desbordamiento, %edx
        int  $0x80
        jmp fin

    continua:

        andl $0x80000000, %esi
        cmpl $0, %esi
        je positivo
        jne negativo

    positivo:
        movl $4, %eax
        movl $1, %ebx
        movl $msg_positivo, %ecx
        movl $len_msg_positivo, %edx
        int  $0x80
        jmp fin

    negativo:
        movl $4, %eax
        movl $1, %ebx
        movl $msg_negativo, %ecx
        movl $len_msg_negativo, %edx
        int  $0x80
        jmp fin

    fin:

        movl $0, %ebx
        movl $1, %eax
        int $0x80




#-------------------------------------------------------------------
# int suma(int, int)
# Devuelve en un int la suma de 2 argumentos de tipo int
# o -1 en caso de desbordamiento
#-------------------------------------------------------------------

    .type suma, @function # define el símbolo 'suma' como función (opcional)
    .global suma # declara 'suma' como global (opcional)
    suma:
        pushl %ebp # salvo el marco de pila del llamador
        movl %esp, %ebp # nuevo marco de pila

        pushl %ebx # salvo %ebx puesto que se usa en la subrutina

        movl 8(%ebp), %eax # copio el 1er argumento en %eax
        movl 12(%ebp), %ebx # copio el 2º argumento en %ebx
        addl %ebx, %eax # sumo ambos y lo salvo en %eax
        jno salir
        movl $-1, %eax # si hay desbordamiento cargo -1

        salir:
        popl %ebx # recupero %ebx

        movl %ebp, %esp # soslayo variables locales (aunque no hay)
        popl %ebp # recupero el marco de pila del llamador
        ret # devuelvo el control al llamador
        