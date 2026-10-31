; Program w NASM dla systemu Linux x86-64
; Wykorzystuje biblioteke prowadzacego asm64_io
;
; Kompilacja biblioteki: nasm -f elf64 ../asm64_io/asm64_io.asm -o build/asm64_io.o
; Kompilacja programu:  nasm -f elf64 -I ../asm64_io/ Zad4.asm -o build/Zad4.o
; Linkowanie:           gcc -no-pie build/Zad4.o build/asm64_io.o -o build/Zad4
; Uruchomienie:         ./build/Zad4
;
; Wszystko w jednej komendzie:
; nasm -f elf64 ../asm64_io/asm64_io.asm -o build/asm64_io.o && nasm -f elf64 -I ../asm64_io/ Zad4.asm -o build/Zad4.o && gcc -no-pie build/Zad4.o build/asm64_io.o -o build/Zad4 && ./build/Zad4

%include "asm64_io.inc"

segment .data
    opis db "Program wyszukuje liczby z przedzialu [a, b],", 0ah
         db "ktore sa wzglednie pierwsze do liczby n.", 0ah, 0

    pytanie_n db "Podaj liczbe n: ", 0
    pytanie_a db "Podaj poczatek przedzialu a: ", 0
    pytanie_b db "Podaj koniec przedzialu b: ", 0

segment .bss
    n resd 1
    a resd 1
    b resd 1
    aktualna_liczba resd 1
    nwd_a resd 1
    nwd_b resd 1

section .text
global MAIN

MAIN:
    enter 0,0

    mov rax, opis
    call print_string

    mov rax, pytanie_n
    call print_string
    call read_int
    mov [n], eax

    mov rax, pytanie_a
    call print_string
    call read_int
    mov [a], eax

    mov rax, pytanie_b
    call print_string
    call read_int
    mov [b], eax
    
    mov eax, [a]
    mov [aktualna_liczba], eax 

.petla: ; Przechodzimy przez wszystkie liczby z przedzialu a, b
    mov eax, [aktualna_liczba]
    cmp eax, [b]
    jg .koniec ; koniec jeśli aktualna_liczba > b (bo koniec przedziału)

    mov eax, [n]
    cmp eax, 0
    jge .zapisz_nwd_a
    neg eax

.zapisz_nwd_a:
    mov [nwd_a], eax ; Pierwszy argument nwd_a = |n|
    mov eax, [aktualna_liczba] 
    cmp eax, 0
    jge .zapisz_nwd_b
    neg eax

.zapisz_nwd_b:
    mov [nwd_b], eax

;nwd_a = 10, nwd_b = 3, aktualna_liczba = 3 dla n = 10, a = 3, b = 7
.nwd: ; Tutaj obliczamy reszte z dzielenia, aktualizujemy nwd_a i nwd_b, aż nwd_b = 0
    cmp dword [nwd_b], 0
    je .sprawdz ; gdy nwd_b = 0, to albo wypisujemy i lecimy z nastepną, albo odrazu następna

    mov eax, [nwd_a]
    xor edx, edx
    div dword [nwd_b] ; eax = 3, edx = 1

    mov eax, [nwd_b]
    mov [nwd_a], eax   ; nwd_a = 3
    mov [nwd_b], edx   ; nwd_b = 1

    jmp .nwd

.sprawdz:
    cmp dword [nwd_a], 1
    jne .nastepna ; Jesli nwd_a != 1, pomijamy wypisywanie
                  ; Jesli nwd_a == 1, wypisujemy aktualna_liczba

    mov eax, [aktualna_liczba]
    call print_int
    mov al, ' '
    call print_char

.nastepna:
    ;Tutaj sprawdzamy czy aktualnie sprawdzam liczba, nie przekroczyła przedziału, liczby b
    mov eax, [aktualna_liczba]
    cmp eax, [b]
    jge .koniec

    inc dword [aktualna_liczba] 
    jmp .petla

.koniec:
    call print_nl
    mov eax, 0
    leave
    ret
