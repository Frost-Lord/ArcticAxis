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

    ; Allocating RAM
    mov si, ram_message
    call puts
    mov si, done_message
    call puts
    call new_line

    ; Initializing CPU
    mov si, cpu_message
    call puts
    mov si, done_message
    call puts
    call new_line

    ; Loading Disk Drivers
    mov si, disk_message
    call puts
    mov si, done_message
    call puts
    call new_line

    ret

print_message:
    push edx            ; Save the address of the message
    push ecx            ; Save the length of the message
    pop edx             ; Restore the length
    pop ecx             ; Restore the address
    mov eax, 4          ; syscall: write
    mov ebx, 1          ; file descriptor: stdout
    int 0x80            ; call kernel
    ret

new_line:
    mov si, newline
    call puts
    ret