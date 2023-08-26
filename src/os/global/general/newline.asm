section  .data
    newline db 0x0D, 0x0A, 0

section .text

new_line:
    mov si, newline
    call puts
    ret