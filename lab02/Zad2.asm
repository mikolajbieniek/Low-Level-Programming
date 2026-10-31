; Program w NASM dla systemu Linux x86-64
; Wykorzystuje wlasna biblioteke io.asm
;
; Kompilacja biblioteki: nasm -felf64 io.asm -o build/io.o
; Kompilacja programu:  nasm -felf64 Zad2.asm -o build/Zad2.o
; Linkowanie:           ld build/Zad2.o build/io.o -o build/Zad2
; Uruchomienie:         ./build/Zad2
;
; Wszystko w jednej komendzie:
; nasm -felf64 io.asm -o build/io.o && nasm -felf64 Zad2.asm -o build/Zad2.o && ld build/Zad2.o build/io.o -o build/Zad2 && ./build/Zad2

section .text
global _start

extern read_int
extern print_int

_start:
    call read_int 
    call print_int
    
    mov rax, 60
    mov rdi, 0
    syscall
