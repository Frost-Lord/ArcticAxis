section .text

show_menu:
    mov si, menu_options
    call puts
    call get_input
    ret

get_input:
    xor ax, ax
    int 16h
    mov ah, 0x0E
    int 0x10


    ret

menu_options db ENDL, '1) Reboot', 0xD, 0xA, '2) Settings', 0xD, 0xA, '3) Build & Run', 0xD, 0xA, 'Choose an option:', 0
