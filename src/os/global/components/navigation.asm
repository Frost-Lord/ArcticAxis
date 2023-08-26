section  .data
    Name db 'ArcticAxis', 0
    Line db '________________________________________________________________________________', 0

section .text
    extern puts

display_nav:
    mov di, 70
    mov si, Name
    call puts_grey

    call new_lineee

    mov si, Line
    call puts_grey

    ret

new_lineee:
    add di, 90
    ret

puts_grey:
    pusha
    .repeat:
        lodsb
        or al, al
        jz .end_puts_blue
        mov ah, 1001b
        stosw
        jmp .repeat
    .end_puts_blue:
    popa
    ret