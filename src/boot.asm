;#
;#   boot loader for fat
;#



org 0x7c00
bits 16

%define ENDL 0x0D, 0x0A

;#
;#   fat headers
;#
;# jump to main
jmp main
nop
;#  name of the file system/disk
db "tamir os"
;# number of bytes per sector
dw 512
;# number of clusters
db 1
;# number of reserved clusters fat12
dw 1
;# number of fat copies
db 2
;# Number of root directory entries
dw 224
;# Total number of sectors in the filesystem
dw 2880
;# Media descriptor type 
db f8
;# Number of sectors per FAT
dw 9
;# Number of sectors per track
dw 12
;# Number of heads (2, for a double-sided diskette)
dw 2
;# Number of hidden sectors (0) Hidden sectors are sectors preceding the partition. /* BIOS Parameter Block ends here */
dw 0


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