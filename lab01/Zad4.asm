
; Program w NASM dla systemu Linux x86-64
; Kompilacja: nasm -felf64 Zad4.asm -o build/Zad4.o
; Linkowanie: ld build/Zad4.o -o build/Zad4
; Uruchomienie: ./build/Zad4
; Wszystko w jednej komendzie:
; nasm -felf64 Zad4.asm -o build/Zad4.o && ld build/Zad4.o -o build/Zad4 && ./build/Zad4

section .text
global _start

_start:
  mov rax, 201 
  mov rdi, 0 
  syscall 
  add rax, 7200 
  
  mov rbx, 10
  div rbx 
  add dl, '0'
  mov [tekst + 13], dl   
  xor dl, dl 

  mov rbx, 6
  div rbx
  add dl, '0'
  mov [tekst + 12], dl
  xor dl, dl 

  mov rbx, 10
  div rbx
  add dl, '0'
  mov [tekst + 10], dl
  xor dl, dl 

  mov rbx, 6
  div rbx
  add dl, '0'
  mov [tekst + 9], dl
  xor dl, dl 

  mov rbx, 24
  div rbx
  mov rax, rdx 
  xor rdx, rdx
  mov rbx, 10
  div rbx
  add al, '0'
  add dl, '0'
  mov [tekst + 7], dl
  mov [tekst + 6], al

  mov rax, 1
  mov rdi, 1
  mov rsi, tekst
  mov rdx, dl_tekst
  syscall

  mov rax, 60
  mov rdi, 0
  syscall

section .data
    tekst db "Time: ##:##:##", 0ah
            ;"01234567890123"
    dl_tekst equ $ - tekst
    