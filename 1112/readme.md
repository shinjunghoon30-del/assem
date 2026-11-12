# 11월 12일 수업 내용

## 1. 문자열 처 명령어 (String Primitive Instructions)
어셈블리어에서는 메모리 블록을 효율적으로 조작하기 위해 ESI(소스), EDI(목적지) 레지스터와 반복 접두사(REP)를 사용하는 원시 명령어들을 제공

- 방향 플래그 (Direction Flag): CLD를 통해 플래그를 클리어하면 인덱스(ESI, EDI)가 증가(순방향)하고, STD로 세트하면 감소(역방향)합니다.
### 주요 명령어 목록
- MOVSB / MOVSW / MOVSD : ESI가 가리키는 메모리 데이터를 EDI가 가리키는 곳으로 복사
- CMPSB / CMPSW / CMPSD : 두 메모리 위치의 값을 비교하며, REPE(같을 동안 반복) 등과 함께 자주 쓰임
- SCASB / SCASW / SCASD : 누산기(AL, AX, EAX)의 값과 EDI가 가리키는 메모리 값을 비교하여 특정 문자를 검색
- STOSB / STOSW / STOSD : 누산기의 값을 EDI가 가리키는 메모리에 저장(채우기)
- LODSB / LODSW / LODSD : ESI가 가리키는 메모리 값을 누산기에 로드

## 2. Irvine32 라이브러리 주요 문자열 프로시저
널 문자(\0)로 끝나는 문자열을 조작하기 위해 Irvine32 라이브러리에서 제공하는 프로시저들

- Str_compare: 두 문자열을 대소문자를 구분하여 비교하고, 결과에 따라 Zero(ZF) 및 Carry(CF) 플래그를 설정합니다.
- Str_length: 문자열의 길이를 계산하여 EAX 레지스터에 반환합니다.
- Str_copy: 소스 문자열을 타겟 위치로 복사합니다 (타겟 공간이 충분해야 함).
- Str_trim: 문자열 끝에 있는 지정된 구분 문자(예: # 또는 /)들을 모두 제거합니다.
- Str_ucase: 문자열의 모든 소문자를 대문자로 변환
