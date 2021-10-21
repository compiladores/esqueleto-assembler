; ----------------------------------------------------------------------------------------
; Writes "Hola, mundo" to the console using a C library. Runs on Linux.
;
;     nasm -felf64 printf.asm && gcc printf.o && ./a.out
; ----------------------------------------------------------------------------------------

          global    main
          extern    printf

          section   .text
main:
        push      rbx                     ; alinear stack a 16 bytes
        mov       rdi, message            ; First integer (or pointer) argument in rdi
        mov       eax, 1                    ; ABI  fig 3.4: Register Usage
        mov       esi, 42                    ; ABI fig 3.36: vector argument
        call      printf WRT ..plt          ; puts(message)
        pop       rbx
        ret                               ; Return from main back into C library wrapper
message:
          db        "holis %d", 0        ; Note strings must be terminated with 0 in C