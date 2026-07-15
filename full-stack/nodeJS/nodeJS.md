# Node.js 전반적인 정리

Node.js는 웹 브라우저 외의 환경, 즉 서버 측에서 JavaScript를 실행할 수 있게 해주는 **오픈 소스 서버 환경(Runtime Environment)** 입니다.  
구글의 V8 JavaScript 엔진을 기반으로 구축되었으며, 특히 높은 처리 성능과 확장성을 요구하는 데이터 집약적인 실시간 애플리케이션 개발에 매우 효과적입니다.

---

## 1. Node.js의 주요 특징

| 특징 | 설명 |
|------|------|
| 자바스크립트 런타임 | 브라우저 밖(주로 서버)에서 자바스크립트를 실행할 수 있게 해줍니다. |
| V8 엔진 사용 | Google Chrome에 사용되는 고성능 V8 엔진을 기반으로 하여 빠른 실행 속도를 제공합니다. |
| 비동기 I/O (Non-blocking I/O) | I/O 작업이 진행되는 동안 다른 작업을 처리할 수 있어, 대규모 동시 요청 처리에 유리합니다. |
| 단일 스레드 + 이벤트 루프 | 하나의 스레드를 사용하지만, 이벤트 루프(Event Loop) 메커니즘을 통해 비동기 작업을 효율적으로 처리합니다. |
| NPM (Node Package Manager) | 세계에서 가장 큰 오픈 소스 라이브러리 생태계 중 하나로, 방대한 모듈을 제공하여 개발 생산성을 높입니다. |
| 내장 HTTP 서버 라이브러리 | 별도의 웹 서버 소프트웨어(Apache, Nginx 등) 없이도 웹 서버를 자체적으로 구축하고 실행할 수 있습니다. |

---

## 2. Node.js의 장점 및 단점

### 장점 (Pros)

- **개발 생산성 향상** — 프론트엔드와 백엔드 모두 JavaScript 단일 언어로 개발 가능하여 코드 재사용성이 높습니다.
- **고성능 및 효율성** — 비동기/논 블로킹 방식 덕분에 I/O 작업이 많은 환경(네트워크, 디스크 접근 등)에서 높은 처리량과 빠른 응답 속도를 보여줍니다.
- **경량 및 빠른 개발** — 서버 설치부터 간단한 애플리케이션 실행까지의 과정이 비교적 가볍고 빠릅니다.
- **방대한 생태계** — npm을 통해 다양한 모듈과 라이브러리를 쉽게 활용할 수 있습니다.
- **낮은 러닝 커브** — JavaScript 개발자에게는 새로운 언어 습득 없이 서버 개발이 가능합니다.

### 단점 (Cons)

- **CPU 집약적 작업에 취약** — 단일 스레드 모델이기 때문에, 복잡한 계산이나 이미지 처리 등 **CPU-intensive** 작업이 발생하면 전체 시스템이 블로킹되어 성능이 급격히 저하될 수 있습니다. (클러스터 모듈 등으로 멀티 코어 활용을 위한 추가 설계 필요)
- **콜백 지옥 (Callback Hell)** — 비동기 처리의 특성상 콜백 함수가 중첩될 경우 코드 가독성이 떨어지고 유지보수가 어려워질 수 있습니다. (Promise, Async/Await로 해결 가능)
- **프로세스 안정성** — 단일 스레드에서 예외가 발생하면 전체 프로세스가 종료될 수 있어, 에러 관리가 중요합니다.

---

## 3. Node.js의 주요 사용 사례

Node.js는 특히 I/O 작업이 많고, 데이터 처리량이 높으며, 실시간 상호작용이 필요한 서비스에 적합합니다.

- **실시간 애플리케이션** — 채팅 서비스, 실시간 협업 도구, 스트리밍 서비스, 온라인 게임 서버 (빠른 데이터 처리와 양방향 통신에 유리)
- **API 서버 개발** — RESTful API나 GraphQL API 서버를 구축하는 백엔드 시스템
- **마이크로 서비스** — 경량화된 독립적인 서비스로 구성된 아키텍처 구축
- **데이터 스트리밍** — 대용량 파일 업로드/다운로드 및 미디어 스트리밍 (데이터를 청크 단위로 빠르게 처리)
- **프론트엔드 빌드 도구** — Webpack, Babel 등의 도구가 Node.js 기반으로 작동하며, 프론트엔드 개발 환경 구성에 필수적으로 사용됩니다.
- **CLI (Command Line Interface) 도구 개발**

---

## 4. 실습 프로젝트 정리

### FIRST — Parcel v2 + CommonJS + lodash

Parcel v2 번들러를 사용한 첫 번째 실습 프로젝트. Node.js의 **CommonJS 모듈 시스템**(`require`)으로 lodash를 불러오는 방식을 다룬다.

```js
// index.js
const _ = require("lodash");

const arr = [1, 2, 3, 4, 5];
const shuffled = _.shuffle(arr);
console.log("shuffled:", shuffled);
```

| 항목 | 내용 |
|------|------|
| 번들러 | Parcel v2 (`.parcel-cache` 생성) |
| 모듈 방식 | CommonJS (`require`) |
| 핵심 라이브러리 | lodash |
| 실습 포인트 | `_.shuffle()` — 배열 요소를 무작위로 섞기 |

---

### TMP — Parcel v1 + ES Module + lodash

Parcel v1 번들러를 사용한 프로젝트. **ES Module 방식**(`import`)으로 lodash를 사용하며, 브라우저에서 실행되는 클라이언트 사이드 번들링을 다룬다.

```js
// index.js
import _ from 'lodash';

const result = _.join(['Hello', 'Parcel'], "|");
console.log(result); // Hello|Parcel
```

| 항목 | 내용 |
|------|------|
| 번들러 | Parcel v1 (`.cache` 생성, `dist/TMP.e31bb0bc.js` 출력) |
| 모듈 방식 | ES Module (`import`) |
| 핵심 라이브러리 | lodash |
| 실습 포인트 | `_.join()` — 배열 요소를 구분자로 연결 |

> **FIRST vs TMP 비교**
> - FIRST: `require()` (CommonJS, Node.js 서버 환경 기본)
> - TMP: `import` (ES Module, 최신 브라우저/번들러 표준)

---

### SCSS — Parcel v1 + sass + SCSS 문법 실습

Parcel v1과 sass를 사용해 SCSS를 CSS로 컴파일하는 실습 프로젝트. `01`, `02` 두 예제로 구성된다.

**스크립트**
```json
"start": "npx parcel 02/index.html"
```

**devDependencies**
```json
"parcel-bundler": "^1.12.5",
"sass": "^1.101.0"
```

#### 01 — 중첩(Nesting), `&` 부모 참조, 속성 중첩(Property Nesting)

```scss
.container {
  ul {
    li {
      &.name { color: green; }       // & = 부모 선택자 참조
      &.age  { background-color: royalblue; }
    }
  }
}

.container3 .box {
  font: {            // 속성 중첩: font-weight, font-size, font-family 한 번에
    weight: bold;
    size: 10px;
    family: "sans-serif";
  };
  padding: {
    top: 10px; right: 20px; bottom: 30px; left: 40px;
  };
}
```

| 개념 | 설명 |
|------|------|
| 중첩(Nesting) | 선택자를 부모 안에 중첩하여 계층 구조를 표현 |
| `&` 선택자 | 현재 선택자(부모)를 참조. `&.active` → `.btn.active` |
| 속성 중첩 | `font:`, `margin:`, `padding:` 등 네임스페이스를 중첩하여 축약 |

#### 02 — 변수(`$variable`): 전역 vs 지역

```scss
$size: 200px;       // 전역 변수 — 어디서든 사용 가능

.container {
  $localsize: 100px; // 지역 변수 — 이 블록 안에서만 사용 가능

  .item {
    width: $size;       // 전역 변수 참조 가능
    height: $localsize; // 지역 변수 참조 가능
  }
}
```

| 변수 종류 | 선언 위치 | 유효 범위 |
|-----------|-----------|-----------|
| 전역 변수 | 최상위 스코프 | 파일 전체 |
| 지역 변수 | 선택자 블록 내부 | 해당 블록 및 하위 블록 |
