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
