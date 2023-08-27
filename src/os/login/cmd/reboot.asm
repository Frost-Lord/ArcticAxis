section .data
    reboot_msg db 'Rebooting...', 0

section .text

RebootCmd:
    mov si, reboot_msg
    call puts
    ret