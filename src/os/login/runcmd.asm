section .data
    promptCmd_msg db 'root@:ArcticAxis: ', 0
    LineFeed db 13, 10, 0 ; Carriage return and Line feed

    ; Commands
    help_cmd_name db 'help', 0
    clear_cmd_name db 'clear', 0
    reboot_cmd_name db 'reboot', 0

    ; Buffer
    input_buffer db 10 dup(0) ; Buffer size for the user input

section .text

%include "./src/os/login/loadcmds.asm"

promptCmd:
    mov si, promptCmd_msg
    call puts

    ; Get user input
    mov si, input_buffer
    call gets

; __________________________________________________________________________________________________________________________
; CMDS
; __________________________________________________________________________________________________________________________

    ; Clear
    mov si, input_buffer
    mov di, help_cmd_name
    call strcmp
    cmp ax, 0
    je .found_help

    ; Clear
    mov si, input_buffer
    mov di, clear_cmd_name
    call strcmp
    cmp ax, 0
    je .found_clear

    ; Reboot
    mov si, input_buffer
    mov di, reboot_cmd_name
    call strcmp
    cmp ax, 0
    je .found_reboot

    jmp .not_found

; __________________________________________________________________________________________________________________________
; Found commands
; __________________________________________________________________________________________________________________________

.found_help:
    call new_line
    call HelpCmd
    jmp .end_cmd

.found_clear:
    call new_line
    call ClearCmd
    jmp .end_cmd

.found_reboot:
    call new_line
    call RebootCmd
    jmp .end_cmd

; __________________________________________________________________________________________________________________________
; Not found commands
; __________________________________________________________________________________________________________________________

.end_cmd:
    mov si, LineFeed
    call puts
    call promptCmd
    ret

.not_found:
    mov si, LineFeed
    call puts
    call promptCmd
    ret

.done:
    ret

; __________________________________________________________________________________________________________________________
; Functions
; __________________________________________________________________________________________________________________________

; Custom strcmp function
strcmp:
    xor ax, ax
.loop:
    mov al, [si]
    mov ah, [di]
    cmp al, ah
    jne .done
    or al, al
    jz .set_equal
    inc si
    inc di
    jmp .loop
.set_equal:
    xor ax, ax
    ret
.done:
    sub al, ah
    ret
