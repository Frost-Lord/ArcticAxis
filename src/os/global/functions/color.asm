section .text

puts_Black:
    pusha
    mov ah, 0000b
    call puts_color_generic
    popa
    ret

puts_Blue:
    pusha
    mov ah, 0001b
    call puts_color_generic
    popa
    ret

puts_Green:
    pusha
    mov ah, 0010b
    call puts_color_generic
    popa
    ret

puts_Cyan:
    pusha
    mov ah, 0011b
    call puts_color_generic
    popa
    ret

puts_Red:
    pusha
    mov ah, 0100b
    call puts_color_generic
    popa
    ret

puts_Magenta:
    pusha
    mov ah, 0101b
    call puts_color_generic
    popa
    ret

puts_Brown:
    pusha
    mov ah, 0110b
    call puts_color_generic
    popa
    ret

puts_White:
    pusha
    mov ah, 0111b
    call puts_color_generic
    popa
    ret

puts_Gray:
    pusha
    mov ah, 1000b
    call puts_color_generic
    popa
    ret

puts_LightBlue:
    pusha
    mov ah, 1001b
    call puts_color_generic
    popa
    ret

puts_LightGreen:
    pusha
    mov ah, 1010b
    call puts_color_generic
    popa
    ret

puts_LightCyan:
    pusha
    mov ah, 1011b
    call puts_color_generic
    popa
    ret

puts_LightRed:
    pusha
    mov ah, 1100b
    call puts_color_generic
    popa
    ret

puts_LightMagenta:
    pusha
    mov ah, 1101b
    call puts_color_generic
    popa
    ret

puts_Yellow:
    pusha
    mov ah, 1110b
    call puts_color_generic
    popa
    ret

puts_BrightWhite:
    pusha
    mov ah, 1111b
    call puts_color_generic
    popa
    ret

puts_color_generic:
    .repeat:
        lodsb
        or al, al
        jz .end_puts_color
        stosw
        jmp .repeat
    .end_puts_color:
    ret