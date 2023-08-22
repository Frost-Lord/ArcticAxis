org 0x7C00
bits 16


%define ENDL 0x0D, 0x0A
%define BOOT_LOGO "ArcticAxis"

; Constants for positioning text
%define ROW    12 ; Middle row of the screen

start:
    jmp main


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

    ; set the starting column
    mov cl, 6 ; Central column for the text

.loop:
    lodsb               ; loads next character in al
    or al, al           ; verify if next character is null?
    jz .done

    ; set cursor position
    mov ah, 0x02
    mov bh, 0
    mov dh, ROW
    mov dl, cl
    int 0x10

    ; print character
    mov ah, 0x0E
    mov bh, 0
    int 0x10

    ; increment column
    add cl, 2

    jmp .loop

.done:
    pop bx
    pop ax
    pop si    
    ret
    

main:
    ; setup data segments
    mov ax, 0           ; can't set ds/es directly
    mov ds, ax
    mov es, ax
    
    ; setup stack
    mov ss, ax
    mov sp, 0x7C00      ; stack grows downwards from where we are loaded in memory

    ; print boot logo
    mov si, msg_boot_logo
    call puts

    hlt

.halt
    jmp .halt


msg_boot_logo: db BOOT_LOGO, ENDL, 0


times 510-($-$$) db 0
dw 0AA55h
