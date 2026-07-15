# 02_VALIDATION - 유효성 검사

## 개요
Spring Boot에서 Bean Validation을 활용한 서버 사이드 유효성 검사를 학습합니다.

## 폴더 구조
```
02_VALIDATION/
├── BN/     # Spring Boot 백엔드
│   └── src/main/java/com/example/app/
│       ├── controller/
│       │   ├── ParamController.java
│       │   └── MemoController.java
│       └── domain/dto/
│           ├── PersonDto.java
│           └── MemoDto.java
└── fn/     # React 프론트엔드
    └── src/Components/
        └── Param.jsx
```

## 핵심 개념

### Backend (Spring Boot)
| 어노테이션 | 설명 |
|---|---|
| `@NotNull` | null 불허 |
| `@NotBlank` | 공백/빈 문자열 불허 |
| `@Size(min, max)` | 문자열 길이 제한 |
| `@Min` / `@Max` | 숫자 범위 제한 |
| `@Email` | 이메일 형식 검사 |
| `@Valid` | 컨트롤러에서 DTO 검증 활성화 |
| `BindingResult` | 검증 오류 결과 수집 |

### Frontend (React)
- 서버 응답의 에러 메시지를 화면에 표시
- 클라이언트 사이드 사전 검증과 서버 검증 병행

## 주요 파일
- `PersonDto.java` : 유효성 검사 어노테이션이 적용된 DTO
- `MemoDto.java` : 메모 내용 검증 DTO
- `ParamController.java` / `MemoController.java` : `@Valid` + `BindingResult` 처리
