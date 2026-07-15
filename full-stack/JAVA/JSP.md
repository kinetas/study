# JSP

---

## 1. JSP 개요

> **JSP (Java Server Pages)** : Java 코드를 HTML 안에 삽입해 동적 웹 페이지를 생성하는 서버 사이드 기술  
> JSP 파일은 서버에서 **Servlet(Java 파일)으로 변환**된 후 실행된다

| 구성 요소 | 설명 |
|-----------|------|
| **선언문** `<%! %>` | 서블릿 클래스의 필드/메서드 추가 (인스턴스 변수·함수) |
| **스크립틀릿** `<% %>` | 서블릿 `service()` 함수 내부 로직 처리 (지역변수·제어문) |
| **표현식** `<%= %>` | 서블릿 값을 HTML(FN)으로 출력 |
| **EL** `${ }` | request 등 내장객체 속성값을 간결하게 출력 |

---

## 2. JSP 내장 객체

| 객체 | 클래스 | 설명 |
|------|--------|------|
| `request` | `HttpServletRequest` | HTTP 요청 정보 저장 |
| `response` | `HttpServletResponse` | HTTP 응답 설정 |

### request 주요 메서드

| 메서드 | 설명 |
|--------|------|
| `request.getParameter("name")` | 단일 파라미터 값 조회 |
| `request.setCharacterEncoding("UTF-8")` | POST 요청 한글 인코딩 설정 |
| `request.setAttribute("key", value)` | 속성값 저장 (EL로 접근 가능) |

---

## 3. GET vs POST

| 방식 | 데이터 전달 위치 | 특징 |
|------|----------------|------|
| **GET** | URL Query String | 데이터 노출, 길이 제한 |
| **POST** | Request Body (Payload) | 데이터 미노출, 한글 인코딩 처리 필요 |

---

## 4. DTO (Data Transfer Object)

> 폼 파라미터를 객체로 한 번에 바인딩할 때 사용  
> `jsp:useBean` + `jsp:setProperty property="*"` 조합으로 자동 매핑

- 필드명 = HTML `name` 속성값과 동일해야 자동 매핑됨
- 디폴트 생성자 + Getter/Setter 필수

---

## Ch01 — 선언문 & 스크립틀릿

### C01 — 선언문 기본

```jsp
<%!
    String name = "HONG GIL DONG";
    public String testFunc(){
        System.out.println("선언문 함수 테스트!");
        return "name : " + name;
    }
%>

NAME    : <%=name %>
testFunc: <%=testFunc() %>
```

> 선언문(`<%! %>`)은 서블릿 클래스 레벨에 추가 → **인스턴스 변수**로 동작 (요청 간 상태 유지)

---

### C02 — 선언문 카운터

```jsp
<%!
    int n = 0;
    public int countUp(){
        n++;
        return n;
    }
%>

N : <%=countUp() %>
```

> 인스턴스 변수이므로 새로고침할 때마다 n이 누적 증가

---

### C03 — 스크립틀릿 기본

```jsp
<%
    String str1 = "HELL01";
    String str2 = "HELL02";
    String str3 = str1 + str2;
    int a = 0;
    for(int i = 0; i < 10; i++){
        a++;
        System.out.println("i : " + i);
    }
%>
str1 : <%=str1 %><br>
str2 : <%=str2 %><br>
str3 : <%=str3 %><br>
a    : <%=a %><br>
```

> 스크립틀릿(`<% %>`)은 `service()` 함수 내부 → **지역변수** (요청 시마다 초기화)  
> 반복문/분기문 처리 가능

---

### C04 — 스크립틀릿 + HTML 혼합 (테이블)

```jsp
<%@ page import="java.util.*" %>
<%
    Scanner sc = new Scanner(System.in);
    int row = sc.nextInt();
    int col = sc.nextInt();
    sc.close();
%>
<table>
    <% for(int i = 0; i < row; i++){ %>
        <tr>
            <% for(int j = 0; j < col; j++){ %>
                <td><%=i %>|<%=j %></td>
            <% } %>
        </tr>
    <% } %>
</table>
```

> 스크립틀릿 블록을 여닫으면서 HTML 태그와 섞어 사용 가능

---

### C05 — 스크립틀릿 Ex (구구단 테이블)

```jsp
<%
    Scanner sc = new Scanner(System.in);
    int dan = sc.nextInt();
    sc.close();
%>
<table>
    <% for(int i = 0; i < 9; i++){ %>
        <tr>
            <td><%=dan %></td><td>x</td>
            <td><%=i %></td><td>=</td>
            <td><%=dan * i %></td>
        </tr>
    <% } %>
</table>
```

---

## Ch02 — Request 내장객체

### C01 — GET 방식 파라미터 수신

```html
<!-- C01Request_Get.html -->
<form action="./C01Request_Process.jsp" method="get">
    <input type="text"     name="username" />
    <input type="password" name="password" />
    <input type="text"     name="bgcolor"  />
    <input type="submit" />
</form>
```

```jsp
<!-- C01Request_Process.jsp -->
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String bgColor  = request.getParameter("bgcolor");
%>
<body bgcolor=<%=bgColor %>>
    username : <%=username %><br>
    password : <%=password %><br>
    bgcolor  : <%=bgColor %><br>
</body>
```

---

### C02 — POST 방식 파라미터 수신

```html
<!-- C02Request_Post.html -->
<form action="./C02Request_Process.jsp" method="post">
    ...
</form>
```

> GET과 동일하게 `request.getParameter()` 로 값 조회  
> 단, 한글이 있으면 깨질 수 있음 → C03에서 인코딩 처리

---

### C03 — POST + 한글 인코딩 처리

```jsp
<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");

    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String bgColor  = request.getParameter("bgcolor");
%>
```

> POST 요청 한글 깨짐 방지 : `request.setCharacterEncoding("UTF-8")` 을 파라미터 조회 전에 호출

---

### C04 — useBean / DTO 자동 바인딩

```java
// C04TestDto.java
package Ch02;

public class C04TestDto {
    private String username;
    private String password;
    private String bgcolor;
    // 디폴트 생성자, 모든인자 생성자, Getter/Setter, toString
}
```

```jsp
<!-- C04Request_Process.jsp -->
<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
%>
<jsp:useBean id="dto" class="Ch02.C04TestDto" scope="request" />
<jsp:setProperty property="*" name="dto"/>
<%
    System.out.println("DTO : " + dto);
%>
<body bgcolor=<%=dto.getBgcolor() %>>
    username : <%=dto.getUsername() %><br>
    password : <%=dto.getPassword() %><br>
    bgcolor  : <%=dto.getBgcolor() %><br>
</body>
```

| 태그 | 설명 |
|------|------|
| `<jsp:useBean>` | 지정한 클래스의 Bean 객체를 생성/재사용 |
| `<jsp:setProperty property="*">` | 폼 파라미터명과 동일한 필드에 자동 매핑 |

---

### C05 — 회원가입 폼 + UserDto 바인딩

```java
// C05UserDto.java (주요 필드)
private String userId, password, rePassword, username;
private String zipcode, addr1, addr2;
private String phone1, phone2, phone3;
private String contract1, contract2, contract3;
private String email01, email02;
private String birth, birthYear, birthMonth, birthDay;
private String email_recv, sms_recv;
```

```jsp
<!-- C05Request_Process.jsp -->
<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
%>
<jsp:useBean id="dto" class="Ch02.C05UserDto" scope="request" />
<jsp:setProperty property="*" name="dto"/>
<body>
    DTO : <%=dto %>
</body>
```

> HTML `<form>` 의 `name` 속성값 = DTO 필드명 일치 시 `property="*"` 으로 전체 자동 매핑

---

### C06 — JSP → JavaScript 데이터 전달

```jsp
<%
    String msg1 = "HELLO WORLD1";
    String msg2 = "HELLO WORLD2";

    request.setAttribute("msg3", "HELLO WORLD3");
    request.setAttribute("msg4", "HELLO WORLD4");
%>

<script>
    const m1 = '<%=msg1%>';   // 스크립틀릿(표현식)
    const m2 = '<%=msg2%>';   // 스크립틀릿(표현식)

    const m3 = '${msg3}';     // EL (request.setAttribute 값)
    const m4 = '${msg4}';     // EL

    console.log('m1', m1);
    console.log('m2', m2);
    console.log('m3', m3);
    console.log('m4', m4);
</script>
```

| 방식 | 문법 | 데이터 출처 |
|------|------|------------|
| 표현식 | `'<%=변수%>'` | 스크립틀릿 지역변수 |
| EL | `'${키}'` | `request.setAttribute()` 로 저장한 값 |

---

## 서블릿 변환 경로

```
JSP_SERVLET\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\work
\Catalina\localhost\01_JSP\org\apache\jsp\Ch01
```

> JSP 파일은 위 경로에 `.java` → `.class` 로 자동 변환·컴파일됨

---

## Ch03 — Forward vs Redirect

> 서버에서 다른 페이지로 이동하는 두 가지 방식

| 구분 | Forward | Redirect |
|------|---------|----------|
| **이동 방식** | 서버 내부에서 이동 | 클라이언트에게 새 URL 재요청 지시 |
| **URL 변화** | 변하지 않음 (최초 요청 URL 유지) | 변함 (이동한 페이지 URL로 변경) |
| **Request 객체** | 유지됨 (Forwarding 동안) | 새로 생성됨 |
| **요청-응답 주기** | 1회 | 이동 횟수만큼 발생 |
| **데이터 전달** | `request.setAttribute()` | Query String 또는 Session |

---

### Forward

```
01.html → 02.jsp → (forward) → 03.jsp → (forward) → 04.jsp
```

```java
// 02.jsp : setAttribute 후 forward
request.setAttribute("C02", "02_Value");
request.getRequestDispatcher("./03.jsp").forward(request, response);

// 03.jsp : 이전 setAttribute 값 유지, 다시 forward
Object ob = request.getAttribute("C02");  // "02_Value" 접근 가능
request.setAttribute("C03", "03_Value");
request.getRequestDispatcher("./04.jsp").forward(request, response);
```

```jsp
<!-- 04.jsp : EL로 파라미터와 모든 setAttribute 접근 가능 -->
USERNAME    : ${param.username }
PASSWORD    : ${param.password }
02PAGE_ATTR : ${C02 }
03PAGE_ATTR : ${C03 }
```

> `${param.xxx}` → URL 파라미터 접근  
> `${키}` → `request.setAttribute()` 로 저장된 값 접근  
> Forward 체인을 따라 최종 페이지까지 같은 Request 객체가 흐름

---

### Redirect

```
01.html → 02.jsp → (redirect + Query String) → 03.jsp → (redirect) → 04.jsp
```

```java
// 02.jsp : Query String으로 데이터 넘기며 redirect
response.sendRedirect("./03.jsp?username=" + username + "&password=" + password);

// 03.jsp : request는 새로 생성되므로 setAttribute 불가 → Session에 저장
session.setAttribute("username", username);
session.setAttribute("password", password);
response.sendRedirect("./04.jsp");
```

```jsp
<!-- 04.jsp : Session 값을 EL로 접근 -->
USERNAME : ${username }
PASSWORD : ${password }
```

> Redirect는 새 요청이므로 `request.setAttribute()` 데이터가 소멸  
> 데이터를 다음 페이지로 넘기려면 **Query String** 또는 **Session** 활용

---

## Ch04 — DB 연동 (회원가입 / 로그인)

> MySQL DB와 연동해 회원가입·로그인 처리하는 실습  
> JDBC + DAO 패턴 + JSP useBean 조합

### 전체 페이지 흐름

```
Join_form.jsp ──POST──▶ auth/Join.jsp ──sendRedirect──▶ login_form.jsp
                                                                │
                                                               POST
                                                                ▼
                                                        auth/Login.jsp
                                                                │
                                              성공: sendRedirect → main.jsp
                                              실패: sendRedirect → login_form.jsp
```

---

### DBManager — JDBC 커넥션

```java
public class DBManager {
    public static Connection getConnection() throws SQLException {
        String driver   = "com.mysql.cj.jdbc.Driver";
        String url      = "jdbc:mysql://localhost:3306/SampleDB"
                        + "?useSSL=false&allowPublicKeyRetrieval=true"
                        + "&serverTimezone=Asia/Seoul&characterEncoding=UTF-8";
        String user     = "root";
        String password = "1234";

        try {
            Class.forName(driver);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("DBManager getConnection: " + e.getCause());
        }
        return DriverManager.getConnection(url, user, password);
    }

    // 여러 AutoCloseable 자원 일괄 close
    public static void close(AutoCloseable... closeables) {
        for (AutoCloseable c : closeables) {
            if (c != null) {
                try { c.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        }
    }
}
```

| 포인트 | 설명 |
|--------|------|
| `Class.forName(driver)` | JDBC 드라이버 로드 |
| `DriverManager.getConnection(url, user, pw)` | DB 커넥션 획득 |
| `close(AutoCloseable...)` | 가변인자로 Connection·Statement·ResultSet 한 번에 close |

---

### DTO 클래스

```java
// UserDTO — 회원가입 폼 전체 필드
public class UserDTO {
    private String userid, password, rePassword, username;
    private String zipcode, addr1, addr2;
    private String ph01, ph02, ph03;      // 휴대전화
    private String tel01, tel02, tel03;   // 연락처
    private String email01, email02;
    private String birthType, birthYear, birthMonth, birthDay;
    private String email_recv, sms_recv;
    // 디폴트 생성자, 전체인자 생성자, Getter/Setter, toString
}

// AuthDTO — 로그인 인증용 (userid + password만)
public class AuthDTO {
    private String userid;
    private String password;
    // 생성자, Getter/Setter, toString
}
```

---

### UserDAO — CRUD

```java
public class UserDAO {

    // 회원 등록
    public int insert(UserDTO dto) throws SQLException {
        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL_INSERT)) {
            pstmt.setString(1,  dto.getUserid());
            pstmt.setString(2,  dto.getPassword());
            // ... (21개 컬럼 바인딩)
            return pstmt.executeUpdate();
        }
    }

    // 로그인 인증 조회 (userid, password만 SELECT)
    public AuthDTO selectAuth(String userid) throws SQLException {
        AuthDTO ad = new AuthDTO();
        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL_SELECT_AUTH)) {
            pstmt.setString(1, userid);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                ad.setUserid(rs.getString("userid"));
                ad.setPassword(rs.getString("password"));
            }
        }
        return ad;
    }
}
```

> `try-with-resources` 로 Connection·PreparedStatement 자동 close  
> `PreparedStatement` 의 `?` 바인딩으로 SQL Injection 방지

---

### auth/Join.jsp — 회원가입 처리

```jsp
<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
%>

<!-- ① 폼 파라미터 → UserDTO 자동 바인딩 -->
<jsp:useBean id="dto1" class="Ch04.UserDTO" scope="request" />
<jsp:setProperty name="dto1" property="*" />

<!-- ② DB insert -->
<jsp:useBean id="dao" class="Ch04.UserDAO" scope="request" />
<%
    dao.insert(dto1);
    // ③ 완료 후 로그인 페이지로 redirect
    response.sendRedirect(request.getContextPath() + "/Ch04/login_form.jsp");
%>
```

---

### auth/Login.jsp — 로그인 처리

```jsp
<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
%>
<jsp:useBean id="dto" class="Ch04.AuthDTO" scope="request" />
<jsp:setProperty property="*" name="dto" />

<jsp:useBean id="dao" class="Ch04.UserDAO" scope="request"/>
<%
    AuthDTO ad = dao.selectAuth(dto.getUserid());

    // userid 없음
    if (ad.getUserid() == null) {
        session.setAttribute("isAuth", false);
        session.setAttribute("message", "동일한 id가 없습니다.");
        response.sendRedirect("../login_form.jsp");
        return;
    }
    // password 불일치
    if (ad.getPassword() == null || !ad.getPassword().equals(dto.getPassword())) {
        session.setAttribute("isAuth", false);
        session.setAttribute("message", "패스워드가 일치하지 않습니다.");
        response.sendRedirect("../login_form.jsp");
        return;
    }

    // 로그인 성공
    session.setAttribute("isAuth", true);
    session.setAttribute("message", "로그인 완료");
    response.sendRedirect("../main.jsp");
%>
```

| 처리 순서 | 설명 |
|-----------|------|
| ① 파라미터 수신 | AuthDTO 바인딩 |
| ② DB 조회 | `selectAuth(userid)` 로 해당 유저 조회 |
| ③ 유효성 검증 | userid 존재 여부 → password 일치 여부 순 확인 |
| ④-A 실패 | `session.setAttribute("message", ...)` 후 login_form으로 redirect |
| ④-B 성공 | `session.setAttribute("isAuth", true)` 후 main.jsp로 redirect |

---

### login_form.jsp — 실패 메시지 표시

```jsp
<span style="font-size:.7rem;color:red;">
    ${message }
</span>
```

> `session.setAttribute("message", ...)` 로 저장된 오류 메시지를  
> EL `${message}` 로 로그인 폼에 표시

### Session vs Request 속성 비교

| 구분 | `request.setAttribute()` | `session.setAttribute()` |
|------|--------------------------|--------------------------|
| **유지 범위** | 현재 요청 (Forward 체인 내) | 세션 유지 동안 (브라우저 닫을 때까지) |
| **Redirect 후** | 소멸 | 유지됨 |
| **주 용도** | Forward 시 데이터 전달 | 로그인 상태·사용자 정보 유지 |

---

## Ch05 — Session (세션)

> **Session** : 서버 측에 데이터를 저장하는 방식. 브라우저당 고유한 세션 ID를 부여하며, 기본 유지 시간은 **1800초(30분)**

| 구분 | `request` | `session` |
|------|-----------|-----------|
| 저장 위치 | 서버 (요청 단위) | 서버 (세션 단위) |
| 유지 범위 | 현재 요청 1회 (Forward 유지) | 세션이 만료될 때까지 |
| Redirect 후 | 소멸 | 유지 |
| 주 용도 | Forward 데이터 전달 | 로그인 상태, 사용자 정보 |

---

### Ch05/01 — Session 기본 (setAttribute vs getSession)

```jsp
<!-- setSession.jsp -->
<%
    request.setAttribute("t1", "v1");       // 요청 범위
    session.setAttribute("t2", "v2");       // 세션 범위 (기본 1800초)
%>
REQUEST t1 : ${t1 }   <!-- 같은 요청 내에서 접근 가능 -->
SESSION t2 : ${t2 }   <!-- 세션 만료 전까지 어디서든 접근 가능 -->
<a href="./getSession.jsp">세션의 속성 확인!</a>
```

```jsp
<!-- getSession.jsp -->
REQUEST t1 : ${t1 }   <!-- 빈 값 (redirect로 넘어왔기 때문에 소멸) -->
SESSION t2 : ${t2 }   <!-- "v2" 그대로 유지 -->
```

> 링크(`<a>` 클릭)로 이동하면 새 요청 → `request` 속성은 소멸, `session` 속성은 유지

---

### Ch05/02 — Session 기반 인증 (회원가입 / 로그인 / 로그아웃)

#### 페이지 흐름

```
join_form.jsp ──POST──▶ auth/Join.jsp ──sendRedirect──▶ login_form.jsp
                                                               │
                                                              POST
                                                               ▼
                                                       auth/Login.jsp
                                                               │
                                              성공: sendRedirect → main.jsp
                                              실패: sendRedirect → login_form.jsp
                                              
main.jsp ──────────────────────────────────▶ auth/Logout.jsp ──▶ main.jsp
```

---

#### ROLE enum — 역할 기반 인가

```java
public enum ROLE {
    ROLE_USER,    // 0 : 일반 사용자
    ROLE_MEMBER,  // 1 : 회원
    ROLE_ADMIN    // 2 : 관리자
}
```

> `userid`가 `"admin"` 이면 `ROLE_ADMIN`, 아니면 `ROLE_USER` 세션에 저장

---

#### UserDAO.select() — userid로 단건 조회

```java
public UserDTO select(String userid) throws SQLException {
    UserDTO dto = null;
    try (Connection conn = DBManager.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(SQL_SELECT)) {
        pstmt.setString(1, userid);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            dto = new UserDTO();
            dto.setUserid(rs.getString("userid"));
            dto.setPassword(rs.getString("password"));
        }
        return dto;   // 없으면 null
    }
}
```

> Ch04의 `selectAuth()` 와 달리 `UserDTO`를 반환 (userid 없으면 `null`)

---

#### auth/Login.jsp — 세션 기반 로그인 처리

```jsp
<jsp:useBean id="authDTO" class="Ch05.AuthDTO" scope="request" />
<jsp:setProperty name="authDTO" property="*" />

<jsp:useBean id="dao" class="Ch05.UserDAO" scope="request" />
<%@ page import="Ch05.UserDTO, Ch05.ROLE" %>
<%
    UserDTO userDTO = dao.select(authDTO.getUserid());

    // userid 없음
    if (userDTO == null) {
        session.setAttribute("isAuth", false);
        session.setAttribute("message", "⚠ 동일한 ID가 없습니다.");
        response.sendRedirect(request.getContextPath() + "/Ch05/02/login_form.jsp");
        return;
    }
    // password 불일치
    if (!authDTO.getPassword().equals(userDTO.getPassword())) {
        session.setAttribute("isAuth", false);
        session.setAttribute("message", "⚠ PW가 일치하지 않습니다.");
        response.sendRedirect(request.getContextPath() + "/Ch05/02/login_form.jsp");
        return;
    }

    // 로그인 성공 — 세션 설정
    session.setMaxInactiveInterval(60);   // 세션 유지 시간 60초로 변경
    session.setAttribute("isAuth", true);
    session.setAttribute("role", authDTO.getUserid().equals("admin") ? ROLE.ROLE_ADMIN : ROLE.ROLE_USER);
    session.setAttribute("message", "✔ 로그인 완료!");
    response.sendRedirect(request.getContextPath() + "/Ch05/02/main.jsp");
%>
```

| 처리 순서 | 설명 |
|-----------|------|
| ① AuthDTO 바인딩 | `userid`, `password` 파라미터 수신 |
| ② DB 조회 | `dao.select(userid)` → `null` 이면 실패 처리 |
| ③ 비밀번호 검증 | DB 저장값과 입력값 비교 |
| ④ 세션 저장 | `isAuth`, `role`, `message` 세션에 저장 |
| ⑤ 이동 | 성공 → `main.jsp` / 실패 → `login_form.jsp` |

---

#### auth/Logout.jsp — 세션 무효화

```jsp
<%
    session.invalidate();   // 세션 전체 삭제
    response.sendRedirect(request.getContextPath() + "/Ch05/02/main.jsp");
%>
```

> `session.invalidate()` : 현재 세션의 모든 속성을 삭제하고 세션 종료

---

#### main.jsp — 세션 체크 (인가 처리)

```jsp
<h1>MAIN PAGE</h1>
역할 : ${role }
<a href="./auth/Logout.jsp">로그아웃</a>

<%
    if (session.getAttribute("isAuth") == null) {
        session.setAttribute("message", "로그인이 필요한 페이지입니다.");
        response.sendRedirect(request.getContextPath() + "/Ch05/02/login_form.jsp");
        return;
    }
    session.removeAttribute("message");
%>
```

> 세션에 `isAuth` 없으면 로그인 페이지로 강제 이동 → **인가(Authorization) 처리** 패턴

---

#### login_form.jsp — 세션 메시지 표시 후 속성 제거

```jsp
<span style="font-size:.7rem;color:red;">
    ${message}   <!-- 실패 메시지 출력 -->
</span>

<%
    session.removeAttribute("isAuth");
    session.removeAttribute("message");   // 한 번 표시 후 제거 (Flash 메시지 패턴)
%>
```

> 세션에서 한 번 읽은 메시지를 즉시 제거 → **Flash Message 패턴**

---

## Ch06 — Cookie (쿠키)

> **Cookie** : 클라이언트(브라우저)에 저장하는 문자열 데이터. 서버와 브라우저가 HTTP 헤더를 통해 주고받는다.

| 특징 | 내용 |
|------|------|
| 저장 데이터 | 문자열만 가능 |
| 크기 제한 | 쿠키 1개당 4KB 이하 |
| 개수 제한 | 브라우저당 최대 300개, 도메인당 20개 |
| 초과 시 | 최근에 사용되지 않은 쿠키부터 자동 삭제 |
| 유지 기간 | `setMaxAge()` 로 설정, `-1`이면 브라우저 종료 시 삭제 |

---

### Ch06/01 — Cookie CRUD

#### setCookie.jsp — 쿠키 생성 및 응답에 추가

```jsp
<%
    // cookie1 : MaxAge 미설정(-1 기본값) → 파일 미생성, 브라우저 종료 시 소멸
    Cookie cookie1 = new Cookie("cookie1", "value1");
    cookie1.setPath("/");

    // cookie2 : 5분(300초) 후 만료 → 파일로 저장됨
    Cookie cookie2 = new Cookie("cookie2", "value2");
    cookie2.setMaxAge(60 * 5);
    cookie2.setPath("/");

    response.addCookie(cookie1);
    response.addCookie(cookie2);
%>
```

| `setMaxAge()` 값 | 동작 |
|-----------------|------|
| `-1` (기본값) | 파일 미생성, 브라우저 닫으면 소멸 |
| `0` | 즉시 만료 (쿠키 삭제에 사용) |
| 양수 (초) | 지정한 초 후 만료, 파일로 저장 |

---

#### getCookie.jsp — 쿠키 목록 조회

```jsp
<%
    Cookie[] cookies = request.getCookies();
    for (Cookie cookie : cookies) {
        System.out.println("key : " + cookie.getName() + " val : " + cookie.getValue());
%>
        <%= cookie.getName() %> : <%= cookie.getValue() %> <br/>
        <a href="./deleteCookie.jsp?name=<%= cookie.getName() %>">
            <%= cookie.getName() %> 쿠키삭제하기
        </a>
<%
    }
%>
```

> `request.getCookies()` → `Cookie[]` 반환 (쿠키가 없으면 `null`)  
> 각 쿠키의 이름·값을 출력하고 삭제 링크 제공

---

#### deleteCookie.jsp — 쿠키 삭제

```jsp
<%
    String cookieName = request.getParameter("name");
    if (cookieName != null) {
        Cookie cookie = new Cookie(cookieName, null);  // 빈 Value 쿠키 생성
        cookie.setMaxAge(0);    // 유지 시간 0초 → 즉시 만료
        cookie.setPath("/");    // 원래 쿠키와 동일한 Path 지정 (필수!)
        response.addCookie(cookie);   // 만료된 쿠키로 덮어쓰기 → 사실상 삭제
    }
%>
<script>
    alert("쿠키가 삭제되었습니다.");
    location.href = './getCookie.jsp';
</script>
```

> 쿠키 삭제 = 동일한 이름·Path 로 `MaxAge(0)` 쿠키를 재전송해 덮어씌우는 것  
> `setPath()` 를 원래와 다르게 설정하면 삭제되지 않으므로 주의

---

### Ch06/02 — Cookie Path 설정

> `setPath()` : 해당 쿠키가 전송되는 URI 범위를 지정

```jsp
<%
    // "/" : 현재 도메인 전체 (http://localhost:8080 내 모든 페이지)
    Cookie cookie1 = new Cookie("cookie1", "value1");
    cookie1.setMaxAge(60 * 10);
    cookie1.setPath("/");

    // "./" : 현재 디렉토리 하위 (http://localhost:8080/01_JSP/Ch06/02/*)
    Cookie cookie2 = new Cookie("cookie2", "value2");
    cookie2.setMaxAge(60 * 10);
    cookie2.setPath("./");

    // 특정 경로 지정 : Ch01 하위에서만 전송
    Cookie cookie3 = new Cookie("cookie3", "value3");
    cookie3.setMaxAge(60 * 10);
    cookie3.setPath("/01_JSP/Ch01");

    response.addCookie(cookie1);
    response.addCookie(cookie2);
    response.addCookie(cookie3);
%>
```

| Path | 쿠키 전송 범위 |
|------|--------------|
| `"/"` | 도메인 전체 (`http://localhost:8080/` 이하 모든 경로) |
| `"./"` | 현재 디렉토리 이하 (`/01_JSP/Ch06/02/*`) |
| `"/01_JSP/Ch01"` | 해당 경로 이하만 (`/01_JSP/Ch01/*`) |

> 쿠키를 삭제할 때는 **생성 시와 동일한 Path** 로 `MaxAge(0)` 쿠키를 보내야 함

---

## Ch07 — 내장 객체 심화 & 파일 다운로드

---

### C01 — pageContext 내장 객체

> `pageContext` : 현재 JSP 페이지의 모든 내장 객체에 접근할 수 있는 최상위 컨텍스트

```jsp
<%
    pageContext.getRequest()          // request 객체
    pageContext.getResponse()         // response 객체
    pageContext.getServletContext()   // application 객체 (서버 전체 공유)
    pageContext.getServletContext().getContextPath()  // 프로젝트 루트 경로
%>
```

**컨텍스트 경로(Context Path) 접근 방법 비교**

| 방식 | 코드 | 결과 예시 |
|------|------|----------|
| `pageContext` 표현식 | `<%=pageContext.getServletContext().getContextPath()%>` | `/01_JSP` |
| `request` 표현식 | `<%=request.getContextPath()%>` | `/01_JSP` |
| EL (`pageContext` 경유) | `${pageContext.request.contextPath}` | `/01_JSP` |
| EL (`request` 직접) | `${request.contextPath}` | (미동작 — EL에서는 pageContext 경유 필요) |

> `action`, `href` 등에서 절대 경로 사용 시 `${pageContext.request.contextPath}` 를 앞에 붙여야 배포 환경에서도 경로가 깨지지 않음

---

### C02 — request 내장 객체 주요 메서드

```jsp
<%
    String protocol    = request.getProtocol();           // HTTP/1.1
    String serverName  = request.getServerName();         // localhost
    int    serverPort  = request.getServerPort();         // 8080
    String remoteAddr  = request.getRemoteAddr();         // 클라이언트 IP
    String remoteHost  = request.getRemoteHost();         // 클라이언트 호스트명
    String method      = request.getMethod();             // GET / POST
    StringBuffer url   = request.getRequestURL();         // http://localhost:8080/01_JSP/Ch07/C02Request.jsp
    String uri         = request.getRequestURI();         // /01_JSP/Ch07/C02Request.jsp
    String browser     = request.getHeader("User-Agent"); // 브라우저 정보
    String fileType    = request.getHeader("Accept");     // 클라이언트가 수용하는 MIME 타입
%>
```

| 메서드 | 반환값 예시 | 설명 |
|--------|------------|------|
| `getProtocol()` | `HTTP/1.1` | 프로토콜 버전 |
| `getServerName()` | `localhost` | 서버 호스트명 |
| `getServerPort()` | `8080` | 서버 포트 |
| `getRemoteAddr()` | `127.0.0.1` | 클라이언트 IP 주소 |
| `getRemoteHost()` | `127.0.0.1` | 클라이언트 호스트명 |
| `getMethod()` | `GET` | 요청 HTTP 메서드 |
| `getRequestURL()` | `http://localhost:8080/...` | 전체 URL (`StringBuffer`) |
| `getRequestURI()` | `/01_JSP/Ch07/...` | 도메인 제외 경로 |
| `getHeader("User-Agent")` | `Mozilla/5.0 ...` | 브라우저 정보 |
| `getHeader("Accept")` | `text/html,...` | 클라이언트 수용 MIME 타입 |

---

### C03 — response 내장 객체 주요 기능

```jsp
<%
    // 1. 리다이렉트
    response.sendRedirect("./C02Request.jsp");

    // 2. HTTP 에러 코드 전송
    response.sendError(HttpServletResponse.SC_NOT_FOUND);        // 404
    response.sendError(HttpServletResponse.SC_REQUEST_TIMEOUT);  // 408

    // 3. 자동 새로고침 (3초마다)
    response.setIntHeader("Refresh", 3);

    // 4. 응답 OutputStream 직접 추출 (파일 다운로드 등에 사용)
    ServletOutputStream bout = response.getOutputStream();
    bout.write('a');
    bout.flush();
    bout.close();

    // 5. JSP 내장 out 객체로 직접 출력
    out.write('a');
    out.write('b');
%>
<%=new Date()%>   <!-- java.util.Date 현재 시각 출력 -->
```

| 기능 | 메서드 | 설명 |
|------|--------|------|
| 리다이렉트 | `sendRedirect(url)` | 클라이언트에게 새 URL 재요청 지시 |
| 에러 전송 | `sendError(status)` | HTTP 에러 코드 응답 |
| 자동 새로고침 | `setIntHeader("Refresh", 초)` | 지정 초마다 페이지 재요청 |
| 응답 스트림 | `getOutputStream()` | 바이너리 데이터 직접 전송 시 사용 |

---

### C04 — 단일 파일 다운로드

> `C04Download_Link.jsp` 에서 링크를 클릭하면 `C04Download_SingleFile.jsp` 가 실행되어 파일 전송

```
C04Download_Link.jsp
  ├─ [단일파일] → C04Download_SingleFile.jsp
  └─ [묶음파일] → C05Download_zip.jsp
```

```jsp
<%@page import="java.io.*"%>
<%
    // 1. 서버 내 실제 파일 경로 획득
    String dirPath = pageContext.getServletContext().getRealPath("/") + "Ch07\\files\\";
    InputStream fin = new FileInputStream(dirPath + "file1.pptx");

    // 2. JSP의 기본 out 스트림 초기화 (HTML 출력 방지)
    out.clear();
    out = pageContext.pushBody();

    // 3. 다운로드용 Response 헤더 설정
    response.setHeader("Content-Type",        "application/octet-stream;charset=utf-8");
    response.setHeader("Content-Disposition", "attachment;filename=file1.pptx");

    // 4. 응답 OutputStream으로 파일 전송 (4KB 버퍼)
    ServletOutputStream bout = response.getOutputStream();
    byte[] buff = new byte[4096];
    while (true) {
        int data = fin.read(buff);
        if (data == -1) break;
        bout.write(buff, 0, data);
        bout.flush();
    }
    bout.close();
    fin.close();
%>
```

| 핵심 포인트 | 설명 |
|------------|------|
| `getRealPath("/")` | 웹 애플리케이션 루트의 **실제 파일 시스템 경로** 반환 |
| `out.clear()` + `pushBody()` | JSP HTML 출력 버퍼를 비우고 순수 바이너리 전송 모드로 전환 |
| `Content-Type: application/octet-stream` | 브라우저가 파일을 렌더링하지 않고 다운로드로 처리하게 함 |
| `Content-Disposition: attachment;filename=...` | 저장 파일명 지정 |
| 4KB 버퍼 루프 | 대용량 파일도 메모리 부담 없이 스트리밍 전송 |

---

### C05 — 여러 파일 ZIP 묶음 다운로드

```jsp
<%@page import="java.io.*, java.util.zip.*"%>
<%
    // 1. 디렉토리 내 모든 파일 목록 획득
    String dirPath = pageContext.getServletContext().getRealPath("/") + "Ch07\\files\\";
    File[] fileList = new File(dirPath).listFiles();

    // 2. out 스트림 초기화
    out.clear();
    out = pageContext.pushBody();

    // 3. 응답 OutputStream → ZipOutputStream 연결
    ServletOutputStream bout = response.getOutputStream();
    ZipOutputStream zout = new ZipOutputStream(bout);

    // 4. 다운로드 헤더 설정
    response.setHeader("Content-Type",        "application/octet-stream;charset=utf-8");
    response.setHeader("Content-Disposition", "attachment; filename=ALLFILES.zip");

    // 5. 파일별로 ZipEntry 추가
    for (File file : fileList) {
        FileInputStream in = new FileInputStream(file);
        zout.putNextEntry(new ZipEntry(file.getName()));  // ZIP 내 파일 이름 등록

        int data;
        while ((data = in.read()) != -1)
            zout.write((byte) data);

        zout.closeEntry();   // 하나의 ZipEntry 완료
        in.close();
    }

    zout.flush();
    zout.close();
    bout.close();
%>
```

| 클래스 / 메서드 | 역할 |
|----------------|------|
| `ZipOutputStream` | ZIP 형식으로 데이터를 쓰는 출력 스트림 |
| `ZipEntry(name)` | ZIP 파일 내 개별 항목(파일) 정의 |
| `putNextEntry(entry)` | 새 파일 항목 시작 |
| `closeEntry()` | 현재 파일 항목 종료 |
| `zout.flush() / close()` | ZIP 스트림 최종화 및 닫기 |

> 단일 파일과 달리 1바이트씩 읽으므로 대용량 파일에는 4096 byte 버퍼 방식 권장

---

## Servlet — 기초 & 등록 방식

> **Servlet** : Java 클래스로 작성된 서버 사이드 컴포넌트. JSP가 내부적으로 변환되는 대상이기도 함  
> `HttpServlet` 을 상속받아 생명주기 메서드를 오버라이드해서 구현

---

### 서블릿 생명주기 (Lifecycle)

```java
public class C01Servlet_Test extends HttpServlet {

    @Override
    public void init() throws ServletException {
        // 서블릿 최초 로딩 시 1회만 실행 (인스턴스 생성 직후)
        System.out.println("init invoke...");
    }

    @Override
    public void service(ServletRequest req, ServletResponse res)
            throws ServletException, IOException {
        // 클라이언트 요청마다 실행
        System.out.println("service invoke...");
    }

    @Override
    public void destroy() {
        // 서블릿 클래스 변경 감지 또는 서버 종료 시 실행
        System.out.println("destroy invoke...");
    }
}
```

| 메서드 | 호출 시점 | 호출 횟수 |
|--------|----------|----------|
| `init()` | 서블릿 최초 로딩 시 | 1회 |
| `service()` | 클라이언트 요청마다 | 매 요청 |
| `destroy()` | 클래스 변경 감지 / 서버 종료 시 | 1회 |

---

### 서블릿 등록 방식 2가지

#### 방식 1 — `@WebServlet` 어노테이션

```java
@WebServlet("/TEST_01")
public class C01Servlet_Test extends HttpServlet { ... }
```

- 클래스 파일에 직접 URL 매핑
- 별도 설정 파일 불필요
- 소규모 프로젝트에 적합

#### 방식 2 — `web.xml` 등록

```xml
<!-- web.xml -->
<servlet>
    <servlet-name>C02Servlet</servlet-name>
    <servlet-class>Servlet.C02Servlet_Test</servlet-class>
</servlet>
<servlet-mapping>
    <servlet-name>C02Servlet</servlet-name>
    <url-pattern>/TEST_02</url-pattern>   <!-- 반드시 / 로 시작 -->
</servlet-mapping>
```

- 클래스에 어노테이션 없이 외부 설정으로 분리
- URL 변경 시 코드 수정 불필요 (설정 파일만 수정)
- 대규모 프로젝트 / URL 중앙 관리에 적합

| 구분 | `@WebServlet` | `web.xml` |
|------|--------------|-----------|
| 설정 위치 | 클래스 파일 내 | `WEB-INF/web.xml` |
| URL 변경 시 | 코드 재컴파일 필요 | 설정 파일만 수정 |
| 가독성 | 클래스와 URL이 한눈에 보임 | URL이 분리되어 관리됨 |

---

### ⚠ url-pattern 주의사항

```xml
<!-- 잘못됨 — 앱 전체 배포 실패 -->
<url-pattern>TEST_02</url-pattern>

<!-- 올바름 -->
<url-pattern>/TEST_02</url-pattern>
```

`url-pattern`에 `/` 가 없으면 Tomcat이 web.xml 파싱 시 **`IllegalArgumentException`** 을 던지며 앱 전체가 배포 실패한다.  
`@WebServlet` 어노테이션 방식으로 등록된 서블릿(C01 등)까지 모두 응답 불가 상태가 된다.

---

## 02_SERVLET_INIT — MVC 패턴 실전 (C03 ~ C06)

> JSP + Servlet + DAO/DTO 조합으로 회원가입·로그인·로그아웃을 구현한 실전 예제  
> `BeanUtils.populate()` 로 폼 파라미터를 DTO에 자동 바인딩하고, Forward / Redirect 를 상황에 맞게 선택

### 전체 URL 흐름

```
GET  /login.do  ──▶ login.jsp  (로그인 폼)
POST /login.do  ──▶ 인증 처리 ──▶ 성공: redirect → /main.do
                                 ──▶ 실패: forward → login.jsp (에러 메시지 표시)

GET  /join.do   ──▶ join.jsp   (회원가입 폼)
POST /join.do   ──▶ DB insert ──▶ 성공: redirect → /login.do
                                 ──▶ 실패: forward → join.jsp

GET  /main.do   ──▶ main.jsp   (메인 페이지)

GET  /logout.do ──▶ 세션 무효화 → forward → main.jsp
```

---

### C03 — `/main.do` (메인 페이지 라우팅)

```java
@WebServlet("/main.do")
public class C03Servlet_Test extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/main.jsp").forward(req, resp);
    }
}
```

> GET 요청만 처리. 단순히 `main.jsp` 로 forward만 수행하는 라우터 역할

---

### C04 — `/join.do` (회원가입)

```java
@WebServlet("/join.do")
public class C04Servlet_Test extends HttpServlet {
    private UserDAO userDAO;
    HttpSession session;
    HttpServletRequest req;   // ⚠ 인스턴스 변수 — isVaild() 내부에서 사용하기 위해 저장

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();   // 서블릿 최초 로딩 시 1회만 생성
    }

    // GET : 회원가입 폼 표시
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) ... {
        req.getRequestDispatcher("/WEB-INF/join.jsp").forward(req, resp);
    }

    // POST : 회원가입 처리
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) ... {
        // ① 폼 파라미터 → UserDTO 자동 바인딩 (BeanUtils)
        UserDTO userDTO = new UserDTO();
        BeanUtils.populate(userDTO, req.getParameterMap());

        session = req.getSession();
        this.req = req;

        // ② 유효성 검증 — 에러 있으면 폼으로 forward (에러 메시지 포함)
        if (isVaild(userDTO)) {
            req.getRequestDispatcher("/WEB-INF/join.jsp").forward(req, resp);
            return;
        }

        // ③ DB insert
        int result = userDAO.insert(userDTO);

        // ④ 결과에 따라 이동
        if (result > 0) {
            session.setAttribute("message", "회원가입 성공");
            resp.sendRedirect(req.getContextPath() + "/login.do");  // redirect
        } else {
            session.setAttribute("message", "회원가입 실패");
            req.getRequestDispatcher("/WEB-INF/join.jsp").forward(req, resp);  // forward
        }
    }

    // 유효성 검증 — 에러 있으면 true, 없으면 false
    private boolean isVaild(UserDTO userDTO) {
        boolean isOK = true;
        if (userDTO.getUserid() == null || userDTO.getUserid().isEmpty()) {
            req.setAttribute("userid", "⚠USERID를 입력");
            isOK = false;
        }
        if (userDTO.getPassword() == null || userDTO.getPassword().isEmpty()) {
            req.setAttribute("password", "⚠PASSWORD를 입력");
            isOK = false;
        }
        return !isOK;   // ⚠ 원본은 return true; 로 되어있어 항상 폼으로 forward되는 버그 있음
    }
}
```

| 처리 순서 | 메서드 / 기술 | 설명 |
|-----------|-------------|------|
| ① 바인딩 | `BeanUtils.populate(dto, req.getParameterMap())` | 폼 파라미터 전체를 DTO 필드에 자동 매핑 |
| ② 검증 | `isVaild()` | userid/password 빈값 체크 → `req.setAttribute`로 에러 메시지 저장 |
| ③ 검증 실패 | `forward` → join.jsp | 에러 메시지를 EL `${userid}`, `${password}` 로 표시 |
| ④ DB 저장 | `userDAO.insert(userDTO)` | 21개 컬럼 INSERT |
| ⑤ 성공 이동 | `sendRedirect` → /login.do | 새 요청 생성, URL 변경 |

---

### C05 — `/login.do` (로그인 + 세션 인증)

```java
@WebServlet("/login.do")
public class C05Servlet_Test extends HttpServlet {
    private UserDAO userDAO;
    HttpSession session;
    HttpServletRequest req;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    // GET : 로그인 폼 표시
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) ... {
        req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, resp);
    }

    // POST : 로그인 처리
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) ... {
        // ① 폼 파라미터 → AuthDTO 바인딩
        AuthDTO authDTO = new AuthDTO();
        BeanUtils.populate(authDTO, req.getParameterMap());

        session = req.getSession();
        this.req = req;

        // ② 빈값 검증
        if (isVaild(authDTO)) {
            req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, resp);
            return;
        }

        // ③ DB 조회 — userid로 단건 조회 (없으면 null)
        UserDTO userDTO = userDAO.select(authDTO.getUserid());
        if (userDTO == null) {
            req.setAttribute("isAuth", false);
            req.setAttribute("userid", "⚠ 동일한 ID가 없습니다.");
            req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, resp);
            return;
        }

        // ④ 비밀번호 검증
        if (!authDTO.getPassword().equals(userDTO.getPassword())) {
            req.setAttribute("isAuth", false);
            req.setAttribute("password", "⚠ PW가 일치하지 않습니다.");
            req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, resp);
            return;
        }

        // ⑤ 세션 인증 저장
        session.setMaxInactiveInterval(60);   // 세션 유지 60초
        session.setAttribute("isAuth", true);
        session.setAttribute("role",
            authDTO.getUserid().equals("admin") ? ROLE.ROLE_ADMIN : ROLE.ROLE_USER);

        // ⑥ 메인으로 redirect
        resp.sendRedirect(req.getContextPath() + "/main.do");
        session.setAttribute("message", "✔ 로그인 완료!");
    }

    private boolean isVaild(AuthDTO authDTO) {
        boolean isOK = true;
        if (authDTO.getUserid() == null || authDTO.getUserid().isEmpty()) {
            req.setAttribute("userid", "⚠USERID를 입력");
            isOK = false;
        }
        if (authDTO.getPassword() == null || authDTO.getPassword().isEmpty()) {
            req.setAttribute("password", "⚠PASSWORD를 입력");
            isOK = false;
        }
        return !isOK;   // 에러 있으면 true
    }
}
```

#### 인증 실패 시 에러 메시지 표시 원리

```
POST /login.do
  └─ req.setAttribute("userid", "⚠ 동일한 ID가 없습니다.")
  └─ forward → /WEB-INF/login.jsp
                  └─ ${userid}   ← requestScope에서 찾아 표시
```

> `forward`는 같은 Request 객체를 유지하므로 `req.setAttribute()` 값이 JSP EL에서 그대로 접근됨  
> `redirect`를 쓰면 새 Request가 생성되어 값이 소멸 → 에러 전달 불가

#### 실패 유형별 처리

| 실패 원인 | setAttribute key | login.jsp 표시 위치 |
|----------|-----------------|-------------------|
| userid/password 빈값 | `"userid"`, `"password"` | `${userid}`, `${password}` |
| DB에 userid 없음 | `"userid"` | `${userid}` |
| 비밀번호 불일치 | `"password"` | `${password}` |

---

### C06 — `/logout.do` (로그아웃)

```java
@WebServlet("/logout.do")
public class C06Servlet_Test extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        session.invalidate();   // 세션 전체 삭제

        req.getRequestDispatcher("/WEB-INF/main.jsp").forward(req, resp);
    }
}
```

> `session.invalidate()` : 현재 세션의 모든 속성 삭제 및 세션 종료  
> 로그아웃 후 `main.jsp`로 forward → `isAuth`가 없으므로 미인증 상태로 표시

---

### BeanUtils.populate() vs jsp:useBean 비교

| 방식 | 코드 위치 | 특징 |
|------|----------|------|
| `jsp:useBean` + `jsp:setProperty property="*"` | JSP | JSP 전용, Servlet에서 사용 불가 |
| `BeanUtils.populate(dto, req.getParameterMap())` | Servlet Java 코드 | Apache Commons BeanUtils 라이브러리 필요, Servlet에서 사용 |

두 방식 모두 **폼 `name` 속성 = DTO 필드명** 이 일치해야 자동 매핑된다.

---

### ⚠ 설계 주의사항

#### 인스턴스 변수로 req 저장 — 스레드 안전 문제

```java
// C04, C05 모두 동일한 패턴
HttpServletRequest req;   // 인스턴스 변수

protected void doPost(HttpServletRequest req, ...) {
    this.req = req;        // isVaild()에서 쓰기 위해 저장
}
```

서블릿은 **싱글턴 인스턴스** 로 동작하므로 동시 요청 시 `this.req` 가 덮어씌워질 수 있다.  
실무에서는 `req` 를 `isVaild()` 의 **메서드 파라미터** 로 전달하는 것이 안전하다.

```java
// 권장 패턴
private boolean isVaild(AuthDTO authDTO, HttpServletRequest req) { ... }
```

#### isVaild() 원본 버그

C04, C05 원본 코드의 `isVaild()`는 `return true;` 로 하드코딩되어 있어  
항상 유효성 검증 실패로 판단 → DB 조회 코드에 절대 도달하지 못한다.  
`return !isOK;` 로 수정해야 정상 동작한다.

---

## 03_FILTER — 필터 (Filter)

> **Filter** : Servlet 요청/응답 사이에 끼어들어 전처리·후처리를 수행하는 컴포넌트  
> `javax.servlet.Filter` 인터페이스를 구현하고 `doFilter()` 를 오버라이드해 작성

### 필터 실행 구조

```
클라이언트 요청
    │
    ▼
[ Filter_1 전처리 ]
    │
    ▼
[ Filter_2 전처리 ]
    │
    ▼
  Servlet (비즈니스 로직)
    │
    ▼
[ Filter_2 후처리 ]
    │
    ▼
[ Filter_1 후처리 ]
    │
    ▼
클라이언트 응답
```

> `chain.doFilter()` 를 기준으로 **앞** = 요청 전처리, **뒤** = 응답 후처리  
> 여러 필터가 등록된 경우 `web.xml` 등록 순서대로 체인 실행

---

### MainFilter_1 / MainFilter_2 — 기본 필터 구조

```java
public class MainFilter_1 implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // ① 요청 전처리
        System.out.println("[FILTER] MAIN FILTER_1 START");

        chain.doFilter(request, response);   // ② 다음 필터 or 서블릿으로 전달

        // ③ 응답 후처리
        System.out.println("[FILTER] MAIN FILTER_1 END");
    }
}
```

`/main.do` 에 Filter_1, Filter_2 두 개를 동시에 등록하면 실행 순서:

```
[FILTER] MAIN FILTER_1 START
[FILTER] MAIN FILTER_2 START
  → 서블릿 실행
[FILTER] MAIN FILTER_2 END
[FILTER] MAIN FILTER_1 END
```

---

### UTF8_EncodingFilter — 인코딩 공통 처리

```java
public class UTF8_EncodingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // 요청 전 — 한글 파라미터 깨짐 방지
        request.setCharacterEncoding("UTF-8");

        chain.doFilter(request, response);

        // 응답 후 — 응답 Content-Type 설정
        response.setContentType("text/html; charset=UTF-8");
    }
}
```

> 모든 서블릿에서 `request.setCharacterEncoding("UTF-8")` 을 반복하는 대신  
> 필터 1개로 전체 `.do` 요청에 일괄 적용

---

### 필터 등록 방법 비교

#### 방법 1 — `@WebFilter` 어노테이션

```java
@WebFilter("/main.do")
public class MainFilter_1 implements Filter { ... }

// 여러 URL 동시 적용
@WebFilter(urlPatterns = {"/main.do", "/login.do"})
public class MainFilter_1 implements Filter { ... }
```

#### 방법 2 — `web.xml` 등록

```xml
<filter>
    <filter-name>UTF8_EncodingFilter</filter-name>
    <filter-class>Filter.UTF8_EncodingFilter</filter-class>
</filter>
<filter-mapping>
    <filter-name>UTF8_EncodingFilter</filter-name>
    <url-pattern>*.do</url-pattern>   <!-- .do 전체에 적용 -->
</filter-mapping>
```

| 구분 | `@WebFilter` | `web.xml` |
|------|-------------|-----------|
| 다중 필터 순서 보장 | 보장 안 됨 (JVM 로딩 순서 의존) | 등록 순서대로 보장 |
| URL 변경 시 | 코드 재컴파일 필요 | 설정 파일만 수정 |
| 권장 | 단순 단일 필터 | 순서가 중요한 다중 필터 |

#### ⚠ url-pattern 주의

| 패턴 | 적용 범위 |
|------|----------|
| `/main.do` | 해당 URL만 정확히 일치 |
| `*.do` | `.do` 로 끝나는 모든 URL |
| `/*` | 모든 URL |
| `.do` | **잘못된 형식** — `IllegalArgumentException` 발생, 앱 전체 배포 실패 |

---

## 04_LISTENER — 리스너 (Listener)

> **Listener** : 서블릿 컨테이너의 생명주기 이벤트를 감지해 자동으로 호출되는 컴포넌트  
> `@WebListener` 어노테이션 또는 `web.xml` 에 등록

### 리스너 종류 6가지

| 클래스 | 인터페이스 | 감지 이벤트 | 주요 메서드 |
|--------|-----------|------------|-----------|
| C01 | `ServletContextListener` | 앱 시작 / 종료 | `contextInitialized()`, `contextDestroyed()` |
| C02 | `ServletContextAttributeListener` | application 속성 변경 | `attributeAdded()`, `attributeRemoved()`, `attributeReplaced()` |
| C03 | `HttpSessionListener` | 세션 생성 / 소멸 | `sessionCreated()`, `sessionDestroyed()` |
| C04 | `HttpSessionAttributeListener` | session 속성 변경 | `attributeAdded()`, `attributeRemoved()`, `attributeReplaced()` |
| C05 | `ServletRequestListener` | 요청 시작 / 종료 | `requestInitialized()`, `requestDestroyed()` |
| C06 | `ServletRequestAttributeListener` | request 속성 변경 | `attributeAdded()`, `attributeRemoved()`, `attributeReplaced()` |

### 이벤트 발생 범위

```
[ 앱 시작 ]  →  C01 contextInitialized()
    │
    │  [ 요청 수신 ]  →  C05 requestInitialized()
    │      │
    │      │  [ 세션 생성 ]  →  C03 sessionCreated()
    │      │      │
    │      │      │  session.setAttribute() → C04 attributeAdded()
    │      │      │
    │      │  [ 세션 소멸 ]  →  C03 sessionDestroyed()
    │      │
    │  [ 요청 완료 ]  →  C05 requestDestroyed()
    │
[ 앱 종료 ]  →  C01 contextDestroyed()
```

### 등록 방법

```java
@WebListener
public class C01ServletContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // 앱 시작 시 1회 — DB 커넥션 풀 초기화, 공통 설정 로딩 등에 활용
        System.out.println("[LISTENER] App Start...");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // 앱 종료 시 1회 — 자원 해제
        System.out.println("[LISTENER] App Stop...");
    }
}
```

```java
@WebListener
public class C03HttpSessionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        // 세션 생성 시 — 동시 접속자 수 카운트 등에 활용
        System.out.println("[LISTENER] Session Created...");
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        System.out.println("[LISTENER] Session Destroyed...");
    }
}
```

> 현재 프로젝트의 C01~C06 리스너는 모두 주석 처리된 상태 (학습용 골격 코드)

---

## 05_RESOURCE — 커넥션 풀 / DataSource (JNDI)

> 요청마다 JDBC 커넥션을 새로 생성하는 방식은 TCP 연결 비용이 크다  
> Tomcat이 미리 커넥션을 만들어 풀(Pool)로 관리하고, 앱은 JNDI로 꺼내 쓰는 방식

### 직접 JDBC vs 커넥션 풀 비교

| 구분 | 직접 JDBC | 커넥션 풀 (DataSource) |
|------|----------|----------------------|
| 커넥션 생성 시점 | 요청마다 새로 생성 | 앱 시작 시 미리 생성 |
| 속도 | 느림 (TCP 핸드셰이크 매번) | 빠름 (풀에서 재사용) |
| 설정 위치 | Java 코드 | `context.xml` |
| 관리 주체 | 개발자 | Tomcat 컨테이너 |

---

### 설정 — META-INF/context.xml

```xml
<Context>
    <Resource
        driverClassName="com.mysql.cj.jdbc.Driver"
        url="jdbc:mysql://localhost/opendatadb"
        username="root"
        password="1234"
        name="jdbc/MysqlDB"
        type="javax.sql.DataSource"
        auth="Container"
        maxActive="10"
        maxIdle="2"
        maxWait="5000" />
</Context>
```

| 속성 | 설명 |
|------|------|
| `name` | JNDI 조회 키 (`jdbc/MysqlDB`) |
| `type` | `javax.sql.DataSource` 고정 |
| `auth` | `Container` — Tomcat이 인증 관리 |
| `maxActive` | 풀에서 동시에 사용할 수 있는 최대 커넥션 수 |
| `maxIdle` | 풀에서 대기 상태로 유지할 최대 커넥션 수 |
| `maxWait` | 풀이 고갈됐을 때 커넥션을 기다리는 최대 시간 (ms), `-1` 이면 무한 대기 |

---

### 사용 — JNDI 조회

```java
// DbUtils.conn()
Context initContext = new InitialContext();
Context envContext  = (Context) initContext.lookup("java:/comp/env");

DataSource dataSource = (DataSource) envContext.lookup("jdbc/MysqlDB");
conn = dataSource.getConnection();   // 풀에서 커넥션 1개 대여
```

| JNDI 경로 | 설명 |
|-----------|------|
| `java:/comp/env` | J2EE 표준 환경 네이밍 컨텍스트 진입점 |
| `jdbc/MysqlDB` | context.xml `name` 속성값과 일치해야 함 |

> `dataSource.getConnection()` 은 풀에서 커넥션을 빌리는 것  
> 사용 후 반드시 `conn.close()` 를 호출해야 풀에 반납됨 (실제 연결 종료 아님)

---

### DbUtils 전체 구조

```java
public class DbUtils {
    private static Connection conn = null;
    private static PreparedStatement pstmt = null;
    private static ResultSet rs = null;

    // ① JNDI로 DataSource에서 커넥션 획득
    public static void conn() throws Exception {
        Context initContext = new InitialContext();
        Context envContext  = (Context) initContext.lookup("java:/comp/env");
        DataSource dataSource = (DataSource) envContext.lookup("jdbc/MysqlDB");
        conn = dataSource.getConnection();
    }

    // ② 자원 일괄 해제
    public static void disConn() throws Exception {
        if (rs    != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn  != null) conn.close();   // 풀에 반납
    }

    // ③ INSERT
    public static int insertUser(String username, String password) throws Exception {
        pstmt = conn.prepareStatement("insert into tbl_user values(?,?,?,?,?,?)");
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        // ...
        return pstmt.executeUpdate();
    }

    // ④ SELECT
    public static UserDto selectUser(String username) throws Exception {
        pstmt = conn.prepareStatement("select * from tbl_user where userid=?");
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();
        UserDto dto = null;
        if (rs != null && rs.next()) {
            dto = new UserDto();
            dto.setUsername(rs.getString("username"));
            dto.setPassword(rs.getString("password"));
        }
        return dto;
    }
}
```

#### ⚠ 정적 필드 방식의 문제점

`conn`, `pstmt`, `rs` 를 `static` 필드로 선언하면 서블릿과 마찬가지로  
동시 요청 시 필드가 덮어씌워지는 **스레드 안전 문제** 가 생긴다.  
실무에서는 메서드 지역변수로 선언하거나, `try-with-resources` 패턴을 사용한다.

```java
// 권장 패턴
public static Connection getConn() throws Exception {
    Context envContext = (Context) new InitialContext().lookup("java:/comp/env");
    return ((DataSource) envContext.lookup("jdbc/MysqlDB")).getConnection();
}
```

---

### JSP에서 DataSource 직접 사용

```jsp
<%@ page import="Servlet.*" %>
<%
    DbUtils.conn();   // JNDI로 커넥션 획득
    // ... DB 작업
%>
```
