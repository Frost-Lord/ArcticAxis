org 0x0
bits 16

%define ENDL 0x0D, 0x0A
%define BOOT_LOGO "ArcticAxis"

; ______________________________________________________________________________________________________________________
;                                                    start
; ______________________________________________________________________________________________________________________

start:

    mov si, msg_kernal
    call puts

    mov si, msg_LOGO
    call puts

    call clearScreen

    ; Load the OS
    %include "./src/kernel/loadOS.asm"
    call loadOS

.halt:
    cli
    hlt

; Clears the screen
clearScreen:
    mov ax, 0x0003
    int 0x10
    ret

puts:
    ; save registers
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