section .data
    badlog_login_msg db 'Invalid username or password', 0
    success_login_msg db 'Now logged in as: ', 0
    user_not_found_msg db 'User not found', 0

    read_fail_msg db 'Read Failed', 0
    file_not_found_msg db 'File not found', 0  ; Fixed typo here
    read_success_msg db 'File Read Successfully', 0

    u_string db "User >> ", 0
    p_string db "Pass >> ", 0

    u_filename db 'users.txt', 0

    input_username db 'You entered username: ', 0
    input_password db 'You entered password: ', 0

    db_user db 'Database User: ', 0

    username times 16 db 0
    password times 16 db 0
    userdb times 256 db 0

    file_content times 256 db 0
    file_handle dw 0

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

    ; Log entered username
    mov esi, input_username
    call puts
    mov esi, username
    call puts
    call new_line
    
    ; Log entered password
    mov esi, input_password
    call puts
    mov esi, password
    call puts
    call new_line

    ; Read and log file content
    mov edi, u_filename
    call open_file
    test eax, eax
    jnz file_not_found

    mov edi, file_content
    mov ecx, 256
    call read_file
    test eax, eax
    jnz read_failed

    ; Save file_content to userdb
    mov esi, file_content
    mov edi, userdb
    mov ecx, 256
    rep movsb

    mov esi, read_success_msg
    call puts
    call new_line

    ; Log userdb content
    mov esi, userdb
    call puts
    call new_line

    ret

file_not_found:
    mov esi, file_not_found_msg
    call puts
    call new_line
    ret

read_failed:
    mov esi, read_fail_msg
    call puts
    call new_line
    ret

open_file:
    mov ah, 3Dh
    mov al, 0
    lea dx, [edi]
    int 21h
    jc .fail
    mov [file_handle], ax
    xor eax, eax
    ret

.fail:
    mov eax, 1
    ret

read_file:
    mov ah, 3Fh
    lea dx, [edi]
    mov cx, [ecx]
    mov bx, [file_handle]
    int 21h
    jc .fail
    xor eax, eax
    ret

.fail:
    mov eax, 1
    ret