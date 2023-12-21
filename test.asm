section .text
    global _start

_start:
    ; Set up the stack
    ; mov ax, 0x07C0
    ; add ax, 288
    ; mov ss, ax
    ; mov sp, 4096

    ; Call the timer function
    call Timer

    jmp 0h:0x7c00
    ; Function to get current time
Timer:
    mov ah, 2
    int 1Ah

    ; Extract seconds
    movzx dx, ch         ; DX = hours
    movzx ax, cl         ; AX = minutes
    imul dx, 60           ; Convert hours to minutes
    add ax, dx           ; AX = total minutes
    imul dx, 60           ; Convert minutes to seconds
    add ax, dx           ; AX = total seconds

    ; Display countdown
    mov cx, 5            ; Set countdown time to 5 seconds

CountdownLoop:
    ; mov ah, 03h
    ; mov bh, 0
    ; int 10h

    ; mov ah, 02h
    ; mov dl, 0
    ; int 10h

    ; Display current countdown value
    mov ah, 0Eh          ; Interrupt 10h, Function 0Eh - Teletype
    mov al, '0'
    add al, cl
    int 10h

    ; Newline
    mov ah, 0Eh
    mov al, 0Ah
    int 10h

    ; Decrement countdown value
    dec cx
    push cx

    ; Delay for 1 second
    mov al, 0
    mov ah, 86h
    mov cx, 000FH
    mov dx, 4240H
    int 15h

    pop cx
    ; Check if countdown is complete
    cmp cx, 0
    jg CountdownLoop

    ; Display "Timer Done!"
    mov ah, 0Eh
    mov al, 'T'
    int 10h
    mov al, 'i'
    int 10h
    mov al, 'm'
    int 10h
    mov al, 'e'
    int 10h
    mov al, 'r'
    int 10h
    mov al, ' '
    int 10h
    mov al, 'D'
    int 10h
    mov al, '+'
    int 10h
    mov al, 'n'
    int 10h
    mov al, 'e'
    int 10h
    mov al, '!'
    int 10h

    ret
