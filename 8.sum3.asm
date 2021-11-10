; ----------------------------------------------------------------------------------------
; Writes "Hola, mundo" to the console using a C library. Runs on Linux.
;
;     nasm -felf64 8.sum3.asm && gcc 8.sum3.o && ./a.out
; ----------------------------------------------------------------------------------------

          global    main
          extern    printf
          extern    scanf
          section   .data

message:
          db        "tomá: %d",0x0A, 0        ; Note strings must be terminated with 0 in C, 10 is newline
scan_message:
          db        "%d", 0        ; Note strings must be terminated with 0 in C, 10 is newline
fgets_buffer:
          db        "12345678", 0        ; Note strings must be terminated with 0 in C, 10 is newline
          section   .text
main:
        push      rbx                   ; alinear ESP
        mov ebx, 0
loop_check:   
        cmp ebx, 1000
        jge end
        call      readit
        add ebx, eax
        jmp loop_check
end:    mov eax, ebx
        call    showit
        pop rbx
        ret
; shows eax
showit:
        push rbx                        ; alinear ESP
        mov  rbp, rsp
        lea       rdi, [rel message]            ; First integer (or pointer) argument in rdi
        mov       esi, eax                    ; ABI fig 3.36: vector argument
        mov       eax, 1                    ; ABI  fig 3.4: Register Usage
        call      printf WRT ..plt          ; puts(message)
        pop rbx
        ret 

; scans number to eax
readit:
        push rbx                        ; alinear ESP
        mov  rbp, rsp
        lea       rdi, [rel scan_message]            ; First integer (or pointer) argument in rdi
        lea       rsi, [rel fgets_buffer]             ; ABI fig 3.36: vector argument
        mov       eax, 0                    ; ABI  fig 3.4: Register Usage
        call      scanf WRT ..plt          ; puts(message)

        mov       eax, [rel fgets_buffer]            ; First integer (or pointer) argument in rdi
        pop rbx                        ; alinear ESP
        ret
