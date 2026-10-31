section .bss
    input_bufor  resb 16
    output_bufor resb 16
    
section .text
global read_int
global print_int

read_int:
    mov rax, 0
    mov rdi, 0
    mov rsi, input_bufor
    mov rdx, 16
    syscall

    mov r8, rax 
    xor rax, rax
    xor rcx, rcx
    xor r9, r9

    cmp byte [input_bufor], '-' 
    jne .petla
    mov r9, 1
    inc rcx

.petla:
    cmp rcx, r8
    jae .koniec

    xor edx, edx
    mov dl, [input_bufor + rcx]
    cmp dl, '0'
    jb .koniec 
    cmp dl, '9'
    ja .koniec 

    imul rax, 10
    sub dl, '0'
    add rax, rdx ; Nie możemy zrobić add rax, dl mimo że tak byłoby intuicyjnie
                 ; Wszystko dlatego, że add wymaga by rejstry miały ten sam rozmiar
    inc rcx
    jmp .petla

.koniec:
    cmp r9, 1
    jne .powrot
    neg rax

.powrot:
    ret

print_int:
    xor rcx, rcx
    xor r10, r10

    mov rbx, 10
    mov rsi, output_bufor + 16 ; Możemy za ostatni znak dać indeks, alternatywnie +15, 
                               ; zapis przed dec rsi, ale wtedy przed wypisaniem trzeba inc rsi
    cmp rax, 0
    jge .petla

    mov r10, 1
    neg rax

.petla:
    xor rdx, rdx
    div rbx 
    add dl, '0'   

    dec rsi
    mov [rsi], dl  
    inc rcx
    
    cmp rax, 0
    jne .petla

.koniec:
    cmp r10, 1
    jne .wypisz
    dec rsi
    mov byte [rsi], '-'
    inc rcx

.wypisz:
    mov rax, 1
    mov rdi, 1
    mov rdx, rcx
    syscall

.powrot:
    ret
