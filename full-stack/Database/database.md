# 데이터베이스

> **정의**  
> 앱·웹을 위한 정보의 **영구 저장**을 담당하고, 데이터를 **체계적으로 저장·접근·공유**할 수 있게 하는 시스템입니다.

---

## DBMS

**DBMS(Database Management System)** 는 MySQL, Oracle 등 다양한 제품이 있습니다.

| 분류 | 설명 |
|------|------|
| 구조 유형 | 계층형 · 망형 · 관계형 · 객체지향형 · 객체-관계형 |
| 일반적 사용 | 현업에서는 **관계형 DBMS** 구조가 널리 쓰입니다 |

---

## SQL

데이터베이스·테이블을 다루는 기본 명령입니다.

### 데이터베이스

| 목적 | 예시 |
|------|------|
| 생성 | `CREATE DATABASE db_name;` |
| 선택(사용) | `USE db_name;` |
| 삭제 | `DROP DATABASE db_name;` |

### 테이블

**생성**

```sql
CREATE TABLE table_name (
    column_name TYPE CONSTRAINT,
    ...
);
```

**컬럼 타입 예**

- `INT`
- `VARCHAR(허용크기)`
- `DATETIME`
- 기타 필요한 타입

**제약 조건 예**

- `NULL` / `NOT NULL`
- `PRIMARY KEY`
- 기타 제약 조건

**삭제**

```sql
DROP TABLE table_name;
```

**변경 (`ALTER`)**

```sql
ALTER TABLE table_name 변경내용;
```

### DDL 요약 — `ALTER TABLE`에서 자주 쓰는 패턴

| 구문 패턴 | 의미 |
|-----------|------|
| `ADD COLUMN 컬럼명 타입 [제약] …` | 컬럼 추가 |
| `DROP COLUMN 컬럼명` | 컬럼 삭제 |
| `… ADD COLUMN … AFTER 기존컬럼명` | 새 컬럼을 특정 컬럼 **바로 뒤**에 배치 |
| `CHANGE COLUMN 기존이름 새이름 타입 [제약]` | 컬럼 이름·타입·제약 일괄 변경 (MySQL) |
| `MODIFY COLUMN 컬럼명 타입 [제약]` | 이름은 유지하고 타입·제약만 변경 (MySQL) |

> DBMS마다 `CHANGE` / `MODIFY` 지원 문법이 다를 수 있으니 제품 문서를 함께 본다.

---

### DML

**데이터 조작**용 명령입니다. 테이블 **행**을 넣고·고치고·지웁니다.

| 목적 | 핵심 형태 |
|------|-----------|
| 삽입 | `INSERT INTO … VALUES …` |
| 수정 | `UPDATE … SET … WHERE …` |
| 삭제 | `DELETE FROM … WHERE …` |
| 조회 | `SELECT … FROM … WHERE …` |

**삽입**

```sql
INSERT INTO 테이블명 (컬럼1, 컬럼2, …)
VALUES ('값1', '값2', …);
```

**수정**

```sql
UPDATE 테이블명
SET 컬럼1 = '내용', …
WHERE 조건;
```

**삭제**

```sql
DELETE FROM 테이블명
WHERE 조건;
```

`WHERE` 없이 `DELETE`/`UPDATE` 를 쓰면 **전체 행**이 대상이 될 수 있어, 운영 DB에서는 특히 주의합니다.

---

### DCL — 계정·권한

**권한 부여·회수**와 **DB 사용자 계정** 관리에 쓰입니다. (MySQL 계열 예)

**사용자 생성**

| 의미 | 예시 |
|------|------|
| 같은 서버에서만 접속 (`localhost`) | 첫 번째 문 |
| 호스트를 넓게 허용(환경에 따라 보안 검토) | `'%'` 등 |

```sql
CREATE USER '유저명'@'localhost' IDENTIFIED BY '패스워드';
CREATE USER '유저명'@'%' IDENTIFIED BY '패스워드';
```

**사용자 삭제**

```sql
DROP USER '유저명'@'localhost';
DROP USER '유저명'@'%';
```

> 예전 방식으로 `mysql.user` 를 직접 `DELETE` 하는 코드가 있을 수 있으나, **계정 제거는 `DROP USER` 사용**을 권장합니다.

**권한 부여 (`GRANT`)**

```sql
GRANT SELECT ON db명.* TO '유저명'@'localhost';
GRANT SELECT, INSERT ON db명.테이블명 TO '유저명'@'%';
GRANT ALL PRIVILEGES ON db명.* TO '유저명'@'localhost';
```

**권한 회수 (`REVOKE`)**

```sql
REVOKE SELECT ON db명.* FROM '유저명'@'localhost';
REVOKE ALL PRIVILEGES ON db명.* FROM '유저명'@'%';
```

`db명.*` 의 `*` 는 해당 DB의 **모든 테이블**에 대한 권한 범위로 자주 씁니다.

---

### TCL — 트랜잭션 제어

**트랜잭션**은 하나 이상의 SQL을 **하나의 논리적 작업 단위**로 묶은 것입니다.  
흐름: **`START TRANSACTION`** (또는 `BEGIN`) → SQL 실행 → **`COMMIT`**(확정) 또는 **`ROLLBACK`**(취소).

| 명령 | 역할 |
|------|------|
| `START TRANSACTION` / `BEGIN` | 트랜잭션 시작 |
| `COMMIT` | 변경을 DB에 반영 |
| `ROLLBACK` | 트랜잭션 시작 이후 변경을 되돌림 |

**ACID** — 트랜잭션이 지향하는 네 가지 성질입니다.

| 약자 | 영문 | 요지 |
|------|------|------|
| **A** | Atomicity (원자성) | 포함된 작업이 **전부 적용**되거나 **전부 적용되지 않음** |
| **C** | Consistency (일관성) | 실행 전·후 **무결성·제약** 유지 |
| **I** | Isolation (고립성) | 동시 실행 트랜잭션 간 **중간 결과 간섭**을 격리 수준으로 제어 |
| **D** | Durability (지속성) | `COMMIT` 후 결과는 **장애 후에도 유지** |

---

### 백업·복원 (MySQL CLI)

**`mysqldump`** 로 스키마·데이터를 SQL(또는 XML) 파일로 내보냅니다. **`mysql`** 클라이언트로 다시 넣거나, 클라이언트 안에서 **`SOURCE`** 로 실행합니다.

**덤프 예시**

| 용도 | 명령(개념) |
|------|------------|
| 특정 DB 전체 | `mysqldump -u 계정 -p DB이름 > 파일이름.sql` |
| 모든 DB | `mysqldump -u 계정 -p --all-databases > all_backup.sql` |
| DB 내 테이블 한 개 | `mysqldump -u 계정 -p DB이름 테이블이름 > table_backup.sql` |
| DB 내 테이블 여러 개 | `mysqldump -u 계정 -p -B DB이름 --tables 테이블1 테이블2 > …` |
| 스키마만(데이터 제외) | `mysqldump -u 계정 -p --no-data DB이름 > schema_only.sql` |
| XML 형식 | `mysqldump -u 계정 -p --xml DB이름 > backup.xml` |

```bash
mysqldump -u root -p DB이름 > backup.sql
mysqldump -u root -p --all-databases > all_backup.sql
mysqldump -u root -p DB이름 테이블이름 > table_backup.sql
mysqldump -u root -p -B DB이름 --tables 테이블1 테이블2 > tables_backup.sql
mysqldump -u root -p --no-data DB이름 > schema_only.sql
mysqldump -u root -p --xml DB이름 > backup.xml
```

**자주 쓰는 `mysqldump` 옵션**

| 옵션 | 설명 |
|------|------|
| `--single-transaction` | InnoDB를 **일관된 시점**으로 덤프(통상 긴 락 회피에 유리) |
| `--routines` | 저장 프로시저·함수 포함 |
| `--triggers` | 트리거 포함 |
| `--add-drop-table` | 복원 시 `DROP TABLE` + `CREATE` 가 들어가 기존 테이블을 덮어쓰기 쉬움 |
| `--set-gtid-purged=OFF` | GTID 환경에서 덤프/복제 이슈·경고 완화(정책에 맞게 사용) |

**복원 예시**

```bash
mysql -u root -p DB이름 < backup.sql
mysql -u root -p < all_backup.sql
```

MySQL 클라이언트에 접속한 뒤:

```sql
USE DB이름;
SOURCE /경로/backup.sql;
-- 또는
SOURCE all_backup.sql;
```

> 실제 환경에서는 **`root` 대신 백업 전용 계정**, 경로·패스워드에 **공백·특수문자**가 있으면 셸/인용 규칙을 지키는 것이 안전합니다.

---

## DB 설계 단계

요구사항부터 구현까지 일반적인 흐름입니다.

| 단계 | 설명 |
|------|------|
| 요구사항 분석 | 사용자와 업무 흐름을 이해하고 필요한 데이터를 도출 |
| 개념적 설계 | ER 모델을 사용하여 현실 세계의 객체 및 관계를 추상화 |
| 논리적 설계 | DBMS에 독립적인 논리 모델 작성 (정규화 포함) |
| 물리적 설계 | 실제 DBMS에서의 저장 구조, 인덱스, 파티셔닝 등 정의 |
| 구현 | DBMS에 스키마와 테이블을 생성하고 적용 |

---

## 모델링의 3단계

| 단계 | 모델 | 주요 표현 방식 |
|------|------|----------------|
| 개념적 모델링 | ER 모델 | 엔터티, 속성, 관계 |
| 논리적 모델링 | 관계형 모델 | 테이블, 속성, 키, 정규화 |
| 물리적 모델링 | 물리적 구조 | 저장소, 인덱스, 파티션 등 |

---

## 개념적 설계 — ER 모델

| 용어 | 의미 | 예 |
|------|------|-----|
| **Entity(엔터티)** | 독립적으로 다루는 객체 | 학생, 도서 |
| **Attribute(속성)** | 객체의 특성 | 학번, 이름 |
| **Relationship(관계)** | 엔터티 간 연결 | 학생–수강–과목 |

---

## 정규화

**정규화**는 테이블 구조를 단계적으로 다듬어 **데이터 중복**을 줄이고, **삽입·삭제·갱신 이상**을 완화하는 논리 설계 과정입니다. (실무에서는 보통 **3NF** 또는 **BCNF**까지 적용하는 경우가 많습니다.)

| 이상 | 한 줄 설명 |
|------|------------|
| 삽입 이상 | 원하지 않는 데이터까지 넣어야 하거나, 넣고 싶은 데이터를 넣기 어려움 |
| 삭제 이상 | 한 정보를 지우면 다른 정보까지 함께 사라짐 |
| 갱신 이상 | 같은 의미의 값이 여러 곳에 있어 일부만 바뀌는 불일치 |

| 정규형 | 요지 |
|--------|------|
| **1NF** | 모든 컬럼이 **원자값**(더 쪼갤 수 없는 값)이며, **반복되는 열·그룹**을 제거 |
| **2NF** | **1NF**를 만족하고, **복합 기본키의 일부**에만 의존하는 속성(부분 함수 종속) 제거 |
| **3NF** | **2NF**를 만족하고, **기본키가 아닌 속성**끼리의 이행적 함수 종속 제거 |
| **BCNF** | **결정자**가 항상 **후보키**가 되도록 정리 (3NF보다 엄격한 경우가 있음) |

> 키·함수 종속 해석은 테이블마다 달라지므로, 실제 스키마를 놓고 **어디가 후보키인지**부터 정리하는 것이 좋습니다.

---

## SELECT 실습 요약

예제 SQL 전체는 `SQL_use/01select.sql`, `SQL_use/02select.sql` 을 참고합니다. **JOIN**은 `09join.sql`, **뷰**는 `10view.sql`, **JSON**은 `11json_object.sql`, **피벗·롤업**은 `12pivot.sql`, **저장 프로시저**는 `13PROCEDURE.sql`, **트랜잭션(세이브포인트 등)** 은 `14TRANSACTION.sql`, **예외 처리**는 `15exeption.sql`, **트리거**는 `16TRIGGER.sql`, **INSERT·UPDATE·DELETE·제약**은 `03insert-update-delete.sql`, `04constraint.sql`, **변수·형변환**은 `05type.sql`, **내장 함수**는 `06func.sql`, **BLOB·파일**은 `07updown.sql`, **인덱스**는 `08index.sql` 및 아래 요약을 참고합니다. 아래 SELECT 요약은 **shopdb**(`usertbl`, `buytbl`) 및 일부 **world** DB 기준으로 개념만 묶은 것입니다.

### 준비·메타

| 목적 | 예시 |
|------|------|
| DB 선택 | `USE shopdb;` |
| 테이블 목록 | `SHOW TABLES;` |
| 구조 확인 | `DESC usertbl;` / `DESC buytbl;` |

### 기본 `SELECT`

- **전체/일부 컬럼**: `SELECT * …` / `SELECT userID, birthYear …`
- **별칭**: `컬럼 AS '표시이름'` (한글 라벨 등)
- **문자열 결합**: `CONCAT(mobile1, '-', mobile2) AS '전화번호'`

### `WHERE` — 비교·논리

| 종류 | 예시 개념 |
|------|-----------|
| 동등·대소 | `name = '…'`, `birthYear >= 1970`, `height <= 170` |
| `AND` / `OR` | 여러 조건 결합 |
| 범위 | `height BETWEEN 170 AND 180` (또는 `>=` / `<=` 조합) |
| 집합 | `addr IN ('서울', '경기')` |
| 패턴 | `name LIKE '김%'`, `'%수'`, `'%경%'`, `LIKE '김__'` (`_` 한 글자) |

### 서브쿼리

- **스칼라 비교**: `height > (SELECT height FROM usertbl WHERE name = '…')`
- **`ALL` / `ANY`**: 한 집합 전체·일부와 비교 (예: 키가 경남 지역 행들의 키 **모두** 이상 등)

### 정렬·중복·개수 제한

| 목적 | 핵심 |
|------|------|
| 정렬 | `ORDER BY 컬럼 ASC|DESC`, 다중 키: `ORDER BY height DESC, mDate ASC` |
| 중복 제거 | `SELECT DISTINCT addr …` |
| 행 제한 | `LIMIT n`, `LIMIT offset, count` |

### 테이블 복사·데이터 이전 (MySQL)

| 패턴 | 설명 |
|------|------|
| `CREATE TABLE t (SELECT … FROM 원본 …)` | 구조+데이터 복사(제약은 보통 PK/FK 그대로 안 따라올 수 있음) |
| `CREATE TABLE t LIKE 원본` | **구조만** 복사 |
| `INSERT INTO t SELECT … FROM 원본 …` | 기존 테이블에 데이터만 채움 |

### 집계·`GROUP BY` (`02select.sql`)

| 목적 | 예시 개념 |
|------|-----------|
| 그룹별 합 | `SELECT userID, SUM(amount) … GROUP BY userID` |
| 그룹별 합(금액) | `SUM(amount * price)` |
| 평균·반올림 표시 | `AVG(…)`, `TRUNCATE(AVG(amount*price), 2)` |
| 전체 최소·최대 | `MIN(height)`, `MAX(height)` (서브쿼리와 조합해 “최대 키 행” 조회 등) |
| 그룹별 최소·최대 | `GROUP BY` 와 함께 `MIN`/`MAX` |
| 개수 | `COUNT(컬럼)` 등 |

**다른 DB(`world`)**: `city`에서 `countrycode`별 `population` 합계, `country`에서 `continent`별 `lifeexpectancy` 평균 등 **같은 패턴**으로 `GROUP BY` 를 적용합니다.

### `HAVING` — 그룹 조건 (`02select.sql`)

- **`WHERE`**: 그룹화 **이전** 행 단위로 걸러냅니다.
- **`HAVING`**: `GROUP BY` **이후** 그룹별 집계 결과에 조건을 겁니다. 집계식·그룹 기준 필터는 `HAVING`에 둡니다.

| 목적 | 예시 개념 |
|------|-----------|
| 구매 합계가 일정 값 이상인 사용자만 | `SELECT userid, SUM(amount) '구매총량' FROM buytbl GROUP BY userid HAVING SUM(amount) >= 5` |
| 별칭으로 조건(환경에 따라) | `HAVING 구매총량 >= 5` — MySQL 등에서 SELECT 별칭을 `HAVING` 에서 허용하는 경우가 있음 |

---

## JOIN 실습 요약 (`09join.sql`)

두 개 이상의 테이블을 연결해 하나의 결과 집합으로 만듭니다. 예제는 **shopdb**, **employees**, **world** 등을 사용합니다.

### JOIN 종류(개념)

| 종류 | 요지 |
|------|------|
| **INNER JOIN** | `ON` 조건에 **맞는 행만** 양쪽에서 짝지어 출력 |
| **LEFT OUTER JOIN** | 왼쪽 테이블 **전체** + 오른쪽에서 조건에 맞는 행(없으면 NULL) |
| **RIGHT OUTER JOIN** | 오른쪽 테이블 **전체** + 왼쪽에서 조건에 맞는 행 |
| **FULL OUTER JOIN** | 양쪽 **전체** — **MySQL은 문법 미지원** → `LEFT OUTER JOIN` 결과와 `RIGHT OUTER JOIN` 결과를 **`UNION`** 으로 합쳐서 유사 구현 |
| **CROSS JOIN** | 조건 없이 행끼리 **모든 조합** |
| **SELF JOIN** | 같은 테이블을 두 번 붙여 조인 |

### `INNER JOIN` 패턴 (shopdb)

- **연결**: `FROM usertbl … INNER JOIN buytbl … ON usertbl.userid = buytbl.userID`
- **컬럼 선택**: 필요한 열만 나열하거나 `SELECT *`
- **별칭**: `FROM usertbl U INNER JOIN buytbl B ON U.userid = B.userID` 로 짧게 씀
- **`WHERE`**: 조인 뒤에 `WHERE amount >= 5` 등으로 추가 필터
- **`GROUP BY` / `HAVING` / `ORDER BY`**: 예) 지역(`addr`)별 `SUM(amount)` 후 `HAVING`·`ORDER BY` 로 집계 순서 정리

### `OUTER JOIN` · FULL 유사

- **LEFT**: `FROM usertbl U LEFT OUTER JOIN buytbl B ON U.userID = B.userID`
- **RIGHT**: 기준 테이블을 오른쪽에 두고 동일한 `ON` 조건으로 짝을 맞춤
- **FULL(유사)**: 위 LEFT 결과 `UNION` 위 RIGHT 결과(실습 스크립트의 패턴 참고)

### 다중 조인 (employees)

- `salaries`, `employees`, `dept_emp`, `departments` 를 `emp_no`·`dept_no` 등으로 **연쇄 INNER JOIN** 하여 사원명·급여·부서명 등을 한 번에 조회합니다.

### `world` DB 예제

- `country` · `city` · `countrylanguage` 를 `CountryCode` 등으로 조인해 국가명·도시명·지역·인구·수도·언어 등을 정렬(`ORDER BY population` 등)해 출력합니다.

---

## VIEW 실습 요약 (`10view.sql`)

**뷰(VIEW)** 는 저장된 SELECT를 이름 붙인 **가상 테이블**입니다. 복잡한 쿼리를 재사용하거나, 노출 컬럼을 제한할 때 쓰입니다.

### 생성·갱신

```sql
CREATE OR REPLACE VIEW 뷰이름
AS
SELECT … ;
```

### 확인

| 목적 | 예시 |
|------|------|
| 정의 확인 | `SHOW CREATE VIEW 뷰이름;` |
| 메타 조회 | `SELECT * FROM information_schema.views WHERE table_schema = '스키마명';` |
| 구조 | `DESC 뷰이름;` |
| 조회 | `SELECT * FROM 뷰이름;` |

### 실습에 나온 뷰 개념

| 예 | 내용 |
|----|------|
| 단일 테이블 | `usertbl`에서 `userid`, `name`, `addr`, `CONCAT(mobile1,'-',mobile2)` 등만 노출 |
| `WHERE` 포함 | 특정 지역(`addr IN ('서울','경기')`)만 필터한 뷰 |
| 조인 뷰 | `usertbl`과 `buytbl`을 `INNER JOIN` 한 결과를 뷰로 고정 |
| `world` | `country`·`city`·`countrylanguage` 조인 + `ORDER BY` 가 들어간 뷰(스크립트에서 DB 접두 등 환경에 맞게 기술) |

### `INSERT` 와 뷰

- **조인으로 만든 뷰**에는 원칙적으로 **`INSERT` 가 어렵거나 불가**한 경우가 많습니다(어느 기본 테이블에 넣을지 모호).
- **단일 테이블**을 바탕으로 한 뷰는 제약·키가 맞으면 `INSERT` 가 가능한 경우가 있습니다.
- 실습(`testdb`의 `tbl_a`, `tbl_b`, `view_a_b`)에서는 조인 뷰에 대한 `INSERT` 시도로 **제한**을 확인합니다.

---

## JSON (`11json_object.sql`)

MySQL **JSON** 타입·함수로 객체를 만들고, 경로(`$…`)로 읽고·검색합니다. 예제는 **shopdb**·변수·`tbl_json` 등을 사용합니다.

### 생성·검증

| 목적 | 예시 개념 |
|------|-----------|
| 객체 생성 | `JSON_OBJECT('키',값,'키2',값2,…)` |
| 문자열을 JSON으로 | 작은따옴표로 감싼 JSON 문자열을 컬럼·변수에 저장 |
| 유효성 | `JSON_VALID(표현식)` |

### 조회·변경

| 함수 | 용도 |
|------|------|
| `JSON_EXTRACT(json, '$.경로')` | `$.배열[인덱스].필드`, `$.배열[*].필드` 등 JSON Path |
| `JSON_SEARCH(json,'one'|'all', 검색문자열, …)` | 값 위치 탐색(와일드카드 `%` 등) |
| `JSON_INSERT` / `JSON_REPLACE` / `JSON_REMOVE` | 경로에 삽입·치환·제거 |

### 테이블

- `CREATE TABLE … ( … json_data JSON NOT NULL … )` 에 JSON 문자열 또는 `JSON_OBJECT(…)` 결과를 `INSERT` 합니다.
- 배열·오픈데이터 형태의 큰 JSON에서는 `JSON_SEARCH`·`JSON_EXTRACT` 조합으로 특정 필드만 뽑는 연습이 나옵니다.

---

## 피벗·`ROLLUP` (`12pivot.sql`)

**행을 열로 펼치는** 집계(피벗)와 **`WITH ROLLUP`** 으로 소계·총계 행을 붙이는 패턴입니다. **shopdb**의 `buytbl`, `usertbl` 기준입니다.

### 조건부 합·개수

| 패턴 | 설명 |
|------|------|
| `SUM(IF(조건, 값, 0))` | 카테고리(상품명·`groupname` 등)별로 열 하나씩 합산 |
| `COUNT(CASE WHEN 조건 THEN 1 END)` | 지역(`addr`) 등 값별 건수를 열로 펼침 |

### `GROUP BY … WITH ROLLUP`

- 그룹별 소계와 **전체 합**을 한 결과에 포함합니다(실습: `userid`별 집계 + 하위 총계 행).
- 피벗 결과를 **`CREATE OR REPLACE VIEW view_pivot_buytbl AS …`** 로 고정해 두는 예가 있습니다.

> NULL 비교는 SQL에서 `컬럼 IS NULL` 이 맞습니다. 스크립트에 `groupname = null` 형태가 있으면 의도와 다르게 동작할 수 있어 수정이 필요할 수 있습니다.

---

## 저장 프로시저 (`13PROCEDURE.sql`)

**저장 프로시저**는 서버에 저장된 SQL 묶음입니다. MySQL에서는 `CALL 프로시저명(인자…);` 로 실행합니다.

### 생성·호출(개념)

```sql
DELIMITER $$
CREATE PROCEDURE 이름(IN 파라미터 타입, …)
BEGIN
  DECLARE 변수 타입;
  SET 변수 = 값;
  -- IF / CASE / WHILE 등
  SELECT … ;
END $$
DELIMITER ;

CALL 이름(값);
```

### 실습에 나온 내용

| 주제 | 요지 |
|------|------|
| 메타 | `SHOW PROCEDURE STATUS WHERE db = 'shopdb';` |
| 분기 | `IF … THEN … ELSE … END IF` |
| 조회 조건 인자화 | `WHERE amount >= IN 파라미터` 등 |
| 날짜·나이 | `CURDATE()`, `DATEDIFF`, `TO_DAYS`, `DATE(CONCAT(birthyear,'-01-01'))`, `FLOOR`/`CEIL` |
| 등급 | `CASE WHEN amount >= … THEN 'VIP' … END` 를 인자로 임계값 조절 |
| 반복 | `WHILE … DO … END WHILE` (예: 1~10 합, `HELLO WORLD` 반복 출력) |

함수(`FUNCTION`)와의 차이는 **항상 스칼라 반환 여부**, **호출 문맥** 등으로 정리할 수 있으나, 제품·버전별 규칙이 있으니 매뉴얼과 병행합니다.

---

## 트랜잭션 심화 (`14TRANSACTION.sql`)

문서 앞부분 **TCL**(`COMMIT` / `ROLLBACK`)에 더해, **세이브포인트**와 **프로시저 안에서의 예외 시 롤백**이 실습됩니다.

### `SAVEPOINT` · `ROLLBACK TO`

- `START TRANSACTION` (또는 `BEGIN`) 후 `SAVEPOINT 이름;` 으로 지점을 찍습니다.
- `ROLLBACK TO 이름;` 으로 그 시점까지의 변경만 취소할 수 있습니다(실습에서 `s1`·`s2`·`s3` 체인).
- `RELEASE SAVEPOINT` 는 환경·문맥에 따라 트랜잭션 종료 방식과 함께 확인합니다.

### 프로시저 + 오류 시 롤백

- `DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN … ROLLBACK; END` 처럼 **예외 시 롤백**을 묶을 수 있습니다.
- `SHOW ERRORS` 로 진단 메시지를 확인하는 패턴이 나옵니다.

---

## 예외 처리 (`15exeption.sql`)

저장 프로시저 안에서 **에러 코드** 또는 **`SQLEXCEPTION`** 을 잡아 흐름을 이어 가거나, 로그 테이블에 남깁니다.

### 핸들러

| 패턴 | 설명 |
|------|------|
| `DECLARE CONTINUE HANDLER FOR 오류번호 …` | 해당 오류 발생 시에도 다음 문 실행을 계속(메시지 `SELECT` 등) |
| `DECLARE CONTINUE HANDLER FOR SQLEXCEPTION …` | 광범위 예외 처리 |
| `DECLARE EXIT HANDLER FOR SQLEXCEPTION …` | 핸들러 실행 후 **프로시저 종료**(실습: `ROLLBACK` 과 함께) |

### 진단·로그

- `SHOW ERRORS;` 로 스택 확인.
- `GET DIAGNOSTICS CONDITION 1 … MYSQL_ERRNO`, `MESSAGE_TEXT` 로 코드·메시지를 변수에 담아 **`tbl_std_errlog`** 등에 `INSERT` 합니다.
- PK 중복(예: `1062`), 잘못된 데이터(예: `1265`) 등 **코드별 분기** 예가 있습니다.

---

## 트리거 (`16TRIGGER.sql`)

**트리거**는 특정 테이블에 `INSERT` / `UPDATE` / `DELETE` 가 일어날 때 **자동 실행**되는 프로시저입니다. 실습은 **shopdb**의 복사 테이블 `c_usertbl`·백업 `c_usertbl_bak` 을 사용합니다.

### 정의(개념)

```sql
DELIMITER $$
CREATE TRIGGER 이름
AFTER UPDATE  -- 또는 AFTER DELETE 등
ON 원본테이블
FOR EACH ROW
BEGIN
  INSERT INTO 백업 … VALUES (OLD.컬럼, …, '수정' 또는 '삭제', NOW());
END $$
DELIMITER ;
```

- **`OLD`**: 변경·삭제 **이전** 행 값(실습에서 `UPDATE`/`DELETE` 직후 백업에 기록).
- **확인**: `SHOW TRIGGERS;`, `SHOW CREATE TRIGGER 이름;`

스크립트 말미에는 `buytbl` 복사본에 대한 **같은 패턴의 과제**가 제시되어 있습니다.

---

## INSERT·UPDATE·DELETE 실습 요약 (`03insert-update-delete.sql`)

예제 SQL 전체는 `SQL_use/03insert-update-delete.sql` 을 참고합니다. (스크립트 일부는 주석 처리되어 있으므로, 실행 시 주석을 해제해 순서대로 시도합니다.)

### `DELETE`

- `DELETE FROM 테이블명;` — `WHERE` 없이 실행하면 **전체 행**이 대상이 될 수 있어 운영 DB에서는 특히 주의합니다.

### `INSERT` 패턴 (MySQL)

| 패턴 | 설명 |
|------|------|
| 여러 행 한 번에 | `INSERT INTO 테이블 VALUES (…), (…), (…);` |
| PK(또는 유니크) 중복 시 **행 무시** | `INSERT IGNORE INTO …` — 충돌 나는 행은 삽입하지 않고 넘어감 |
| 자동 번호 | `AUTO_INCREMENT` 가 걸린 컬럼에 `NULL`(또는 생략 규칙에 맞게) 넣어 연속 번호 부여 |
| 중복 시 **갱신**(업서트) | `INSERT INTO … VALUES … ON DUPLICATE KEY UPDATE 컬럼 = 표현식;` — PK/유니크 충돌 시 `UPDATE` 절 실행 (예: `amount = amount + 1`) |

### `AUTO_INCREMENT` 확인·조정

| 목적 | 예시 개념 |
|------|-----------|
| 다음 증가값 조회 | `information_schema.tables` 에서 `AUTO_INCREMENT` (스키마·테이블명 조건) |
| 방금 넣은 자동값 | `SELECT LAST_INSERT_ID();` |
| 기준값 변경 | `ALTER TABLE … AUTO_INCREMENT = n;` (데이터·스토리지 상태에 따라 기대와 다를 수 있어 문서·환경 확인) |

---

## 제약 조건 실습 요약 (`04constraint.sql`)

예제 SQL 전체는 `SQL_use/04constraint.sql` 을 참고합니다.

### 기본키(PK)

| 방법 | 예시 개념 |
|------|-----------|
| 컬럼 정의에 직접 | `id … PRIMARY KEY` |
| 테이블 제약으로 단일·복합 | `PRIMARY KEY (id)` / `PRIMARY KEY (id, name)` |
| 나중에 추가 | `ALTER TABLE … ADD CONSTRAINT 이름 PRIMARY KEY (컬럼…);` |
| 제거 | `ALTER TABLE … DROP PRIMARY KEY;` |

- 복사본 테이블(`CREATE TABLE … SELECT …`)에 데이터를 넣은 뒤 `num` 등에 **이름 붙인 PK**(`PK_num` 등)를 거는 패턴이 나옵니다.
- 메타 확인: `DESC`, `SHOW CREATE TABLE`, `information_schema.columns` 의 `COLUMN_KEY` 등.

### 외래키(FK)

| 방법 | 예시 개념 |
|------|-----------|
| 생성 시 | `CONSTRAINT FK_이름 FOREIGN KEY (자식컬럼) REFERENCES 부모테이블(부모컬럼)` |
| 복합 FK | `FOREIGN KEY (id, name) REFERENCES 부모(id, name)` |
| 나중에 추가 | `ALTER TABLE … ADD CONSTRAINT … FOREIGN KEY … REFERENCES …` |

**참조 시 `ON UPDATE` / `ON DELETE` 옵션**(개념 정리 — 제품·버전별 세부는 매뉴얼 확인):

| 옵션 | 요지 |
|------|------|
| `CASCADE` | 부모 쪽 PK 값 변경·행 삭제가 자식 FK에 **연쇄 반영** |
| `RESTRICT` / `NO ACTION` | 참조가 있으면 부모 삭제·갱신을 **막는** 쪽(엔진에서 동작 차이가 있을 수 있음) |
| `SET NULL` | 부모 변경 시 자식 FK를 **NULL** 로 |
| `SET DEFAULT` | 지정된 **기본값**으로 |

- 정의 확인: `information_schema.referential_constraints`, `SHOW CREATE TABLE` 등.

### FK 제거·인덱스(MySQL)

- `ALTER TABLE … DROP FOREIGN KEY 제약이름;`
- FK에는 보통 **인덱스**가 함께 생성됩니다. 필요 시 `DROP INDEX` (예시에서는 FK와 연관된 인덱스명 처리).
- `SHOW INDEX FROM 테이블;`

### 테이블 삭제 순서·외래키 검사 끄기

- **자식(FK가 있는 쪽) 테이블을 먼저** `DROP` 하고, 참조되는 **부모**를 나중에 삭제하는 것이 일반적입니다.
- 개발·데이터 정리 시에만: `SET FOREIGN_KEY_CHECKS = 0;` … `DROP TABLE …;` … `SET FOREIGN_KEY_CHECKS = 1;` 로 순서를 바꿀 수 있으나, **운영에서는 오용 시 무결성이 깨지므로** 매우 주의합니다.

### 예시: `copy_buytbl`

- `buytbl` 복사 후 `num`에 PK, `userID` → `usertbl(userID)` FK 를 두고, `ON UPDATE CASCADE`, `ON DELETE RESTRICT` 등으로 규칙을 맞춥니다.

---

## 변수·형변환 (`05type.sql`)

예제 SQL 전체는 `SQL_use/05type.sql` 을 참고합니다.

### 사용자 변수(MySQL)

- `SET @이름 = 값;` — 세션 동안 쓰는 **사용자 변수** (`@var1` 등).
- `SELECT` 절에서 `@변수`와 컬럼을 함께 쓰거나, `@var1 + @var2` 처럼 연산할 수 있습니다.

### 준비된 문(`PREPARE` / `EXECUTE`)

- 문자열로 SQL을 만들고 `PREPARE 이름 FROM '…'` → `EXECUTE 이름 USING @변수` 로 플레이스홀더(`?`)에 값을 넣는 패턴이 나옵니다. (예: `ORDER BY … LIMIT ?`)

### 형변환

| 구분 | 설명 |
|------|------|
| 암시적(자동) | 연산 시 DB가 타입을 맞춤(데이터 손실을 줄이는 쪽으로 동작하는 경우가 많음) |
| 명시적(강제) | `CAST(값 AS 타입)` 등으로 개발자가 지정(목적에 따라 손실 가능) |

- 날짜 문자열: `CAST('2024$01$01' AS DATE)` 처럼 구분 문자가 달라도 날짜로 해석되는 경우가 있습니다(환경·형식에 따름).
- `CONCAT` 전에 `CAST(price AS CHAR(10))` 등으로 숫자를 문자열로 맞추는 예가 나옵니다.

### 숫자·문자 연산(참고)

- `'100' + 200` 처럼 **숫자로 읽히는 앞부분**만 더해지는 등 MySQL의 변환 규칙이 적용됩니다.
- 비교 결과는 **참 1 / 거짓 0** 으로 나오는 형태로 쓸 수 있습니다.

---

## 내장 함수 (`06func.sql`)

예제 SQL 전체는 `SQL_use/06func.sql` 을 참고합니다.

### 문자열

| 함수 | 용도 |
|------|------|
| `CONCAT(…)` | 여러 값을 이어 붙임 |
| `CONCAT_WS(구분자, …)` | 구분자로 연결 |
| `SUBSTRING(str, 시작)` / `SUBSTRING(str, 시작, 길이)` | 부분 문자열 |
| `SUBSTRING_INDEX(str, 구분자, n)` | 구분자 기준 n번째까지(예: 날짜에서 `'-'` 기준 앞부분) |
| `LENGTH(…)` | 바이트 길이(문자셋에 따라 문자 “개수”와 다를 수 있음) |
| `TRIM(…)` | 앞뒤 공백 제거 |
| `LOWER` / `UPPER` | 대소문자 변환 |

- 예: `bin(숫자)` — 이진 표기 확인 등(교육·디버그용으로 자주 나옵니다).

### 날짜·시간

| 함수 | 용도 |
|------|------|
| `YEAR` / `MONTH` / `DAY` | 날짜 컬럼에서 연·월·일 추출 |
| `NOW()` | 현재 일시 |
| `CURDATE()`, `CURTIME()` | 오늘 날짜, 현재 시각 |
| `DATE(…)`, `TIME(…)` | 일시에서 날짜·시각만 추출 |

- `REPLACE` 로 날짜·시간 구분 문자를 바꾼 뒤 `CONCAT` 으로 원하는 포맷(예: `YYYY#MM#DD` 와 `hh|mm|ss` 결합)을 만드는 예가 있습니다.

---

## BLOB·파일 입출력 (`07updown.sql`)

예제 SQL 전체는 `SQL_use/07updown.sql` 을 참고합니다. (`testdb` 등 별도 DB·경로는 환경에 맞게 수정합니다.)

### 테이블 예

- `LONG BLOB` 컬럼에 **파일 바이너리**를 넣는 형태입니다.

### 서버에서 파일 읽기 → DB에 넣기

- `INSERT INTO … VALUES ('제목', LOAD_FILE('경로'));` — 서버가 접근 가능한 경로의 파일을 읽어 저장합니다.
- Windows 경로는 `c:\\sql\\파일명` 처럼 **이스케이프**하거나 슬래시를 쓰는 식으로 맞춥니다.
- `LOAD_FILE` 은 **권한·secure_file_priv·경로** 제약이 있어 실패하면 서버 설정을 확인합니다.

### DB에서 파일로 내보내기

- `SELECT blob컬럼 FROM … WHERE … INTO DUMPFILE '경로';` — **단일 행** 결과를 바이너리로 파일에 씁니다.
- `INTO OUTFILE` 과 용도가 다릅니다(텍스트 내보내기 등). 보안·권한·경로 정책을 반드시 확인합니다.

---

## 인덱스 (`08index.sql`)

예제 SQL 전체는 `SQL_use/08index.sql` 을 참고합니다.

### 목적

- **`WHERE`** 등 조건에 자주 쓰는 열에 인덱스를 두면 **검색·조인 비용**을 줄이는 경우가 많습니다. (항상 빨라지는 것은 아니며, 쓰기·저장 비용은 늘 수 있습니다.)

### MySQL에서 자주 언급되는 유형(개념)

| 유형 | 요지 |
|------|------|
| B-Tree | InnoDB 등에서 **기본**에 가깝게 쓰이는 범용 인덱스 |
| Hash | **동등 비교**에 유리한 경우(범위·LIKE 등은 부적합할 수 있음) |
| Full-text | 텍스트 **전문 검색** |
| Spatial | 공간(위치) 데이터 |

### 클러스터형 vs 보조(보통 InnoDB 맥락)

- **PK(클러스터형 인덱스)**: 테이블당 **하나**, 데이터 정렬·저장과 연관되는 방식으로 이해하면 됩니다.
- **보조 인덱스**: PK 외 컬럼·유니크·수동 생성 인덱스 등, **여러 개** 둘 수 있습니다.

### 제약과 인덱스

- **PK**, **`UNIQUE`** 를 걸면 보통 **유니크 인덱스**가 함께 생성됩니다. `SHOW INDEX FROM 테이블;` 로 확인합니다.

### 생성·삭제

| 작업 | 예시 개념 |
|------|-----------|
| 유니크(단일·복합) | `UNIQUE INDEX 이름 (col)` / `UNIQUE INDEX 이름 (col2, col3)` |
| 일반 보조 | `CREATE INDEX 이름 ON 테이블(컬럼);` |
| PK 제거 | `ALTER TABLE … DROP PRIMARY KEY;` |
| 인덱스 제거 | `ALTER TABLE … DROP INDEX 인덱스명;` (유니크 제약 이름과 인덱스명이 같은 경우가 많음) |

> MySQL 버전에 따라 `DROP CONSTRAINT` 로 유니크를 제거하는 문법이 다를 수 있어, **해당 버전 매뉴얼**과 `SHOW CREATE TABLE` 결과를 병행합니다.

### FK와 인덱스

- FK를 걸면 **참조 열에 인덱스가 생기는** 경우가 많습니다. `SHOW INDEX` 로 함께 확인합니다.

### 성능 확인 예(`employees`)

- 큰 테이블(`salaries` 등)에서 특정 날짜(`to_date`)로 조회할 때 **인덱스 생성 전후**를 비교하는 예가 나옵니다. 실제 효과는 데이터 분포·쿼리 패턴에 따라 다릅니다.