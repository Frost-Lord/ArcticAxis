section .data
    boot_message db 'Boot:', 0
    kernel_message db 'kernel:', 0
    os_message db 'OS:', 0

    ram_message db 'Allocating ram:', 0
    cpu_message db 'Initializing cpu:', 0
    disk_message db 'Loading disk drivers:', 0
    
    done_message db ' done', 0
    suc_message db ' Successful!', 0

section .text    

boot_animation:

    call new_line
    call new_line

    ; Boot
    mov si, boot_message
    call puts
    mov di, 364 ; +160 for next line, same position
    mov si, suc_message
    call puts_Green
    call new_line

    ; Kernel
    mov si, kernel_message
    call puts
    mov di, 524
    mov si, suc_message
    call puts_Green
    call new_line

    ; OS
    mov si, os_message
    call puts
    mov di, 684
    mov si, suc_message
    call puts_Green
    call new_line
    call puts
    call new_line

    ; Allocating RAM
    mov si, ram_message
    call puts
    mov di, 1164
    mov si, done_message
    call delay_500ms
    call puts_Blue
    call new_line

    ; Initializing CPU
    mov si, cpu_message
    call puts
    mov di, 1324
    mov si, done_message
    call delay_500ms
    call puts_Blue
    call new_line

    ; Loading Disk Drivers
    mov si, disk_message
    call puts
    mov di, 1484
    mov si, done_message
    call delay_500ms
    call puts_Blue

    xor di, di
    call clear_all
    call new_line
    call new_line

    ret