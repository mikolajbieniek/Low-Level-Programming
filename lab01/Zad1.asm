; Program w NASM dla systemu Linux x86-64
; Kompilacja: nasm -felf64 Zad1.asm -o build/Zad1.o
; Linkowanie: ld build/Zad1.o -o build/Zad1
; Uruchomienie: ./build/Zad1
; Wszystko w jednej komendzie:
; nasm -felf64 Zad1.asm -o build/Zad1.o && ld build/Zad1.o -o build/Zad1 && ./build/Zad1
section .bss
    imie resb 100       

section .text           
global _start

_start:               
  mov     rax, 1                         
  mov     rdi, 1          
  mov     rsi, pytanie      
  mov     rdx, dlugosc_pytanie
  syscall                 

  mov rax, 0 
  mov rdi, 0
  mov rsi, imie
  mov rdx, 100
  syscall 

  mov r12, rax 
  sub r12, 1
  mov rax, 1
  mov rdi, 1 
  mov rsi, witanie
  mov rdx, dlugosc_witanie
  syscall

  mov rax, 1
  mov rdi, 1
  mov rsi, imie
  mov rdx, r12
  syscall

  mov rax, 1
  mov rdi, 1
  mov rsi, wykrzyknik
  mov rdx, dlugosc_wykrzyknik
  syscall

  mov     rax, 60            
  mov     rdi, 0          
  syscall                

section .data                  
  pytanie db "Jak masz na imię? "
  dlugosc_pytanie equ $ - pytanie  

  witanie db "Witaj "
  dlugosc_witanie equ $ - witanie

  wykrzyknik db "!"
  dlugosc_wykrzyknik equ $ - wykrzyknik
  