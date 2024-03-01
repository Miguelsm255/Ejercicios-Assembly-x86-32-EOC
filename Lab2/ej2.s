.data
    len =  20
    buf:  .zero len
    buf2: .zero len
    cuenta = len
    maskMin = 00100000
    maskMax = 11011111

.text
    .global _start
    _start:
        movl $3,   %eax
        movl $0,   %ebx
        movl $buf, %ecx
        movl $len, %edx
        int  $0x80

        decl %eax

        movl %eax, %ecx
        movl $0, %esi
        bucleMin:
            movb buf(%esi), %al
            orb maskMin, %al
            movb %al, buf2(%esi)
            incl %esi
            loop bucleMin


        movl %eax, %ecx
        movl $0, %esi
        bucleMax:
            movb buf(%esi), %al
            orb maskMax, %al
            movb %al, buf2(%esi)
            incl %esi
            loop bucleMax



        movl $4,   %eax
        movl $1,   %ebx
        movl $buf2, %ecx
        movl $len, %edx
        

        int  $0x80

        movl $1,   %eax
        movl $0,   %ebx
        int  $0x80
