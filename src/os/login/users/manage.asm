section .data
    badlog_login_msg db 'Invalid username or password', 0
    success_login_msg db 'Now logged in as: ', 0
    user_not_found_msg db 'User not found', 0

    read_fail_msg db 'Read Failed', 0
    file_not_found_msg db 'File not found', 0
    read_success_msg db 'File Read Successfully', 0

    u_string db "User >> ", 0
    p_string db "Pass >> ", 0

    filename db 'users.txt', 0

    input_username db 'You entered username: ', 0
    input_password db 'You entered password: ', 0

    username times 16 db 0
    password times 16 db 0
    userdb times 256 db 0

    file_content times 40 db 0

section .bss
    fd resw 1
    buffer resb 256

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
    
       ; open the file
    mov ah, 3Dh       ; DOS function for opening a file
    mov al, 0         ; read mode
    lea dx, [filename]  ; pointer to filename
    int 21h           ; interrupt to invoke DOS function
    jc  exit          ; jump on error
    mov [fd], ax      ; save file descriptor

    ; read from file
    mov ah, 3Fh       ; DOS function for reading from file
    mov bx, [fd]      ; file handle
    lea dx, [buffer]  ; buffer to read into
    mov cx, 256       ; number of bytes to read
    int 21h           ; interrupt to invoke DOS function
    jc  exit          ; jump on error
    mov si, ax        ; save number of bytes read

    ; write to stdout
    mov ah, 40h       ; DOS function for writing to file
    mov bx, 1         ; file handle (stdout)
    lea dx, [buffer]  ; buffer to write from
    mov cx, si        ; number of bytes to write
    int 21h           ; interrupt to invoke DOS function

exit:
    ; close the file
    mov ah, 3Eh       ; DOS function for closing a file
    mov bx, [fd]      ; file handle
    int 21h           ; interrupt to invoke DOS function

    ; exit
    mov ah, 4Ch       ; DOS function for program exit
    xor al, al        ; exit code 0
    int 21h           ; interrupt to invoke DOS function

    ret