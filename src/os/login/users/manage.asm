section .data
    badlog_login_msg db 'Invalid username or password', 0x0A, 0x0D, 0
    success_login_msg db 'Now logged in as: ', 0x0A, 0x0D, 0
    read_fail_msg db 'Read Failed', 0x0A, 0x0D, 0
    read_success_msg db 'File Read Successfully', 0x0A, 0x0D, 0
    user_not_found_msg db 'User not found', 0x0A, 0x0D, 0

    u_string db "User >> ", 0
    p_string db "Pass >> ", 0

    u_filename db './src/os/login/users/users.txt', 0

    username times 16 db 0
    password times 16 db 0

section .bss
    fd_out resb 1
    fd_in  resb 1
    info resb  256

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

   ; Open the file for reading
   mov eax, 5
   mov ebx, u_filename
   mov ecx, 0             ; For read-only access
   mov edx, 0777          ; Read, write and execute by all
   int  0x80

   ; Check if file opened successfully
   test eax, eax
   js .ReadFailed
   mov  [fd_in], eax

   ; Read from file
   mov eax, 3
   mov ebx, [fd_in]
   mov ecx, info
   mov edx, 256  ; Updated buffer size
   int 0x80

   ; Check if read was successful
   test eax, eax
   js .ReadFailed
   jmp .ReadSuccess

.ReadFailed:
    mov esi, read_fail_msg
    call puts
    jmp .Exit

.ReadSuccess:
    mov esi, read_success_msg
    call puts

    ; Here you would call a function to compare the username and password in the 'info' buffer.
    ; For example:
    call compare_user_pass

    ; Close the file
    mov eax, 6
    mov ebx, [fd_in]
    int  0x80

.Exit:       
    mov eax, 1             ; System call number (sys_exit)
    int 0x80               ; Call kernel

    ret

; The compare_user_pass subroutine
compare_user_pass:
    mov esi, info
    mov edi, username
    mov ebx, password

.loop_user:
    ; Compare username
    xor ecx, ecx
.loop_username:
    mov al, [esi]
    cmp al, '@'
    je .check_pass
    cmp al, 0
    je .user_not_found

    cmp [edi + ecx], al
    jne .next_user

    inc ecx
    inc esi
    jmp .loop_username

.check_pass:
    inc esi ; skip '@'
    xor ecx, ecx
.loop_password:
    mov al, [esi]
    cmp al, ':'
    je .success
    cmp al, 0
    je .user_not_found

    cmp [ebx + ecx], al
    jne .next_user

    inc ecx
    inc esi
    jmp .loop_password

.next_user:
    ; Skip to next user
.find_next_colon:
    mov al, [esi]
    cmp al, ':'
    je .next_entry
    cmp al, 0
    je .user_not_found
    inc esi
    jmp .find_next_colon

.next_entry:
    inc esi ; skip ':'
    jmp .loop_user

.user_not_found:
    mov esi, user_not_found_msg
    call puts
    ret

.success:
    mov esi, success_login_msg
    call puts
    ret