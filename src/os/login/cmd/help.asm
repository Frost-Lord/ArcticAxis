section .data
    help_msg db 'Help CMD...', 0

section .text

HelpCmd:
    mov si, help_msg
    call puts
    ret