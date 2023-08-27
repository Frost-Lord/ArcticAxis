section .data
    clear_msg db 'Clear...', 0

section .text

ClearCmd:
    call clear_text
    call new_line
    ret