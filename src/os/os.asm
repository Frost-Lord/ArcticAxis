section .text
    extern puts
    extern gets

load_os:
    mov ax, 0xB800 ; Video memory
    mov es, ax
    xor di, di ; Start at the beginning of video memory

    call startup_routine

    ret

startup_routine:
    ;extern boot_animation
    ;extern displayload
    ;extern display_nav
    extern login
    
    call login
    ;call display_nav
    ;call boot_animation
    ;call displayload

    ret

%include "./src/os/global/functions.asm"
;%include "./src/os/boot/boot.asm"
;%include "./src/os/login/display.asm"
%include "./src/os/login/users/manage.asm"