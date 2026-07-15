# 01_PARAM - 파라미터 처리

## 개요
React에서 Spring Boot로 다양한 방식으로 데이터를 전달하는 방법을 학습합니다.

## 폴더 구조
```
01_PARAM/
├── BN/     # Spring Boot 백엔드
│   └── src/main/java/com/example/app/
│       ├── controller/
│       │   └── ParamController.java
│       └── controller/domain/dto/
│           └── PersonDto.java
└── fn/     # React 프론트엔드
    └── src/Components/
        └── Param.jsx
```

## 핵심 개념

### Backend (Spring Boot)
| 어노테이션 | 설명 |
|---|---|
| `@PathVariable` | URL 경로에서 값 추출 |
| `@RequestParam` | 쿼리 파라미터 추출 |
| `@RequestBody` | JSON body를 객체로 바인딩 |
| `@ModelAttribute` | form 데이터를 객체로 바인딩 |

### Frontend (React)
- `axios`를 이용한 GET/POST 요청
- URL 파라미터, 쿼리스트링, body 전송 방법
- `useState`로 입력값 관리 및 결과 출력

## 주요 파일
- `ParamController.java` : 파라미터 수신 방식별 엔드포인트 정의
- `PersonDto.java` : 이름, 나이 등 요청/응답 데이터 구조
- `Param.jsx` : 파라미터 전송 테스트 UI
