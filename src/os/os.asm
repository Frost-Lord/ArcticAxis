section  .data
    newline db 0x0D, 0x0A, 0

section .text
    extern puts

load_os:
    mov ax, 0xB800 ; Video memory
    mov es, ax
    xor di, di ; Clear DI to start at the beginning of video memory

    %include "./src/os/boot.asm"  
    call boot_animation

    call clearScreen
    call delay

    %include "./src/os/display.asm"     
    call displayload 

    ret