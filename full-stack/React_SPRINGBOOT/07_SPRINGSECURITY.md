# 07_SPRINGSECURITY - Spring Security + JWT + OAuth2

## 개요
Spring Security를 기반으로 JWT 인증(쿠키 저장), Redis Refresh Token 관리, OAuth2 로그인(설정만 존재, provider별 구현은 BN_REF 참고용)까지 다룹니다.
로그인/로그아웃/토큰검증은 `formLogin`을 끄고 `UserRestController`에서 직접 처리하는 방식입니다. 세부 CORS 트러블슈팅 기록은 [[../../필기/7월/3일.md]] 참고.

## 폴더 구조 (BN 기준, 실제 코드)
```
07_SPRINGSECURITY/
├── BN/         # Spring Boot 백엔드 (실습, 실제 구현체)
│   └── src/main/java/com/example/demo/
│       ├── Config/
│       │   ├── SecurityConfig.java              # Security 필터 체인 설정
│       │   ├── DataSourceConfig.java
│       │   ├── JPAConfig.java
│       │   ├── TxConfig.java
│       │   └── auth/
│       │       ├── PrincipalDetails.java            # UserDetails 구현체
│       │       ├── PrincipalDetailsService.java      # UserDetailsService 구현체
│       │       ├── PrincipalDetailsOauth2Service.java # OAuth2 사용자 처리
│       │       ├── jwt/
│       │       │   ├── JWTTokenProvider.java     # 토큰 생성/검증, 서명키는 DB(Signature)에서 로드
│       │       │   ├── JWTAuthorizationFilter.java # 요청마다 쿠키의 JWT 검증 + Redis 재발급
│       │       │   ├── JWTProperties.java        # 쿠키명/만료시간 등 상수
│       │       │   ├── TokenInfo.java            # 토큰 응답 DTO
│       │       │   └── KeyGenerator.java         # 서명 키 생성
│       │       ├── handler/
│       │       │   ├── CustomLoginSuccessHandler.java   # 현재 미사용(formLogin disable로 호출 안 됨)
│       │       │   ├── CustomLoginFailureHandler.java    # 현재 미사용
│       │       │   ├── CustomLogoutHandler.java          # 로그아웃 시 부가 정리(현재는 자리만)
│       │       │   ├── CustomLogoutSuccessHandler.java   # Redis refresh 삭제 + 쿠키 만료 + redirect
│       │       │   ├── CustomAuthenticationEntryPoint.java # 401 → /login 리다이렉트
│       │       │   └── CustomAccessDeniedHandler.java      # 403 → /login 리다이렉트
│       │       ├── provider/                   # OAuth2 공급자 정보(구현체, 실제 연동은 BN_REF 중심)
│       │       │   ├── OAuth2UserInfo.java
│       │       │   ├── GoogleUserInfo.java
│       │       │   ├── KakaoUserInfo.java
│       │       │   └── NaverUserInfo.java
│       │       └── redis/
│       │           ├── RedisConfig.java
│       │           ├── RedisProperties.java
│       │           ├── RedisUtil.java            # save/getRefreshToken/delete
│       │           └── Redis.java
│       ├── Controller/
│       │   ├── HomeController.java
│       │   ├── UserController.java          # 전부 주석 처리된 레거시(Thymeleaf 방식) — UserRestController로 대체됨
│       │   └── UserRestController.java      # /join /login /user /logout /validate 실제 엔드포인트
│       └── Domain/Common/
│           ├── Dtos/UserDTO.java
│           ├── Entity/ (User.java, JwtToken.java, Signature.java)
│           └── Repository/ (UserRepository, JwtTokenRepository, SignatureRepository)
├── BN_REF/     # Spring Boot 백엔드 (참고/완성본 코드, OAuth2 공급자별 구현 포함)
└── fn/         # React 프론트엔드
    └── src/Components/
        ├── main.jsx
        ├── join.jsx
        ├── login.jsx
        ├── logout.jsx
        └── user.jsx
```

## 핵심 개념

### 인증 흐름 (JWT, 쿠키 방식)
```
POST /login (UserRestController, formLogin 아님)
→ authenticationManager.authenticate() 직접 호출
→ JWTTokenProvider.generateToken() — Access + Refresh 발급
→ Refresh Token은 Redis에 저장 ("RT:" + username)
→ Access Token + username을 HttpOnly 쿠키로 응답

이후 모든 요청 → JWTAuthorizationFilter (addFilterBefore LogoutFilter.class)
→ 쿠키의 accessToken 검증 → 만료 시 Redis의 refreshToken으로 재발급
→ 유효하면 SecurityContextHolder에 Authentication 세팅
```

### 로그아웃 흐름
```
POST /logout → Spring Security LogoutFilter가 컨트롤러보다 먼저 가로챔
→ CustomLogoutHandler (부가 정리) → CustomLogoutSuccessHandler
   (Redis refresh 삭제, 쿠키 만료, redirect)
```
> `UserRestController`에 있는 `@PostMapping("/logout")`은 실제로 실행되지 않는 placeholder다.
> `LogoutFilter`가 POST만 가로채기 때문에, OPTIONS 프리플라이트가 `HandlerMapping`에 `/logout` 경로를
> 인식시키기 위한 용도로만 존재한다(CORS preflight 대응).

### 토큰 검증 확인 흐름
```
GET /validate → SecurityConfig에서 permitAll
→ 컨트롤러 내부에서 SecurityContextHolder의 Authentication을 직접 체크
→ 인증됨(ROLE_ANONYMOUS 아님) → 200 / 아니면 → 401
```
> 왜 permitAll인가: `anyRequest().authenticated()`로 막아두면 미인증 요청이
> `CustomAuthenticationEntryPoint`에서 리다이렉트로 끊겨버려 `@CrossOrigin`이 적용되지 못한다.
> permitAll로 컨트롤러까지 도달시키고 인증 판단은 컨트롤러가 직접 한다.

### 주요 구성요소

| 구성요소 | 역할 |
|---|---|
| `SecurityConfig` | 필터 체인, 권한 설정(`authorizeHttpRequests`), CSRF disable, STATELESS 세션 |
| `JWTTokenProvider` | Access/Refresh 토큰 생성 및 파싱, 서명키는 DB(`Signature` 테이블)에서 1회 로드 |
| `JWTAuthorizationFilter` | 요청마다 JWT 유효성 검사 + Redis 기반 자동 재발급 |
| `PrincipalDetails` | Spring Security `UserDetails` 구현 |
| `RedisUtil` | Refresh Token을 Redis에 저장/조회/삭제 |
| `CustomLogoutHandler` / `CustomLogoutSuccessHandler` | 로그아웃 처리(Redis 삭제, 쿠키 만료, redirect) |
| `CustomAccessDeniedHandler` | 403 권한 없음 처리 (redirect) |
| `CustomAuthenticationEntryPoint` | 401 미인증 처리 (redirect) |
| `CustomLoginSuccessHandler` / `CustomLoginFailureHandler` | 현재 미사용 — `formLogin` disable로 호출 경로 없음 |

### CORS 설정 — 현재 방식과 주의점

`SecurityConfig`에 `corsConfigurationSource()` 빈이 정의되어 있지만 `http.cors(...)`로
필터체인에 연결되어 있지 않아 **사실상 미사용**이다. 실제 CORS는 `UserRestController`
클래스 레벨의 `@CrossOrigin(origins = "http://localhost:3000", allowCredentials = "true")`
로 처리한다.

`@CrossOrigin`은 요청이 `DispatcherServlet`(컨트롤러)까지 도달했을 때만 적용되므로,
Security 필터체인에서 응답이 먼저 끊기는 경로(`/validate`, `/logout` 등)는 `permitAll` +
필요 시 컨트롤러 placeholder 매핑으로 우회해야 했다. 상세 트러블슈팅 과정은
[[../../필기/7월/3일.md]]의 "오늘 겪은 CORS 트러블슈팅" 절 참고.

### 지원 OAuth2 공급자 (provider 클래스 존재, 연동 코드는 BN_REF 중심)
- Google
- Kakao
- Naver
