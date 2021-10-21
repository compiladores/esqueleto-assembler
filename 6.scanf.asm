; ----------------------------------------------------------------------------------------
; Writes "Hola, mundo" to the console using a C library. Runs on Linux.
;
;     nasm -felf64 printf.asm && gcc printf.o && ./a.out
; ----------------------------------------------------------------------------------------

          global    main
          extern    printf
          extern    scanf
          section   .data
fgets_buffer:
          db        "12345678", 0        ; Note strings must be terminated with 0 in C, 10 is newline
          section   .text
main:
        push      rbx                   ; alinear ESP
        mov       eax, 56
        call      readit
        ret
; shows eax
showit:
        push rbx                        ; alinear ESP
        mov  rbp, rsp
        mov       rdi, message            ; First integer (or pointer) argument in rdi
        mov       esi, eax                    ; ABI fig 3.36: vector argument
        mov       eax, 1                    ; ABI  fig 3.4: Register Usage
        call      printf WRT ..plt          ; puts(message)
        pop rbx
        ret 

; scans number to eax
readit:
        push rbx                        ; alinear ESP
        mov  rbp, rsp
        mov       rdi, message            ; First integer (or pointer) argument in rdi
        mov       esi, [ rel fgets_buffer ]             ; ABI fig 3.36: vector argument
        mov       eax, 1                    ; ABI  fig 3.4: Register Usage
        call      scanf WRT ..plt          ; puts(message)
        pop rbx
        push rbx                        ; alinear ESP
        mov eax, 2
;        mov eax, esi
        call showit
        ret 
message:
          db        "holis %d",0x0A, 0        ; Note strings must be terminated with 0 in C, 10 is newline
