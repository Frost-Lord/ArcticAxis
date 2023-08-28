section .data
    help_msg db '   [General]', 0
    cmd1 db '   help      Display available commands', 0,
    cmd2 db '   reboot    Reboot the system', 0,
    cmd3 db '   clear     Clear the screen', 0,
    cmd4 db '   ls        List files in the current directory', 0,
    cmd5 db '   dir       Alias for "ls"', 0,
    cmd6 db '   cat       Display the contents of a file', 0

section .text

HelpCmd:
    mov si, help_msg
    call puts
    call new_line
    
    mov si, cmd1
    call puts
    call new_line
    
    mov si, cmd2
    call puts
    call new_line
    
    mov si, cmd3
    call puts
    call new_line
    
    mov si, cmd4
    call puts
    call new_line
    
    mov si, cmd5
    call puts
    call new_line
    
    mov si, cmd6
    call puts
    
    ret
