section .data
    promptCmd_msg db 'root@:ArcticAxis: ', 0

    ; Commands
    help_msg db 'help', 0
    run_msg db 'run', 0
    reboot_msg db 'reboot', 0

    input_buffer db 10 ; Buffer size for the user input

section .text

promptCmd:
    ; Display prompt
    mov si, promptCmd_msg
    call putss

    ; Get user input
    mov si, input_buffer
    call gets

    ; Check if input is 'help'
    mov si, input_buffer
    mov di, help_msg
    call strcmp
    cmp ax, 0
    je .found_help
    jmp .not_found

.found_help:
    ; Code for 'help' command
    mov si, help_msg
    call putss
    ret

.not_found:
    ; Command not found
    call promptCmd
    ret

; Custom putss function
putss:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    jmp putss
.done:
    ret

; Custom gets function
gets:
    xor cx, cx
.loop:
    mov ah, 0x00
    int 0x16
    mov ah, 0x0E
    int 0x10
    mov [si + cx], al
    inc cx
    cmp al, 0x0D ; Enter key
    jz .done
    jmp .loop
.done:
    mov byte [si + cx], 0 ; Null-terminate
    ret

; Custom strcmp function
strcmp:
    xor ax, ax
.loop:
    mov al, [si]
    mov ah, [di]
    cmp al, ah
    jne .done
    or al, al
    jz .done
    inc si
    inc di
    jmp .loop
.done:
    sub al, ah
    ret