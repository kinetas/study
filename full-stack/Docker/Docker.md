# Docker 학습 정리

실습은 `00_INIT → 01_IMAGES → 02_CONTAINER → 03_COMPOSE → 04_DOCKER_COMPOSE_DEPLOY` 순서로 단계를 올려가며 진행.
구성: `BN`(Spring Boot 백엔드), `DB`(MySQL), `REDIS`, `fn`(React 프론트), `JENKINS`(CI/CD).

---

## 00_INIT — Dockerfile 기초

- `FROM node:18` : 베이스 이미지 지정
- `WORKDIR /app` : 이후 명령의 기준 디렉토리
- `COPY package*.json ./` → `RUN npm install` → `COPY . .` 순서로 레이어를 나눠서
  **의존성 설치 레이어를 캐싱**하는 게 핵심 (소스만 바뀌면 npm install 레이어는 재사용됨)
- `CMD ["npm","start"]` : 컨테이너 시작 시 실행되는 기본 명령

## 01_IMAGES — 서비스별 이미지 빌드

각 서비스(BN/DB/REDIS/fn)를 독립된 이미지로 빌드하는 단계.

- **BN (Spring Boot)**: 멀티스테이지 빌드
  - 1단계 `gradle:8.14.1-jdk21` 이미지에서 `gradle build --no-daemon -x test`로 jar 생성
  - 2단계 `eclipse-temurin:21-jdk-alpine`(실행 전용, 가벼움)에 jar만 복사 → `EXPOSE 8080` → `java -jar app.jar`
  - → **빌드 도구와 실행 환경을 분리**해서 최종 이미지 용량을 줄이는 패턴
- **fn (React)**: 멀티스테이지 빌드
  - 1단계 `node:20-alpine`에서 `npm install` → `npm run build`
  - 2단계 `nginx:alpine`에 빌드 산출물(`/app/build`)만 복사해서 정적 파일 서빙
- **DB**: `mysql:8.0` 기반, `ENV`로 `MYSQL_ROOT_PASSWORD`/`MYSQL_DATABASE`/`MYSQL_USER`/`MYSQL_PASSWORD` 하드코딩, `EXPOSE 3306`
- **REDIS**: `redis:latest` 기반, `EXPOSE 6479`(실제 리스닝 포트 6379와 다름 — 이후 단계에서 정리 필요)
- **문제점**: 이 단계에서는 각 컨테이너를 따로 `docker run`으로 띄우기 때문에 서로를 모름.
  BN의 `application.properties`/`DataSourceConfig`가 `localhost:3306`, `redis.host=localhost`로 하드코딩되어 있으면
  컨테이너 안에서는 자기 자신만 가리켜서 DB/Redis 연결 실패 → **컨테이너 간 통신은 `localhost`가 아니라 네트워크로 묶어야 한다**는 걸 확인.

## 02_CONTAINER — 컨테이너 연결 (docker network)

- 커스텀 브릿지 네트워크에 각 컨테이너를 올리고, **컨테이너 이름을 호스트명으로 사용**해서 통신
  - `spring.redis.host=localhost` → `redis-container`
  - `spring.datasource.url=jdbc:mysql://localhost:3306/...` → `jdbc:mysql://db-container:3306/bookdb`
- `DataSourceConfig.java`를 하드코딩 대신 `@Value("${spring.datasource.*}")`로 바꿔서
  설정값을 코드가 아니라 `application.properties`(나중엔 환경변수)에서 주입받도록 리팩터링
- BN Dockerfile에 `RUN apk add --no-cache curl` 추가 → **헬스체크(`curl`)를 컨테이너 안에서 실행하려면 이미지에 curl이 있어야 함**
- **fn/nginx**: React를 그냥 정적 서빙만 하지 않고, `nginx.conf`로 리버스 프록시 구성
  - `location /bn/ { proxy_pass http://bn-container:8080/; ... }` : `/bn/` 요청을 백엔드 컨테이너로 전달
  - `location / { try_files $uri /index.html; }` : SPA 라우팅 (파일 없으면 index.html로 폴백)
  - `proxy_set_header`로 `Host`, `X-Real-IP`, `X-Forwarded-For`, `X-Forwarded-Proto` 전달 → 백엔드에서 원 요청 정보 인식 가능
  - 프론트의 `.env`도 `REACT_APP_API_URL=http://bn-container:8080` (컨테이너명 직접 호출) 대신
    `REACT_APP_API_URL=/bn` (같은 nginx가 프록시) 로 변경 → **브라우저는 컨테이너 이름을 모르기 때문에**,
    프론트에서 백엔드를 직접 호출하지 않고 자신을 서빙하는 nginx를 통해 프록시하는 구조로 전환

## 03_COMPOSE — docker-compose로 오케스트레이션

- 여러 개의 `docker run` 명령을 `docker-compose.yml` 하나로 통합
- **커스텀 네트워크 + 고정 IP** 부여
  ```yaml
  networks:
    custom-network:
      driver: bridge
      ipam:
        config:
          - subnet: 172.30.0.0/24
            gateway: 172.30.0.1
  ```
  서비스별로 `ipv4_address`를 지정(db: .10, redis: .20, fn: .30, bn: .40)
- **healthcheck + depends_on(condition)** 으로 기동 순서 제어
  - db: `mysqladmin ping`으로 헬스체크
  - bn: `curl -f http://127.0.0.1:8080/actuator/health`로 헬스체크, `depends_on: db: condition: service_healthy`
  - fn: `depends_on: bn: condition: service_healthy`
  - → 단순 `depends_on`(컨테이너 시작 순서)만으로는 부족하고, **서비스가 "완전히 준비된 상태"까지 기다려야** 뒤 서비스가 정상 동작 (예: DB가 뜨기 전에 BN이 붙으면 연결 실패)
- **volumes**: `db-data:/var/lib/mysql` 로 DB 데이터를 named volume에 영속화 (컨테이너 삭제해도 데이터 유지)
- **환경변수로 설정 오버라이드**: `docker-compose.yml`의 `environment`에 적은 값이
  이미지 안 `application.properties`보다 **우선 적용**됨
  - Spring Boot의 relaxed binding 규칙: `SPRING_DATASOURCE_URL` (환경변수, 대문자+언더스코어) ↔ `spring.datasource.url` (properties 키) 로 자동 매핑
  - 그래서 이미지를 다시 빌드하지 않고도 compose 파일만 바꿔서 DB 접속 정보를 바꿀 수 있음
- `actuator/health` 엔드포인트를 헬스체크 대상으로 쓰려면 BN 쪽에 Spring Boot Actuator 의존성/설정이 필요 (`management.endpoint.health` 노출 확인 필요)

## 04_DOCKER_COMPOSE_DEPLOY — 배포용 compose 분리 + Jenkins CI/CD

03_COMPOSE의 4개 서비스(db/redis/bn/fn) 구성은 그대로 두고, **compose 파일을 용도별로 분리**하고 **Jenkins 컨테이너를 추가**해서 CI/CD까지 붙인 단계.

- **compose 파일 2개로 분리**
  - `docker-compose.yml` : db/redis/bn/fn 만 — 실제 배포(운영) 대상
  - `docker-compose-local.yml` : 위 4개 + `jenkins` 서비스 — 로컬에서 CI/CD 파이프라인까지 함께 띄워서 검증
- **JENKINS 서비스** (`docker-compose-local.yml`)
  ```yaml
  jenkins:
    image: jenkins
    build:
      context: ./JENKINS
    container_name: jenkins-container
    ports:
      - "9090:8080"
      - "50000:50000"
    volumes:
      - jenkins-data:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
    networks:
      - custom-network
  ```
  - `9090:8080` : Jenkins 웹 UI (호스트의 8080은 BN이 이미 쓰고 있어서 9090으로 매핑)
  - `50000:50000` : Jenkins 에이전트(빌드 노드) 연결용 포트
  - `jenkins-data:/var/jenkins_home` : Jenkins 설정/빌드 이력을 named volume에 영속화
  - `/var/run/docker.sock:/var/run/docker.sock` : **호스트의 Docker 데몬 소켓을 그대로 마운트** → Jenkins 컨테이너 안에서 `docker build`/`docker run`을 실행하면 컨테이너 안이 아니라 **호스트의 Docker에 직접 명령**이 전달됨 (Docker-outside-of-Docker 방식). 컨테이너 안에 별도로 Docker 데몬을 새로 띄우는 것보다 가볍지만, 호스트 Docker 제어권을 컨테이너에 넘겨주는 것이라 권한 범위에 주의 필요
- **JENKINS Dockerfile**
  ```dockerfile
  FROM jenkins/jenkins:lts
  USER root
  RUN apt-get update && apt-get -y install --no-install-recommends \
      curl unzip gnupg ca-certificates && rm -rf /var/lib/apt/lists/*
  RUN curl -fsSL https://get.docker.com | sh   # Docker CLI 설치
  RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
      && unzip awscliv2.zip && ./aws/install && rm -rf awscliv2.zip aws  # AWS CLI 설치
  USER jenkins
  ```
  - 공식 `jenkins/jenkins:lts` 이미지에는 Docker CLI가 없어서, 빌드 파이프라인에서 `docker build`/`docker push`를 실행하려면 **CLI를 따로 설치**해야 함 (데몬은 호스트 소켓 마운트로 이미 확보되어 있으니 CLI만 있으면 됨)
  - AWS CLI까지 설치 → 빌드된 이미지/아티팩트를 AWS(ECR, S3, EC2 등)로 배포하는 파이프라인을 염두에 둔 구성
  - 설치 단계에서만 `root`가 필요하고, 실제 실행은 다시 `jenkins` 유저로 복귀 (권한 최소화)
- **BN `application.properties`에 컨테이너 호스트명을 기본값으로 미리 반영**
  ```properties
  spring.redis.host=redis-container
  spring.datasource.url=jdbc:mysql://db-container:3306/testdb
  ```
  - 02_CONTAINER 때는 `@Value`로 외부 주입만 받고 기본값은 그대로였는데, 이 단계부터는 **이미지 자체의 기본 설정도 컨테이너 이름 기준으로 정리** → compose의 `environment` 오버라이드가 없어도 같은 네트워크 안에서는 바로 동작
  - DB 이름도 `testdb`/`dbconn`으로 compose와 통일 (03 단계에서 `bookdb`/`root`로 남아있던 불일치를 정리함)
- **FN 배포 대상 정리**: `.env`에 로컬용 `/bn`(nginx 프록시 경로) 값과 함께, 실제 EC2 배포 주소(`http://<EC2-IP>:8080`)를 주석으로 남겨서 로컬/배포 전환 지점을 표시

### 핵심 포인트

| 항목 | 설명 |
|---|---|
| compose 파일 분리 (`-local` suffix) | 운영에 필요 없는 CI/CD 도구(Jenkins)는 배포용 compose에서 빼고, 로컬 검증용 compose에만 포함 |
| `docker.sock` 마운트 | 컨테이너 안에서 호스트 Docker를 직접 제어(Docker-outside-of-Docker) → Jenkins가 이미지를 빌드/배포하는 파이프라인 구현 가능 |
| Jenkins 이미지에 Docker CLI + AWS CLI 설치 | CI 컨테이너 자체가 "빌드 후 클라우드로 배포"까지 수행할 수 있는 도구를 갖추도록 구성 |
| `application.properties` 기본값 정리 | 배포 단계에서는 환경변수 오버라이드에만 의존하지 않고, 이미지 기본 설정 자체를 컨테이너 네트워크 기준으로 맞춰서 설정 불일치 여지를 줄임 |

---

## 남은 이슈 / 다음에 볼 것

- DB Dockerfile의 비밀번호, OAuth client-id/secret 등이 소스에 그대로 커밋되어 있음
  → `.env` + `docker-compose.yml`의 `env_file`/`environment`로 분리하고 `.gitignore` 처리 필요
- REDIS Dockerfile `EXPOSE 6479`가 실제 redis 리스닝 포트(6379)와 불일치 — compose에서는 `6380:6379`로 맞게 매핑되어 있어 동작엔 문제 없지만 Dockerfile 자체는 오타로 보임 (04 단계 REDIS Dockerfile은 `EXPOSE 6379`로 수정됨)
- `docker.sock`을 Jenkins 컨테이너에 그대로 마운트하는 방식은 편리하지만 사실상 호스트 루트 권한과 다름없음 → 운영 반영 전에 권한 분리(예: rootless docker, 별도 빌드 에이전트) 검토 필요
- 아직 Jenkinsfile/파이프라인 스크립트가 저장소에 없음 → Jenkins UI에서 수동 구성 중이라면 다음 단계에서 파이프라인 코드화(Jenkinsfile) 필요
