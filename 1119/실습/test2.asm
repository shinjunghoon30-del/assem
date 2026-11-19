
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

    prompt1 BYTE "Enter first number: ", 0
    prompt2 BYTE "Enter second number: ", 0

    len1 DWORD 20
    len2 DWORD 21

    inputBuffer BYTE 100 DUP(0)
    charsRead DWORD ?
    charsWritten DWORD ?

    num1 DWORD ?
    num2 DWORD ?

    resultAdd DWORD ?
    resultSub DWORD ?
    resultMul DWORD ?
    resultDiv DWORD ?

    saveAX WORD ?
    saveBX WORD ?
    saveCX WORD ?
    saveDX WORD ?

    outputBuffer BYTE 100 DUP(0)

    msgAdd BYTE "Addition: "
    lenAdd DWORD 10

    msgSub BYTE 13,10,"Subtraction: "
    lenSub DWORD 13

    msgMul BYTE 13,10,"Multiplication: "
    lenMul DWORD 16

    msgDiv BYTE 13,10,"Division: "
    lenDiv DWORD 11

    msgAX BYTE 13,10,"AX = "
    lenAX DWORD 6

    msgBX BYTE 13,10,"BX = "
    lenBX DWORD 6

    msgCX BYTE 13,10,"CX = "
    lenCX DWORD 6

    msgDX BYTE 13,10,"DX = "
    lenDX DWORD 6

    msgZero BYTE 13,10,"Cannot divide by zero."
    lenZero DWORD 23

.code

main PROC

    ; 콘솔 핸들 가져오기
    invoke GetStdHandle, STD_INPUT_HANDLE
    mov inputHandle, eax

    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov outputHandle, eax

    ; 첫 번째 숫자 입력
    invoke WriteConsoleA, outputHandle, ADDR prompt1, len1, ADDR charsWritten, 0

    invoke ReadConsoleA, inputHandle, ADDR inputBuffer, 100, ADDR charsRead, 0

    call ConvertInput
    mov num1, eax

    ; 두 번째 숫자 입력
    invoke WriteConsoleA, outputHandle, ADDR prompt2, len2, ADDR charsWritten, 0

    invoke ReadConsoleA, inputHandle, ADDR inputBuffer, 100, ADDR charsRead, 0

    call ConvertInput
    mov num2, eax

    ; 덧셈
    mov eax, num1
    add eax, num2
    mov resultAdd, eax

    ; 뺄셈
    mov eax, num1
    sub eax, num2
    mov resultSub, eax

    ; 곱셈
    mov eax, num1
    imul eax, num2
    mov resultMul, eax

    ; 나눗셈
    mov eax, num1
    cdq
    mov ebx, num2

    cmp ebx, 0
    je DIV_ZERO

    idiv ebx
    mov resultDiv, eax
    jmp SAVE_REG

DIV_ZERO:
    mov resultDiv, 0

SAVE_REG:

    ; 레지스터에 연산 결과 저장
    mov ax, WORD PTR resultAdd
    mov saveAX, ax

    mov bx, WORD PTR resultSub
    mov saveBX, bx

    mov cx, WORD PTR resultMul
    mov saveCX, cx

    mov dx, WORD PTR resultDiv
    mov saveDX, dx

    ; 덧셈 출력
    invoke WriteConsoleA, outputHandle, ADDR msgAdd, lenAdd, ADDR charsWritten, 0

    mov eax, resultAdd
    call PrintNumber

    ; 뺄셈 출력
    invoke WriteConsoleA, outputHandle, ADDR msgSub, lenSub, ADDR charsWritten, 0

    mov eax, resultSub
    call PrintNumber

    ; 곱셈 출력
    invoke WriteConsoleA, outputHandle, ADDR msgMul, lenMul, ADDR charsWritten, 0

    mov eax, resultMul
    call PrintNumber

    ; 나눗셈 출력
    cmp num2, 0
    je SHOW_ZERO

    invoke WriteConsoleA, outputHandle, ADDR msgDiv, lenDiv, ADDR charsWritten, 0

    mov eax, resultDiv
    call PrintNumber
    jmp SHOW_REG

SHOW_ZERO:
    invoke WriteConsoleA, outputHandle, ADDR msgZero, lenZero, ADDR charsWritten, 0

SHOW_REG:

    ; AX 출력
    invoke WriteConsoleA, outputHandle, ADDR msgAX, lenAX, ADDR charsWritten, 0

    movzx eax, saveAX
    call PrintHex

    ; BX 출력
    invoke WriteConsoleA, outputHandle, ADDR msgBX, lenBX, ADDR charsWritten, 0

    movzx eax, saveBX
    call PrintHex

    ; CX 출력
    invoke WriteConsoleA, outputHandle, ADDR msgCX, lenCX, ADDR charsWritten, 0

    movzx eax, saveCX
    call PrintHex

    ; DX 출력
    invoke WriteConsoleA, outputHandle, ADDR msgDX, lenDX, ADDR charsWritten, 0

    movzx eax, saveDX
    call PrintHex

    invoke ExitProcess, 0

main ENDP


; 입력 문자열을 정수로 변환
ConvertInput PROC

    push ebx
    push esi

    mov esi, OFFSET inputBuffer
    xor eax, eax
    xor ebx, ebx

    ; 공백 건너뛰기
SKIP_SPACE:
    mov bl, [esi]
    cmp bl, ' '
    je NEXT_INPUT
    cmp bl, 13
    je NEXT_INPUT
    cmp bl, 10
    je NEXT_INPUT
    jmp CHECK_SIGN

NEXT_INPUT:
    inc esi
    jmp SKIP_SPACE

CHECK_SIGN:
    mov ecx, 0

    cmp BYTE PTR [esi], '-'
    jne READ_DIGIT

    mov ecx, 1
    inc esi

READ_DIGIT:
    mov bl, [esi]

    cmp bl, '0'
    jb INPUT_DONE
    cmp bl, '9'
    ja INPUT_DONE

    imul eax, 10
    sub bl, '0'
    movzx ebx, bl
    add eax, ebx

    inc esi
    jmp READ_DIGIT

INPUT_DONE:
    cmp ecx, 1
    jne INPUT_RETURN

    neg eax

INPUT_RETURN:
    pop esi
    pop ebx
    ret

ConvertInput ENDP


; 정수 출력
PrintNumber PROC

    pushad

    mov edi, OFFSET outputBuffer
    add edi, 99

    xor ecx, ecx

    test eax, eax
    jns POSITIVE

    neg eax
    mov BYTE PTR [edi], '-'
    dec edi

POSITIVE:
    mov ebx, 10

CONVERT_NUM:
    xor edx, edx
    div ebx

    add dl, '0'
    mov [edi], dl
    dec edi

    inc ecx

    test eax, eax
    jnz CONVERT_NUM

    inc edi

    mov edx, edi
    mov eax, OFFSET outputBuffer
    add eax, 99
    sub eax, edi
    mov ecx, eax

    invoke WriteConsoleA, outputHandle, edx, ecx, ADDR charsWritten, 0

    popad
    ret

PrintNumber ENDP


; 16진수 출력 (4자리)
PrintHex PROC

    pushad

    mov edi, OFFSET outputBuffer
    mov ecx, 4

HEX_LOOP:
    rol ax, 4
    mov bl, al
    and bl, 0Fh

    cmp bl, 9
    jbe HEX_DIGIT

    add bl, 7

HEX_DIGIT:
    add bl, '0'
    mov [edi], bl
    inc edi

    loop HEX_LOOP

    mov BYTE PTR [edi], 13
    inc edi
    mov BYTE PTR [edi], 10
    inc edi

    mov eax, edi
    sub eax, OFFSET outputBuffer

    invoke WriteConsoleA, outputHandle, ADDR outputBuffer, eax, ADDR charsWritten, 0

    popad
    ret

PrintHex ENDP

END main
