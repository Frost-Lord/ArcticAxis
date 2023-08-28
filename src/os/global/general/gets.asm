section .text

gets:
    xor cx, cx
.loop:
    mov ah, 0x00
    int 0x16
    mov ah, 0x0E
    int 0x10

    mov bx, di
    add bx, cx
    mov [bx], al

    inc cx
    cmp al, 0x0D ; Enter key
    jz .done
    jmp .loop
.done:
    mov bx, di
    add bx, cx
    dec bx ; adjust for the Enter key
    mov byte [bx], 0 ; Null-terminate
    ret