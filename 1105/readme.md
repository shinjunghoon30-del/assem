# 11월 4일 수업 내용

## 1. 스택 프레임 (Stack Frames)
프로시저가 실행될 때 스택에 할당되는 메모리 영역
### 스택 프레임 생성 순서
- 인자 푸시 (Push Arguments) -> 서브루틴 호출 (Call Subroutine) -> EBP 푸시 (Push EBP) -> EBP를 ESP로 설정 (Set EBP to ESP)
  -> 지역 변수 할당 (Allocate Local Variables) -> 레지스터 저장 (Save Registers)
### 인자 전달 방식
- 값에 의한 전달 (Pass by Value): 값의 복사본을 스택에 푸시
- 참조에 의한 전달 (Pass by Reference): 객체의 메모리 주소(오프셋)를 스택에 전달하며, 고수준 언어는 배열을 항상 참조로 전달
### 호출 규칙 (Calling Conventions)
- C 호출 규칙 (C Convention): 인자를 역순으로 푸시하며, 호출자가 스택을 정리
- STDCALL 규칙: 인자를 전달한 후 피호출 함수가 RET n 형태로 직접 스택을 정리
### 스택 관련 명령어
- LEA: 간접 오퍼랜드의 주소를 반환
- ENTER / LEAVE: 스택 프레임을 자동으로 생성(ENTER bytes, level)하고 해제(LEAVE)함
- LOCAL 지시어: 이름을 통해 지역 변수를 선언하고 크기 속성을 부여

## 2. 재귀 (Recursion)
서브루틴이 직접 또는 간접적으로 자기 자신을 호출하는 방식
### 꼬리 재귀(Tail Recursion)
- 재귀 함수에서 자기 자신을 호출하는 부분이 함수의 마지막에 위치하는 재귀 방식
### 꼬리 재귀 최적화 (Tail Call Optimization)
- 재귀 호출이 마지막에 있을 때, 컴파일러나 실행 환경이 기존 함수의 스택 프레임을 재사용하여 메모리 사용량을 줄이는 최적화 기법
