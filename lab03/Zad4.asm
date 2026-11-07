; Program w NASM dla systemu Linux x86-64
; Szyfrowanie tekstu szyfrem GA-DE-RY-PO-LU-KI
;
; Kompilacja programu: nasm -f elf64 Zad4.asm -o build/Zad4.o
; Linkowanie:          gcc -no-pie build/Zad4.o -o build/Zad4
; Uruchomienie:        ./build/Zad4
;
; Wszystko w jednej komendzie:
; mkdir -p build && nasm -f elf64 Zad4.asm -o build/Zad4.o && gcc -no-pie build/Zad4.o -o build/Zad4 && ./build/Zad4

section .data
    szyfr db "ga","de","ry","po","lu","ki", " -", 0, 0
    tekst db "ala ma kota", 0 ; OUTPUT: gug-mg-iptg
    ; tekst db "123 gug-mg-iptg.", 0 ;OUTPUT: 123-ala ma kota.

section .text
global main
main:
    mov rdi, szyfr    
    mov rsi, tekst    
    call szyfruj

    mov rdx, rax 
    mov rax, 1
    mov rdi, 1
    mov rsi, tekst
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

szyfruj:
    xor rcx, rcx

    .petla:
        mov al, [rsi + rcx] 
        cmp al, 0
        je .koniec  
        xor r8, r8

        .petla2:
            cmp byte [rdi + r8], 0
            je .nastepny_znak

            mov r9b, [rdi + r8] 
            mov r10b, [rdi + r8 + 1]
            
            cmp al, r9b
            je .zamien_na_drugi

            cmp al, r10b
            je .zamien_na_pierwszy

            add r8, 2 
            jmp .petla2

            .zamien_na_pierwszy:
                mov [rsi + rcx], r9b
                jmp .nastepny_znak

            .zamien_na_drugi:
                mov [rsi + rcx], r10b
                jmp .nastepny_znak

        .nastepny_znak:
            inc rcx
            jmp .petla
    
    .koniec:
        mov rax, rcx    
        ret
