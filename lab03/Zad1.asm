; Program w NASM dla Linux x86-64
; Kompilacja biblioteki:
; nasm -f elf64 ../asm64_io/asm64_io.asm -o build/asm64_io.o
;
; Kompilacja programu:
; nasm -f elf64 -I ../asm64_io/ Zad1.asm -o build/Zad1.o
;
; Linkowanie:
; gcc -no-pie build/Zad1.o build/asm64_io.o -o build/Zad1
;
; Uruchomienie:
; ./build/Zad1
;
; Wszystko w jednej komendzie:
; nasm -f elf64 ../asm64_io/asm64_io.asm -o build/asm64_io.o && nasm -f elf64 -I ../asm64_io/ Zad1.asm -o build/Zad1.o && gcc -no-pie build/Zad1.o build/asm64_io.o -o build/Zad1 && ./build/Zad1
; Przyklad: INPUT: 4 -9 7 6 336 78 91 88 -111 0 3 OUTPUT: 5

%include "asm64_io.inc"
section .text
global MAIN

; r12 nasz dzielnik
; r13 liczba elementów na stosie
; r14 wynik
MAIN:
    enter 0,0
    xor r13, r13
    xor r14, r14

    .petla:
        call read_int
        cmp eax, 0
        je .koontynuj_dzielnik

        mov eax, eax ;wyzerowanie górnych 32 bitów
        push rax
        inc r13
        jmp .petla
    
    .koontynuj_dzielnik:
        call read_int
        cmp eax, 0
        je .koniec
        jge .zapis_dzielnika
        neg eax

    .zapis_dzielnika:
        mov r12d, eax
        
    .petla2:
        cmp r13, 0
        je .wypisz_wynik

        pop rax
        dec r13

        cmp eax, 0
        jge .dzielenie
        neg eax
   
    .dzielenie:
        xor rdx, rdx
        div r12
        cmp rdx, 0
        jne .petla2
        
        inc r14
        jmp .petla2

    .wypisz_wynik:
        mov eax, r14d
        call print_int

    .koniec:
        mov eax, 0 
        leave
        ret
