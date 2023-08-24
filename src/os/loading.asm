section .data

section .text

load_animation:
    mov di, 68 ; Top middle of the screen (38 * 2)

    ; Draw the animation
    mov si, message
top_draw:
    lodsb             ; Load next character into al
    or al, al         ; Check if it's null terminator
    jz animation_done ; If it is, end the animation
    mov ah, 0x09     ; Blue on black
    stosw             ; Store ax at es:di and increment di by 2
    jmp top_draw     ; Repeat

animation_done:
    ret

section .data

message db ' ArcticAxis ', 0
