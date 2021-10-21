; ----------------------------------------------------------------------------------------
; Writes "Hola, mundo" to the console using a C library. Runs on Linux.
;
;     nasm -felf64 printf.asm && gcc printf.o && ./a.out
; ----------------------------------------------------------------------------------------

          global    main
          extern    printf

          section   .text
main:
        push      rbx                   ; alinear ESP
        mov       eax, 56
        call      showit
        mov       ax, 32
        call      showit
        mov       ax, 98
        call      showit
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
message:
          db        "holis %d",0x0A, 0        ; Note strings must be terminated with 0 in C, 10 is newline