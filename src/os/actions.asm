bits 16
section .text

; ... (Font data remains the same)

draw_char:
    ; Calculate pixel position in framebuffer
    lea edx, [font_bitmap + 8 * (al - 'A')] ; Get address of character in font
    mov ecx, 8                               ; 8 pixels tall
    .next_row:
        push ecx
        push edx                             ; Save address of character row
        push esi                             ; Save y position
        mov ecx, 8                           ; 8 pixels wide
        mov al, [edx]                        ; Load the current row of the character
        .next_pixel:
            shl al, 1
            jc .set_pixel
            add edi, 4
            loop .next_pixel
            pop esi                          ; Restore y position
            add esi, 4 * (720 - 8)           ; Move to next row
            inc edx                          ; Move to the next row of the character
            pop edx                          ; Restore address of character row
            pop ecx
            loop .next_row
            ret
        .set_pixel:
            ; Assuming framebuffer at 0xA0000 (replace with correct address)
            mov dword [0xA0000 + 4 * esi + edi], 0xFFFFFF ; White pixel
            add edi, 4                                        ; Move to next pixel
            loop .next_pixel
            pop esi                                      ; Restore y position
            add esi, 4 * (720 - 8)                       ; Move to next row
            inc edx                                      ; Move to the next row of the character
            pop edx                                      ; Restore address of character row
            pop ecx
            loop .next_row
            ret
