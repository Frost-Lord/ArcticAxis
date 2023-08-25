section .data
    version db 'ArcticAxis - Version 1.0.0', 0
    github db 'Github Repository: https://github.com/Frost-Lord/ArcticAxis', 0
    general db 'Type "help" for a list of commands', 0

    time db 'Time: 0', 0
    uptime db 'Uptime: ', 0
    current_user db 'User: Root', 0

section .text

displayload:
    mov si, version
    call puts
    call new_line

    mov si, github
    call puts
    call new_line

    mov si, general
    call puts
    call new_line
    call new_line

    mov si, time
    call puts
    call new_line

    mov si, uptime
    call puts
    call new_line

    mov si, current_user
    call puts
    call new_line
    
    ret
