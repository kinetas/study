# React 핵심 정리

---

## 1. React란?

> React는 **Facebook**에서 개발하고 유지 관리하는 오픈 소스 JavaScript 라이브러리로, 사용자 인터페이스(UI)를 구축하기 위해 사용됩니다.

- 주로 **단일 페이지 애플리케이션(SPA)** 에서 빠르고 효율적인 UI 업데이트를 위해 활용
- **컴포넌트 기반 구조**로 UI를 재사용 가능한 단위로 분리

---

## 2. React의 주요 특징 및 장점

| # | 특징 | 설명 |
|---|------|------|
| 1 | 컴포넌트 기반 아키텍처 | UI를 독립적이고 재사용 가능한 컴포넌트로 분할 |
| 2 | Virtual DOM | 최소한의 실제 DOM 변경으로 성능 향상 |
| 3 | 단방향 데이터 흐름 | 부모 → 자식 방향으로만 데이터 흐름, 예측 가능한 상태 관리 |
| 4 | JSX | JavaScript + HTML 혼합 문법, 가독성과 유지보수성 향상 |
| 5 | React Hooks | 함수형 컴포넌트에서 상태관리 및 생명주기 활용 |
| 6 | 풍부한 생태계 | Redux, React Router, Styled-Components 등과 호환 |
| 7 | SSR 지원 | Next.js 등으로 SEO 친화적 서버사이드 렌더링 가능 |
| 8 | 지속적인 업데이트 | Facebook 주도의 꾸준한 성능 개선 및 커뮤니티 반영 |

---

## 3. React 핵심 기술

### 1) 컴포넌트 기반 구조

- React 애플리케이션은 **컴포넌트 단위**로 구성됨
- 각 컴포넌트는 재사용 가능하고 독립적으로 동작
- `props`(속성)와 `state`(상태)를 통해 유동적인 데이터 표현 가능

---

## 4. 실습 단계별 정리 (`start/` 폴더)

### 폴더 구조 개요

```
start/
├── 01/          # CRA 기본 프로젝트 구조
├── 02/          # JSX 기초
├── 02_EX/       # JSX 응용 연습 (쇼핑몰 테마)
├── 03/          # 컴포넌트 & Hooks (useState / useEffect)
├── 03_EX/       # Hooks 응용 연습
├── 04/          # 이벤트 핸들링 (6종)
├── 04_EX/       # 이벤트 핸들링 응용 연습
├── 05/          # 조건부 렌더링 (3가지 방식)
├── 05_EX/       # 조건부 렌더링 응용 연습 (10단계)
├── 06/          # React Router DOM (BrowserRouter · Route · Link · useParams)
├── 06_EX/       # 라우팅 응용 연습
├── 07/          # 컴포넌트 간 통신 (Props · Callback · Context API)
├── 07_EX/       # 통신 응용 연습
├── 08/          # 레이아웃 합성 (children · Layout · isShowAside)
├── 08_EX/       # 레이아웃 합성 응용 연습
├── 09/          # 스타일링 (인라인 · CSS · SCSS · react-bootstrap)
└── 09_EX/       # 스타일링 응용 연습
```

---

### 01 — CRA 기본 프로젝트 구조

> `create-react-app` 초기 상태. 최소한의 App.js만 수정된 진입점.

**`src/App.js`**
```jsx
function App() {
  return (
    <div className="App">
      <header className="App-header">TITLE-1</header>
    </div>
  );
}
```

| 파일 | 역할 |
|------|------|
| `index.js` | React DOM 진입점, `<App />`을 `#root`에 마운트 |
| `App.js` | 최상위 컴포넌트 |

---

### 02 — JSX 기초

> JSX 문법과 컴포넌트 선언 방식을 다양하게 실습.

**`src/App.js`** — `03_Event.jsx`의 이벤트 컴포넌트 3개를 렌더링 (이전 단계는 주석 처리)

#### `02JSX/01_Basic.jsx` — JSX 핵심 패턴

| 요소 | 내용 |
|------|------|
| `Element1` | 화살표 함수로 JSX 반환 |
| `Element2` | `function` 키워드로 JSX 반환 |
| `Element3` | `props` 객체로 값 전달, 조건 분기 (`ROLE_ADMIN` / `ROLE_USER`) |
| `Element4` | props **구조분해할당**으로 `{auth, name}` 직접 받기 |
| `Element5` | `props.list` 배열을 `map()`으로 `<li>` 목록 렌더링 |
| `export default {}` | 객체 형태 default export (복수 컴포넌트 묶기) |

```jsx
// props 구조분해할당 예시
export function Element4({ auth, name }) {
  if (auth === "ROLE_ADMIN") return <h2>관리자님 환영합니다, NAME={name}</h2>;
  else if (auth === "ROLE_USER") return <h2>유저님 환영합니다, NAME={name}</h2>;
}

// 배열 map() 렌더링
export const Element5 = (props) => (
  <ul>
    {props.list.map((item, idx) => <li key={idx}>{item}</li>)}
  </ul>
);
```

#### `02JSX/03_Event.jsx` — 이벤트 핸들러 기초

| 컴포넌트 | 이벤트 | 포인트 |
|----------|--------|--------|
| `Component_Event_01` | `onClick` | 핸들러를 컴포넌트 **외부**에 선언 |
| `Component_Event_02` | `onClick` | 핸들러를 컴포넌트 **내부**에 선언 |
| `Component_Event_03` | `onKeyDown` | `e.target.value`로 입력값 접근 |

#### `02JSX/CustomComponent.jsx` — Fragment 사용

```jsx
const CustomComponent = () => (
  <>
    <h2>02_CUSTOM_COMPONENT</h2>
  </>
);
```

---

### 02_EX — JSX 응용 연습 (쇼핑몰 테마)

> `02JSX/02_EX.jsx` 단계별 TODO 완성 형식.

| 단계 | 컴포넌트 | 학습 내용 |
|------|----------|-----------|
| 1 | `ShopBanner`, `ShopNotice` | 화살표 함수 / `function` 두 방식으로 컴포넌트 생성 |
| 2 | `ProductLine` | `props.name`, `props.price` 출력 |
| 3 | `DiscountLine` | 구조분해할당 + 할인가 계산 (`price * (100 - rate) / 100`) |
| 4 | `StockStatus` | 재고 수에 따른 3가지 조건 분기 (`품절` / `마감임박` / `구매가능`) |
| 5 | `Cart` | `map()`으로 목록 출력 + `reduce()`로 합계 계산 |

```jsx
// 단계 5 핵심 패턴
export function Cart({ items }) {
  const total = items.reduce((sum, item) => sum + item.price * item.qty, 0);
  return (
    <>
      <ul>{items.map(item => <li key={item.id}>{item.name} x {item.qty} = {item.price * item.qty}</li>)}</ul>
      <p>합계 : {total}</p>
    </>
  );
}
```

---

### 03 — 컴포넌트 & Hooks (`useState` / `useEffect`)

> `03Component/MyComponent.jsx`에서 두 Hook을 함께 실습.

**`src/App.js`** — `<MyComponent />` 단독 렌더링

#### `MyComponent.jsx` 핵심 패턴

```jsx
import { useState, useEffect } from "react";

const MyComponent = () => {
  const [count, setCount] = useState(1);

  const handleClick = () => setCount(count + 1); // 비동기 상태 업데이트

  useEffect(() => {
    console.log("init setting..");
  }, []);                    // 의존성 배열 [] → 마운트 시 1회만 실행

  useEffect(() => {
    console.log("count changed:", count);
  }, [count]);               // [count] → count 변경 시마다 실행

  return <button onClick={handleClick}>BTN Count : {count}</button>;
};
```

| Hook | 의존성 배열 | 실행 시점 |
|------|------------|-----------|
| `useEffect(() => {}, [])` | `[]` | 마운트 시 **1회** |
| `useEffect(() => {}, [count])` | `[count]` | `count` 변경 **시마다** |
| `useEffect(() => {})` | 없음 | **매 렌더링** 후 |

---

### 03_EX — Hooks 응용 연습

> `03Component/03_EX.jsx` 단계별 TODO 완성 형식.

| 단계 | 컴포넌트 | 학습 내용 |
|------|----------|-----------|
| 1 | `Counter` | `useState(0)` + `+1 / -1 / 초기화` 버튼 |
| 2 | `NameInput` | `input` 제어 컴포넌트 (`value` + `onChange` 연결) |
| 3 | `ToggleLamp` | `boolean` 상태 토글 + 조건부 텍스트 출력 |
| 4 | `WelcomeBox` | `useEffect([])`로 마운트 시 메시지 변경 |
| 5 | `TitleCounter` | `useEffect([count])`로 탭 제목(`document.title`) 실시간 업데이트 |

---

### 04 — 이벤트 핸들링 (6종)

> `04Event/` 폴더에 이벤트 종류별로 분리, `App.js`에서 모두 렌더링.

| 파일 | 이벤트 | 핵심 내용 |
|------|--------|-----------|
| `01OnClick.jsx` | `onClick` | 버튼 클릭 → 콘솔 출력 (가장 기본) |
| `02OnMouse.jsx` | `onMouseEnter` / `onMouseLeave` | `useState`로 호버 상태 관리, 텍스트 변경 |
| `03OnKey.jsx` | `onKeyUp` / `onKeyDown` | `e.target.value`로 입력값 실시간 상태 반영 |
| `04OnChange.jsx` | `onChange` | `text` / `checkbox` / `radio` 통합 처리, `e.target` 구조분해 |
| `05OnSubmit.jsx` | `onSubmit` | `e.preventDefault()`로 페이지 새로고침 차단 |
| `06OnScroll.jsx` | `onScroll` | 스크롤 영역에 핸들러 부착 |

```jsx
// onChange 통합 처리 패턴
const handleChange = (e) => {
  const { name, value, type, checked } = e.target;
  setState(value);
};

// onSubmit + preventDefault 패턴
const handleSubmit = (e) => {
  e.preventDefault(); // 폼 기본 동작(페이지 이동) 차단
  console.log("onSubmit...", e);
};
```

---

### 04_EX — 이벤트 핸들링 응용 연습

> `04EVENT/04_EX.jsx` 단계별 TODO 완성 형식. 다루는 이벤트: `onClick / onMouse / onChange / onKey / onSubmit / onScroll`

**`App.js`**
```jsx
import EX_04 from "./04EVENT/04_EX";

function App() {
  return (
    <div className="App">
      <h1>04_EX (이벤트 핸들링 단계별 연습)</h1>
      <EX_04 />
    </div>
  );
}
```

| 단계 | 컴포넌트 | 이벤트 | 학습 내용 |
|------|----------|--------|-----------|
| 1 | `ClickCounter` | `onClick` | `useState(0)`으로 클릭 횟수 누적 |
| 2 | `HoverBox` | `onMouseEnter` / `onMouseLeave` | `boolean` 상태로 배경색·텍스트 조건부 변경 |
| 3 | `LiveInput` | `onChange` | 제어 컴포넌트(`value`+`onChange`) + 글자 수 실시간 출력 |
| 4 | `EnterInput` | `onKeyUp` | `e.key === "Enter"` 감지 후 메시지 업데이트 |
| 5 | `AddForm` | `onSubmit` | `e.preventDefault()` + 스프레드 연산자로 목록 추가 |
| 6 | `ScrollTracker` | `onScroll` | `e.target.scrollTop`으로 스크롤 위치 출력 |

#### [단계 1] onClick — 클릭 카운터

```jsx
export function ClickCounter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <button onClick={() => setCount(count + 1)}>클릭</button>
      <p>버튼을 {count}번 눌렀습니다.</p>
    </div>
  );
}
```

#### [단계 2] onMouseEnter / onMouseLeave — 마우스 오버 박스

```jsx
export function HoverBox() {
  const [state, setState] = useState(false);
  const color   = state ? "orange"    : "lightgray";
  const message = state ? "마우스 들어옴" : "마우스 나감";

  return (
    <div
      onMouseEnter={() => setState(true)}
      onMouseLeave={() => setState(false)}
      style={{ backgroundColor: color, width: "150px", height: "80px" }}
    >
      {message}
    </div>
  );
}
```

#### [단계 3] onChange — 실시간 입력 + 글자 수

```jsx
export function LiveInput() {
  const [text, setText] = useState("");

  return (
    <div>
      <input value={text} onChange={(e) => setText(e.target.value)} placeholder="입력하세요" />
      <p>입력한 값 : {text}({text.length}자)</p>
    </div>
  );
}
```

#### [단계 4] onKeyUp — Enter 키 감지

```jsx
export function EnterInput() {
  const [message, setMessage] = useState("Enter 키를 눌러보세요.");

  const onKeyUp = (e) => {
    if (e.key === "Enter") setMessage(`Enter 입력됨: ${e.target.value}`);
  };

  return (
    <div>
      <input onKeyUp={onKeyUp} type="text" placeholder="입력 후 Enter" />
      <p>{message}</p>
    </div>
  );
}
```

#### [단계 5] onSubmit — 폼 제출 + 목록 추가

```jsx
export function AddForm() {
  const [value, setValue] = useState("");
  const [list, setList]   = useState([]);

  const onSubmit = (e) => {
    e.preventDefault();          // 페이지 새로고침 방지
    setList([...list, value]);   // 불변성 유지 (스프레드 복사)
    setValue("");                 // 입력칸 초기화
  };

  return (
    <div>
      <form onSubmit={onSubmit}>
        <input type="text" value={value} onChange={(e) => setValue(e.target.value)} placeholder="할 일 입력" />
        <button type="submit">추가</button>
      </form>
      <ul>{list.map((item, idx) => <li key={idx}>{item}</li>)}</ul>
    </div>
  );
}
```

#### [단계 6] onScroll — 스크롤 위치 표시

```jsx
export function ScrollTracker() {
  const [top, setTop] = useState(0);

  return (
    <div>
      <p>scrollTop : {top}px</p>
      <div onScroll={(e) => setTop(e.target.scrollTop)}
           style={{ height: "120px", overflow: "scroll", border: "1px solid" }}>
        <div style={{ height: "600px", backgroundColor: "skyblue" }}>
          박스 안에서 스크롤하세요.
        </div>
      </div>
    </div>
  );
}
```

---

### 05 — 조건부 렌더링

> `05ConditionRandering/` 폴더. `App.js`에서 `isAuth` prop을 다르게 전달하며 테스트.

| 파일 | 방식 | 코드 패턴 |
|------|------|-----------|
| `Component01.jsx` | `if / else` | 조건에 따라 다른 JSX를 `return` |
| `Component02.jsx` | 삼항 연산자 `? :` | JSX 내부 또는 return 값에 삼항 연산자 사용 |
| `Component03.jsx` | `&&` 단축평가 + `map()` | `items && items.map(...)` — items가 없으면 렌더링 생략 |

```jsx
// Component01 — if/else
const Component01 = ({ isAuth }) => {
  if (isAuth) return <div><h1>인증 완료 상태</h1></div>;
  else         return <div><h1>로그인이 필요합니다</h1></div>;
};

// Component02 — 삼항 연산자 (가장 간결한 형태)
const Component02 = ({ isAuth }) =>
  isAuth ? <div>인증 완료 상태</div> : <div>로그인이 필요합니다</div>;

// Component03 — && 단축평가 (undefined/null 방어)
const Component03 = ({ items }) => (
  <ul>
    {items && items.map((item, idx) => <li key={idx}>{item}</li>)}
  </ul>
);
```

**`App.js` 사용 예시**
```jsx
<Component01 isAuth={false} />   {/* 로그인이 필요합니다 출력 */}
<Component02 isAuth={true}  />   {/* 인증 완료 상태 출력 */}
<Component03 />                  {/* items undefined → 빈 ul */}
<Component03 items={['오렌지','바나나','수박','딸기']} />
```

---

### 05_EX — 조건부 렌더링 응용 연습

> `05조건부랜더링/05_EX.jsx` 단계별 TODO 완성 형식. 포인트: **return의 형태** — 같은 결과를 여러 방식으로 표현.

| 단계 | 컴포넌트 | 방식 | 학습 내용 |
|------|----------|------|-----------|
| 1 | `LoginMessage` | `if/else` | 조건에 따라 각각 `return` |
| 2 | `Greeting` | 삼항 직접 반환 | 래퍼 없이 삼항 결과 JSX를 `return` |
| 3 | `CartList` | `&&` + 인라인 `map` | 빈 배열 안내 + 중괄호 없는 화살표 `map` |
| 4 | `Grade` | 중첩 삼항 + `&&` | `a ? x : b ? y : z` 한 줄 등급 + 만점 보너스 |
| 5 | `StatusBadge` | IIFE | JSX 안에서 `if` 분기: `{(() => { ... })()}` |
| 6 | `UserName` | `\|\|` 기본값 + `&&` | `name \|\| "익명"` + `isAdmin && " (관리자)"` |
| 7 | `SecretBox` | `return null` | 조건 미충족 시 아무것도 렌더하지 않기 |
| 8 | `StatusLabel` | 객체 룩업 | `labels[status] \|\| "알수없음"` |
| 9 | `TrafficLight` | `switch` | `case` 마다 다른 JSX `return` |
| 10 | `Profile` | 옵셔널 체이닝 + `??` | `user?.name ?? "이름 없음"` |

```jsx
// 단계 4 — 중첩 삼항 + && 보너스
export function Grade({ score }) {
  return (
    <p>
      점수 {score}점 - 등급 {score >= 90 ? "A" : score >= 80 ? "B" : score >= 70 ? "C" : "F"}
      {score === 100 && <b>(만점!)</b>}
    </p>
  );
}

// 단계 5 — IIFE 분기
export function StatusBadge({ status }) {
  return (
    <p>주문 상태 : {(() => {
      if (status === "ready")    return "준비중";
      if (status === "shipping") return "배송중";
      return "배송완료";
    })()}</p>
  );
}

// 단계 8 — 객체 룩업
export function StatusLabel({ status }) {
  const labels = { ready: "준비중", shipping: "배송중", done: "배송완료" };
  return <p>주문 상태 : {labels[status] || "알수없음"}</p>;
}

// 단계 10 — 옵셔널 체이닝 + ??
export function Profile({ user }) {
  return <p>이름 : {user?.name ?? "이름 없음"}</p>;
}
```

---

### 06 — React Router DOM

> `06Route/` 폴더. `BrowserRouter · Routes · Route · Link · useParams` 실습.

**`App.js`**
```jsx
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/"                      element={<Home />} />
        <Route path="/About"                 element={<About />} />
        <Route path="/Contact/:name?/:age?"  element={<Contact />} />
      </Routes>
    </Router>
  );
}
```

| 파일 | 핵심 기능 |
|------|-----------|
| `Home.jsx` | `<Link to="...">` 로 네비게이션 |
| `About.jsx` | `useLocation().search` + `URLSearchParams`로 쿼리스트링 파싱 |
| `Contact.jsx` | `useParams()`로 경로 파라미터(`name`, `age`) 추출 |

```jsx
// Contact — 선택적 파라미터 (:name?/:age?)
const Contact = () => {
  const { name, age } = useParams();
  return <div>PARAMS : {name},{age}</div>;
};
```

| 라우터 요소 | 역할 |
|-------------|------|
| `BrowserRouter` | HTML5 history API 기반 라우터 |
| `Routes` | 경로 목록 컨테이너 (첫 번째 매칭만 렌더) |
| `Route path element` | 경로와 컴포넌트 매핑 |
| `Link to` | `<a>` 대체, 페이지 새로고침 없이 이동 |
| `:param?` | 선택적 URL 파라미터 |

---

### 06_EX — 라우팅 응용 연습

> `06ROUTE/06_EX.jsx` 단계별 TODO 완성 형식. 다루는 것: `Routes·Route·Link·useParams·useLocation·useNavigate·*`

| 단계 | 컴포넌트 | Hook/요소 | 학습 내용 |
|------|----------|-----------|-----------|
| 1 | `Home` | `Link` | 기본 라우트 연결 확인 |
| 2 | `User` | `useParams` | `/user/:id` 에서 `id` 추출 |
| 3 | `Search` | `useLocation` | `location.search` → `URLSearchParams` → `query.get("keyword")` |
| 4 | `Move` | `useNavigate` | `navigate("/user/99")` · `navigate(-1)` 뒤로 가기 |
| 5 | `NotFound` | `path="*"` | 매칭 없는 경로의 404 처리 |

```jsx
// useParams
function User() {
  const { id } = useParams();
  return <h2>USER - 파라미터 id : {id}</h2>;
}

// useLocation + URLSearchParams
function Search() {
  const location = useLocation();
  const keyword = new URLSearchParams(location.search).get("keyword");
  return <h2>SEARCH - 검색어 : {keyword}</h2>;
}

// useNavigate
function Move() {
  const navigate = useNavigate();
  return (
    <>
      <button onClick={() => navigate("/user/99")}>USER 99 로 이동</button>
      <button onClick={() => navigate(-1)}>뒤로 가기</button>
    </>
  );
}

// Routes 구성
<Routes>
  <Route path="/"         element={<Home />} />
  <Route path="/user/:id" element={<User />} />
  <Route path="/search"   element={<Search />} />
  <Route path="/move"     element={<Move />} />
  <Route path="*"         element={<NotFound />} />
</Routes>
```

---

### 07 — 컴포넌트 간 통신

> `07Component간통신/` 폴더. Props · Callback · Context API 세 방식 비교.

**`App.js`**
```jsx
// Context API는 생성(Context) → 제공(Provider) → 소비(useContext) 3단계
function App() {
  return (
    <CustomProvider>       {/* Provider로 앱 전체를 감싸 전역 값 제공 */}
      <Parent_01 />
    </CustomProvider>
  );
}
```

#### Props/Callback 패턴 (`Props/Parent.jsx`, `Props/Son.jsx`)

```jsx
// 부모 → 자식: props로 전달
// 자식 → 부모: 부모가 만든 콜백 함수를 props로 내려줌
const Parent = () => {
  const [name, setName] = useState("홍길동");
  const handleChangeParentName = (name) => setName(name); // 콜백

  return <Son user={name} handleChangeParentName={handleChangeParentName} />;
};
```

#### Context API 패턴 (`ContextAPI/Context.jsx`, `ContextAPI/Provider.jsx`)

```jsx
// 1단계 — 생성
const AppContext = React.createContext();

// 2단계 — 제공 (Provider)
const CustomProvider = ({ children }) => {
  const [globalState, setGlobalState] = useState("KOREA_GLOBAL");
  return (
    <AppContext.Provider value={{ globalState, setGlobalState }}>
      {children}
    </AppContext.Provider>
  );
};

// 3단계 — 소비 (useContext) — props 없이 어디서든 접근
const { globalState } = useContext(AppContext);
```

| 방식 | 방향 | 특징 |
|------|------|------|
| `props` | 부모 → 자식 | 직접 전달, 단순 |
| `callback` | 자식 → 부모 | 부모가 함수를 만들어 props로 내려줌 |
| `Context API` | 전역 | Prop drilling 없이 트리 어디서든 소비 |

---

### 07_EX — 컴포넌트 통신 응용 연습

> `07통신/07_EX.jsx` 단계별 TODO 완성 형식.

| 단계 | 컴포넌트 | 학습 내용 |
|------|----------|-----------|
| 1 | `Child1` | `props`로 `title` 받아 출력 |
| 2 | `Child2` | 제어 컴포넌트 + `onSend(value)` 콜백으로 부모에 전달 |
| 3 | `ThemeProvider` + `DeepChild` | `createContext` → `Provider` → `useContext` + `light/dark` 토글 |

```jsx
// 단계 3 — Context API 전체 패턴 (한 파일 안에서)
const ThemeContext = createContext();

function ThemeProvider({ children }) {
  const [theme, setTheme] = useState("light");
  return <ThemeContext.Provider value={{ theme, setTheme }}>{children}</ThemeContext.Provider>;
}

function DeepChild() {
  const { theme, setTheme } = useContext(ThemeContext);
  return (
    <div>
      현재 테마: <b>{theme}</b>
      <button onClick={() => setTheme(theme === "light" ? "dark" : "light")}>테마 전환</button>
    </div>
  );
}
```

---

### 08 — 레이아웃 합성

> `layouts/` + `pages/` 폴더. `children` prop과 컴포넌트 합성으로 공통 레이아웃 구성.

**`App.js`**
```jsx
<Router>
  <Routes>
    <Route path="/"      element={<Home />} />
    <Route path="/About" element={<About />} />
  </Routes>
</Router>
```

#### 레이아웃 구조

```
Layout
├── Header (TopHeader + Nav)
├── main
│   ├── Aside (isShowAside가 true일 때만 렌더)
│   └── Section (children 출력)
└── Footer
```

```jsx
// Layout.jsx — children + 조건부 Aside
const Layout = ({ children, isShowAside }) => (
  <div className="wrapper">
    <Header />
    <main>
      {isShowAside && <Aside />}    {/* && 단축평가로 조건부 렌더 */}
      <Section>{children}</Section>
    </main>
    <Footer />
  </div>
);

// 페이지에서 사용
const Home = () => (
  <Layout isShowAside={false}>     {/* Aside 숨김 */}
    <h1>HOME PAGE</h1>
  </Layout>
);
```

| 파일 | 역할 |
|------|------|
| `Layout.jsx` | 전체 틀 (`children` + `isShowAside` prop) |
| `Header.jsx` | `TopHeader` + `Nav` 합성 |
| `Section.jsx` | `{children}` 출력 영역 |
| `Aside.jsx` | 사이드바 (조건부 렌더) |
| `Footer.jsx` | 하단 고정 영역 |

---

### 08_EX — 레이아웃 합성 응용 연습

> `08LAYOUT/08_EX.jsx` 단계별 TODO 완성 형식.

| 단계 | 컴포넌트 | 학습 내용 |
|------|----------|-----------|
| 1 | `Section` | `children` prop 받아 `<section>` 안에 출력 |
| 2 | `Layout` | Header + (조건부 Aside) + Section + Footer 합성 |
| 3 | `Layout` | `isShowAside = true` 기본값 + `&&` 조건부 렌더 |
| 4 | `Card` | `title·footer·children` 세 슬롯(slot) 합성 패턴 |
| 5 | `Grid` | `items.map()`으로 반복 레이아웃 |
| 6 | `Alert` | `type` 기본값 + 객체 룩업으로 색상 결정 |

```jsx
// 단계 2·3 — Layout 합성 + 기본 prop값
function Layout({ children, isShowAside = true }) {
  return (
    <div>
      <Header />
      <main style={{ display: "flex" }}>
        {isShowAside && <Aside />}
        <Section>{children}</Section>
      </main>
      <Footer />
    </div>
  );
}

// 단계 4 — 슬롯(slot) 패턴 (children 외 여러 영역을 props로)
function Card({ title, footer, children }) {
  return (
    <div>
      <div>{title}</div>
      <div>{children}</div>
      <div>{footer}</div>
    </div>
  );
}

// 단계 6 — 객체 룩업으로 variant 색상 분기
function Alert({ type = "info", children }) {
  const colors = { success: "#2f9e44", danger: "#e03131", info: "#1971c2" };
  return <div style={{ color: colors[type], borderLeft: `3px solid ${colors[type]}` }}>{children}</div>;
}
```

---

### 09 — 스타일링

> `STYLING/` 폴더. React에서 스타일을 적용하는 3가지 방법 + react-bootstrap.

**`App.js`**
```jsx
import Basic from "./STYLING/Basic";           // 인라인 + CSS import + BS5 바닐라
import ScssTest from "./STYLING/ScssTest";     // SCSS import
import ReactBsComponent from "./STYLING/ReactBsComponent"; // react-bootstrap
```

| 파일 | 방식 | 핵심 |
|------|------|------|
| `Basic.jsx` | 인라인 `style={{}}` + `import "./Basic.css"` | 인라인은 객체 문법, CSS는 className으로 연결 |
| `ScssTest.jsx` | `import "./ScssTest.scss"` | 선택자 중첩 그대로 사용, **className 오타 주의** |
| `ReactBsComponent.jsx` | `react-bootstrap` 컴포넌트 | `<Button variant="primary">` — JSX 컴포넌트로 BS5 사용 |

```jsx
// 인라인 style — 객체 문법, camelCase
<div style={{ width: "100px", height: "100px", backgroundColor: "orange" }} />

// SCSS import — className과 scss 선택자가 반드시 일치해야 함
// ScssTest.scss: .scss-component { h1 { } ul { li { } } }
<div className="scss-component">...</div>

// react-bootstrap
import Button from "react-bootstrap/Button";
<Button variant="primary">Primary</Button>
<Button variant="danger">Danger</Button>
```

---

### 09_EX — 스타일링 응용 연습

> `STYLING/09_EX.jsx` 단계별 TODO 완성 형식.

| 단계 | 컴포넌트 | 학습 내용 |
|------|----------|-----------|
| 1 | `DynamicBox` | `props`로 받은 `color·size`로 동적 `style` 객체 구성 |
| 2 | `ToggleTag` | 템플릿 문자열로 조건부 className (`tag` + `tag-active`) |
| 3 | `ScssBox` | SCSS import + `className="scss-box"` (중첩 선택자 확인) |
| 4 | `BootstrapKit` | `Card + Badge + Alert + Button` 조합 |
| 5 | `BootstrapLayout` | `Navbar + Container + Row/Col` 으로 레이아웃 |
| 6 | `LayoutBS` | 08 레이아웃 구조를 BS5 컴포넌트로 재구성 |
| 7 | `Layout7` | 각 영역에 적절한 BS5 컴포넌트 매핑 (Navbar·Nav·ListGroup·Card) |

```jsx
// 단계 1 — 동적 style
export function DynamicBox({ color, size }) {
  return <div style={{ width: size, height: size, backgroundColor: color, color: "white" }}>{color}</div>;
}

// 단계 2 — 조건부 className
export function ToggleTag({ label, active }) {
  return <span className={`tag ${active ? "tag-active" : ""}`}>{label}</span>;
}

// 단계 7 — 영역별 BS5 컴포넌트 매핑
// Header  → <Navbar bg="primary" variant="dark">
// Nav     → <Nav variant="pills"> + <Nav.Item>
// Aside   → <ListGroup> + <ListGroup.Item action>
// Section → <Card> + <Card.Header> + <Card.Body>
// 레이아웃 → <Container> + <Row> + <Col md={4/8}>
```

| 레이아웃 역할 | react-bootstrap 컴포넌트 |
|--------------|--------------------------|
| Header | `Navbar` |
| Nav | `Nav` (variant="pills") |
| Aside | `ListGroup` |
| Section | `Card` |
| 전체 그리드 | `Container > Row > Col` |
