section  .data
    newline db 0x0D, 0x0A, 0

section .text
    extern puts

load_os:
    mov ax, 0xB800 ; Video memory
    mov es, ax
    xor di, di ; Clear DI to start at the beginning of video memory

    call startup_routine

    ret

new_line:
    mov si, newline
    call puts
    ret

startup_routine:
    extern boot_animation
    extern displayload
    
    call boot_animation
    call display_nav
    call displayload

    ret

%include "./src/os/boot.asm"
%include "./src/os/display.asm"
%include "./src/os/nav/navigation.asm"