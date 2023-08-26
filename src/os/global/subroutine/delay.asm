section .text

delay_500ms:
    push cx
    push dx
    mov cx, 0x1388
    .outer_loop:
        mov dx, 0xFFFF
        .inner_loop:
            nop
            nop
            dec dx
            jnz .inner_loop
        loop .outer_loop
    pop dx
    pop cx
    ret

delay_1s:
    push cx
    push dx
    mov cx, 0x2710
    .outer_loop:
        mov dx, 0xFFFF
        .inner_loop:
            nop
            nop
            dec dx
            jnz .inner_loop
        loop .outer_loop
    pop dx
    pop cx
    ret

delay_2s:
    push cx
    push dx
    mov cx, 0x4E20
    .outer_loop:
        mov dx, 0xFFFF
        .inner_loop:
            nop
            nop
            dec dx
            jnz .inner_loop
        loop .outer_loop
    pop dx
    pop cx
    ret