.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD
GetStdHandle PROTO, nStdHandle:DWORD
WriteConsoleA PROTO, hConsoleOutput:DWORD, lpBuffer:PTR BYTE, nNumberOfCharsToWrite:DWORD, lpNumberOfCharsWritten:PTR DWORD, lpReserved:DWORD

.data
    studentID BYTE "20222564022", 13, 10
    studentName BYTE "신정훈", 13, 10
    written DWORD ?

.code
main PROC

    ; 콘솔 핸들 가져오기
    INVOKE GetStdHandle, -11

    ; 학번 출력
    INVOKE WriteConsoleA, EAX, ADDR studentID, SIZEOF studentID, ADDR written, 0

    ; 콘솔 핸들 다시 가져오기
    INVOKE GetStdHandle, -11

    ; 이름 출력
    INVOKE WriteConsoleA, EAX, ADDR studentName, SIZEOF studentName, ADDR written, 0

    ; 프로그램 종료
    INVOKE ExitProcess, 0

main ENDP
END main