;#
;#   boot loader for fat
;#



org 0x7c00
bits 16

%define ENDL 0x0D, 0x0A

;#
;#   fat headers
;#




puts:
    push si
    push ax

.loop:
    lodsb
    or al,al
    jz .done

    mov bh,0
    mov ah, 0x0e
    int 0x10

    jmp .loop

.done:
    pop ax
    pop si
    ret


main:
    ;setup data segments
    xor ax,ax
    mov ds,ax
    mov es,ax
    mov fs,ax
    mov gs,ax
    mov ss,ax

    
    ;setup stack
    mov ss,ax
    mov sp,0x7c00 ;start of the program because stacks grows downwords

    mov si,msg_hello_world
    call puts


    hlt
.halt:
    jmp .halt



msg_hello_world: db 'Hello World!',ENDL , 0

times 510-($-$$) db 0
dw 0AA55h