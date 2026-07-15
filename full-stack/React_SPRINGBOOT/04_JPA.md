# 04_JPA - JPA 데이터베이스 연동

## 개요
Spring Data JPA를 활용한 CRUD 기능 구현과 React에서의 데이터 조회/저장을 학습합니다.

## 폴더 구조
```
04_JPA/
├── BN/     # Spring Boot 백엔드
│   └── src/main/java/com/example/demo/
│       ├── config/
│       │   ├── DataSourceConfig.java
│       │   ├── JpaConfig.java
│       │   └── TxConfig.java
│       ├── controller/
│       │   ├── ParamController.java
│       │   └── MemoController.java
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
        └── (Param, Memo 관련 컴포넌트)
```

## 핵심 개념

### Backend (Spring Boot + JPA)
| 구성요소 | 설명 |
|---|---|
| `@Entity` | DB 테이블과 매핑되는 클래스 |
| `@Id` / `@GeneratedValue` | 기본키 및 자동 생성 전략 |
| `JpaRepository` | 기본 CRUD 메서드 자동 제공 |
| `@Transactional` | 트랜잭션 경계 설정 |
| JPQL / 메서드 쿼리 | 커스텀 조회 쿼리 작성 |

### 레이어 구조
```
Controller → Service → Repository → Database
```

### Frontend (React)
- 메모 목록 조회, 등록, 수정, 삭제 UI
- `axios`로 REST API 호출 후 상태 업데이트

## 주요 파일
- `Memo.java` : 메모 엔티티 (id, content, createdAt 등)
- `MemoRepository.java` : Spring Data JPA 레포지토리
- `MemoServiceImpl.java` : 비즈니스 로직 구현체
- `MemoController.java` : CRUD API 엔드포인트
- `JpaConfig.java` / `TxConfig.java` : JPA 및 트랜잭션 설정
