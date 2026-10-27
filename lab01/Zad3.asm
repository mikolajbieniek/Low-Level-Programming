; Program w NASM dla systemu Linux x86-64
; Kompilacja: nasm -felf64 Zad3.asm -o build/Zad3.o
; Linkowanie: ld build/Zad3.o -o build/Zad3
; Uruchomienie: ./build/Zad3
; Wszystko w jednej komendzie:
; nasm -felf64 Zad3.asm -o build/Zad3.o && ld build/Zad3.o -o build/Zad3 && ./build/Zad3

section .text
global _start:

_start:  
  mov rax, 2
  mov rdi, plik
  mov rsi, 1o | 100o | 2000o 
  mov rdx, 200o | 400o 
  syscall

  mov r12, rax
  mov rax, 1
  mov rdi, r12
  mov rsi, tekst
  mov rdx, dl_tekst
  syscall

  mov rax, 3
  mov rdi, r12
  syscall 

  mov rax, 60            
  mov rdi, 0          
  syscall         

section .data
    plik db "dane.txt", 0
    tekst db "Jan Kowalski", 0ah
    dl_tekst equ $ - tekst
