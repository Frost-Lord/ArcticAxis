section .data

section .text

load_animation:
    ; Calculate the center position
    mov ax, 0xB800 ; Video memory
    mov es, ax
    mov di, 3840 ; Center of the screen (40*12*2)

    ; Draw the top border
    mov cx, 14
top_border:
    mov word [es:di], 0xCD20
    add di, 2
    loop top_border

    ; Draw the side borders and text
    mov si, message
    add di, 56 ; Move to the next line
    mov word [es:di - 2], 0xBA20 ; Left border
side_and_text:
    lodsb
    or al, al
    jz bottom_border
    mov ah, 0x07 ; White on black
    stosw
    loop side_and_text

bottom_border:
    mov word [es:di], 0xBA20 ; Right border

    ; Draw the bottom border
    add di, 58 ; Move to the next line
    mov cx, 14
bottom_draw:
    mov word [es:di], 0xCD20
    add di, 2
    loop bottom_draw

    ret

section .data

message db ' ArcticAxis ', 0
