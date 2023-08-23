bits 16

section .data
    gdt_pointer:
        dw gdt_end - gdt_start - 1 ; GDT length
        dd gdt_start              ; GDT address

    gdt_start:
        dd 0x0, 0x0              ; Null Descriptor
        dw 0xFFFF, 0x0000, 0x9A00, 0x00CF ; Code Segment Descriptor
        dw 0xFFFF, 0x0000, 0x9200, 0x00CF ; Data Segment Descriptor
    gdt_end:

%define CODE_SEG 0x08
%define DATA_SEG 0x10

section .text

loadOS:
    cli                         ; Disable interrupts
    lgdt [gdt_pointer]          ; Load GDT
    mov eax, cr0                ; Load control register 0 into EAX
    or eax, 0x1                 ; Set PE bit to enable protected mode
    mov cr0, eax                ; Move the new value into CR0
    jmp dword CODE_SEG:protected_mode_transition ; Far jump to set CS

protected_mode_transition:
    ; Set up the data segments now that CS has been changed
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

bits 32
protected_mode_start:
    call print_protected_mode
    ret

print_protected_mode:
    ; call os - update later
    ret
