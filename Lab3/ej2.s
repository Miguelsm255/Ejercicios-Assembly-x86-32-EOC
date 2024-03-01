.data
    len = 21
    buf: .zero len
    maskMin = 00100000

.text
    .global _start
    _start:
        movl $3,     %eax
        movl $0,     %ebx
        movl $buf,   %ecx
        movl $len,   %edx
        int  $0x80

        movl %eax, %esi

        cmpb $'\n', buf-1(%esi)
        je fixed

    purgue:
        movl $3,     %eax
        movl $0,     %ebx
        movl $buf+len-1, %ecx
        movl $1,     %edx
        int  $0x80

        cmpb $'\n', buf+len-1
        jne purgue

    fixed:

        movl %esi, %ecx
        decl %ecx
        movl $0, %esi

        bucleMin:
            movb buf(%esi), %al
            orb maskMin, %al
            movb %al, buf(%esi)
            incl %esi
            loop bucleMin

        movl $4,     %eax
        movl $1,     %ebx
        movl $buf,   %ecx
        movl $len,   %edx
        int  $0x80

        cmpb $'S', buf
        jne _start

        movl $1,     %eax
        movl $0,     %ebx
        int  $0x80
