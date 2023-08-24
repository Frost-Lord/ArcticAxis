section .data
    boot_message db 'Boot:', 0
    kernel_message db 'kernel:', 0
    os_message db 'OS', 0
    suc_message db ' Successful!', 0
    ram_message db 'Allocating ram:', 0
    done_message db ' done', 0
    cpu_message db 'Initializing cpu:', 0
    disk_message db 'Loading disk drivers:', 0
    newline db 0x0D, 0x0A, 0

section .text
    extern puts

boot_animation:
    mov ax, 0xB800 ; Video memory
    mov es, ax
    xor di, di ; Clear DI to start at the beginning of video memory

    ; Boot
    mov si, boot_message
    call puts
    mov si, suc_message
    call puts
    call new_line

    ; Kernel
    mov si, kernel_message
    call puts
    mov si, suc_message
    call puts
    call new_line

    ; OS
    mov si, os_message
    call puts
    mov si, suc_message
    call puts
    call new_line
    call puts
    call new_line

    ; Allocating RAM
    mov si, ram_message
    call puts
    mov si, done_message
    call puts_blue
    call new_line

    ; Initializing CPU
    mov si, cpu_message
    call puts
    mov si, done_message
    call puts_blue
    call new_line

    ; Loading Disk Drivers
    mov si, disk_message
    call puts
    mov si, done_message
    call puts_blue

    %include "./src/os/loading.asm"
    call load_animation

    ret

puts_blue:
    pusha
    .repeat:
        lodsb
        or al, al
        jz .end_puts_blue
        mov ah, 0x09 ; Attribute byte for blue foreground
        stosw       ; Store AX into ES:[DI] and increment DI by 2
        jmp .repeat
    .end_puts_blue:
    popa
    ret

new_line:
    mov si, newline
    call puts
    ret