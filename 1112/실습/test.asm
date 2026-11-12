
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO :DWORD
GetStdHandle PROTO :DWORD
ReadConsoleA PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
WriteConsoleA PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD

includelib kernel32.lib

STD_INPUT_HANDLE EQU -10
STD_OUTPUT_HANDLE EQU -11

.data
    inputHandle DWORD ?
    outputHandle DWORD ?

    prompt BYTE "Enter 5 numbers: ", 0
    promptLen DWORD 18

    inputBuffer BYTE 100 DUP(0)
    charsRead DWORD ?

    outputBuffer BYTE 100 DUP(0)
    charsWritten DWORD ?

    numbers DWORD 5 DUP(0)
    total DWORD 0
    avg DWORD 0

.code
main PROC

    invoke GetStdHandle, STD_INPUT_HANDLE
    mov inputHandle, eax

    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov outputHandle, eax

    ; 입력 안내 출력
    invoke WriteConsoleA, outputHandle, ADDR prompt, promptLen, ADDR charsWritten, 0

    ; 숫자 입력
    invoke ReadConsoleA, inputHandle, ADDR inputBuffer, 100, ADDR charsRead, 0

    mov esi, OFFSET inputBuffer
    mov ecx, 5
    mov ebx, 0

READ_NUM:
    xor eax, eax

SKIP_SPACE:
    mov dl, [esi]
    cmp dl, ' '
    je NEXT_CHAR
    cmp dl, 13
    je NEXT_CHAR
    cmp dl, 10
    je NEXT_CHAR
    jmp GET_NUM

NEXT_CHAR:
    inc esi
    jmp SKIP_SPACE

GET_NUM:
    mov dl, [esi]
    cmp dl, '0'
    jb SAVE_NUM
    cmp dl, '9'
    ja SAVE_NUM

    imul eax, 10
    sub dl, '0'
    movzx edx, dl
    add eax, edx
    inc esi
    jmp GET_NUM

SAVE_NUM:
    add ebx, eax
    inc esi
    loop READ_NUM

    ; 평균 계산
    mov eax, ebx
    xor edx, edx
    mov ecx, 5
    div ecx

    ; 평균을 출력 문자열로 변환
    mov edi, OFFSET outputBuffer
    mov ebx, 10
    xor ecx, ecx

CONVERT:
    xor edx, edx
    div ebx
    add dl, '0'
    push edx
    inc ecx
    test eax, eax
    jnz CONVERT

PRINT_NUM:
    pop edx
    mov [edi], dl
    inc edi
    loop PRINT_NUM

    mov BYTE PTR [edi], 13
    inc edi
    mov BYTE PTR [edi], 10
    inc edi

    mov eax, edi
    sub eax, OFFSET outputBuffer

    invoke WriteConsoleA, outputHandle, ADDR outputBuffer, eax, ADDR charsWritten, 0

    invoke ExitProcess, 0

main ENDP
END main
