.data
    len = 2
    buf: .zero len

.text
    .global _start
    _start:
        movl $3,   %eax
        movl $0,   %ebx
        movl $buf, %ecx
        movl $len, %edx
        int  $0x80

        cmpb $'\n', buf + len-1
        je seguir

    purgar:
        movl $3,            %eax
        movl $0,            %ebx
        movl $buf+ len-1,   %ecx
        movl $1,            %edx
        int  $0x80

        cmpb $'\n', buf+1
        jne purgar

    seguir:
        movl $4,   %eax
        movl $1,   %ebx
        movl $buf, %ecx
        movl $len, %edx
        int  $0x80

        cmpb $'S', buf
        jne _start


        movl $1,   %eax
        movl $0,   %ebx
        int  $0x80