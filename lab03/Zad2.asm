; Program w NASM dla systemu Linux x86-64
; Wykorzystuje biblioteke prowadzacego asm64_io
;
; Kompilacja biblioteki: nasm -f elf64 ../asm64_io/asm64_io.asm -o build/asm64_io.o
; Kompilacja programu:  nasm -f elf64 -I ../asm64_io/ Zad2.asm -o build/Zad2.o
; Linkowanie:           gcc -no-pie build/Zad2.o build/asm64_io.o -o build/Zad2
; Uruchomienie:         ./build/Zad2
;
; Wszystko w jednej komendzie:
; nasm -f elf64 ../asm64_io/asm64_io.asm -o build/asm64_io.o && nasm -f elf64 -I ../asm64_io/ Zad2.asm -o build/Zad2.o && gcc -no-pie build/Zad2.o build/asm64_io.o -o build/Zad2 && ./build/Zad2

%include "asm64_io.inc"

section .data
  tab1 dd 4, -5, 91, 44, 104, 4
  tab2 dd -1, -2, -3, -5
section .text

global MAIN 

find_max:
    mov ecx, [rsp + 8] 
    mov r8, [rsp + 16] 
    
    dec ecx
    mov r10d, [r8 + rcx*4] 
    dec ecx

    .petla:
        cmp ecx, 0
        jl .koniec

        mov r9d, [r8 + rcx*4] 
        cmp r9d, r10d
        jle .dalej

        mov r10d, r9d

    .dalej:
        dec ecx
        jmp .petla    

    .koniec:
        mov eax, r10d
        shl rax, 32      
        sar rax, 32      
        ret 16

MAIN:
  push tab1 ; Odklada adres tablicy, nastepnie liczbe 5 i adres powrotu (kazdy zajmuje zawsze 8 bajtow w x86-64).
  push 5
  call find_max    ; wynik = 104
  call println_int ; funckja wypisuje wartosc 32 bitowa z EAX
  push tab2
  push 4
  call find_max    ; wynik = -1
  call println_int 
  ret
