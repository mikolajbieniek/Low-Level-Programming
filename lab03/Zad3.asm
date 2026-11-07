; Program w NASM dla systemu Linux x86-64
; Wykorzystuje wlasna biblioteke io.asm
;
; Kompilacja biblioteki: nasm -f elf64 io.asm -o build/io.o
; Kompilacja programu:  nasm -f elf64 Zad3.asm -o build/Zad3.o
; Linkowanie:           gcc -no-pie build/Zad3.o build/io.o -o build/Zad3
; Uruchomienie:         ./build/Zad3
;
; Wszystko w jednej komendzie:
; mkdir -p build && nasm -f elf64 io.asm -o build/io.o && nasm -f elf64 Zad3.asm -o build/Zad3.o && gcc -no-pie build/Zad3.o build/io.o -o build/Zad3 && ./build/Zad3

section .data
    tekst db "-345", 0

section .bss
    output_bufor resb 16

section .text
global main
extern print_int
extern print_nl

string_to_int:
    xor rax, rax
    xor rcx, rcx
    xor r9, r9

    cmp byte [rdi], '-'
    jne .petla
    mov r9, 1
    inc rcx

.petla:
    xor edx, edx
    mov dl, [rdi + rcx] 

    cmp dl, 0
    je .koniec

    cmp dl, '0'
    jb .koniec
    cmp dl, '9'
    ja .koniec

    imul rax, 10
    sub dl, '0'
    add rax, rdx ;add wymaga by rejstry miały ten sam rozmiar

    inc rcx
    jmp .petla

.koniec:
    cmp r9, 1
    jne .powrot
    neg rax

.powrot:
    ret

int_to_string:
    xor r10, r10
    mov r8, 10

    lea rsi, [rdi + 15]
    mov byte [rsi], 0 

    cmp rax, 0
    jge .petla

    mov r10, 1
    neg rax

.petla:
    xor rdx, rdx
    div r8
    add dl, '0'

    dec rsi
    mov [rsi], dl

    cmp rax, 0
    jne .petla

.koniec:
    cmp r10, 1
    jne .powrot

    dec rsi
    mov byte [rsi], '-'

.powrot:
    mov rax, rsi
    ret


main:
    ; tekst -> liczba
    mov rdi, tekst
    call string_to_int
    call print_int
    call print_nl

    ; liczba -> tekst
    mov rax, 123
    mov rdi, output_bufor ;adres poczatku bufora
    call int_to_string

    mov rsi, rax
    mov rdx, output_bufor + 15
    sub rdx, rax         
    mov rax, 1
    mov rdi, 1
    syscall

    mov eax, 0
    ret

; W przypadku konwersji tekstu na liczbę zwracamy wynik w rejestrze RAX, ponieważ liczba mieści się w 64 bitach. 
; Natomiast przy konwersji liczby na tekst przygotowujemy bufor w sekcji .bss
; Funkcja zapisuje tekst w tym buforze i zwraca adres jego początku w RAX. 
; Alternatywnie w obu przypadkach możemy zarezerwować miejsce na stosie i tam zapisać wynik.
