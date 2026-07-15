# React + Spring Boot 풀스택 학습

## 개요
React 프론트엔드와 Spring Boot 백엔드를 연동하는 풀스택 개발을 단계별로 학습합니다.

## 단원 목록

| 폴더 | 주제 | 핵심 내용 |
|---|---|---|
| [00_EX](./00_EX.md) | 실습 예제 | 종합 문제풀이 |
| [01_PARAM](./01_PARAM.md) | 파라미터 처리 | `@PathVariable`, `@RequestParam`, `@RequestBody` |
| [02_VALIDATION](./02_VALIDATION.md) | 유효성 검사 | Bean Validation, `@Valid`, `BindingResult` |
| [03_EXCEPTION](./03_EXCEPTION.md) | 예외 처리 | `@ControllerAdvice`, `@ExceptionHandler` |
| [04_JPA](./04_JPA.md) | JPA DB 연동 | Entity, Repository, Service, CRUD |
| [05_UPLOAD](./05_UPLOAD.md) | 파일 업로드/다운로드 | `MultipartFile`, `Resource`, FormData |
| [06_RESTFUL_API](./06_RESTFUL_API.md) | 외부 API 연동 | 카카오·네이버·구글·결제·FCM 등 |
| [07_SPRINGSECURITY](./07_SPRINGSECURITY.md) | Spring Security | JWT, OAuth2, Redis, 소셜 로그인 |

## 공통 프로젝트 구조

```
각 단원/
├── BN/         # Spring Boot 백엔드
│   └── src/main/java/com/example/
│       ├── config/         # 설정 클래스
│       ├── controller/     # REST 컨트롤러
│       └── domain/
│           ├── dto/        # 데이터 전송 객체
│           ├── entity/     # JPA 엔티티
│           ├── repository/ # Spring Data JPA
│           └── service/    # 비즈니스 로직
├── BN_REF/     # 참고용 백엔드 (일부 단원)
└── fn/         # React 프론트엔드
    └── src/
        ├── App.js
        └── Components/     # React 컴포넌트
```

## 기술 스택
- **Frontend**: React, axios
- **Backend**: Spring Boot, Spring Data JPA, Spring Security
- **Database**: MySQL (DataSourceConfig)
- **인증**: JWT, OAuth2 (Google / Kakao / Naver)
- **캐시**: Redis (Refresh Token 저장)
- **빌드**: Gradle (Backend), npm (Frontend)
