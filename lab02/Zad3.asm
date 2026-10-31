; Program w NASM dla systemu Linux x86-64
; Wykorzystuje biblioteke prowadzacego asm64_io
;
; Kompilacja biblioteki: nasm -f elf64 ../asm64_io/asm64_io.asm -o build/asm64_io.o
; Kompilacja programu:  nasm -f elf64 -I ../asm64_io/ Zad3.asm -o build/Zad3.o
; Linkowanie:           gcc -no-pie build/Zad3.o build/asm64_io.o -o build/Zad3
; Uruchomienie:         ./build/Zad3
;
; Wszystko w jednej komendzie:
; nasm -f elf64 ../asm64_io/asm64_io.asm -o build/asm64_io.o && nasm -f elf64 -I ../asm64_io/ Zad3.asm -o build/Zad3.o && gcc -no-pie build/Zad3.o build/asm64_io.o -o build/Zad3 && ./build/Zad3

%include "asm64_io.inc"

segment .bss
    liczba    resd 1
    dzielnik  resd 1

section .text
global MAIN
MAIN:
    enter 0,0 
    call read_int ;EAX

    mov [liczba], eax
    mov dword [dzielnik], 2

.petla: 
    cmp dword [liczba], 1
    jle .koniec 

    xor rdx, rdx
    mov eax, [liczba]
    div dword [dzielnik] 

    cmp edx, 0
    jne .nastepny_dzielnik
    
    mov [liczba], eax

    mov eax, [dzielnik]
    call print_int 

    mov al, ' '
    call print_char 

    jmp .petla  

.nastepny_dzielnik:
    inc dword [dzielnik]
    jmp .petla

.koniec:
    call print_nl
    mov eax, 0 
    leave
    ret
