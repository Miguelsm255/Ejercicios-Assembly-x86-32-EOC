.data
    len = 20
    buf: .zero len

.text
    .global _start
    _start:
        movl $len, %edx
        movl $buf, %ecx
        movl $0,   %ebx
        movl $3,   %eax
        int  $0x80

        movl $len, %edx
        movl $buf, %ecx
        movl $1,   %ebx
        movl $4,   %eax
        int  $0x80

        movl $0,   %ebx
        movl $1,   %eax
        int  $0x80
