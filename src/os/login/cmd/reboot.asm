section .data
    reboot_msg db 'Rebooting...', 0

section .text

RebootCmd:
    mov si, reboot_msg
    call puts
    cli
    mov al, 0xFE
    out 0x64, al
    hlt
    ret