# 10월 29알 수업 내용

## 1.시프트 및 로테이트 명령어
비트를 좌우로 이동하거나 회전시키는 명령어

### Logical & Arithmetic Shifts
-SHL / SAL (Shift Left / Shift Arithmetic Left): 비트를 왼쪽으로 이동시키며, 빈 자리는 0으로 채웁니다. 비트wise 곱셈 효과를 냄(2^n 곱하기)
-SHR (Shift Right): 논리적 오른쪽 시프트로, 최고위 비트(MSB)를 0으로 채우며 비트wise 나눗셈(2^n 나누기)에 활용
-SAR (Shift Arithmetic Right): 산술적 오른쪽 시프트로, 부호를 유지하기 위해 기존의 부호 비트(MSB)를 채우며 음수 나눗셈에 사용

### Rotate Instructions
-ROL / ROR (Rotate Left / Right): 밀려 나가는 비트가 반대편 끝과 캐리 플래그(CF)에 동시에 복사되므로 비트 손실이 없슴
-RCL / RCR (Rotate Carry Left / Right): 캐리 플래그(CF)를 연산에 포함시켜 비트를 회전시킴

### Double-Precision Shift
-SHLD / SHRD: 두 개의 오퍼랜드(Destination, Source)를 결합하여 다중 워드 시프트를 수행

## 2.시프트 및 로테이트 응용
-이진수 곱셈 최적화: 덧셈과 시프트(SHL)를 조합하여 빠른 연산 구현 (예: EAX x 36 = EAX x (32 + 4))
-기타 응용: 다중 더블워드 시프트, 이진수를 ASCII 문자열로 변환(BinToAsc), 파일 날짜/시간 필드 추출(비트 AND 및 시프트 활용) 등

## 3.곱셈과 나눗셈 명령어
### MUL (Unsigned Multiply
피연산자 크기에 따라 결과가 두 배 크기의 레지스터에 저장됩니다. (예: AL x reg/m8 ㅡ> AX)

### IMUL (Signed Multiply
부호 있는 정수 곱셈으로, 단일/이중/삼중 오퍼랜드 형식을 지원, 이중/삼중 형식에서는 오버플로우 발생 시 Carry/Overflow 플래그가 설정

### DIV 및 IDIV (Division)
나눗셈 규칙: 몫은 낮은 레지스터, 나머지는 높은 레지스터(AX, DX:AX, EDX:EAX)에 저장
부호 확장 (Sign Extension): 음수 나눗셈 전에는 반드시 부호 확장을 수행(CBW, CWD, CDQ 명령어 사용)
예외 처리: 0으로 나누기(Divide Overflow) 방지를 위해 사전 비교(CMP)가 권장

## 4.확장 덧셈과 뺄셈
-ADC (Add with Carry): 일반 덧셈에 캐리 플래그(CF) 값을 더하여 다중 바이트/워드 덧셈을 수행
-SBB (Subtract with Borrow): 뺄셈 시 캐리(빌림) 플래그를 고려하여 연산

## 5.ASCII 및 언팩 십진수 연산
언팩 십진수는 상위 4바이트가 0011b(ASCII) 또는 0000b 형태를 가짐

### 조건 명령어
-AAA / AAS: 덧셈/뺄셈 후 ASCII 결과를 올바른 십진수 형태로 조정
-AAM / AAD: 곱셈 이후 변환(AAM) 및 나눗셈 이전 바이너리 변환(AAD)을 수행

