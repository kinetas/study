# 03_EXCEPTION - 예외 처리

## 개요
Spring Boot에서 전역 예외 처리기를 구성하고 React에서 에러 응답을 처리하는 방법을 학습합니다.

## 폴더 구조
```
03_EXCEPTION/
├── BN/     # Spring Boot 백엔드
│   └── src/main/java/com/example/demo/
│       ├── config/
│       │   └── DataSource.java
│       ├── controller/
│       │   ├── ParamController.java
│       │   └── MemoController.java
│       └── domain/dto/
│           ├── Person.java
│           └── MemoDto.java
└── fn/     # React 프론트엔드
    └── src/Components/
        └── (Param, 메모 관련 컴포넌트)
```

## 핵심 개념

### Backend (Spring Boot)
| 구성요소 | 설명 |
|---|---|
| `@ControllerAdvice` | 전역 예외 처리 클래스 선언 |
| `@ExceptionHandler` | 특정 예외 타입별 처리 메서드 |
| `@RestControllerAdvice` | REST 응답에 특화된 전역 처리 |
| 커스텀 예외 클래스 | 비즈니스 예외를 명시적으로 분리 |
| HTTP 상태 코드 | `400`, `404`, `500` 등 적절한 상태 반환 |

### Frontend (React)
- `axios` 에러 인터셉터 또는 `.catch()` 블록으로 에러 처리
- 서버에서 반환된 에러 메시지를 UI에 표시

## 주요 파일
- `DataSource.java` : DB 연결 설정
- `ParamController.java` / `MemoController.java` : 예외 발생 시나리오 포함 컨트롤러
- `Person.java` / `MemoDto.java` : 요청/응답 DTO
