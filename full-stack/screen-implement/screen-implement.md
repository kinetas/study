# 화면 구현

서버 server(물리) : 제공하다 / service(논리) 제공하는 주체  
클라이언트 client : 요청하는 주체  

- Web Browser(80) <--> Web Service(HTML)

네트워크(Network) : 서버와 클라이언트를 연결  
IP : 네트워크 환경 상 주소  
포트 : 포트별 서비스 제공  

---

# 웹서비스 구현

## HTML

**Hyper Text Markup Language**

- Hyper Text  
  여러 텍스트 페이지들을 링크 등을 통해 이동할 수 있는 것

- Markup  
  `<h1>` 같은 태그를 이용하여 문서의 구조를 표현

- Protocol (프로토콜)  
  통신을 위한 규칙 / 프로그램  
  웹에서는 HTTP 사용

- Request : 요청  
- Response : 응답(수신)

➡ HTML은 **웹페이지의 구조를 만들 때 사용**

---

## Markup Language

- 시작 태그와 종료 태그가 필요

```
<태그명></태그명>
```

- 속성을 포함할 수도 있음

```
<태그명 속성=값>
```

- 태그는 부모 태그와 자식 태그 구조를 가짐

```
부모 태그
 └ 자식 태그
```

- 자세한 내용은 practice.html 주석 참고

### 단축키 및 확장 플러그인

- `Ctrl + /` : 주석 처리/해제
- `Ctrl + Shift + P` : 설정 환경 진입
- `Alt + Shift + ↓` : 한 줄 복사
- `Alt + Shift + F` : 코드 정리

추천 확장 플러그인: Korean, Live Server, Auto Rename Tag

---

## Basic

`<!DOCTYPE html>`  
- 이 문서가 **HTML5 문서임을 선언**

`<html lang="ko">`  
- HTML 문서의 시작을 나타냄  
- `lang="ko"` : 문서의 기본 언어가 **한국어**임을 명시

`<head>`  
- 문서의 **메타데이터, 설정, 제목** 등을 포함하는 머리말 영역

`<meta charset="UTF-8">`  
- 문서의 **문자 인코딩을 UTF-8로 설정**

`<meta name="viewport" content="width=device-width, initial-scale=1.0">`  
- **반응형 웹 디자인을 위한 Viewport 설정**

옵션 설명

- `width=device-width`  
  → 뷰포트의 너비를 **디바이스 화면 너비에 맞춤**

- `initial-scale=1.0`  
  → 페이지가 처음 로드될 때 **기본 확대/축소 비율을 1로 설정**

`<title>Document</title>`  
- 브라우저 **탭에 표시되는 문서 제목**

`<body>`  
- 문서의 **본문 영역**
- 브라우저 **Viewport(사용자가 보는 웹페이지 영역)** 에 표시되는 내용

---

## HTML 기본 구조 및 태그 예제

### HTML 기본 구조

```html
<!DOCTYPE html>
<html lang="en"> <!-- HTML 문서의 시작, lang 속성은 문서의 기본 언어를 영어로 설정 -->

<head>
    <meta charset="UTF-8"> <!-- 문서의 문자 인코딩을 UTF-8로 설정 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    <!-- 반응형 웹 디자인을 위한 뷰포트 설정 (모바일/데스크탑 등 장치 화면 크기에 맞게 표시) -->

    <title>Document</title> <!-- 웹 페이지 제목, 브라우저 탭에 표시 -->
</head>

<body>

    <!-- block : 한 행 전체를 사용하는 태그 -->
    <!-- inline : 한 행을 다른 요소들과 공유하는 태그 -->

    <!-- block 태그 예시 -->
    <h1 style="border:1px solid">Hello, World!</h1>
    <h2>Hello, World!</h2>
    <h3>Hello, World!</h3>
    <h4>Hello, World!</h4>
    <h5>Hello, World!</h5>
    <h6>Hello, World!</h6>

    <!-- 구분선 -->
    <hr />

    <!-- inline 태그 예시 -->
    <span>Hello World</span> <br>
    <span>Hello World</span>
    <span>Hello World</span>
    <span>Hello World</span>
    <span>Hello World</span>

    <hr />

    <!-- 단락 및 기본 태그 -->
    <!-- p : 단락 태그 -->
    <!-- div : block 기본 태그 (레이아웃 구성에 많이 사용) -->
    <!-- span : inline 기본 태그 (CSS 스타일 적용에 많이 사용) -->

    <p>
        HTML 최초의 일반 공개 설명은 1991년 말에 버너스리가 처음으로 인터넷에서 문서를
        "HTML 태그"(HTML tag)로 부르면서 시작되었다.
    </p>

    <p>
        그것은 머릿글자로 이루어진 20개의 요소를 기술하였고,

        <div style="background-color: orange; width:400px; height:300px; border:5px solid;">
            block 요소(div) 예시
        </div>

        상대적으로 HTML의 단순한 디자인이었다.
    </p>

    <p>
        HTML은 동적인 웹 페이지를 웹 브라우저를 통해 문자와 이미지 형식으로 표현한다.

        <span style="display:block; background-color: orange; width:400px; height:300px; border:5px solid;">
            inline 태그(span)를 block처럼 사용한 예시
        </span>

        HTML은 구조를 담당하고, 스타일은 CSS로 분리하는 방향으로 발전하였다.
    </p>

</body>

</html>
```

---

### 정리

#### Block 요소
- 한 줄 전체를 차지
- 자동 줄바꿈 발생

대표 태그
- `h1 ~ h6`
- `p`
- `div`
- `hr`

#### Inline 요소
- 한 줄을 다른 요소들과 공유
- 줄바꿈 없음

대표 태그
- `span`
- `a`
- `img`
- `strong`

#### 주요 태그 역할

| 태그 | 역할 |
|-----|-----|
| `h1~h6` | 제목 태그 |
| `hr` | 수평 구분선 |
| `br` | 줄바꿈 |
| `p` | 문단 |
| `div` | 블록 영역 구성 |
| `span` | 인라인 영역 스타일 |

---

### 핵심 개념

- **HTML** : 웹 페이지의 구조 담당  
- **CSS** : 디자인 / 스타일 담당  
- **JavaScript** : 동적 기능 담당

## HTML 리스트 태그 (List)

### 리스트 종류

HTML에서 목록을 만들 때 사용하는 태그

| 태그 | 설명 |
|-----|-----|
| `ul` | 순서 없는 리스트 (unordered list) |
| `ol` | 순서 있는 리스트 (ordered list) |
| `li` | 리스트 항목 (list item) |

---

### 예제 코드

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>

    <!-- ul-li : 순번 없는 리스트 -->
    <ul>
        <li>list_1</li>
        <li>list_2</li>
        <li>list_3</li>
        <li>list_4</li>
    </ul>

    <!-- Emmet 사용 예 -->
    <!-- ul>li*4{list_$} -->

    <!-- ol-li : 순번 있는 리스트 -->
    <!-- type 속성 : 1, a, A, i, I -->

    <ol type="1">
        <li>List01</li>
        <li>List02</li>
        <li>List03</li>
        <li>List04</li>
    </ol>

    <hr />

    <!-- 중첩 리스트 (Nested List) -->

    <ul>
        <li>
            화면설계
            <ul>
                <li>요구사항 확인</li>
                <li>유스케이스</li>
                <li>스타일가이드</li>
            </ul>
        </li>

        <li>
            UI디자인
            <ul>
                <li>스토리보드</li>
                <li>UI설계</li>
            </ul>
        </li>

        <li>화면구현</li>
        <li>요구사항 확인</li>
        <li>개별 운영 환경 지원</li>
    </ul>

</body>

</html>
```

---

### 정리

#### 1️⃣ ul (Unordered List)

- 순서 없는 목록
- 기본적으로 **●(bullet)** 표시

예시

```
<ul>
  <li>항목1</li>
  <li>항목2</li>
</ul>
```

---

#### 2️⃣ ol (Ordered List)

- 순서 있는 목록
- 번호가 자동으로 붙음

속성

| 속성 | 설명 |
|-----|-----|
| `type="1"` | 숫자 |
| `type="a"` | 소문자 알파벳 |
| `type="A"` | 대문자 알파벳 |
| `type="i"` | 로마 숫자 소문자 |
| `type="I"` | 로마 숫자 대문자 |

---

#### 3️⃣ li (List Item)

- 리스트 내부의 **항목**

```
<li>내용</li>
```

---

#### 4️⃣ 중첩 리스트 (Nested List)

리스트 안에 또 다른 리스트를 넣어 **계층 구조** 표현 가능

예시

```
화면설계
 ├ 요구사항 확인
 ├ 유스케이스
 └ 스타일가이드
```

---

### Emmet 단축어

```
ul>li*4{list_$}
```

생성 결과

```
<ul>
  <li>list_1</li>
  <li>list_2</li>
  <li>list_3</li>
  <li>list_4</li>
</ul>
```

---

## HTML 엔티티 (Entity)

HTML에서는 **특수 문자나 공백을 표현하기 위해 엔티티(Entity)** 를 사용한다.

대표적인 경우
- 공백 표현
- HTML 태그 문자(`<`, `>`) 출력
- 특수 문자 출력

---

### 예제 코드

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>

    <!-- 공백 엔티티 -->
    <!-- &nbsp; : 공백 1칸 -->
    Hello&nbsp;&nbsp;&nbsp;&nbsp;World<br />

    <!-- 특수 문자 출력 -->
    <!-- < , > 기호 -->
    <!-- &lt; : < -->
    <!-- &gt; : > -->

    HTML 기호 설명 &lt;span&gt; 태그는 inline형 태그입니다.

</body>

</html>
```

---

### 자주 사용하는 HTML 엔티티

| 엔티티 | 출력 | 설명 |
|------|------|------|
| `&nbsp;` | 공백 | 공백 한 칸 |
| `&lt;` | `<` | less than |
| `&gt;` | `>` | greater than |
| `&amp;` | `&` | and 기호 |
| `&quot;` | `"` | 큰따옴표 |
| `&apos;` | `'` | 작은따옴표 |

---

### 예시

```html
Hello&nbsp;&nbsp;World
```

출력

```
Hello  World
```

---

### 핵심 정리

- **HTML 엔티티(Entity)** : 특수 문자나 공백을 표현하는 코드
- 공백 여러 개 표현할 때 `&nbsp;` 사용
- 태그 문자 `< >` 를 그대로 출력하려면  
  `&lt;` , `&gt;` 사용

---

## Emmet 문법 (HTML 자동 생성)

Emmet은 HTML 구조를 **짧은 문법으로 빠르게 생성하는 기능**이다.  
VS Code 등 코드 에디터에서 많이 사용된다.

---

### 예제 코드

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>

    <!-- 자식 요소 선택 : '>' -->
    <!-- div>ul>li -->
    <div>
        <ul>
            <li></li>
        </ul>
    </div>

    <!-- div>p>ul>li -->
    <div>
        <p>
        <ul>
            <li></li>
        </ul>
        </p>
    </div>

    <!-- 형제 노드 : '+' -->
    <!-- div>ol+ul -->
    <div>
        <ol></ol>
        <ul></ul>
    </div>

    <!-- div>p+div+span -->
    <div>
        <p></p>
        <div></div>
        <span></span>
    </div>

    <!-- div>ul>li>a+ul -->
    <div>
        <ul>
            <li>
                <a href=""></a>
                <ul></ul>
            </li>
        </ul>
    </div>

    <!-- 상위 태그 이동 : '^' -->
    <!-- div>ul>li^p -->
    <div>
        <ul>
            <li></li>
        </ul>
        <p></p>
    </div>

    <!-- Nav 메뉴 구조 -->
    <!-- div>ul>li>a+ul>li*3 -->
    <div>
        <ul>
            <li>
                <a href=""></a>
                <ul>
                    <li></li>
                    <li></li>
                    <li></li>
                </ul>
            </li>
        </ul>
    </div>

    <hr />

    <!-- div>ul>li*4>a{$.MainMenu}+ul>li*5>a{$.SubMenu} -->

    <div>
        <ul>
            <li>
                <a href="">1.MainMenu</a>
                <ul>
                    <li><a href="">1.SubMenu</a></li>
                    <li><a href="">2.SubMenu</a></li>
                    <li><a href="">3.SubMenu</a></li>
                    <li><a href="">4.SubMenu</a></li>
                    <li><a href="">5.SubMenu</a></li>
                </ul>
            </li>
        </ul>
    </div>

    <!-- 클래스 선택자 -->
    <div class="c1"></div>
    <div class="abc"></div>

    <!-- ID 선택자 -->
    <div id="wrapper"></div>

    <!-- 속성 선택 -->
    <!-- ol[type='I']>li*4{Test_$} -->

    <ol type="I">
        <li>Test_1</li>
        <li>Test_2</li>
        <li>Test_3</li>
        <li>Test_4</li>
    </ol>

    <!-- 레이아웃 구조 -->

    <!-- .wrapper>header>.top-header+nav^main>section^footer -->

    <div class="wrapper">
        <header>
            <div class="top-header"></div>
            <nav></nav>
        </header>
        <main>
            <section></section>
        </main>
        <footer></footer>
    </div>

</body>

</html>
```

---

## Emmet 주요 문법 정리

| 문법 | 의미 | 예시 |
|-----|-----|-----|
| `>` | 자식 요소 | `div>ul>li` |
| `+` | 형제 요소 | `div>p+span` |
| `^` | 상위 요소 이동 | `div>ul>li^p` |
| `*` | 반복 생성 | `li*5` |
| `{}` | 텍스트 삽입 | `a{Menu}` |
| `$` | 자동 번호 | `li{item_$}` |
| `.` | class 생성 | `.container` |
| `#` | id 생성 | `#wrapper` |
| `[]` | 속성 추가 | `ol[type="A"]` |

---

## 예시

### 반복 생성

```
ul>li*3
```

결과

```
<ul>
  <li></li>
  <li></li>
  <li></li>
</ul>
```

---

### 메뉴 구조 생성

```
div>ul>li*4>a{$.MainMenu}+ul>li*5>a{$.SubMenu}
```

설명

- 메인 메뉴 4개 생성
- 각 메뉴마다 서브 메뉴 5개 생성
- `$` 는 자동 번호

---

## 레이아웃 구조 생성 예시

```
.wrapper>header>.top-header+nav^main>section^footer
```

결과 구조

```
wrapper
 ├ header
 │   ├ top-header
 │   └ nav
 ├ main
 │   └ section
 └ footer
```

---

## HTML 이미지 태그 (img)

### 기본 사용

```html
<a href="" target="_blank">
    <img style="width: 150px; height: 150px; border-radius: 50%;"
        src="./Images/이미지파일.jpg" alt="풍경">
</a>
```

### 이미지 경로 종류

| 경로 | 설명 |
|-----|-----|
| 로컬 경로 | `./Images/파일명.jpg` - 프로젝트 내부 경로 |
| 외부 경로 | `https://...` - 공개 URL (권한 필요) |
| Base64 | `data:image/jpeg;base64,/9j/4AAQ...` - 인라인 인코딩 |

- `alt` 속성 : 이미지 대체 텍스트 (접근성, 로딩 실패 시 표시)

---

## HTML 비디오 태그 (video)

### video 옵션

| 속성 | 설명 |
|-----|-----|
| `controls` | 하단 제어부 표시 여부 |
| `autoplay` | 자동 재생 |
| `muted` | 음소거 |
| `loop` | 무한 반복 |

### MIME TYPE

Client-Server 간 자료 교환 시 사용되는 표준화된 식별자

- 형식 : `type/subtype`
- type : video, image, text, application
- subtype : html, png, mp4, pdf

```html
<video autoplay muted loop>
    <source src="Video/파일.mp4" type="video/mp4">
</video>
```

---

## HTML 폼 (Form)

### form 기본 개념

- **form** : 사용자로부터 정보를 받아 서버로 전달하는 태그
- **action** : 전달받는 서버 URI
- **method** : 요청 방식
  - `GET` : Query String으로 전달 (기본값)
  - `POST` : Request body(Payload)로 전달
  - `PUT`, `PATCH`, `DELETE`

### input 종류

| type | 설명 |
|------|------|
| `text` | 텍스트 입력 |
| `password` | 비밀번호 (가려짐) |
| `email` | 이메일 형식 |
| `file` | 파일 선택 |
| `radio` | 단일 선택 (name 동일) |
| `checkbox` | 다중 선택 |
| `submit` | 전송 버튼 |
| `reset` | 초기화 버튼 |

### select / option

```html
<select>
    <option value="" selected>010</option>
    <option value="">011</option>
</select>
```

### label과 input 연결

```html
<input id="email-recv" name="email_recv" type="checkbox" /> 
<label for="email-recv">이메일 수신에 동의합니다.</label>
```

### 폼 유효성 검증 (HTML5)

- **required** : 필수 입력
- **pattern** : 정규표현식 검증
- **disabled** : 서버 전송 제외, 입력 불가
- **readonly** : 서버 전송 포함, 입력 불가

```html
<input name="password" type="password" required 
    pattern="(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}"
    title="최소 8자이상 영문 대/소문자를 섞어 입력하세요" />
```

---

## HTML 기타 input type

| type | 설명 |
|------|------|
| `search` | 검색 필드 |
| `url` | URL 형식 |
| `number` | 숫자 입력 |
| `date` | 날짜 선택 |
| `time` | 시간 선택 |
| `datetime` | 날짜+시간 |
| `datetime-local` | 로컬 날짜+시간 |

---

## HTML data-* 속성 (DataSet)

요소에 커스텀 데이터 저장, JavaScript에서 `dataset`으로 접근

```html
<div data-username="user1234" data-address="대구광역시 중구">계정명</div>
```

```javascript
const els = document.querySelectorAll('div');
els.forEach(el => console.log(el.dataset));
// dataset.username, dataset.address 로 접근
```

---

### 🔹 핵심 요약

1. **HTML 구조** : `<!DOCTYPE html>`, `<html>`, `<head>`, `<body>`  
2. **Block / Inline** : 레이아웃 구성 시 구분  
3. **리스트** : `ul`, `ol`, `li`  
4. **엔티티** : 특수 문자 & 공백 표현  
5. **Emmet** : 빠른 HTML 구조 생성  
6. **테이블** : `<table>` + rowspan/colspan  
7. **선택자** : class(.), id(#), 속성([])  
8. **레이아웃** : header, nav, main, section, footer  
9. **버튼/링크/iframe** : 클래스 스타일링, 새창/iframe 활용  
10. **이미지/비디오** : img 경로, video 옵션, MIME TYPE  
11. **폼** : action, method, input/select, 유효성 검증  
12. **data-*** : 커스텀 데이터 저장

---

### HTML 폴더 예제 파일 인덱스

| 파일 | 설명 |
|------|------|
| 01Basic.html | (71-183) Basic / (60-69) 단축키·확장 플러그인 |
| 02Basic.html | (106-217) block / inline, p, div, span |
| 03List.html | (225-365) ul, ol, li 리스트 |
| 04ListEx.html | (225-365) 리스트·중첩 리스트 예제 |
| 05Entity.html | (387-464) 엔티티 |
| 06Emmet.html | (466-678) Emmet 문법, 메뉴·레이아웃 구조 |
| 07Table.html | (822) table, rowspan/colspan |
| 07-1TableEx.html | (822) 테이블 예제 |
| 08Table.html | (822) 테이블 활용 |
| 09ATag.html | (680-701) a, img, target _blank / (466-678) Emmet |
| 10ATag.html | (660-677) 레이아웃 구조 생성 예시 |
| 12Video.html | (703-728) video, MIME TYPE |
| 13video.html | (703-728) 비디오 예제 |
| 14form.html | (730-783) form, input, select, label |
| 15form_add_css.html | (730-783) 폼 + CSS |
| 16Form_only_html.html | (730-754) form 기본 개념, input 종류 |
| 17Form_only_css.html | (730-783) form + CSS |
| 18Form_only_bs.html | (730-783) form + Bootstrap |
| 19myForm.html | (730-783) 폼 예제 |
| 20form_validation.html | (770-783) 폼 유효성 검증 (HTML5) |
| 21DataSet.html | (799-813) data-* 속성 (DataSet) |
| 22etc_input.html | (785-797) 기타 input type |
| 99form_only_html.html | (730-783) 폼 연습 |

---

## CSS

스타일링 담당 - 색상, 크기, 레이아웃, 디자인

---

### CSS 폴더 예제 파일 인덱스

| 폴더 | 파일 | 설명 |
|------|------|------|
| **01BASIC** | 01Block_vs_Inline.html | (934-950) Block vs Inline (display) |
| | 02StylePiority.html | (952-962) 스타일 우선순위 |
| | 03WidthHeight.html | (964-973) Width / Height |
| | 04Color.html | (975-984) Color |
| | 05단위.html | (986-1003) 단위 |
| | 06Background.html | (1005-1015) Background |
| | 07textBasic.html | (1017-1028) 텍스트 스타일 |
| | 08FontSize.html | (1030-1048) Font Size |
| | 09FontFamily.html | (1050-1068) Font Family |
| | css/common.css | 공통 스타일 |
| **02BOX** | 01Margin.html | (1070-1094) Margin |
| | 02padding.html | (1096-1107) Padding |
| | 03border.html | (1109-1127) Border |
| | 04BoxSizing.html | (1129-1142) Box Sizing |
| | 05Overflow.html | (1144-1160) Overflow |
| **03SELECTOR** | 01.html | (1162-1179) 선택자 기초 |
| | 02.html | (1182-1192) 자식/자손 선택자 |
| | 03.html | (1182-1192) 자식 선택자 레이아웃 예제 |
| | 04.html | (1194-1204) 동위(형제) 선택자 |
| | 05.html | (1206-1213) 속성 선택자 |
| | 06.html | (1215-1235) 의사 클래스, :checked + label |
| | 07.html | (1215-1235) 의사 클래스 (:hover, :active, :visited) |
| | 08.html | (1237-1245) 의사 요소 (::before, ::after) |
| | 09.html | (1215-1235) :nth-child |
| **04POSITION** | 01Relative.html | (1248-1279) Position |
| | 02Absolute.html | (1248-1279) Position |
| | 03GnB_origin.html | (1455-1504) GNB |
| | 04GnB_01.html ~ 08GnB_05.html | (1455-1504) GNB |
| | 09FIxed.html | (1248-1279) fixed |
| | 10sticky.html | (1248-1279) sticky |
| | 11index.html | (1248-1279) position 종합 |
| | 98GnB_Ex.html | (1455-1504) GNB 연습 |
| | 99_GNB_practice.html | (1455-1504) GNB 연습 |
| **05LAYOUT** | 01Flex.html | (1281-1301) Flexbox |
| | 02Flex.html | (1281-1301) Flexbox |
| | 03flex_solve.html | (1281-1301) Flex 연습 |
| | 04Flex_solved.html | (1281-1301) Flex 연습 정답 |
| | 05Grid.html | (1303-1330) Grid |
| | 06KREAM_Layout.html | (1332-1338) KREAM 스타일 레이아웃 |
| **06ANIMATION** | 01Transition.html | (1340-1360) Transition |
| | 02Transition.html | (1340-1360) Transition |
| | 03Transform.html | (1362-1385) Transform |
| | 04Sitemenu.html | (1340-1385) Transition, Transform |
| | 05Transform3D.html | (1362-1385) Transform 3D |
| | 06Transform3D.html | (1362-1385) Transform 3D |
| | 07Animation.html | (1387-1413) Animation (@keyframes) |
| | 08Animation.html | (1387-1413) Animation |
| | 09Animation.html | (1387-1413) Animation |
| | 10Animation.html | (1387-1413) Animation |
| | 11Ball.html | (1387-1413) Animation |
| | 12Slider.html | (1415-1422) 슬라이더 예제 |
| | 13Slider.html | (1415-1422) 슬라이더 예제 |
| | 14Slider.html | (1415-1422) 슬라이더 예제 |
| **07MQ** | 01.html | (1424-1453) 미디어 쿼리 |
| | 02.html | (1424-1453) 미디어 쿼리 (link media) |
| | css/desktop.css | (1424-1453) |
| | css/tablet.css | (1424-1453) |
| | css/mobile.css | (1424-1453) |
| **CSS 루트** | yo.html | 기타 연습용 |

---

### Block vs Inline (display)

Block 요소와 Inline 요소의 `display` 속성 차이

| display | Block | Inline | Inline-block |
|---------|-------|--------|--------------|
| width/height | O | X | O |
| margin | O | left, right만 | O |
| padding | O | O | O |
| 한 행 사용 | 전체 | 공유 | 공유 |

```css
div { display: inline; }   /* block → inline */
span { display: inline-block; }  /* width, height 적용 가능 */
```

---

### 스타일 우선순위 (Cascading)

- 점수 동일 시 **마지막** 스타일 적용
- **인라인 스타일** > head 내 `<style>` > 외부 CSS
- `!important` : 우선순위 최상향 (유지보수 시 주의)

```css
h1 { background-color: orange !important; }
```

---

### Width / Height

| 속성 | 설명 |
|------|------|
| `width` | auto (기본: 최대 너비) |
| `height` | auto (기본: 최소 높이) |
| `min-width` / `max-width` | 최소/최대 너비 |
| `min-height` / `max-height` | 최소/최대 높이 |

---

### Color (색상 표현)

| 표현 | 예시 |
|------|------|
| 키워드 | `color: red` |
| rgb | `color: rgb(150, 200, 200)` |
| rgba | `color: rgba(150, 200, 200, 0.5)` (알파 투명도) |
| hex | `color: #A0F500` |

---

### 단위 (크기)

| 단위 | 설명 | 기준 |
|------|------|------|
| `px` | 고정 크기 | 픽셀 |
| `%` | 가변 크기 | 상위 요소 |
| `vw` | 가변 크기 | 뷰포트 너비 (1vw = 1%) |
| `vh` | 가변 크기 | 뷰포트 높이 |

```css
/* 상위 300px 중 50% */
width: 50%;

/* 뷰포트 너비의 50% */
width: 50vw;
```

---

### Background (배경)

| 속성 | 설명 |
|------|------|
| `background-color` | 배경 색상 |
| `background-image` | 배경 이미지 `url(경로)` |
| `background-repeat` | 반복 `repeat` / `no-repeat` |
| `background-size` | `cover`(채우기) / `contain`(비율 유지) |
| `background-attachment` | `fixed`(고정) / `scroll` |

---

### 텍스트 스타일

| 속성 | 설명 |
|------|------|
| `letter-spacing` | 글자 간격 |
| `word-spacing` | 단어 간격 |
| `line-height` | 줄 높이 (세로 가운데: height와 동일) |
| `text-align` | 정렬 `left` / `center` / `right` |
| `text-decoration` | `overline` / `underline` / `line-through` / `none` |
| `font-weight` | 100~900 (400: normal, 700: bold) |

---

### Font Size (글자 크기 단위)

| 단위 | 설명 | 기준 |
|------|------|------|
| `px` | 고정 크기 | 픽셀 |
| `em` | 배수 | 부모 font-size |
| `rem` | 배수 | root(`:root`) font-size |
| `%` | 비율 | 부모 font-size |
| `vw` | 뷰포트 | 화면 너비 비율 |

```css
:root { font-size: 16px; }

font-size: 1em;   /* 부모의 1배 */
font-size: 1rem;  /* root의 1배 = 16px */
font-size: clamp(16px, 3vw, 80px);  /* 최소 16px, 최대 80px */
```

---

### Font Family (글꼴)

```css
/* 시스템 폰트 (fallback) */
font-family: 'Times New Roman', Times, serif;

/* @font-face로 로컬 폰트 등록 */
@font-face {
    font-family: "custom-01";
    src: url(./fonts/MaruBuri-Bold.ttf);
}
font-family: custom-01;

/* Google Font (CDN) */
/* <link href="https://fonts.googleapis.com/css2?family=Orbitron&display=swap" rel="stylesheet"> */
font-family: "Orbitron", sans-serif;
```

---

### Margin (여백)

```css
/* 1값: 전체 | 2값: 상하 좌우 | 3값: 상 좌우 하 | 4값: 상 우 하 좌 */
margin: 20px;
margin: 20px 40px;
margin: 10px 20px 30px;
margin: 10px 20px 30px 40px;

/* 가운데 정렬 */
margin: 0 auto;

/* 개별 지정 */
margin-top: 10px;
margin-bottom: 20px;
margin-left: 30px;
margin-right: 40px;
```

**가운데 정렬 방법**
1. `margin: 0 auto` (block 요소)
2. `display: flex` + `justify-content: center` + `align-items: center`
3. `position: absolute` + `left/right/top/bottom: 0` + `margin: auto`

---

### Padding (안쪽 여백)

```css
padding: 10px;              /* 전체 */
padding: 10px 20px;         /* 상하 좌우 */
padding: 10px 20px 30px;    /* 상 좌우 하 */
padding: 10px 20px 30px 40px;  /* 상 우 하 좌 */
```

버튼 스타일 예: `padding: 10px 20px` (상하 10px, 좌우 20px)

---

### Border (테두리)

```css
/* 개별 방향 */
border-top: 2px solid red;
border-right: 3px dashed black;
border-bottom: 4px dotted blue;
border-left: 5px double green;

/* border-radius */
border-radius: 10px;
border-radius: 20px 40px;      /* 1,3 / 2,4 모서리 */
border-radius: 10px 20px 30px 40px;  /* 시계방향 */
border-radius: 50%;            /* 원형 */
```

**삼각형 만들기**: `width: 0; height: 0` + 한쪽 border만 색상 지정, 나머지 `transparent`

---

### Box Sizing

기본값은 `content-box`이며, 이 경우 `padding`/`border`가 **width/height 바깥으로 추가**되어 실제 박스가 커질 수 있음.  
`border-box`는 `padding`/`border`를 **width/height 안에 포함**시켜 레이아웃 계산이 쉬움.

```css
/* 기본값 */
box-sizing: content-box;

/* 권장 */
box-sizing: border-box;
```

---

### Overflow

컨텐츠가 박스를 넘칠 때 처리.

| 값 | 설명 |
|---|---|
| `visible` | 넘친 컨텐츠 그대로 표시 (기본) |
| `hidden` | 넘친 부분 숨김 |
| `scroll` | 항상 스크롤바 표시 |
| `auto` | 필요할 때만 스크롤바 표시 |

```css
.parent { overflow: auto; }
/* overflow-x, overflow-y 로 축별 제어 가능 */
```

---

### Selector (선택자) 기초

| 선택자 | 형태 | 의미 |
|---|---|---|
| 전체 선택자 | `*` | 모든 요소 |
| 요소 선택자 | `div`, `span` | 태그로 선택 |
| ID 선택자 | `#id` | 유일한 요소 1개 (권장: 페이지 내 1번만) |
| class 선택자 | `.class` | 여러 요소 그룹 |
| 그룹 선택자 | `A, B` | 여러 선택자 동시 적용 |

```css
* { box-sizing: border-box; }
div { width: 150px; height: 150px; }
#id_01 { background: red; }
.c1 { background: royalblue; }
#id_01, .c1 { border-radius: 50px; }
```

---

### 자식/자손 선택자

- **자식 선택자**: `A > B` (바로 아래 1단계)
- **자손 선택자**: `A B` (하위 모든 단계)

```css
.parent > p { color: orange; }
.parent p { background: royalblue; }
```

---

### 동위(형제) 선택자

- `A + B` : A 바로 다음의 형제 1개
- `A ~ B` : A 다음의 형제 전체

```css
.c2 + p { width: 200px; }
.c2 ~ p { background-color: orange; }
```

---

### 속성 선택자

```css
input[type="checkbox"] { display: none; }
input[type="checkbox"] + label { cursor: pointer; }
```

---

### 의사 클래스 선택자 (Pseudo-class)

상태/구조에 따라 스타일 적용.

```css
/* 링크 상태 */
.btn:hover { opacity: 1; }
.btn:active { background: black; color: white; }
.btn:visited { color: green; }

/* 체크 상태 */
input[type="checkbox"]:checked + label { background-color: lightgreen; }

/* 구조 선택 */
li:first-child { background: red; }
li:last-child { background: orange; }
li:nth-child(2n) { border: 5px solid; }
li:nth-child(2n+1) { border: 5px solid blue; }
```

---

### 의사 요소 선택자 (Pseudo-element)

요소의 특정 “부분”을 생성/선택 (`::before`, `::after`).

```css
div::before { content: '😢'; }
div::after { content: '🤬'; }
```

---

### Position (위치 지정)

| 값 | 기준점 |
|----|--------|
| `static` | 기본값, 문서 흐름 그대로 |
| `relative` | **원래 위치(static)** 기준으로 `top`/`left` 등으로 이동 |
| `absolute` | **position이 있는 가장 가까운 상위 요소** 기준 (없으면 viewport) |
| `fixed` | viewport 기준 (스크롤해도 고정) |
| `sticky` | 스크롤 시 `top`/`left` 값만큼 고정 (흐름 있다가 특정 지점에서 고정) |

```css
/* relative: 원래 위치 기준 offset */
position: relative;
left: 20px;
top: -10px;

/* absolute: 상위 relative/absolute 요소 기준 */
.parent { position: relative; }
.son {
    position: absolute;
    top: 0;
    left: 0;
    bottom: -1px;
    right: -10px;
}
```

**absolute 기준**: 상위에 `position: relative`(또는 absolute)가 없으면 **viewport** 기준.

**sticky**: 스크롤 전에는 일반 흐름, 스크롤 시 `top`(또는 `left`)에 도달하면 그 위치에 고정. 예제: `04POSITION/10sticky.html`

---

### Flexbox (플렉스 레이아웃)

단일 행/열 기준 배치. 예제: `05LAYOUT/01Flex.html`, `02Flex.html`

| 속성 (컨테이너) | 설명 |
|-----------------|------|
| `display: flex` | Flex 컨테이너로 지정 |
| `flex-direction` | `row` / `column` / `row-reverse` / `column-reverse` |
| `justify-content` | 주축 정렬: `start`, `end`, `center`, `space-between`, `space-around`, `space-evenly` |
| `align-items` | 교차축 정렬: `start`, `end`, `center`, `stretch` |
| `flex-wrap` | `nowrap`(한 줄) / `wrap`(줄바꿈) |
| `gap` | 자식 간 간격 |

| 속성 (자식) | 설명 |
|-------------|------|
| `flex-grow` | 남는 공간 비율로 확장 |
| `flex-shrink` | 부족 시 축소 비율 |
| `flex-basis` | 기본 크기 (예: `200px`) |
| `align-self` | 해당 자식만 교차축 정렬 (`flex-start`, `flex-end`, `center`, `stretch`) |

---

### Grid (그리드 레이아웃)

행·열 기준 배치. 예제: `05LAYOUT/05Grid.html`

```css
.grid-container {
    display: grid;
    grid-template-columns: 1fr 2fr 1fr;   /* repeat(3, 1fr) 가능 */
    grid-template-rows: 1fr 1fr 1fr;
    gap: 10px;
}

/* 영역 이름으로 배치 */
.grid-areas {
    display: grid;
    grid-template-areas:
        'header header header'
        'sidebar main main'
        'footer footer footer';
    gap: 10px;
}
.header { grid-area: header; }
.sidebar { grid-area: sidebar; }
.main { grid-area: main; }
.footer { grid-area: footer; }
```

---

### KREAM 스타일 레이아웃

실전 레이아웃 예제: `05LAYOUT/06KREAM_Layout.html`  
- 1280px 중앙 레이아웃, 상단 헤더·네비·메인 구조  
- Flex로 상단/네비 배치, Google Material Icons 사용

---

### Transition (전환)

속성 값이 바뀔 때 **일정 시간에 걸쳐** 부드럽게 변하게 함. 예제: `06ANIMATION/01Transition.html`, `02Transition.html`

| 속성 | 설명 |
|------|------|
| `transition-property` | 전환할 속성 (all 또는 width, background-color 등) |
| `transition-duration` | 지속 시간 (예: `.5s`, `1s`) |
| `transition-timing-function` | 가속도: `ease`, `linear`, `ease-in`, `ease-out` |
| `transition-delay` | 시작 지연 시간 |

```css
div {
    transition: 1s;                    /* duration만 */
    transition: .5s ease;              /* duration + timing */
    transition: width .5s, background .3s;
}
div:hover { width: 500px; background-color: aqua; }
```

---

### Transform (변형)

요소의 **위치·크기·회전·기울기**를 변경. 레이아웃 흐름에는 영향 없음. 예제: `06ANIMATION/03Transform.html`, `05Transform3D.html`, `06Transform3D.html`

| 함수 | 설명 |
|------|------|
| `translate(x, y)` / `translateX`, `translateY` | 이동 |
| `scale(x, y)` | 크기 비율 (2 = 2배) |
| `rotate(deg)` | 2D 회전 (단위: deg) |
| `skew(x, y)` | 기울이기 |
| `perspective(npx)` | 3D 원근 (부모에 지정) |
| `rotateX`, `rotateY`, `rotateZ` | 3D 회전 |

```css
.son:hover {
    transform: translate(400px, 400px) scale(2) rotate(360deg);
}
/* 3D */
.container:hover > .item {
    transform: perspective(100px) rotateY(180deg);
}
```

---

### Animation (@keyframes)

**키프레임**으로 구간별 스타일을 정의하고, 요소에 `animation-*` 속성으로 적용. 예제: `06ANIMATION/07Animation.html`, `09Animation.html`, `11Ball.html`

| 속성 | 설명 |
|------|------|
| `animation-name` | @keyframes 이름 |
| `animation-duration` | 한 사이클 시간 |
| `animation-iteration-count` | 반복 횟수 (`infinite` 가능) |
| `animation-direction` | `normal` / `alternate`(왕복) |
| `animation-timing-function` | `linear`, `ease-in`, `ease-out` 등 |
| `animation-play-state` | `running` / `paused` (hover에서 정지 등) |

```css
@keyframes moving {
    from { margin-left: 100%; }
    to   { margin-left: 0%; }
}
div {
    animation-name: moving;
    animation-duration: 2s;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}
```

---

### 슬라이더 예제

`06ANIMATION/12Slider.html`, `13Slider.html`, `14Slider.html`  
- `overflow: hidden` + 넓은 wrapper + `@keyframes`로 좌우 이동  
- `animation-play-state: paused` on hover 로 멈춤  
- 자식 아이템에 `transform: scale(1.5)` 등으로 강조 가능

---

### 미디어 쿼리 (Media Query, 07MQ)

화면 너비 등 조건에 따라 **다른 CSS**를 적용. 반응형 레이아웃의 기본. 예제: `07MQ/01.html`, `07MQ/02.html`

**방법 1: 같은 파일 안에서 @media**

```css
/* 기본: 데스크톱 */
div { height: 150px; background-color: orange; }

@media all and (max-width: 1024px) {
    div { background-color: green; height: 100px; }
}
@media all and (max-width: 400px) {
    div { background-color: royalblue; height: 50px; }
}
```

**방법 2: link 태그에 media 속성**

```html
<link rel="stylesheet" href="./css/desktop.css">
<link rel="stylesheet" href="./css/tablet.css" media="all and (max-width:1024px)">
<link rel="stylesheet" href="./css/mobile.css" media="all and (max-width:400px)">
```

- `07MQ/01.html`: 한 HTML에 `<style>` 내부에 `@media` 작성  
- `07MQ/02.html`: desktop / tablet / mobile CSS 파일 분리 후 `link`의 `media`로 로드

---

### GNB (글로벌 네비게이션 바)

**가로 GNB + 서브메뉴 (아래로 펼침)**

```css
.main-menu {
    display: flex;
    justify-content: space-around;
    height: 50px;
}
.main-menu > li {
    position: relative;
}
.sub-menu {
    position: absolute;
    left: 0;
    top: 50px;
    display: none;
}
.main-menu > li:hover > .sub-menu {
    display: block;
}
```

**세로 GNB + 서브메뉴 (오른쪽으로 펼침)**

```css
.main-menu {
    display: flex;
    flex-direction: column;
}
.main-menu > li {
    position: relative;
    width: 150px;
}
.sub-menu {
    position: absolute;
    left: 150px;
    top: 0;
    display: none;
}
.main-menu > li:hover > .sub-menu {
    display: block;
}
```

- 부모 `position: relative` + 자식 `position: absolute` 로 서브메뉴 위치 지정
- `:hover` + `display: none/block` 으로 토글
- `transition` 으로 애니메이션 추가 가능

---

### CSS 핵심 요약

1. **display** : block / inline / inline-block 구분  
2. **우선순위** : !important > 인라인 > style > 외부 CSS  
3. **크기** : width/height, min/max  
4. **색상** : rgb, rgba, hex  
5. **단위** : px(고정), %·vw·vh(가변), em·rem(폰트)  
6. **배경** : image, repeat, size, attachment  
7. **텍스트** : letter/word-spacing, line-height, text-align, font-weight  
8. **폰트** : font-family, @font-face, Google Font  
9. **박스** : box-sizing, margin(바깥 여백), padding(안쪽 여백), border(테두리)  
10. **오버플로우** : overflow, overflow-x/y  
11. **선택자** : 기본/조합/속성/가상 선택자 (예제: `03SELECTOR/01.html`~`09.html`)  
12. **position** : relative, absolute, fixed, **sticky**(스크롤 시 고정)  
13. **Flexbox** : display: flex, direction, justify-content, align-items, gap, wrap, flex-grow/shrink/basis (예제: `05LAYOUT/01Flex.html`, `02Flex.html`)  
14. **Grid** : grid-template-columns/rows, grid-template-areas, gap (예제: `05LAYOUT/05Grid.html`)  
15. **GNB** : relative + absolute, hover로 서브메뉴 토글  
16. **가운데 정렬** : margin: 0 auto, flex, position  
17. **Transition** : transition-duration, timing-function (예제: `06ANIMATION/01Transition.html`, `02Transition.html`)  
18. **Transform** : translate, scale, rotate, skew, 3D perspective/rotateY (예제: `06ANIMATION/03Transform.html`, `05Transform3D.html`)  
19. **Animation** : @keyframes, animation-name/duration/iteration-count/direction, play-state (예제: `06ANIMATION/07Animation.html`, `11Ball.html`, `12Slider.html`)  
20. **미디어 쿼리** : @media (max-width), link media (예제: `07MQ/01.html`, `02.html`)  
21. **예제 파일** : CSS 폴더 내 `01BASIC`, `02BOX`, `03SELECTOR`, `04POSITION`, `05LAYOUT`, `06ANIMATION`, `07MQ` 참고  

---

## JavaScript

동적 처리

- 브라우저 기능 사용
- 사용자 이벤트 처리
- 객체지향 문법 기반

---

### onclick (이벤트 속성)

HTML 요소에 **클릭 시 실행할 JavaScript**를 넣을 때 씀. 버튼·링크 등에 사용.

```html
<button onclick="alert('Hello World')">Btn_1</button>
<button onclick="alert(10 + 20)">Btn_2</button>
```

- 클릭하면 `onclick` 뒤 따옴표 안 코드가 실행됨
- 예: 문자열 알림, 계산식 결과(30), `\n` 줄바꿈 문자열 등

---

### alert()

브라우저가 **알림창(팝업)**을 띄우는 함수. 인자로 준 문자열·숫자 등을 그대로 보여 줌.

```javascript
alert('Hello World');   // 알림창에 Hello World
alert(10 + 20);        // 알림창에 30
alert('A\nB\nC');      // 알림창에 A, B, C 세 줄
```

- 사용자가 확인 버튼을 누르기 전까지 다음 코드는 실행되지 않음

---

### href="javascript:..."

`<a>` 태그에서 **클릭 시 페이지 이동 대신 JavaScript 실행**할 때 씀.

```html
<a href="javascript:void(0)">아무 동작 없음</a>
<a href="javascript:alert('HELLOWORLD')">BTN_2</a>
```

- `javascript:` 뒤에 올 표현식이 실행됨
- `void(0)` 은 아무 값도 반환하지 않아서, 링크만 눌렀을 때 아무 동작도 안 함

---

### document.write

문서에 **HTML 문자열을 그대로 출력**하는 메서드. 주로 예제·테스트용.

```javascript
document.write('<h1>HELLO WORLD</h1>');
```

- 호출 시점에 문서에 바로 쓰여서, 로드 후에 쓰면 기존 내용이 다 지워질 수 있음

---

### getElementById, innerHTML

**id로 요소를 찾아서**, 그 요소 **안의 HTML/텍스트를 바꿀 때** 씀.

```javascript
document.getElementById('d1');        // id="d1" 인 요소
document.getElementById('d1').innerHTML = '<h2>ABCD</h2>';  // 내용 변경
```

| 메서드 / 속성 | 설명 |
|---------------|------|
| `getElementById('id값')` | id로 요소 한 개 찾기 |
| `innerHTML` | 요소 안의 HTML 문자열 읽기·쓰기 |

---

### typeof

**값의 타입**이 뭔지 문자열로 알려 주는 연산자.

```javascript
typeof 10;           // "number"
typeof "HELLO";      // "string"
typeof {};           // "object"
typeof null;         // "object" (예외)
typeof undefined;    // "undefined"
typeof true;         // "boolean"
```

---

### 보간법 (템플릿 리터럴)

**백틱(``)** 문자열 안에서 `${표현식}` 으로 변수·계산 결과를 넣는 문법.

```javascript
let str1 = 'hello', str2 = 'world';
`TEST1 : ${str1} / ${str2}`   // "TEST1 : hello / world"
`TEST2 : ${10 + 20 + 30}`     // "TEST2 : 60"
```

- 일반 따옴표 `'...'`, `"..."` 에서는 `${}` 가 그대로 문자로 나옴. **백틱에서만** 보간됨

---

### 객체 (Object), this

**속성(key)과 값(value)** 묶음. 함수를 넣으면 그 객체의 **메서드**가 되고, 메서드 안에서는 `this` 가 그 객체를 가리킴.

```javascript
const MyCar = {
    owner: '홍길동',
    currentSpeed: 0,
    Accel: function() { this.currentSpeed += 10; },
    Break: function() { this.currentSpeed -= 10; }
};
MyCar.Accel();   // this === MyCar
```

| 개념 | 설명 |
|------|------|
| `{ key: value }` | 객체 리터럴 |
| 메서드 | 객체 안의 함수 (예: `Accel`, `Break`) |
| `this` | 메서드가 호출될 때, 그 메서드를 가진 객체 |

---

### 배열 (Array)

**순서가 있는 값의 나열.** index(0부터)로 접근하고, `push`/`pop`, `forEach`, `sort` 등으로 다룸.

```javascript
let arr = ['str1', 'str2', 'str3'];
arr[0];              // "str1"
arr.push('aaa');     // 맨 뒤에 추가
arr.pop();           // 맨 뒤 제거
arr.forEach((item, idx) => { console.log(idx, item); });
arr.sort((a, b) => a - b);   // 오름차순
```

| 메서드 / 개념 | 설명 |
|---------------|------|
| `arr[index]` | index번째 요소 접근 |
| `push(값)` | 맨 뒤에 추가 |
| `pop()` | 맨 뒤 제거 |
| `forEach(콜백)` | 요소를 순서대로 하나씩 넘겨서 처리 |
| `sort(비교함수)` | 배열 정렬 (비교함수 생략 시 문자열 기준) |

---

### querySelector, value

**CSS 선택자 방식으로 요소를 찾고**, 입력창·선택창의 **현재 값**을 읽거나 쓸 때 씀.

```javascript
const koreaInput = document.querySelector('.korea');
const restaurantEl = document.querySelector('.select-restorant');

koreaInput.value;             // 입력값 읽기
restaurantEl.value = '식당명'; // 값 넣기
```

| 메서드 / 속성 | 설명 |
|---------------|------|
| `querySelector('선택자')` | CSS 선택자로 요소 한 개 찾기 |
| `.value` | input, select 등의 현재 값 읽기·쓰기 |

---

### Number()

`input.value` 는 **문자열(string)** 이라서, **계산하기 전에 숫자로 변환**할 때 자주 씀.

```javascript
const kor = document.querySelector('.korea').value;
const eng = document.querySelector('.english').value;

const sum = Number(kor) + Number(eng);
```

- `"10" + "20"` 은 문자열 결합이라 `"1020"` 이 됨
- `Number(...)` 로 바꾸면 `10 + 20` 처럼 숫자 계산 가능

---

### filter, map, reduce

배열이나 오픈데이터에서 **조건 추출**, **형태 변환**, **누적 계산**할 때 가장 많이 쓰는 조합.

```javascript
const koreanFoods = dataArray.filter(item => item.FD_CS == '한식');
const japaneseFoods = dataArray
    .filter(item => item.FD_CS == '일식')
    .map(item => ({ 상호명: item.BZ_NM, 메뉴: item.MNU }));

const deptTotal = employees.reduce((sum, item) => {
    sum[item.department] = (sum[item.department] || 0) + item.salary;
    return sum;
}, {});
```

| 메서드 | 설명 |
|--------|------|
| `filter(조건)` | 조건에 맞는 요소만 골라 새 배열 반환 |
| `map(변환)` | 각 요소를 다른 형태로 바꾼 새 배열 반환 |
| `reduce(누적로직, 초기값)` | 합계, 통계, 묶음 만들기 등 누적 처리 |

---

### document.createElement, appendChild

JavaScript로 **새 HTML 요소를 만들고**, 화면에 **붙일 때** 씀. `select > option` 채우기에서 자주 사용.

```javascript
const optionEl = document.createElement('option');
optionEl.innerHTML = item.BZ_NM;
selectRestorantEl.appendChild(optionEl);
```

| 메서드 | 설명 |
|--------|------|
| `createElement('태그명')` | 새 요소 노드 생성 |
| `appendChild(노드)` | 부모 요소의 맨 뒤에 자식 노드 추가 |

---

### Object.entries()

객체를 **`[key, value]` 형태의 배열**로 바꿔서 반복문이나 `forEach` 로 처리할 때 사용.

```javascript
const categoryList = { 한식: 10, 일식: 4 };

Object.entries(categoryList).forEach(item => {
    console.log(item[0], item[1]); // key, value
});
```

| 메서드 | 설명 |
|--------|------|
| `Object.entries(obj)` | 객체를 `[key, value]` 배열 묶음으로 변환 |
| `item[0]` | key |
| `item[1]` | value |

---

### Object 유틸리티 메서드

객체를 다루는 기본 함수 제공.

| 메서드 | 설명 |
|--------|------|
| `Object.keys(obj)` | 객체의 key를 배열로 변환 |
| `Object.values(obj)` | 객체의 value를 배열로 변환 |
| `Object.entries(obj)` | 열거 가능한 속성을 `[key, value]` 배열로 변환 |
| `Object.assign(target, ...sources)` | 여러 객체를 병합하여 target에 반영 |
| `Object.freeze(obj)` | 객체 읽기 전용 (수정·추가 불가) |

```javascript
const obj = { name: "김", age: 25 };
Object.keys(obj);    // ["name", "age"]
Object.values(obj);  // ["김", 25]
Object.entries(obj); // [["name", "김"], ["age", 25]]

Object.freeze(obj);
obj.name = "이";     // 무시됨
obj.hobby = "등산";  // 추가 안 됨
```

---

### Object.prototype

**Object.prototype**은 자바스크립트의 모든 객체가 상속하는 프로토타입 체인의 최상위 객체.

| 메서드/속성 | 설명 |
|-------------|------|
| `toString()` | 객체를 문자열로 변환 |
| `hasOwnProperty(prop)` | 해당 속성을 직접 소유하는지 확인 |
| `isPrototypeOf(obj)` | 프로토타입 체인에 존재하는지 확인 |
| `valueOf()` | 객체의 원시 값 표현 반환 |
| `constructor` | 객체를 생성한 생성자 함수 참조 |

---

### 프로토타입 기초 (생성자 + prototype)

생성자 함수와 `prototype`으로 **메서드 재정의** 및 **기능 추가(Extends)** 가능.

```javascript
function Person(name) {
    this.name = name;
    this.getName = function() { console.log(this.name); };
}
// toString 재정의
Person.prototype.toString = function() {
    return `toString 재정의 : ${this.name}`;
};
// 새 기능 추가
Person.prototype.helloworld = function() {
    console.log(`${this.name} HELLO WORLD`);
};

const person1 = new Person("김");
person1.toString();    // "toString 재정의 : 김"
person1.helloworld();  // "김 HELLO WORLD"
```

| 개념 | 설명 |
|------|------|
| `생성자.prototype.메서드` | 해당 생성자로 만든 모든 인스턴스가 공유하는 메서드 |
| `new 생성자()` | prototype을 상속한 인스턴스 생성 |

---

### 프로토타입 상속 (Object.create)

상위 생성자 → 하위 생성자로 **상속 체인**을 만들 때 사용.

```javascript
// 상위
function Animal(name) {
    this.name = name;
}
Animal.prototype.toString = function() {
    return `toString 재정의 : ${this.name}`;
};

// 하위 (Animal 상속)
function Dog(name, kind) {
    Animal.call(this, name);  // 상위 생성자 호출
    this.kind = kind;
}
Dog.prototype = Object.create(Animal.prototype);  // 상속 연결
Dog.prototype.toString = function() {
    return `toString 재정의 : ${this.name}, ${this.kind}`;
};

// 하위의 하위 (Dog 상속)
function 포매라니안(name, kind, color) {
    Dog.call(this, name, kind);
    this.color = color;
}
포매라니안.prototype = Object.create(Dog.prototype);
포매라니안.prototype.toString = function() {
    return `toString 재정의 : ${this.name}, ${this.kind}, ${this.color}`;
};

const knife = new 포매라니안("검", "포매라니안", "검정");
knife.toString();  // "toString 재정의 : 검, 포매라니안, 검정"
```

| 패턴 | 설명 |
|------|------|
| `상위.call(this, ...args)` | 하위 생성자에서 상위 생성자 호출 (속성 상속) |
| `하위.prototype = Object.create(상위.prototype)` | prototype 체인 연결 (메서드 상속) |

---

### 산술 연산자 (Arithmetic Operators)

| 연산자 | 설명 |
|--------|------|
| `+` | 덧셈 |
| `-` | 뺄셈 |
| `*` | 곱셈 |
| `/` | 나눗셈 |
| `%` | 나머지 (짝홀수, 배수, 끝자리수, 수 범위 제한 등에 활용) |
| `++` | 증가 (전치 `++n` / 후치 `n++`) |
| `--` | 감소 |

```javascript
4 % 2 == 0 && '짝수입니다.';   // 짝수 판별
123456 % 10;                   // 끝 1자리 (6)
123456 % 100;                  // 끝 2자리 (56)
(parseInt(Math.random() * 100) % 45 + 1);  // 1~45 범위 난수

// 전치 vs 후치
let n1 = 10;
n1++;   // 후치: 다른 연산 처리 후 증가
++n1;   // 전치: 증가 후 다른 연산
```

---

### 할당 연산자 (Assignment Operators)

| 연산자 | 설명 | 동등 표현 |
|--------|------|-----------|
| `=` | 할당 | - |
| `+=` | 더해서 할당 | `n1 = n1 + n2` |
| `-=` | 빼서 할당 | `n1 = n1 - n2` |
| `*=` | 곱해서 할당 | `n1 = n1 * n2` |
| `/=` | 나눠서 할당 | `n1 = n1 / n2` |
| `%=` | 나머지를 할당 | `n1 = n1 % n2` |

---

### 비교 연산자 (Comparison Operators)

조건식 생성에 사용. 이항 연산자.

| 연산자 | 설명 |
|--------|------|
| `==` | 동등 비교 (타입 변환 후 비교) |
| `===` | 일치 비교 (값 + 자료형 모두 일치) |
| `!=` | 부등 비교 |
| `!==` | 불일치 비교 |
| `>`, `<`, `>=`, `<=` | 크다, 작다, 크거나 같다, 작거나 같다 |

```javascript
'123' == 123;   // true (문자열→숫자 변환 후 비교)
'123' === 123;  // false (타입이 다름)
```

---

### 논리 연산자 (Logical Operators)

| 연산자 | 설명 | 단축 평가 |
|--------|------|-----------|
| `&&` | 논리 AND | 왼쪽이 **참**이면 오른쪽 실행 |
| `\|\|` | 논리 OR | 왼쪽이 **거짓**이면 오른쪽 실행 |
| `!` | 논리 NOT | 반대값 반환 |

```javascript
// AND: 둘 다 참이어야 참
10 > 5 && "data";   // "data" (왼쪽 참 → 오른쪽 반환)
10 < 5 && "data";   // false (왼쪽 거짓 → 오른쪽 미실행)

// OR: 하나만 참이어도 참
true || false;      // true
false || "대체값";  // "대체값" (왼쪽 거짓 → 오른쪽 반환)

// falsy 값: null, undefined, 0, false, '' 등
!n4 && 'n4는 null입니다.';
```

---

### 비트 연산자 (Bitwise Operators)

| 연산자 | 설명 |
|--------|------|
| `&` | 비트 AND |
| `\|` | 비트 OR |
| `^` | 비트 XOR |
| `~` | 비트 NOT |
| `<<` | 왼쪽 시프트 |
| `>>` | 오른쪽 시프트 (부호 유지) |
| `>>>` | 부호 없는 오른쪽 시프트 |

---

### 삼항 조건 연산자 (Ternary Operator)

```javascript
조건식 ? 참일 때 실행 : 거짓일 때 실행;

// 예시
(data > 10) ? console.log("참입니다") : console.log("거짓입니다");

// 반응형 스타일
(window.innerWidth < 380)
    ? (boxEl.style.backgroundColor = 'green') && (boxEl.style.height = "50px")
    : console.log("거짓입니다");
```

---

### 타입 연산자 (typeof)

피연산자의 **타입을 문자열로 반환**.

```javascript
typeof 10;        // "number"
typeof "HELLO";  // "string"
typeof {};       // "object"
typeof null;     // "object" (예외)
typeof undefined;// "undefined"
```

---

### 분기문 (if / else if / else)

조건에 따라 **다른 코드 블록**을 실행.

```javascript
if (조건식) {
    // 참인 경우 실행
} else if (다른조건) {
    // 다른조건 참인 경우 실행
} else {
    // 모두 거짓인 경우 실행
}
```

**실전 예시** (01분기문.html): select 변경 시 레이아웃 모드 전환 (데스크탑/태블릿/모바일)

```javascript
modeEl.addEventListener('change', (e) => {
    const mode = e.target.value;
    if (mode == 'desktop') {
        wrapperEl.classList.remove('layout-mobile', 'layout-tablet');
        wrapperEl.classList.add('layout');
    } else if (mode == 'tablet') {
        wrapperEl.classList.remove('layout', 'layout-mobile');
        wrapperEl.classList.add('layout-tablet');
    } else {
        wrapperEl.classList.remove('layout', 'layout-tablet');
        wrapperEl.classList.add('layout-mobile');
    }
});
```

**실전 예시** (02분기문.html): 회원가입 폼 유효성 검증

```javascript
const submitForm = (e) => {
    e.preventDefault();
    const form = e.target;
    if (form.email.value == "") {
        messageEl.innerHTML = "※이메일 입력은 필수사항입니다.";
        return false;
    } else if (form.password.value == "") {
        messageEl.innerHTML = "※패스워드 입력은 필수사항입니다.";
        return false;
    } else if (!regex.test(form.password.value)) {
        messageEl.innerHTML = "※최소 8자, 대소문자+숫자+특수문자 포함";
        return false;
    } else if (form.password.value != form.rePassword.value) {
        messageEl.innerHTML = "※패스워드가 일치하지 않습니다.";
        return false;
    }
    // 전송
};
```

---

### 반복문 (while / for)

**while**: 조건이 참인 동안 반복

```javascript
let i = 0;
while (i < n) {
    // 종속 문장
    i++;
}
```

**for**: 탈출용 변수·조건·연산식을 한 줄에

```javascript
for (let i = 0; i < n; i++) {
    // 조건이 참인 동안 반복
}
```

---

### 함수 기초 (function / 화살표 함수)

| 문법 | 호이스팅 | 설명 |
|------|----------|------|
| `function 함수명() {}` | O | ECMAScript 6 이전, 호이스팅 됨 |
| `const 함수명 = () => {}` | X | ECMAScript 6 이후, 유지보수에 유리 |

**인자·리턴 조합**

| 인자 | 리턴 | 예시 |
|------|------|------|
| O | O | `(n1, n2) => { return n1 + n2; }` |
| O | X | `(n1, n2) => { console.log(n1, n2); }` |
| X | O | `() => { return prompt('입력'); }` |
| X | X | `() => { console.log('실행'); }` |

```javascript
// function 선언 (호이스팅 O)
function sum1(n1, n2) {
    return n1 + n2;
}
const r1 = sum1(10, 20);  // Call-by-value

// 화살표 함수 (호이스팅 X)
const sum2 = (n1, n2) => {
    return n1 + n2;
};
```

---

### 호이스팅 (Hoisting)

**변수와 함수 정의가 코드 실행 전에 메모리에 미리 올라가는 현상.**

| 예약어 | 호이스팅 |
|--------|----------|
| `function` | O |
| `var` | O |
| `let`, `const` | X (TDZ) |

```javascript
h1();  // 정상 실행 (function 호이스팅)
function h1() { console.log("HELLO"); }

h2();  // 에러 (화살표 함수는 호이스팅 안 됨)
const h2 = () => { console.log("HELLO-2"); };
```

- `var`는 가급적 사용 지양
- `function`은 “선언 전 호출” 효과가 필요할 때만 사용
- 화살표 함수는 기본적으로 익명 함수

---

### 스코프 (Scope)

**변수·함수가 접근할 수 있는 범위.**

| 구분 | 설명 |
|------|------|
| **전역 스코프** | 모든 지역에서 접근 가능 |
| **지역 스코프** | 특정 `{}` 블록 내에서만 접근 가능 |
| **함수 스코프** | `var` – 함수 본문 `{}` 내에서만 유효 |
| **블록 스코프** | `let`, `const` – `if`, `while` 등 `{}` 블록 내에서만 유효 |
| **렉시컬 스코프** | 변수를 **선언한 위치**에 따라 스코프 결정 |

```javascript
// var: 함수 스코프 (블록 무시)
if (true) {
    var v_2 = "블록 내 var";
}
console.log(v_2);  // 접근 가능

// let: 블록 스코프
if (true) {
    let v_1 = "블록 내 let";
}
console.log(v_1);  // 에러

// 렉시컬 스코프
const name = "Global";
function outer() {
    const name = "Local";
    function inner() {
        console.log(name);  // "Local" (선언 위치 기준)
    }
    inner();
}
```

**this 차이**

| 함수 형태 | this 기준 |
|-----------|-----------|
| `function` | **호출 시점** 기준 (호출한 객체) |
| `() => {}` | **탄생 시점** 기준 (상위 스코프, 렉시컬) |

```javascript
const a = {
    name: "김",
    talk: function() { console.log(this.name); },  // this === a
    walk: () => { console.log(this.name); }        // this === 상위(예: window)
};
```

---

### 클로저 (Closure)

**내부 함수가 외부 함수의 변수에 접근할 수 있는 메커니즘.**

- **정보 은닉**: 외부에서 직접 접근 불가, 함수를 통해서만 제어
- **데이터 보존**: 함수 생성 시점의 환경을 유지하며 데이터 보존
- **비동기 처리**: 비동기 결과를 유지하고 필요 시 접근

```javascript
function outer() {
    let state = 0;
    function setState(n) {
        state = n;  // outer의 state에 접근 (렉시컬 스코프)
        console.log('state', state);
    }
    return setState;  // 함수 참조(주소) 반환
}
const closureFunc = outer();
closureFunc(10);  // state 10
closureFunc(20);  // state 20 (state가 유지됨)
```

---

### 콜백 함수 (Callback)

**호출 시점이 바뀐 함수.** 인자로 **함수(로직)**를 넘겨, 그 함수를 내부에서 호출하는 방식.

| 방식 | 설명 |
|------|------|
| 기존 | 개발자가 함수 정의 → 직접 호출(CALL) → 결과 반환 |
| 콜백 | 로직이 담긴 함수를 인자로 전달 → 콜백 함수가 내부에서 호출 → 결과 반환 |

```javascript
// 일반 함수: 직접 호출
function func1(n1, n2) { return n1 + n2; }
const r1 = func1(10, 20);

// 콜백: logic 함수를 인자로 전달
function callbackFunc(n1, n2, logic) {
    const result = logic(n1, n2);  // 외부에서 받은 함수를 내부에서 CALL
    return result;
}
callbackFunc(100, 200, func1);
callbackFunc(10, 20, (n1, n2) => n2 - n1);
```

**콜백으로 map 유사 구현**

```javascript
function customMap(array, func) {
    let newArray = [];
    for (let i = 0; i < array.length; i++) {
        newArray.push(func(array[i]));
    }
    return newArray;
}
const r2 = customMap(arr, (item) => ({ id: item.id, addr: item.addr }));
```

**customMap2: 조건부 반환 (filter 유사)**

cutline 등 추가 인자를 넘겨, 조건에 맞는 항목만 반환.

```javascript
const students = [
    { name: "철수", score: 85 },
    { name: "영희", score: 42 },
    { name: "민수", score: 91 },
    { name: "지현", score: 55 },
    { name: "태호", score: 73 }
];

function customMap2(cutline, students, func) {
    let newArray = [];
    for (let i = 0; i < students.length; i++) {
        const passItem = func(students[i], cutline);
        if (passItem) newArray.push(passItem);
    }
    return newArray;
}
// 60점 이상만 pass
const result = customMap2(60, students, (item, cutline) =>
    item.score >= cutline && { name: item.name, grade: "pass" }
);
// [ { name: '철수', grade: 'pass' }, { name: '민수', grade: 'pass' }, { name: '태호', grade: 'pass' } ]
```

**클로저 + 콜백: customMap (체이닝 형태)**

`customMap(array)`가 내부 `map` 함수를 담은 객체를 반환. `newArray`는 클로저로 유지.

```javascript
function customMap(array) {
    let newArray = [];  // 클로저 대상 (State)
    function map(func) {
        for (let i = 0; i < array.length; i++) {
            newArray.push(func(array[i]));
        }
        return newArray;
    }
    return { map: map };
}
// 사용
customMap(arr).map((item) => ({ id: item.id, addr: item.addr }));
```

---

### 마우스 이벤트 (Mouse Events)

| 이벤트 | 설명 |
|--------|------|
| `mouseenter` | 마우스 포인터가 특정 영역 내로 진입 시 |
| `mouseover` | 마우스 포인터가 특정 영역 내에 머무를 시 |
| `mouseleave` | 마우스 포인터가 특정 영역 밖으로 나갈 때 |
| `click` | 마우스 1회 클릭 |
| `dblclick` | 마우스 2회 클릭 (더블클릭) |
| `contextmenu` | 마우스 우클릭 (메뉴 표시) |
| `mousedown` | 마우스 버튼 눌림 |
| `mousemove` | 마우스 이동 |

---

### 드래그 앤 드롭 (Drag and Drop)

| 이벤트 | 발생 대상 | 설명 |
|--------|------------|------|
| `dragstart` | 드래그 소스 | 드래그 시작 |
| `drag` | 드래그 소스 | 드래그 중 |
| `dragenter` | 드롭 대상 | 드래그가 대상 영역 위로 이동 시 |
| `dragover` | 드롭 대상 | 드래그가 대상 영역 위에 있는 동안 |
| `dragleave` | 드롭 대상 | 드래그가 대상 영역에서 벗어날 때 |
| `drop` | 드롭 대상 | 드롭 (마우스 버튼을 뗀 경우) |
| `dragend` | 드래그 소스 | 드래그 종료 |

**필수 설정**

1. 드래그 소스에 `draggable="true"` 지정
2. `dragenter`, `dragover`에서 `e.preventDefault()` 호출 (필수, drop 이벤트 발생을 위해)
3. `drop`에서 `e.preventDefault()` 호출

```javascript
// 드래그 소스
d1El.addEventListener('dragstart', (e) => {
    e.dataTransfer.setData('text/plain', d1El.querySelector('span').innerHTML);
});

// 드롭 대상
d4El.addEventListener('dragenter', (e) => { e.preventDefault(); });
d4El.addEventListener('dragover', (e) => { e.preventDefault(); });  // 필수
d4El.addEventListener('drop', (e) => {
    e.preventDefault();
    const data = e.dataTransfer.getData('text/plain');
    d4El.innerHTML = data || 'dropped';
});
```

---

### 파일 드롭 (File Drop)

`e.dataTransfer.files`로 드롭된 파일 목록 접근

```javascript
d4El.addEventListener('drop', (e) => {
    e.preventDefault();
    const files = e.dataTransfer.files;
    for (let i = 0; i < files.length; i++) {
        if (!isValid(files[i])) return;
        const newImgEl = document.createElement('img');
        newImgEl.src = URL.createObjectURL(files[i]);
        previewEl.appendChild(newImgEl);
    }
});
// 파일 검증: file.type (mime), file.size (bytes)
```

---

### 드래그로 요소 생성 (보드에 아이템 배치)

aside의 아이템을 article 보드로 드래그해 div 생성

```javascript
let dragedNode = null;
liEls.forEach((liEl) => {
    liEl.addEventListener('dragstart', (e) => { dragedNode = e.target; });
});

boardEl.addEventListener('dragover', (e) => { e.preventDefault(); });
boardEl.addEventListener('drop', (e) => {
    e.preventDefault();
    const newDivEl = document.createElement("div");
    newDivEl.setAttribute('style', `left:${e.offsetX}px;top:${e.offsetY}px`);
    newDivEl.classList.add("item", dragedNode.classList[0]);  // 드래그한 아이템 스타일 적용
    boardEl.appendChild(newDivEl);
});
```

---

### 마우스 이벤트 좌표

| 속성 | 설명 |
|------|------|
| `e.offsetX`, `e.offsetY` | 이벤트 대상 요소 기준 좌표 |
| `e.clientX`, `e.clientY` | 뷰포트 기준 좌표 |
| `e.target.getBoundingClientRect()` | 요소의 left, top, width, height 등 |

---

### 우클릭 이동 모드 (contextmenu)

`contextmenu`에서 `e.preventDefault()`로 브라우저 기본 메뉴 비활성화 후, `mousedown`(e.button == 2)으로 이동 모드 토글.

```javascript
boardEl.addEventListener('contextmenu', (e) => { e.preventDefault(); });
// mousedown에서 e.button == 2 (우클릭) 체크
// targetNode.getBoundingClientRect()로 위치 계산
// mousemove에서 targetNode.style.left/top 설정
```

---

### 키보드 이벤트 (Keyboard Events) — `06EVENT/03Keyboard.html`

| 이벤트 | 발생 시점 | 비고 |
|--------|-------------|------|
| `keyup` | 키를 뗄 때 | 영문 대소문자 구분 없음, 제어 문자 포함 |
| `keydown` | 키를 누를 때 | 영문 대소문자 구분 없음, 제어 문자 포함 |
| `keypress` | 키를 누르고 있을 때(레거시) | 영문 대소문자 구분, 제어 문자는 제외되는 경우가 많음 |

- `addEventListener`로 각 입력창에 연결, 이벤트 객체 `e`에서 `e.key`, `e.keyCode` 등 확인 가능.
- 예제: `keyup`에서 `e.keyCode == 13`(Enter)이면 입력값을 `<p>`에 누적하고 입력창은 비움.

---

### 입력·IME(한글 조합) 이벤트 — `06EVENT/04Keyboard.html`

| 이벤트 | 설명 |
|--------|------|
| `input` | 텍스트 입력이 반영될 때(한글·영문 공통, 입력 완료 단위로 감지) |
| `compositionstart` | IME 조합 시작(한글 자모 입력 시작) |
| `compositionupdate` | 조합 중(현재 조합 상태 확인) |
| `compositionend` | 조합 완료(완성 글자 확정) |

- 콘솔에 `e`, `e.data`, `e.target.value`를 출력해 키보드 이벤트와의 차이를 비교하는 용도.

---

### 타자 연습 — `06EVENT/05KeyboardPractice.html`

- 문장 배열 `texts`에서 **랜덤 인덱스**로 제시 문장 표시.
- `input` 이벤트로 입력값과 목표 문장을 **한 글자씩 비교**: 일치는 `.valid`(초록), 불일치·초과 입력은 `.invalid`(빨강).
- `validCnt / text.length`로 진행률(%) 계산, `#percentage` 안 아이콘의 `left`를 이동해 시각적 진행 표시(100%일 때 `calc(... - 25px)`로 끝 정렬).
- 입력이 목표 문장과 **완전 일치**하면 `setTimeout`으로 잠시 후 다음 문장(이전과 다른 인덱스가 나올 때까지 `while`로 재추첨), 입력·결과 초기화, 포커스 유지.

---

### 체크박스 — `06EVENT/06CheckEvent.html`

- `change` 이벤트: `e.target.checked`로 체크 여부 확인.
- 체크 시 라벨 색을 초록, 해제 시 검정으로 변경 (`label` 스타일).

---

### 표 동적 생성·셀 선택 — `06EVENT/07solve.html`, `07solved.html`

- **07solve.html** : 연습용 뼈대. 행·열 입력으로 표를 만들고, `selectedStyle` / `deSelectedStyle` / `makemap` 등을 스스로 채우는 과제.
- **07solved.html** : 완성 예제. 행·열 개수 입력 후 `생성`으로 `<tbody>`를 비우고 `tr`/`td`를 `createElement` + `appendChild`로 생성. 각 `td`에 `data-row`, `data-col`, 클릭 시 이전 선택 해제 후 동일 속성을 가진 셀을 `querySelector`로 찾아 스타일 적용. **화살표 키**(37~40)로 셀 이동, `maxRow`/`maxCol`로 경계 처리.

---

### 스크롤 이벤트 — `06EVENT/08Scroll.html`

- `document`에 `scroll` 리스너. `window.scrollY`(또는 `document.documentElement.scrollTop`)로 세로 스크롤 위치 확인.
- `.wrapper>header>nav`에 `scrollY >= 50`이면 `nav-fixed`(상단 고정·전체 너비) 클래스 토글, 헤더 레이아웃 전환 예제.

---

### 리사이즈 이벤트 — `06EVENT/09Resize.html`

- `window`에 `resize` 리스너. `outerWidth` 구간에 따라 `.ball`에 `ball-1280px` / `ball-860px` / `ball-380px` 클래스 교체(원 크기·배경색 반응형).

---

### DOM 로드 이벤트 — `06EVENT/10DOMload.html`

- **`DOMContentLoaded`** : HTML 파싱 완료 후 DOM 준비 시 1회 (CSS·이미지 등 리소스 완료와 무관).
- **`load`** : 문서·하위 리소스까지 모두 로드 후 1회.
- 예제: `DOMContentLoaded` 안에서 `innerWidth`로 초기 `ball-*` 클래스 설정, 리사이즈와 동일한 브레이크포인트 로직.

---

### DOM 노드 탐색·CRUD — `JAVASCRIPT/07NodeCRUD`

| 파일 | 설명 |
|------|------|
| **01.html** | `getElementById`, `querySelector` / `querySelectorAll`, `getElementsByTagName`, 유사 배열 `Array.from`·`Object.entries` |
| **02.html** | `document.forms`, 인덱스·`name`으로 폼·폼 내 `input` 접근 |
| **03.html** | `querySelectorAll` + `mouseover` / `mouseleave`로 클래스 `btn--style1~8` 동적 부여 |
| **04.html** | Enter·입력 버튼으로 값 추가, `createElement`로 행 UI 생성, 삭제 링크로 `remove()` (유효성: 빈 값·첫 글자 숫자 금지 등) |
| **05solve.html** | 폼 → `tbody`에 행 추가·삭제, 더블클릭으로 폼에 재로딩 후 수정, 행 `dragstart`/`drop`으로 순서 바꾸기 |
| **05solved.html** | 동일 주제 완성본: 각 셀 `input readonly`, 수정/삭제 링크, 입력 유효성 (`05solve`와 마크업 방식 차이) |
| **06.html** | 04 유사 + **드래그 앤 드롭**으로 항목 순서 재배치(`dragstart` / `dragover` / `drop`) |

---

### 동기·비동기 — `JAVASCRIPT/08Sync&Async`

`Info.txt` 요약: **동기**는 위→아래 순차 실행(긴 작업 시 지연), **비동기**는 기다리지 않고 다음 코드가 먼저 실행되며 콜백·Promise·async/await로 후속 처리.

| 파일 | 설명 |
|------|------|
| **01.html** | 메인 스레드 `for`와 `setTimeout(..., 1)` 안 루프 실행 순서 비교(콘솔 로그) |
| **02.html** | `setTimeout` 지연 실행, `clearTimeout`으로 예약 취소 |
| **03.html** | `setInterval` 반복, `clearInterval`로 중지 |
| **04.html** | `setInterval`로 메인 패널 갱신 + `Promise` + `async`/`await`로 `sub_process_executor` 두 단계 순서 배치 예제 |

---

### JAVASCRIPT 폴더 예제 파일 인덱스

| 폴더 | 파일 | 설명 |
|------|------|------|
| **01Basic** | 01.html | (1560-1568) onclick, href="javascript:" |
| | 02.html | (1560-1568) document.write, DOM |
| | 03.html | (1560-1568) getElementById, innerHTML |
| | 04.html | (1560-1568) typeof |
| **02Type** | 01보간법.html | (1560-1568) 보간법 `${}` |
| | 02Object.html | (1560-1568) 객체, 메서드, this |
| | 03solve.html | (1560-1568) 점수 저장, `querySelector`, `value`, `Number()` |
| | 03-1solved.html | (1560-1568) 점수 합계/평균 객체 처리 |
| | 04solve.html | (1560-1568) 객체 연습 (은행, 카페, 주차장) |
| | 05ArrayObject.html | (1560-1568) 배열, `filter`, `map`, `reduce` |
| | 06OpenData.html | (1560-1568) 오픈데이터 필터링/가공 |
| | 07solve.html | (1560-1568) `createElement`, `appendChild`, `Object.entries` |
| | 07solved.html | (1560-1568) 주문받기 화면 실습 |
| | 08Prototype.html | Object 유틸리티, Object.prototype, 프로토타입 기초 (Person) |
| | 09Prototype.html | 프로토타입 상속 (Animal → Dog → 포매라니안) |
| **03Operator** | 00Info.html | 산술·할당·비교·논리·비트·삼항·typeof 연산자 |
| **04FlowControl** | 01분기문.html | if/else if/else, 레이아웃 모드 전환 (select) |
| | 02분기문.html | if 분기, 회원가입 폼 유효성 검증 |
| | 03반복문.html | while, for 반복문 |
| **05Function** | 01Basic.html | function vs 화살표 함수, 인자·리턴 조합 |
| | 02Hoisting.html | 호이스팅 (function, var) |
| | 03Scope.html | 전역/지역/함수/블록/렉시컬 스코프, this |
| | 04Closure.html | 클로저 (정보 은닉, 데이터 보존) |
| | 05CallBack.html | 콜백 함수, customMap, customMap2(조건부), 클로저+콜백 |
| **06EVENT** | 01Mouse.html | 마우스 이벤트, 드래그 앤 드롭, 파일 드롭 (dataTransfer.files, URL.createObjectURL) |
| | 02Mouse.html | aside→article 드래그 배치, 우클릭 이동 모드 (contextmenu, mousedown, mousemove) |
| | 03Keyboard.html | `keyup` / `keydown` / `keypress` 차이, Enter(`keyCode` 13)로 입력 확정 예제 |
| | 04Keyboard.html | `input`, `compositionstart` / `compositionupdate` / `compositionend`(IME·한글 조합) |
| | 05KeyboardPractice.html | `input`으로 글자 단위 검증, 진행률·Material 아이콘 이동, 문장 완료 시 다음 문장 |
| | 06CheckEvent.html | 체크박스 `change`, `checked`로 라벨 색 변경 |
| | 07solve.html | 표 동적 생성·셀 선택 과제(함수 뼈대) |
| | 07solved.html | 표 생성 + 클릭 선택 + 화살표 키 이동(완성) |
| | 08Scroll.html | `scroll`, `scrollY`, 네비 상단 고정(`nav-fixed`) |
| | 09Resize.html | `resize`, `outerWidth` 구간별 클래스 전환 |
| | 10DOMload.html | `DOMContentLoaded` vs `load`, 초기 레이아웃 |
| **07NodeCRUD** | 01~06.html | 노드 탐색, forms, 이벤트+동적 생성, 폼→테이블 CRUD, 드래그 순서 변경 (위 표 참고) |
| **08Sync&Async** | 01~04.html, Info.txt | 동기·비동기 개념, `setTimeout`/`setInterval`, Promise·async/await (위 표 참고) |

---

### JavaScript 핵심 요약

1. **실행 위치** : `onclick`, `href="javascript:..."`, `<script>` 내부  
2. **DOM** : `document.getElementById`, `querySelector`, `innerHTML`, `document.write`  
3. **보간법** : 백틱(``) + `${표현식}`  
4. **변수** : `let`(재할당 가능), `const`(상수)  
5. **타입** : number, string, boolean, object, null, undefined (typeof로 확인)  
6. **객체** : `{ key: value }`, 메서드, `this`  
7. **배열** : `[]`, index 접근, `push`/`pop`, `forEach`, `filter`, `map`, `reduce`  
8. **입력값 처리** : `querySelector`, `.value`, `Number()`
9. **동적 DOM 생성** : `createElement`, `appendChild`, `Object.entries`
10. **프로토타입** : `Object.keys/values/entries/freeze`, `생성자.prototype`, `Object.create` 상속 (예제: `02Type/08Prototype.html`, `09Prototype.html`)
11. **연산자** : 산술(+, -, *, /, %), 할당(+=, -=), 비교(==, ===), 논리(&&, \|\|, !), 삼항(?:), typeof (예제: `03Operator/00Info.html`)
12. **흐름 제어** : if/else if/else 분기문, while/for 반복문 (예제: `04FlowControl/01~03`)
13. **함수** : function vs 화살표 함수, 호이스팅, 스코프(전역/지역/렉시컬), 클로저, 콜백 (예제: `05Function/01~05`)
14. **이벤트** : 마우스·드래그(`01Mouse.html`, `02Mouse.html`), 키보드(`keyup`/`keydown`/`keypress`, `03Keyboard.html`), 입력·IME(`input`, `composition*`, `04Keyboard.html`), 타자 연습(`05KeyboardPractice.html`), 체크박스(`change`, `06CheckEvent.html`), 표·선택(`07solve.html` / `07solved.html`), 스크롤(`08Scroll.html`), 리사이즈(`09Resize.html`), 로드(`10DOMload.html`)
15. **DOM CRUD·폼** : `07NodeCRUD`(탐색, `forms`, 동적 리스트/테이블, 드래그 정렬)
16. **동기·비동기** : `08Sync&Async`(`setTimeout`/`setInterval`, Promise, `async`/`await`)
17. **예제 파일** : 핵심 문법·DOM은 `JAVASCRIPT` 폴더(`01Basic` ~ `08Sync&Async`), **외부 라이브러리 연동**은 `JSLIB`, **Bootstrap 레이아웃·컴포넌트**는 `BSS` 폴더 참고

---

## JSLIB

메인 `JAVASCRIPT`와 달리 **npm 없이 CDN·로컬 스크립트로 붙이는 외부 라이브러리**를 연습하는 구역이다. (과거 `SUB` 폴더를 `JSLIB`으로 옮긴 경우 경로만 **`JSLIB/...`** 로 맞추면 된다.)

아래는 **각 라이브러리가 무엇을 해 주는지, 핵심 호출이 어떤 모양인지**를 `콜백 함수` 절처럼 정리한 것이다. 예제 HTML은 맨 아래 **「예제 위치」** 표에만 모아 두었다.

---

### Swiper — 터치·휠 슬라이드 UI

**역할:** 컨테이너 안의 슬라이드를 넘기기, 자동 재생, 페이지 표시, 이전/다음 버튼을 한 번에 묶어 준다. 인스턴스는 **CSS 선택자(또는 요소)** 와 **옵션 객체**로 만든다.

| 항목 | 설명 |
|------|------|
| 인스턴스 | `new Swiper(선택자, { …옵션 })` |
| 자동 재생 | `autoplay: { delay: 2000 }` — ms마다 다음 슬라이드 |
| 루프 | `loop: true` — 끝에서 처음으로 이어 붙임 |
| 페이지 | `pagination: { el, type: 'fraction', clickable: true }` — 예: 현재/전체 분수 표시 |
| 화살표 | `navigation: { prevEl, nextEl }` — DOM과 연결 |
| 멀티 뷰 | `slidesPerView`, `centeredSlides` — 한 화면에 여러 장 + 가운데 정렬 |
| 수직 | `direction: 'vertical'` — 상단 공지 롤링 등 |
| API | `swiper.autoplay.stop()` / `start()` — 재생 제어, `slideToLoop(i)` — 루프 모드에서 인덱스 이동 |

```javascript
const swiper = new Swiper('.my-swiper', {
    direction: 'horizontal',
    loop: true,
    autoplay: { delay: 2000 },
    pagination: { el: '.swiper-pagination', type: 'fraction', clickable: true },
    navigation: { prevEl: '.swiper-button-prev', nextEl: '.swiper-button-next' },
});
// swiper.autoplay.stop();
```

**예제:** `JSLIB/01SWIPER` — `01` 단일 배너, `02` 배너+수직 공지, `03` 멀티 슬라이드·호버 시 autoplay 끊기·`slideToLoop`.

---

### Lodash — `throttle` (호출 빈도 줄이기)

**역할:** `scroll` 같이 아주 자주 도는 이벤트에서 **같은 함수를 너무 많이 호출하지 않도록** 막는다. Lodash의 **`_.throttle(함수, 간격ms)`** 가 **새 함수**를 반환하고, 그걸 리스너에 넣는다.

| 항목 | 설명 |
|------|------|
| 의도 | 연속 이벤트 → 최대 N ms에 한 번만 본문 실행 |
| 반환 | throttled 함수 (원본과 시그니처 동일하게 쓰면 됨) |

```javascript
window.addEventListener('scroll', _.throttle(() => {
    console.log(window.scrollY);
}, 100));
```

**예제:** `JSLIB/02LODASH/01.html`

---

### ScrollMagic — 스크롤 구간과 연동된 연출

**역할:** 특정 요소가 뷰포트의 어느 지점에 **걸렸을지**를 감시하고, 그때마다 **클래스 넣기/빼기** 등 후속 동작을 걸 수 있다. CSS `transition`과 같이 쓰면 “스크롤에 반응하는 모션”이 된다.

| 항목 | 설명 |
|------|------|
| Controller | `new ScrollMagic.Controller()` — 스크롤 관측의 허브 |
| Scene | `new ScrollMagic.Scene({ triggerElement, triggerHook })` — 트리거 대상·위치(0~1, 예: 0.5는 화면 중앙) |
| 토글 | `.setClassToggle(대상El, '클래스명')` — 씬 활성/비활성에 맞춰 클래스 스위치 |
| 등록 | `.addTo(controller)` |

```javascript
const controller = new ScrollMagic.Controller();
new ScrollMagic.Scene({ triggerElement: spySection, triggerHook: 0.5 })
    .setClassToggle(ballEl, 'move')
    .addTo(controller);
```

**예제:** `JSLIB/03SCROLLMAGIC` — `01` 단일 씬, `02` 구역마다 다른 클래스(`move1` / `move2`).

---

### GSAP — 타임라인·트윈 애니메이션

**역할:** 선택자(또는 요소)의 **CSS 값·변환**을 시간에 따라 바꾼다. **`gsap.to(대상, { 속성들 })`** 에 `duration`, `ease`, `delay` 등을 넣는다.

```javascript
gsap.to('.box', {
    duration: 3,
    x: 200,
    y: 200,
    opacity: 0.2,
    rotate: 360,
    ease: 'elastic.out(1, 0.3)',
});
```

**예제:** `JSLIB/04GSAP/01.html`

---

### Chart.js — `<canvas>` 차트

**역할:** `canvas` + **데이터 객체**로 막대·선·파이 등을 그린다. 패턴은 **`new Chart(캔버스컨텍스트 또는 요소, { type, data, options })`** 이 한 가지이다.

| 항목 | 설명 |
|------|------|
| `type` | `'bar'`, `'line'`, `'pie'`, `'doughnut'`, `'radar'`, `'scatter'` 등 |
| `data` | `labels`, `datasets` (배열·색·값) |
| `options` | `scales`(축, 스택), `plugins`(제목·범례), `onClick` 등 |

```javascript
const ctx = document.getElementById('myChart');
new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['A', 'B', 'C'],
        datasets: [{ label: '값', data: [1, 2, 3], backgroundColor: ['#f44', '#4af', '#4f4'] }],
    },
    options: { scales: { y: { beginAtZero: true } } },
});
```

앱 데이터는 **`reduce` / `Object.keys` / `Object.entries` / `filter`** 로 가공한 뒤 `labels`·`datasets.data`에 넣는 식으로 이어 붙인다.  
**예제:** `JSLIB/05CHART` — `01` 스택·애니메이션·클릭, `02` 타입별 6종, `03` 맛집 카테고리 집계, `04` 범죄 통계 분할 차트.

---

### QR 코드 (qrcode-generator)

**역할:** 문자열을 QR 규격으로 인코딩해 **SVG 등 DOM**으로 내보낸다. 흐름은 **버전·오류보정 → 데이터 넣기 → 생성 → 태그 삽입**이다.

```javascript
const qr = qrcode(0, 'L');       // 버전, 오류보정 레벨
qr.addData('https://example.com');
qr.make();
document.getElementById('qrcode').innerHTML = qr.createSvgTag({ scalable: true });
```

**예제:** `JSLIB/06QRCODE/01.html`

---

### Canvas 2D API — 그림판 (라이브러리 아님, `JSLIB`에 실습만 있음)

**역할:** **`getContext('2d')`** 로 붓을 잡고, `lineTo` / `stroke` / `beginPath` / `moveTo` 로 선을 그린다. 화면 비우기는 **`clearRect`** .

```javascript
const canvas = document.getElementById('canvas');
const ctx = canvas.getContext('2d');
ctx.lineWidth = 4;
ctx.strokeStyle = '#000';
ctx.lineCap = 'round';
ctx.lineTo(x, y);
ctx.stroke();
ctx.clearRect(0, 0, canvas.width, canvas.height);
```

마우스는 `mousedown` / `mousemove` / `mouseup` 으로 “그리는 중” 플래그와 조합한다.  
**예제:** `JSLIB/07CANVAS/01.html` + `01.js`

---

### Leaflet — 웹 지도

**역할:** **`L.map`** 으로 지도 루트를 만들고, **`L.tileLayer(타일URL규칙).addTo(map)`** 으로 배경 타일을 깐다. **마커**는 `L.marker([lat, lng]).addTo(map)`, 팝업은 `bindPopup` / `openPopup`. **한국 전용 타일(EPSG 변환)** 은 `proj4`, `proj4leaflet`, `Leaflet.KoreanTmsProviders` 를 붙여 **`crs: L.Proj.CRS.Daum`** 같은 식으로 쓴다.

```javascript
const map = L.map('map').setView([35.87, 128.60], 13);
L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', { maxZoom: 19 }).addTo(map);

const m = L.marker([35.87, 128.60]).addTo(map);
m.bindPopup('설명').openPopup();
```

- **역지오코딩:** 위경도 → 주소는 외부 API(예: Nominatim)에 **`fetch`** 후 JSON을 파싱하고, **`L.popup().setLatLng(latlng).setContent(html).openOn(map)`** 으로 표시한다.
- **클러스터:** 많은 마커를 묶어 보이려면 **`L.markerClusterGroup()`** 에 마커를 `addLayer` 한 뒤 `map.addLayer(그룹)` 한다.
- **CSV → 점:** 플러그인 조합으로 `L.geoCsv` + `MarkerClusterGroup` + 필터 UI를 쓰는 패턴도 있다.

**예제:** `JSLIB/07LEFTLET/01Basic`(OSM), `02MapTileTrans`(OSM·다음·TMap·CSV 등 변형), `03AddMarker`(아이콘·팝업·우클릭 이동), `04GeoCoder`(우클릭 역지오코딩), `05Clustering`(다수 마커 클러스터).  
`05Clustering/ex` 는 외부 템플릿 복제로 **`index.html`에 Jekyll 문법(`{{ }}`)** 이 있어 그대로 열기 어려울 수 있고, 참고는 `ex/assets` 쪽 스크립트·GeoJSON을 보면 된다.

---

### 예제 위치 (`JSLIB` 폴더)

| 주제 | 경로 |
|------|------|
| Swiper | `01SWIPER/01.html` ~ `03.html`, 이미지 `01SWIPER/images/` |
| Lodash | `02LODASH/01.html` |
| ScrollMagic | `03SCROLLMAGIC/01.html`, `02.html` |
| GSAP | `04GSAP/01.html` |
| Chart.js | `05CHART/01.html` ~ `04.html` (+ `03`은 `JAVASCRIPT/02Type/js/중구맛집.js` 참조) |
| QR | `06QRCODE/01.html` |
| Canvas | `07CANVAS/01.html`, `07CANVAS/01.js` |
| Leaflet | `07LEFTLET/01Basic`, `02MapTileTrans`, `03AddMarker/index.html`, `04GeoCoder/index.html`, `05Clustering/index.html` |

---

## BSS (Bootstrap)

**역할:** **Bootstrap 5** CSS·JS 번들로 레이아웃·내비·폼·버튼·오버레이 UI를 빠르게 맞춘다. 예제는 CDN **`bootstrap@5.0.2`** — CSS + **`bootstrap.bundle.min.js`**(Popper 포함)를 함께 쓴다. 컴포넌트 동작은 **데이터 속성 `data-bs-*`** 로 연결한다. (Bootstrap 4의 `data-toggle` 대신 **`data-bs-toggle`** 이다.)

| 포함 | 설명 |
|------|------|
| CSS | 그리드·유틸리티·컴포넌트 스타일 |
| `bundle` JS | Collapse, Dropdown, Offcanvas, Modal, Carousel 등 스크립트 + Popper |

```html
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
```

로컬로는 **`BSS/css/common.css`**(리셋·레이아웃 뼈대), **`BSS/css/join.css`**(`.join` 폼·파일 버튼 스타일), **`BSS/js/common.js`**(현재 `DOMContentLoaded` 뼈대만 있음 — 동작은 거의 전부 Bootstrap 데이터 속성)을 덧붙인다.

---

### 컨테이너·레이아웃

| 클래스 | 설명 |
|--------|------|
| `container` | 좌우 여백이 있는 고정 폭 느낌의 콘텐츠 폭 |
| `container-fluid` | 뷰포트 전체 너비(내부 `navbar` 등에서 자주 씀) |

```html
<div class="wrapper container">…</div>
<nav>…<div class="container-fluid">…</div></nav>
```

**예제:** `BSS/01Layout.html` — Bootstrap만 로드하고 `container`·헤더/메인 뼈대만 구성.

---

### Navbar — 접히는 내비 + 드롭다운

| 클래스 / 속성 | 설명 |
|---------------|------|
| `navbar`, `navbar-expand-lg` | 내비 바, `lg` 이상에서 가로 펼침 |
| `navbar-light`, `bg-success` 등 | 테마/배경(여기서는 밝은 텍스트 조합 + 녹색 배경) |
| `navbar-toggler` | 모바일용 햄버거 버튼 |
| `data-bs-toggle="collapse"`, `data-bs-target="#id"` | 접기/펼치기 대상 `#id`와 연결 |
| `collapse`, `navbar-collapse` | 접히는 본문 영역 |
| `navbar-nav`, `nav-item`, `nav-link` | 메뉴 리스트·링크 |
| `dropdown`, `dropdown-toggle`, `data-bs-toggle="dropdown"` | 서브메뉴 |
| `dropdown-menu`, `dropdown-item`, `dropdown-divider` | 드롭다운 패널·항목·구분선 |
| `d-flex` | 플렉스(검색 폼 가로 배치) |
| `form-control`, `btn`, `btn-light` / `btn-warning` / `btn-primary` | 검색 입력·버튼 스타일 |
| `me-2`, `mb-2`, `mb-lg-0` 등 | margin 유틸(margin-end, 반응형 margin-bottom) |
| `text-light`, `active`, `disabled` | 링크 색·현재 항목·비활성 |

```html
<nav class="navbar navbar-expand-lg navbar-light bg-success">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent">…</button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">…</ul>
      <form class="d-flex">…</form>
    </div>
  </div>
</nav>
```

**예제:** `BSS/02Nav.html`

---

### Offcanvas — 옆에서 슬라이드 패널

**역할:** 화면 측면에서 패널을 밀어 넣어 **회원가입 폼** 등을 띄운다.

| 클래스 / 속성 | 설명 |
|---------------|------|
| `offcanvas`, `offcanvas-end` | 패널 루트·**오른쪽**에서 열림(`-start` 는 반대편) |
| `offcanvas-header`, `offcanvas-body` | 헤더·본문 영역 |
| `data-bs-toggle="offcanvas"`, `data-bs-target="#offcanvasId"` | 버튼으로 해당 패널 토글 |

```html
<button type="button" class="btn btn-warning" data-bs-toggle="offcanvas"
        data-bs-target="#offcanvasExample">Join</button>

<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasExample">
  <div class="offcanvas-header">…</div>
  <div class="offcanvas-body">…폼…</div>
</div>
```

**예제:** `BSS/03OffCanvas.html` — Join 버튼 → 오프캔버스 폼.

---

### Modal — 중앙 대화상자

| 클래스 / 속성 | 설명 |
|---------------|------|
| `modal`, `fade` | 루트·페이드 전환 |
| `modal-dialog`, `modal-dialog-centered` | 박스·세로 가운데 정렬 |
| `modal-content`, `modal-header`, `modal-body`, `modal-footer` | 구역 나눔 |
| `btn-close`, `data-bs-dismiss="modal"` | 닫기(X)·닫기 동작 |
| `data-bs-toggle="modal"`, `data-bs-target="#exampleModal"` | 버튼으로 모달 열기 |

```html
<button type="button" class="btn btn-primary" data-bs-toggle="modal"
        data-bs-target="#exampleModal">Login</button>

<div class="modal fade" id="exampleModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">…</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
```

**예제:** `BSS/04Modal.html` — Offcanvas Join + Modal Login 조합.

---

### Carousel — 이미지 슬라이드

| 클래스 / 속성 | 설명 |
|---------------|------|
| `carousel`, `slide` | 캐러셀 루트·슬라이드 전환 |
| `data-bs-ride="carousel"` | 자동 재생 시작 |
| `carousel-indicators` + `button` | 하단 인디케이터; `data-bs-target`, `data-bs-slide-to` |
| `carousel-inner`, `carousel-item`, `active` | 슬라이드 래퍼·한 장; 첫 장에 `active` |
| `data-bs-interval` | 슬라이드별 대기 시간(ms), 예: `10000` |
| `carousel-control-prev` / `next`, `data-bs-slide="prev"` / `"next"` | 이전·다음 버튼 |
| `d-block`, `w-100` | 이미지가 영역을 채우도록(유틸) |
| `visually-hidden` | 스크린리더용 문구만 보이게 |

```html
<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0"
            class="active" aria-current="true"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active" data-bs-interval="10000">
      <img src="1.jpg" class="d-block w-100" alt="">
    </div>
    <div class="carousel-item" data-bs-interval="10000">…</div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"
          data-bs-slide="prev"><span class="carousel-control-prev-icon"></span></button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"
          data-bs-slide="next"><span class="carousel-control-next-icon"></span></button>
</div>
```

**예제:** `BSS/05Carousel.html` — 배너 캐러셀 + `04`와 동일한 Nav·Offcanvas·Modal. 이미지는 `BSS/assets/1.jpg` ~ `4.jpg`.

---

### Card — 콘텐츠 카드

**역할:** 이미지·제목·본문·버튼을 **한 덩어리 UI**로 묶어 상품·게시글 미리보기 등에 쓴다. JS 없이 **클래스만**으로 스타일이 잡힌다.

| 클래스 | 설명 |
|--------|------|
| `card` | 카드 루트(테두리·배경·그림자 등 컴포넌트 기본형) |
| `card-img-top` | 상단 이미지(첫 자식으로 두면 윗부분에 붙은 느낌) |
| `card-body` | 본문 영역(패딩) |
| `card-title` | 제목(`h5` 등과 함께) |
| `card-text` | 설명 문단 |
| (버튼) | `btn`, `btn-primary`, 유틸 `w-100` 으로 카드 너비에 맞춘 전폭 버튼 |

폭은 **`style="width: 18rem;"`** 처럼 지정하거나, 실무에서는 **`row` / `col-*`** 로 그리드에 넣어 한 줄에 여러 장을 두는 경우가 많다. 예제 파일은 `container` 안에 카드를 **반복 나열**만 하고 있다.

```html
<section class="card-section container">
  <div class="card" style="width: 18rem;">
    <img src="thumb.jpg" class="card-img-top" alt="">
    <div class="card-body">
      <h5 class="card-title">Card title</h5>
      <p class="card-text">설명 텍스트…</p>
      <a href="#" class="btn btn-primary w-100">Go somewhere</a>
    </div>
  </div>
</section>
```

**예제:** `BSS/06Card.html` — `05Carousel.html`과 동일한 상단(Nav·캐러셀·Offcanvas·Modal) + **`card-section`** 에 동형 카드 다수. 새로 배우는 BS는 위 **Card** 블록이 핵심이다.

---

### Nav · Tabs — 탭으로 본문 전환

**역할:** 같은 화면에서 **제목 줄(탭)** 을 눌러 **아래 패널**만 바꾼다. Bootstrap **`Tab`** 플러그인이 `data-bs-toggle="tab"` 을 처리하므로 **`bootstrap.bundle.js`** 가 필요하다.

| 구역 | 클래스 / 속성 | 설명 |
|------|---------------|------|
| 탭 줄 | `nav`, `nav-tabs` | 탭 스타일 내비(버튼 pill variant는 `nav-pills`) |
| 접근성 | `role="tablist"` | 탭 목록임을 보조기술에 알림 |
| 탭 트리거 | `button.nav-link`, `active`(현재 탭) | `<a>` 대신 `button` + **`data-bs-toggle="tab"`**, **`data-bs-target="#패널id"`** |
| | `aria-controls`, `aria-selected` | 어떤 패널과 연결되는지, 선택 여부 |
| 본문 래퍼 | `tab-content` | 패널들의 부모 |
| 각 패널 | `tab-pane`, `fade` | 한 탭에 대응하는 블록 |
| 첫 패널 | `show`, `active` | **둘 다** 있어야 첫 로드 시 보임(`fade`와 함께 쓰는 패턴) |
| 나머지 패널 | `tab-pane`, `fade` 만 | 눌렀을 때 JS가 `active`/`show` 스위치 |
| | `role="tabpanel"`, `aria-labelledby` | 탭 버튼 id와 짝 맞추기 |

```html
<nav>
  <div class="nav nav-tabs" id="nav-tab" role="tablist">
    <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab"
            data-bs-target="#nav-home" type="button" role="tab"
            aria-controls="nav-home" aria-selected="true">Home</button>
    <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab"
            data-bs-target="#nav-profile" type="button" role="tab"
            aria-controls="nav-profile" aria-selected="false">Profile</button>
  </div>
</nav>
<div class="tab-content" id="nav-tabContent">
  <div class="tab-pane fade show active" id="nav-home" role="tabpanel"
       aria-labelledby="nav-home-tab">HOME SECTION</div>
  <div class="tab-pane fade" id="nav-profile" role="tabpanel"
       aria-labelledby="nav-profile-tab">PROFILE SECTION</div>
</div>
```

**예제:** `BSS/07NavTab.html` — `06Card.html`과 동일한 상단 + 카드 섹션 + **`navtab-section`** 에 위 패턴(Home / Profile / Contact 세 탭).

---

### 예제 위치 (`BSS` 폴더)

| 파일 | 다루는 Bootstrap 요약 |
|------|-------------------------|
| `01Layout.html` | CDN 포함, `container`, 페이지 뼈대 |
| `02Nav.html` | Navbar, Collapse, Dropdown, `d-flex` 폼, `form-control`, 버튼 유틸 |
| `03OffCanvas.html` | 위 + Offcanvas(`offcanvas-end`), Join 버튼 연동 |
| `04Modal.html` | 위 + Modal(`fade`, `modal-dialog-centered`, `data-bs-dismiss`) |
| `05Carousel.html` | 위 + Carousel 전체 패턴, `container-fluid` 섹션 |
| `06Card.html` | `05` 구성 + **Card**(`card`, `card-img-top`, `card-body`, `card-title`, `card-text`, `w-100` 버튼) |
| `07NavTab.html` | `06` 구성 + **Nav Tabs**(`nav-tabs`, `data-bs-toggle="tab"`, `tab-content`, `tab-pane`, `fade`/`show`/`active`) |
| `css/common.css` | 전역 박스모델·링크 리셋, `.wrapper` 자리표(주로 비-BS) |
| `css/join.css` | `.join` 오프캔버스 폼 입력·셀렉트·버튼 보조 스타일 |

---
