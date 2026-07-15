# 05_UPLOAD - 파일 업로드/다운로드

## 개요
Spring Boot에서 파일 업로드·다운로드 기능을 구현하고 React에서 파일을 전송·수신하는 방법을 학습합니다.

## 폴더 구조
```
05_UPLOAD/
├── BN/     # Spring Boot 백엔드
│   └── src/main/java/com/example/demo/
│       ├── config/
│       │   ├── DataSourceConfig.java
│       │   ├── MultipartConfig.java
│       │   ├── TxConfig.java
│       │   └── WebMvcConfig.java
│       ├── controller/
│       │   ├── ParamController.java
│       │   ├── MemoController.java
│       │   └── UpDownloadController.java
│       └── domain/
│           ├── dto/
│           │   ├── Person.java
│           │   └── MemoDto.java
│           ├── entity/
│           │   └── Memo.java
│           ├── repository/
│           │   └── MemoRepository.java
│           └── service/
│               └── MemoServiceImpl.java
└── fn/     # React 프론트엔드
    └── src/Components/
        └── updownload/
            ├── Upload.jsx
            ├── Download.jsx
            └── List.jsx
```

## 핵심 개념

### Backend (Spring Boot)
| 구성요소 | 설명 |
|---|---|
| `MultipartConfig.java` | 업로드 파일 크기 제한, 임시 경로 설정 |
| `WebMvcConfig.java` | 정적 리소스(업로드 파일) 경로 매핑 |
| `MultipartFile` | 업로드된 파일을 받는 파라미터 타입 |
| `Resource` / `InputStreamResource` | 파일 다운로드 응답 처리 |
| `Content-Disposition` 헤더 | 브라우저에 다운로드 파일명 지정 |

### Frontend (React)
- `<input type="file" />` + `FormData`로 파일 전송
- `multipart/form-data` Content-Type으로 axios 전송
- 업로드된 파일 목록 조회 및 다운로드 링크 제공

## 주요 파일
- `MultipartConfig.java` : 파일 업로드 제한 설정
- `WebMvcConfig.java` : 업로드 파일 정적 경로 노출
- `UpDownloadController.java` : 업로드·다운로드 엔드포인트
- `Upload.jsx` : 파일 선택 및 업로드 UI
- `Download.jsx` : 파일 다운로드 처리
- `List.jsx` : 업로드 파일 목록 표시
