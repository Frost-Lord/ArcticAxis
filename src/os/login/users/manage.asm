section .data
    badlog_login_msg db 'Invalid username or password', 0x0A, 0x0D, 0
    success_login_msg db 'Now logged in as: ', 0x0A, 0x0D, 0

    u_string db "User >> ", 0
    p_string db "Pass >> ", 0

    u_filename db 'src/os/login/users/users.txt', 0

    username times 16 db 0
    password times 16 db 0
    info     times 64 db 0

section .bss
    fd_in resb 1

section .text

login:
    ; Get username input
    mov esi, u_string
    call puts
    mov edi, username
    call gets
    call new_line

    ; Get password input
    mov esi, p_string
    call puts
    mov edi, password
    call gets
    call new_line

    .readfile:
    mov eax, 5
    mov ebx, u_filename
    mov ecx, 0             ;for read only access
    mov edx, 0777          ;read, write and execute by all
    int  0x80
	
    mov  [fd_in], eax
    
    ;read from file
    mov eax, 3
    mov ebx, [fd_in]
    mov ecx, info
    mov edx, 26
    int 0x80
    ret

    .closefile:
    mov eax, 6
    mov ebx, [fd_in]
    int  0x80    
    ret

    mov eax, 4
    mov ebx, 1
    mov ecx, info
    mov edx, 26
    int 0x80

    ret