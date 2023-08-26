section .text

clear_all:
    mov ax, 0x0003
    int 0x10
    call display_nav
    ret


clear_text:
    mov ax, 0x0003
    int 0x10
    call display_nav
    ret