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
    mov di, 364
    mov si, suc_message
    call puts_green
    call new_line

    ; Kernel
    mov si, kernel_message
    call puts
    mov di, 524
    mov si, suc_message
    call puts_green
    call new_line

    ; OS
    mov si, os_message
    call puts
    mov di, 684
    mov si, suc_message
    call puts_green
    call new_line
    call puts
    call new_line

    ; Allocating RAM
    mov si, ram_message
    call puts
    mov di, 1164
    mov si, done_message
    call delay
    call puts_blue
    call new_line

    ; Initializing CPU
    mov si, cpu_message
    call puts
    mov di, 1324
    mov si, done_message
    call delay
    call puts_blue
    call new_line

    ; Loading Disk Drivers
    mov si, disk_message
    call puts
    mov di, 1484
    mov si, done_message
    call delay
    call puts_blue

    call clearScreen
    call delay

    ret

delay:
    push cx
    push dx
    mov cx, 0x1388 ; 0x2710 = 1s | 0x4E20 = 2s
    .outer_loop:
        mov dx, 0xFFFF
        .inner_loop:
            nop
            nop
            dec dx
            jnz .inner_loop
        loop .outer_loop
    pop dx
    pop cx
    ret

puts_blue:
    pusha
    .repeat:
        lodsb
        or al, al
        jz .end_puts_blue
        mov ah, 0x09
        stosw
        jmp .repeat
    .end_puts_blue:
    popa
    ret

puts_green:
    pusha
    .repeat:
        lodsb
        or al, al
        jz .end_puts_green
        mov ah, 0010b
        stosw
        jmp .repeat
    .end_puts_green:
    popa
    ret

new_line:
    mov si, newline
    call puts
    ret