; Program w NASM dla systemu Linux x86-64
; Kompilacja: nasm -felf64 Zad2.asm -o build/Zad2.o
; Linkowanie: ld build/Zad2.o -o build/Zad2
; Uruchomienie: ./build/Zad2
; Wszystko w jednej komendzie:
; nasm -felf64 Zad2.asm -o build/Zad2.o && ld build/Zad2.o -o build/Zad2 && ./build/Zad2

section .bss
    X resb 10
    Y resb 10
    wynik_bufor resb 2

section .text           
global _start

_start:               
  mov     rax, 1                         
  mov     rdi, 1          
  mov     rsi, tekst      
  mov     rdx, dl_calosc
  syscall                 

  mov rax, 0 
  mov rdi, 0
  mov rsi, X
  mov rdx, 10
  syscall 

  mov     rax, 1                         
  mov     rdi, 1          
  mov     rsi, pytanie_Y      
  mov     rdx, dl_pytanie_Y
  syscall                 

  mov rax, 0 
  mov rdi, 0
  mov rsi, Y
  mov rdx, 10
  syscall 


  mov al, [X]
  sub al, '0'
  mov bl, [Y]
  sub bl, '0'
  mul bl ; AX = AL * BL

  mov bl, 10 
  div bl 
  add al, '0'
  add ah, '0'

  mov [wynik_bufor], al
  mov [wynik_bufor + 1], ah


  mov rax, 1
  mov rdi, 1
  mov rsi, wynik
  mov rdx, dl_wynik
  syscall

  mov rax, 1
  mov rdi, 1
  mov rsi, wynik_bufor
  mov rdx, 2
  syscall

  mov     rax, 60            
  mov     rdi, 0          
  syscall                

section .data                  
  tekst db "Program do mnożenia dwóch liczb, proszę podaj ", 0ah
  pytanie_X  db "Pierwszą liczbę: "
  dl_calosc  equ $ - tekst

  pytanie_Y  db "Drugą liczbę: "
  dl_pytanie_Y equ $ - pytanie_Y 

  wynik db "Wynik mnożenia to: " 
  dl_wynik equ $ - wynik
  