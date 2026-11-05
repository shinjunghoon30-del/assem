# 11월 4일 수업 내용

## 1. 스택 프레임 (Stack Frames)
프로시저가 실행될 때 스택에 할당되는 메모리 영역

### 스택 프레임 생성 순서
- 인자 푸시 (Push Arguments) -> 서브루틴 호출 (Call Subroutine) -> EBP 푸시 (Push EBP) -> EBP를 ESP로 설정 (Set EBP to ESP)
  -> 지역 변수 할당 (Allocate Local Variables) -> 레지스터 저장 (Save Registers)
