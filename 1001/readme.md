# 10월1일 수업내용

##  1.데이터 이동 명령어
### 피연산자(Operand) 종류
-Immediate: 리터럴 숫자/상수 값
-Register: 레지스터 이름 (EAX, EBX, AX 등)
-Memory: 메모리 위치 참조

### MOV 명령의 제약사항
-피연산자 간 크기가 동일해야 함
-두 피연산자가 동시에 메모리일 수는 없음 (메모리 간 직접 이동 불가 $\rightarrow$ 레지스터 경유 필요)
-instruction pointer (EIP) 등은 목적지 피연산자로 지정 불가

### 확장 이동 명령어
-MOVZX (Zero Extension): 작은 크기의 피연산자를 큰 목적지로 복사할 때 상위 비트를 0으로 채움 (부호 없는 정수)
-MOVSX (Sign Extension): 작은 크기의 피연산자를 복사할 때 최상위 부호 비트(MSB)를 확장하여 채움 (부호 있는 정수)

## 2.덧셈과 뺄셈 및 플래그 (Addition and Subtraction)
### 기본 산술 명령어
-INC / DEC: 1 증가 / 1 감소
-ADD / SUB: 덧셈 / 뺄셈 연산 수행
-NEG: 2의 보수를 취하여 부호를 반전

### 상태 플래그 (Status Flags)
-Carry Flag (CF): 부호 없는 정수 연산 시 범위를 넘어서는 오버플로우/빌림 발생 시 설정
-Zero Flag (ZF): 연산 결과가 0일 때 설정
-Sign Flag (SF): 연산 결과가 음수일 때(최상위 비트가 1) 설정
-Overflow Flag (OF): 부호 있는 정수 연산 시 범위를 벗어나는 오버플로우/언더플로우 발생 시 설정
-Parity Flag (PF): 하위 바이트에서 1인 비트의 개수가 짝수일 때 설정
-Auxiliary Carry Flag (AC): 3번 비트에서 비트 넘김/빌림이 발생할 때 설정

## 3. 데이터 관련 연산자 및 지시어 (Operators & Directives)
-OFFSET: 데이터 레이블이 시작되는 지점으로부터의 오프셋 거리(바이트 단위 주소) 반환
-PTR: 선언된 피연산자의 기본 크기를 재정의 (예: WORD PTR myDouble)
-TYPE: 변수의 한 요소(element) 크기를 바이트 단위로 반환
-LENGTHOF: 배열의 전체 요소 개수 반환
-IZEOF: 배열이 차지하는 총 바이트 수 반환 (LENGTHOF * TYPE)
-ALIGN: 변수를 바이트, 워드, 더블워드 경계에 정렬하여 CPU 처리 속도 향상
-LABEL: 추가 메모리 할당 없이 기존 위치에 새로운 크기 속성을 가진 레이블 부여 

