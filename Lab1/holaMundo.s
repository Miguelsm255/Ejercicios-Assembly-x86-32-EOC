.data
    msg1:
    .ascii  "\n¡Hola, mundo!\n"
    len1 = . - msg1

    msg2:
    .ascii "\nMe llamo Miguel\n"
    len2 = . - msg2

.text
.global _start
_start:
    movl $len1,%edx
    movl $msg1,%ecx
    movl $1,   %ebx
    movl $4,   %eax
    int  $0x80

    movl $len2,%edx
    movl $msg2,%ecx
    movl $1,   %ebx
    movl $4,   %eax
    int  $0x80

    movl $0,   %ebx
    movl $1,   %eax
    int  $0x80
