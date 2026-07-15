# 06_RESTFUL_API - 외부 RESTful API 연동

## 개요
Spring Boot에서 다양한 외부 API와 연동하는 방법을 학습합니다. OpenData, 카카오, 네이버, 구글, 결제, SMS, FCM 등 실무 API 연동 예제를 포함합니다.

## 폴더 구조
```
06_RESTFUL_API/
├── BN/         # Spring Boot 백엔드 (실습)
│   └── src/main/java/com/example/demo/
│       ├── config/                     # DB, JPA, Multipart, WebMvc 설정
│       ├── controller/                 # 기본 CRUD 컨트롤러
│       └── 외부API연동/
│           ├── C01OpenData/            # 공공데이터 API
│           ├── C02OpenWeatherMap/      # 날씨 API
│           ├── C03Kakao/               # 카카오 지도·로그인·채널·페이
│           ├── C04Naver/               # 네이버 로그인·검색
│           ├── C05Google/              # 구글 로그인·캘린더·Gmail
│           ├── C06Portone/             # 포트원 결제
│           ├── C07CollSMS/             # CoolSMS 문자 발송
│           ├── C08FCM/                 # Firebase 푸시 알림
│           ├── C09TossPayments/        # 토스페이먼츠 결제
│           ├── DaumAddress/            # 다음 주소 검색
│           └── GithubAPI/              # GitHub 로그인
├── BN_REF/     # Spring Boot 백엔드 (참고 코드)
└── fn/         # React 프론트엔드
    └── src/Components/
        ├── restful/
        │   ├── Kakao.jsx           # 카카오 API 연동 UI
        │   └── OpenData.jsx        # 공공데이터 조회 UI
        ├── memo/
        │   ├── List.jsx
        │   └── Post.jsx
        ├── updownload/
        │   ├── Upload.jsx
        │   ├── Download.jsx
        │   └── List.jsx
        ├── Param.jsx
        └── Exception.jsx
```

## 외부 API 연동 목록

| 폴더 | API | 주요 기능 |
|---|---|---|
| C01OpenData | 공공데이터포털 | 공공 데이터 조회 |
| C02OpenWeatherMap | OpenWeatherMap | 날씨 정보 조회 |
| C03Kakao | 카카오 | 지도, 소셜 로그인, 채널, 카카오페이 |
| C04Naver | 네이버 | 소셜 로그인, 검색 API |
| C05Google | 구글 | 소셜 로그인, 캘린더, Gmail |
| C06Portone | 포트원(구 아임포트) | 결제 모듈 |
| C07CollSMS | CoolSMS | SMS 문자 발송 |
| C08FCM | Firebase | 웹 푸시 알림(FCM) |
| C09TossPayments | 토스페이먼츠 | 결제 |
| DaumAddress | 다음 주소 | 우편번호/주소 검색 |
| GithubAPI | GitHub | GitHub OAuth 로그인 |

## 핵심 개념
- `RestTemplate` / `WebClient` 로 외부 HTTP 요청
- API Key, OAuth2 토큰 관리
- 응답 JSON 파싱 및 DTO 변환
- CORS 설정 (`WebMvcConfig`)
