; Program w NASM dla systemu Linux x86-64
; Wykorzystuje wlasna biblioteke io.asm
;
; Kompilacja biblioteki: nasm -felf64 io.asm -o build/io.o
; Kompilacja programu:  nasm -felf64 Zad1.asm -o build/Zad1.o
; Linkowanie:           ld build/Zad1.o build/io.o -o build/Zad1
; Uruchomienie:         ./build/Zad1
;
; Wszystko w jednej komendzie:
; nasm -felf64 io.asm -o build/io.o && nasm -felf64 Zad1.asm -o build/Zad1.o && ld build/Zad1.o build/io.o -o build/Zad1 && ./build/Zad1

section .data       
  zapytanie db "Sprawdzenie czy twoja jest liczba pierwszą: "
  dlugosc_zapytanie equ $ - zapytanie

  jest_pierwsza db "Wpisana liczba jest liczba pierwszą."
  dlugosc_jest_pierwsza equ $ - jest_pierwsza  

  n_jest_pierwsza db "Wpisana liczbą nie jest liczbą pierwszą."
  dlugosc_n_jest_pierwsza equ $ - n_jest_pierwsza

section .text
global _start
extern read_int

_start:
  mov rax, 1
  mov rdi, 1
  mov rsi, zapytanie
  mov rdx, dlugosc_zapytanie
  syscall

  call read_int
  mov r9, rax

  cmp r9, 2      
  jb .npierwsza

  mov r10, 2 
  
  .petla:
    mov r11, r10
    imul r11, r10 ; r11 = dzielnik * dzielnik 
    cmp r11, r9 ; Zmienia nam flagi, między innymi flage ZF, 
                ; gdzie ustawi ZF = 1, gdy wynik odejmowania wynosi 0, czyli liczby są równe
    ja .pierwsza 
    
    mov rax, r9
    xor rdx, rdx
    div r10 

    cmp rdx, 0
    je .npierwsza 

    inc r10 
    jmp .petla
  
  .pierwsza:
    mov rax, 1
    mov rdi, 1
    mov rsi, jest_pierwsza
    mov rdx, dlugosc_jest_pierwsza
    syscall
    jmp .koniec

  .npierwsza:
    mov rax, 1
    mov rdi, 1
    mov rsi, n_jest_pierwsza
    mov rdx, dlugosc_n_jest_pierwsza
    syscall
    jmp .koniec

    .koniec:
    mov rax, 60
    mov rdi, 0
    syscall   
