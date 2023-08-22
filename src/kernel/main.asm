org 0x0
bits 16

%define ENDL 0x0D, 0x0A
%define BOOT_LOGO "ArcticAxis"

start:
    ; clear the screen
    call clearScreen

    ; print message
    mov si, msg_kernal
    call puts

    ; Print boot logo BOOT_LOGO
    mov si, msg_LOGO
    call puts

.halt:
    cli
    hlt

;
; Clears the screen
;
clearScreen:
    mov ax, 0x0003
    int 0x10
    ret

;
; Prints a string to the screen
; Params:
;   - ds:si points to string
;
puts:
    ; save registers we will modify
    push si
    push ax
    push bx

.loop:
    lodsb               ; loads next character in al
    or al, al           ; verify if next character is null?
    jz .done

    mov ah, 0x0E        ; call bios interrupt
    mov bh, 0           ; set page number to 0
    int 0x10

    jmp .loop

.done:
    pop bx
    pop ax
    pop si    
    ret

msg_kernal: db 'KERNEL Loaded...', ENDL, 0
msg_LOGO: db BOOT_LOGO, ENDL, 0
