# Spring Boot 정리

---

## 01_INIT — 프로젝트 초기 세팅 (JSP + Gradle + Embedded Tomcat)

### 프로젝트 구조

```
01_INIT/
├── build.gradle
├── settings.gradle
├── gradlew / gradlew.bat
├── src/
│   ├── main/
│   │   ├── java/com/example/demo/
│   │   │   ├── DemoApplication.java        # 진입점
│   │   │   ├── ServletInitializer.java     # WAR 배포용
│   │   │   └── Controller/
│   │   │       └── HomeController.java     # GET / 핸들러
│   │   ├── resources/
│   │   │   └── application.properties     # 서버/JSP/인코딩 설정
│   │   └── webapp/WEB-INF/views/
│   │       └── index.jsp                  # 뷰 템플릿
│   └── test/
│       └── java/com/example/demo/
│           └── DemoApplicationTests.java
```

---

### build.gradle

```groovy
plugins {
    id 'java'
    id 'war'                                          // WAR 패키징 지원
    id 'org.springframework.boot' version '3.5.14'
    id 'io.spring.dependency-management' version '1.1.7'
}

group = 'com.example'
version = '0.0.1-SNAPSHOT'

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(21)  // Java 21
    }
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
    testRuntimeOnly 'org.junit.platform:junit-platform-launcher'

    // JSP — Embedded Tomcat에서 JSP 사용하려면 필수
    implementation 'org.apache.tomcat.embed:tomcat-embed-jasper:11.0.10'

    // JSTL — Spring Boot 3.x (Jakarta EE 네임스페이스)
    implementation 'jakarta.servlet:jakarta.servlet-api'
    implementation 'jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl-api'
    implementation 'org.glassfish.web:jakarta.servlet.jsp.jstl'
}
```

> **포인트**
> - `id 'war'` + `tomcat-embed-jasper` 조합으로 Embedded Tomcat에서 JSP 렌더링 가능
> - Spring Boot 3.x는 `javax.*` → `jakarta.*` 패키지 사용
> - `providedRuntime 'spring-boot-starter-tomcat'`은 외부 톰캣 배포 시 사용 (현재 주석 처리)

---

### application.properties

```properties
spring.application.name=demo

# 포트 설정
server.port=8090

# UTF-8 인코딩 필터
spring.servlet.filter.encoding.filter-name=encodingFilter
spring.servlet.filter.encoding.filter-class=org.springframework.web.filter.CharacterEncodingFilter
spring.servlet.filter.encoding.init-param.encoding=UTF-8
spring.servlet.filter.encoding.init-param.forceEncoding=true
spring.servlet.filter.encoding.url-pattern=/*

# JSP View Resolver
spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp
server.servlet.jsp.init-parameters.development=true  # JSP 수정 시 자동 반영
```

---

### 핵심 클래스

#### DemoApplication.java — 진입점
```java
@SpringBootApplication
public class DemoApplication {
    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }
}
```

#### ServletInitializer.java — WAR 외부 배포용
```java
public class ServletInitializer extends SpringBootServletInitializer {
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(DemoApplication.class);
    }
}
```
> Embedded Tomcat으로 실행할 땐 사용 안 됨. 외부 WAS에 WAR로 배포할 때 진입점 역할.

#### HomeController.java
```java
@Controller
@Slf4j
public class HomeController {

    @GetMapping("/")
    public String home() {
        log.info("GET /");
        return "index";   // → /WEB-INF/views/index.jsp
    }
}
```
> `@Slf4j` (Lombok) : `log.info()` 로 콘솔 로그 출력 (`System.out.println` 대체)

#### index.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Home</title></head>
<body>
    <h1>Hello world!</h1>
    <p>The time on the server is 하이</p>
</body>
</html>
```

---

### 흐름 요약

```
브라우저 GET /
    → HomeController.home()
    → return "index"
    → ViewResolver: /WEB-INF/views/index.jsp
    → JSP 렌더링 → 응답
```

---

### 세팅 체크리스트

| 항목 | 값 |
|------|-----|
| Spring Boot | 3.5.14 |
| Java | 21 |
| 빌드 도구 | Gradle (Groovy DSL) |
| 패키징 | WAR (Embedded Tomcat 실행 가능) |
| 포트 | 8090 |
| 뷰 | JSP (`/WEB-INF/views/*.jsp`) |
| JSTL | Jakarta EE (`jakarta.*`) |
| Lombok | `@Slf4j`, `@Controller` 등 사용 |

---

## 02_LOMBOK_DI — Lombok 어노테이션 & DI (의존성 주입)

> 세팅(build.gradle, application.properties) 01_INIT과 동일. 새로 추가된 클래스만 정리.

### 새로 추가된 구조

```
src/main/java/com/example/demo/
├── Dtos/
│   └── PersonDTO.java       # Lombok 어노테이션 실습
├── Component/
│   └── PersonComponent.java # @Component로 빈 등록
└── Config/
    └── PersonConfig.java    # @Configuration + @Bean으로 빈 등록

src/test/java/com/example/demo/
├── Dtos/
│   └── PersonDTOTest.java   # Lombok 3가지 생성 방식 테스트
└── DiTest/
    └── DiTest.java          # DI 주입 & ApplicationContext 테스트
```

---

### Lombok 주요 어노테이션

| 어노테이션 | 역할 |
|-----------|------|
| `@Data` | `@Getter` + `@Setter` + `@ToString` + `@EqualsAndHashCode` + `@RequiredArgsConstructor` 합본 |
| `@AllArgsConstructor` | 모든 필드를 받는 생성자 |
| `@NoArgsConstructor` | 기본 생성자 (빈 생성자) |
| `@Builder` | 빌더 패턴 생성자 |
| `@Slf4j` | `log` 필드 자동 생성 (`log.info()` 사용 가능) |

> Lombok 확인: `Ctrl + F12` (IntelliJ에서 생성된 메서드 목록 확인)  
> JUnit 테스트 생성: `Ctrl + Shift + T`

---

### PersonDTO.java — Lombok 실습 대상

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Component          // 빈으로도 등록 (DI 실습용)
public class PersonDTO {
    private String name;
    private int age;
    private String addr;
}
```

---

### DI 방법 1 — `@Component`

```java
@Data
@Component
public class PersonComponent {
    private String name;
    private int age;
    private String addr;

    PersonComponent() {
        this.name = "티모";
        this.age = 100;
        this.addr = "창원";
    }
}
```

- 클래스에 `@Component` 붙이면 Spring이 자동으로 빈 등록
- 빈 이름: 클래스명 camelCase → `personComponent`

---

### DI 방법 2 — `@Configuration` + `@Bean`

```java
@Configuration
public class PersonConfig {

    @Bean                          // 빈 이름: 메서드명 → "personBean01"
    public PersonDTO personBean01() {
        return PersonDTO.builder()
                .name("김범수").age(50).addr("인천").build();
    }

    @Bean(name = "personBean")     // 빈 이름 직접 지정
    public PersonDTO personBean02() {
        return PersonDTO.builder()
                .name("김나영").age(31).addr("인천").build();
    }
}
```

- `@Bean` 이름 기본값: **메서드명**
- `@Bean(name = "xxx")` 으로 이름 직접 지정 가능
- 같은 타입(`PersonDTO`) 빈이 여러 개일 때 → `@Autowired` 변수명으로 구분

---

### 테스트 — PersonDTOTest

```java
@SpringBootTest
class PersonDTOTest {

    @Test
    public void t1() {
        // 방법 1: @NoArgsConstructor + setter
        PersonDTO dto = new PersonDTO();
        dto.setName("홍길동"); dto.setAge(10); dto.setAddr("대구");

        // 방법 2: @AllArgsConstructor
        PersonDTO dto2 = new PersonDTO("남길동", 22, "서울");

        // 방법 3: @Builder
        PersonDTO dto3 = PersonDTO.builder()
                .name("서길동").addr("울산").build();  // age는 기본값 0
    }

    @Autowired
    private PersonDTO personDTO;  // @Component로 등록된 빈 주입

    @Test
    public void t2() {
        System.out.println(personDTO);  // PersonDTO(name=null, age=0, addr=null)
    }
}
```

---

### 테스트 — DiTest

```java
@SpringBootTest
public class DiTest {

    @Autowired PersonDTO personDTO;           // @Component 빈
    @Autowired PersonComponent personComponent;

    @Test
    public void t1() { ... }  // 두 빈 출력

    @Autowired PersonConfig personConfig;
    @Autowired PersonDTO personBean01;        // 변수명 = 빈 이름 "personBean01"
    @Autowired PersonDTO personBean;          // 변수명 = 빈 이름 "personBean"

    @Test
    public void t2() { ... }  // @Configuration 빈 출력

    @Autowired ApplicationContext applicationContext;

    @Test
    public void t3() {
        // 빈 이름으로 직접 꺼내기
        applicationContext.getBean("personBean");
        applicationContext.getBean("personBean01");
    }
}
```

> **같은 타입 빈 여러 개일 때 `@Autowired` 규칙**  
> → 변수명과 빈 이름이 일치하는 걸 주입. 이름 불일치 시 `NoUniqueBeanDefinitionException`

---

### 핵심 정리

```
빈 등록 방법
  @Component       → 클래스 자체를 빈으로 등록 (빈 이름: camelCase 클래스명)
  @Configuration   → 설정 클래스 선언
  @Bean            → @Configuration 안에서 메서드 반환값을 빈으로 등록

DI (주입) 방법
  @Autowired       → 타입 기준 주입, 동일 타입 여러 개면 변수명으로 구분
  ApplicationContext.getBean("빈이름")  → 이름으로 직접 꺼내기
```

---

## 03_PARAM — 요청 파라미터 수신 & 뷰 데이터 전달

> 01_INIT 대비 변경: DevTools + JSP EL API 의존성 추가, `ExController` 추가.

### build.gradle 변경점 (01_INIT → 03_PARAM)

```groovy
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'

//  providedRuntime 'org.springframework.boot:spring-boot-starter-tomcat'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
    testRuntimeOnly 'org.junit.platform:junit-platform-launcher'

    // JSP EMBED TOMCAT
    implementation 'org.apache.tomcat.embed:tomcat-embed-jasper:11.0.10'

    // JSP EL PARSER  ← 추가
    implementation 'jakarta.el:jakarta.el-api:6.0.1'

    // JSTL
    implementation 'jakarta.servlet:jakarta.servlet-api'
    implementation 'jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl-api'
    implementation 'org.glassfish.web:jakarta.servlet.jsp.jstl'

    // DEVTOOLS  ← 추가
    implementation 'org.springframework.boot:spring-boot-devtools'
}
```

> - `jakarta.el:jakarta.el-api` — JSP EL(`${...}`) 파서. Embedded Tomcat 단독 실행 시 EL이 동작하지 않을 경우 명시적으로 추가
> - `spring-boot-devtools` — 코드 변경 시 자동 재시작 + LiveReload

### application.properties 변경점

```properties
# DevTools — 추가됨
spring.devtools.restart.enabled=true
spring.devtools.restart.poll-interval=2s
spring.devtools.restart.quiet-period=1s
spring.devtools.livereload.enabled=true
```

---

### 새로 추가된 구조

```
Controller/
├── ParamController.java     # /param/** 전체 라우팅
└── ExController.java        # /ex/**  실습 문제 (ex01~ex09)  ← 추가
Dtos/
└── PersonDTO.java           # name, age, addr

webapp/WEB-INF/views/
├── param/
│   ├── page01~14.jsp
│   ├── forward/  init.jsp / step1.jsp / step2.jsp
│   └── redirect/ init.jsp / step1.jsp / step2.jsp
└── ex/
    └── ex1.jsp              # ← 추가
```

---

### 파라미터 수신 방법 (p01~p10)

#### p01~p03 — `@RequestParam` 기본
```java
@GetMapping("/p01")
public String p01(@RequestParam(required = false) String name) { ... }
// required=false → 파라미터 없으면 null (기본은 true, 없으면 400)

@PostMapping("/p02")
public String p02(@RequestParam(name = "username") String name) { ... }
// 요청 파라미터명(username)과 변수명(name)이 다를 때 name= 으로 매핑

@GetMapping("/p03")
public String p03(String name) { ... }
// 어노테이션 없이도 파라미터명 = 변수명이면 자동 바인딩
```

#### p04 — 여러 파라미터 개별 수신
```java
@GetMapping("/p04")
public String p04(@RequestParam String name, @RequestParam int age, @RequestParam String addr) { ... }
// ?name=xx&age=20&addr=xx 각각 바인딩
```

#### p05/p06 — `@ModelAttribute` / DTO 자동 바인딩
```java
@GetMapping("/p05")
public String p05(@ModelAttribute PersonDTO dto) { ... }

@GetMapping("/p06")
public String p06(PersonDTO dto) { ... }
// p05, p06 동일 동작 — 쿼리스트링 ?name=&age=&addr= → DTO 필드에 자동 바인딩
// @ModelAttribute 어노테이션 생략 가능
```

#### p07/p08 — `@PathVariable` (URL 경로에서 수신)
```java
@GetMapping("/p07/{name}/{age}/{addr}")
public String p07(@PathVariable String name, @PathVariable int age, @PathVariable String addr) { ... }
// URL: /param/p07/홍길동/25/서울

@GetMapping("/p08/{name}/{age}/{addr}")
public String p08(PersonDTO dto) { ... }
// PathVariable도 DTO에 자동 바인딩 가능
```

#### p09/p10 — POST 파라미터 수신 방식 비교
```java
// p09: @ModelAttribute — HTML form / form-data 처리 (Content-Type: application/x-www-form-urlencoded)
@PostMapping("/p09")
public String p09(@ModelAttribute PersonDTO dto) { ... }

// p10: @RequestBody — JSON 처리 (Content-Type: application/json)
@PostMapping("/p10")
public String p10(@RequestBody PersonDTO dto) { ... }
```

| | `@RequestParam` / `@ModelAttribute` | `@RequestBody` |
|---|---|---|
| 처리 대상 | HTML form, Query String | JSON, 비동기 요청 |
| Content-Type | `application/x-www-form-urlencoded` | `application/json` |
| 테스트 | 브라우저 form | Postman (Body → raw → JSON) |

---

### 뷰로 데이터 전달 방법 (p11~p14)

#### p11 — `Model` 에 개별 속성 추가
```java
@GetMapping("/p11")
public String p11(PersonDTO dto, Model model) {
    model.addAttribute("name", dto.getName());
    model.addAttribute("age",  dto.getAge());
    model.addAttribute("addr", dto.getAddr());
    model.addAttribute("now",  LocalDateTime.now());
    return "param/page11";
}
```
```jsp
${name} ${age} ${addr} ${now}   <%-- JSP에서 EL로 출력 --%>
```

#### p12 — `Model` 에 DTO 통째로 전달
```java
@GetMapping("/p12")
public String p12(PersonDTO dto, Model model) {
    model.addAttribute("dto", dto);
    model.addAttribute("now", LocalDateTime.now());
    return "param/page12";
}
```
```jsp
${dto}        <%-- toString() 출력 --%>
${dto.name}   <%-- 필드 접근 --%>
```

#### p13 — `ModelAndView` (뷰명 + 데이터 한 객체로)
```java
@GetMapping("/p13")
public ModelAndView p13(PersonDTO dto) {
    ModelAndView mav = new ModelAndView();
    mav.addObject("dto", dto);
    mav.addObject("now", LocalDateTime.now());
    mav.setViewName("param/page13");
    return mav;
}
```

#### p14 — `HttpServletRequest` / `HttpServletResponse` (순수 Servlet API)
```java
@GetMapping("/p14")
public void p14(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String name = request.getParameter("name");
    int age = request.getParameter("age") != null
            ? Integer.parseInt(request.getParameter("age")) : -1;
    String addr = request.getParameter("addr");

    PersonDTO dto = new PersonDTO(name, age, addr);
    request.setAttribute("dto", dto);
    request.setAttribute("now", LocalDateTime.now());
    request.getRequestDispatcher("/WEB-INF/views/param/page14.jsp")
           .forward(request, response);
}
// 반환타입 void — 직접 forward/response 처리
```

---

### 뷰 데이터 전달 방법 비교

| 방법 | 특징 |
|------|------|
| `Model.addAttribute()` | 가장 일반적. 개별 또는 객체 전달 |
| `ModelAndView` | 뷰명과 데이터를 하나의 객체로 묶어 반환 |
| `HttpServletRequest.setAttribute()` | 순수 Servlet API, 직접 forward 처리 |

---

### Forward vs Redirect

#### Forward — `return "forward:/경로"`
```java
@GetMapping("/forward/init")
public String forward_init(Model model) {
    model.addAttribute("init", "init_value");
    return "forward:/param/forward/step1";   // 서버 내부 이동 (URL 안 바뀜)
}
@GetMapping("/forward/step1")
public String forward_step1(Model model) {
    model.addAttribute("step1", "step1_value");
    return "forward:/param/forward/step2";
}
@GetMapping("/forward/step2")
public String forward_step2(Model model) {
    model.addAttribute("step2", "step2_value");
    return "param/forward/step2";            // 최종 뷰 렌더링
}
```
```jsp
<%-- step2.jsp — init, step1, step2 모두 출력 가능 --%>
${init} ${step1} ${step2}
```
> Forward는 같은 request가 이어지므로 이전 Model 데이터가 누적됨

#### Redirect — `return "redirect:/경로"`
```java
@GetMapping("/redirect/init")
public String redirect_init(RedirectAttributes redirectAttributes) {
    redirectAttributes.addFlashAttribute("init", "init_value");
    // addAttribute()     → QueryString으로 붙음 (?init=init_value)
    // addFlashAttribute() → 세션에 1회 저장 후 소멸 (URL에 노출 안 됨)
    return "redirect:/param/redirect/step1"; // 새 요청 (URL 바뀜)
}
```
> Redirect는 새 요청이므로 `Model` 데이터 소멸 → `RedirectAttributes.addFlashAttribute()`로 1회성 전달

---

### 핵심 비교 정리

| | Forward | Redirect |
|---|---|---|
| URL 변화 | 없음 | 변경됨 |
| 요청 횟수 | 1번 | 2번 (새 요청) |
| Model 데이터 | 유지 (누적) | 소멸 |
| 데이터 전달 | `Model` | `RedirectAttributes.addFlashAttribute()` |
| 주 용도 | 내부 단계 처리 | PRG 패턴, 외부 이동 |

---

### `@RequestMapping` vs `@GetMapping` / `@PostMapping`

```java
// 구형 방식 (method 명시)
@RequestMapping(value = "/p01", method = RequestMethod.GET)

// 신형 방식 (축약)
@GetMapping("/p01")
@PostMapping("/p02")
```

> 클래스 레벨 `@RequestMapping("/param")` → 메서드 레벨 경로와 합쳐져 `/param/p01` 완성

---

### ExController — 파라미터 실습 문제 (ex01~ex09)

`@RequestMapping("/ex")` 기반. 모든 핸들러는 반환타입 `void` → 뷰 렌더링 없이 콘솔 로그로만 확인.

```java
@Controller @Slf4j @RequestMapping("/ex")
public class ExController {

    // EX01: @RequestParam — 단일 파라미터
    // GET /ex/ex01?keyword=spring  →  EX01 keyword : spring
    @GetMapping("/ex01")
    public void ex01(@RequestParam String keyword) {
        log.info("EX01 keyword : " + keyword);
    }

    // EX02: required=false + defaultValue
    // GET /ex/ex02          →  EX02 page : 1
    // GET /ex/ex02?page=3   →  EX02 page : 3
    @GetMapping("/ex02")
    public void ex02(@RequestParam(required = false, defaultValue = "1") int page) {
        log.info("EX02 page : " + page);
    }

    // EX03: 파라미터명 ≠ 변수명 (name= 으로 매핑)
    // GET /ex/ex03?user_name=hong  →  EX03 name : hong
    @GetMapping("/ex03")
    public void ex03(@RequestParam(name = "user_name") String name) {
        log.info("EX03 name : " + name);
    }

    // EX04: 여러 파라미터 + 자동 형변환
    // GET /ex/ex04?name=hong&age=20  →  EX04 name : hong, age : 20
    @GetMapping("/ex04")
    public void ex04(@RequestParam String name, @RequestParam int age) {
        log.info("EX04 name : " + name + ", age : " + age);
    }

    // EX05: Map으로 모든 파라미터 수신
    // GET /ex/ex05?a=1&b=2&c=3  →  EX05 params : {a=1, b=2, c=3}
    @GetMapping("/ex05")
    public void ex05(@RequestParam Map<String, Object> params) {
        log.info("EX05 params : " + params);
    }

    // EX06: @PathVariable — 1개
    // GET /ex/ex06/100  →  EX06 id : 100
    @GetMapping("/ex06/{id}")
    public void ex06(@PathVariable int id) {
        log.info("EX06 id : " + id);
    }

    // EX07: @PathVariable — 여러 개
    // GET /ex/ex07/book/100  →  EX07 category : book, id : 100
    @GetMapping("/ex07/{category}/{id}")
    public void ex07(@PathVariable String category, @PathVariable int id) {
        log.info("EX07 category : " + category + ", id : " + id);
    }

    // EX08: DTO 자동 바인딩
    // GET /ex/ex08?name=hong&age=20&addr=seoul  →  EX08 dto : PersonDTO(name=hong, age=20, addr=seoul)
    @GetMapping("/ex08")
    public void ex08(PersonDTO dto) {
        log.info("EX08 dto : " + dto);
    }

    // EX09: POST + @RequestBody (raw body 전체를 문자열로 수신)
    // POST /ex/ex09  body: username=hong  →  EX09 username : username=hong
    // PowerShell: curl -Method POST "http://localhost:8090/ex/ex09" -Body "username=hong"
    @PostMapping("/ex09")
    public void ex09(@RequestBody String username) {
        log.info("EX09 username : " + username);
    }
}
```

#### ExController 포인트 정리

| 문제 | 핵심 | 요청 예시 |
|------|------|-----------|
| EX01 | `@RequestParam` 기본 | `GET /ex/ex01?keyword=spring` |
| EX02 | `required=false` + `defaultValue` | `GET /ex/ex02` (파라미터 생략) |
| EX03 | `name=` 으로 파라미터명 매핑 | `GET /ex/ex03?user_name=hong` |
| EX04 | 다중 파라미터 + String→int 자동변환 | `GET /ex/ex04?name=hong&age=20` |
| EX05 | `Map<String,Object>` 로 전체 수신 | `GET /ex/ex05?a=1&b=2&c=3` |
| EX06 | `@PathVariable` 1개 | `GET /ex/ex06/100` |
| EX07 | `@PathVariable` 다중 | `GET /ex/ex07/book/100` |
| EX08 | DTO 커맨드 객체 바인딩 | `GET /ex/ex08?name=hong&age=20&addr=seoul` |
| EX09 | `@RequestBody` — raw body 수신 | `POST /ex/ex09` |

> EX09 주의: `@RequestBody String username` 은 body 전체 문자열(`username=hong`)을 변수에 담음.  
> form 파라미터를 분리해 받으려면 `@RequestParam`을 사용해야 함.

---

## 04_DATA_VALIDATION — Bean Validation & Custom DataBinder

> 03_PARAM 대비 변경: `spring-boot-starter-validation` 추가, `ExController`(유효성 검증 실습), `MemoController`(@InitBinder) 추가.

### build.gradle 변경점 (03_PARAM → 04_DATA_VALIDATION)

```groovy
// VALIDATION  ← 추가
implementation 'org.springframework.boot:spring-boot-starter-validation'
```

---

### 새로 추가된 구조

```
Controller/
├── ExController.java        # /ex/**  유효성 검증 실습 (ex01~06, form)  ← 변경
└── MemoController.java      # /memo/** @InitBinder + 커스텀 바인더  ← 추가
Dtos/
├── ExUserDto.java           # 검증 어노테이션 실습용 DTO  ← 추가
└── MemoDTO.java             # 다양한 제약 + @DateTimeFormat + CustomData  ← 추가

webapp/WEB-INF/views/
├── ex/
│   ├── form.jsp             # 회원가입 폼 (오류 메시지 출력)  ← 추가
│   └── form_ok.jsp          # 가입 완료 페이지  ← 추가
└── memo/
    └── add.jsp              # 메모 등록 폼 (커스텀 바인더 테스트)  ← 추가
```

---

### 유효성 검증 제약 어노테이션

| 어노테이션 | 대상 타입 | 조건 | 주요 속성 |
|---|---|---|---|
| `@NotNull` | 모든 타입 | `null` 불가 | `message` |
| `@NotBlank` | String | `null` + 공백 불가 | `message` |
| `@NotEmpty` | String, Collection | `null` + 빈값 불가 | `message` |
| `@Min(value)` | 숫자 | 최솟값 이상 | `value`, `message` |
| `@Max(value)` | 숫자 | 최댓값 이하 | `value`, `message` |
| `@Size(min,max)` | String, Collection | 길이/크기 범위 | `min`, `max`, `message` |
| `@Email` | String | 이메일 형식 | `message` |
| `@Pattern(regexp)` | String | 정규식 일치 | `regexp`, `message` |
| `@Future` | 날짜/시간 | 현재 이후 | `message` |
| `@Past` | 날짜/시간 | 현재 이전 | `message` |

> `@NotNull` vs `@NotBlank`: `@NotNull`은 `null`만 막음. `" "` (공백 문자열)은 통과.  
> `@NotBlank`는 `null` + 빈 문자열 + 공백만 있는 문자열 모두 막음 → String 필드에는 보통 `@NotBlank`를 씀

---

### ExUserDto — 검증 어노테이션 실습

```java
@NoArgsConstructor @AllArgsConstructor @Data
public class ExUserDto {

    @NotBlank(message = "이름은 필수입니다.")
    private String username;

    @Min(value = 10, message = "10세 이상만 가입 가능합니다.")
    @Max(value = 120, message = "나이가 올바르지 않습니다.")
    private int age;

    @NotBlank(message = "이메일은 필수입니다.")
    @Email(message = "이메일 형식이 올바르지 않습니다.")
    private String email;

    @Size(min = 8, max = 20, message = "비밀번호는 8~20자여야 합니다.")
    private String password;
}
```

---

### MemoDTO — 복합 제약 + `@DateTimeFormat` + 커스텀 필드

```java
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemoDTO {

    @Min(value = 10, message = "ID는 10이상의 값부터 시작합니다.")
    @Max(value = 65535, message = "ID의 최대 숫자는 65535입니다.")
    @NotNull(message = "ID는 필수 항목입니다.")
    private Long id;

    @NotBlank(message = "TITLE는 필수 항목입니다.")
    private String title;

    @NotBlank(message = "WRITER는 필수 항목입니다.")
    @Email(message = "example@example.com형식으로 입력하세요")
    private String writer;

    @NotBlank(message = "TEXT는 필수 항목입니다.")
    private String text;

    @NotNull(message = "CREATE_AT는 필수 항목입니다.")
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")   // HTML datetime-local 입력값 파싱
    @Future(message = "오늘날짜기준 이후날짜를 입력하세요.")
    private LocalDateTime createAt;

    private LocalDate customData;   // @InitBinder 커스텀 에디터로 처리
}
```

> `@DateTimeFormat` — Spring MVC가 폼 문자열(`"2025-06-01T09:00"`)을 `LocalDateTime`으로 자동 변환할 때 패턴을 지정

---

### 컨트롤러에서 `@Valid` + `BindingResult` 사용 패턴

```java
@PostMapping("/add")
public String handler(@Valid SomeDTO dto, BindingResult bindingResult, Model model) {
    //                  ↑ 검증 대상     ↑ 반드시 바로 뒤에 위치

    if (bindingResult.hasErrors()) {
        // 오류 처리
    }
    // 정상 처리
}
```

#### BindingResult 주요 메서드

| 메서드 | 반환 | 설명 |
|---|---|---|
| `hasErrors()` | boolean | 오류가 하나라도 있으면 true |
| `getErrorCount()` | int | 전체 오류 개수 |
| `getFieldErrors()` | `List<FieldError>` | 필드별 오류 목록 |
| `hasFieldErrors("필드명")` | boolean | 특정 필드에 오류 있는지 |
| `getFieldError("필드명")` | `FieldError` | 특정 필드의 첫 번째 오류 |

#### FieldError 주요 메서드

| 메서드 | 반환 | 설명 |
|---|---|---|
| `getField()` | String | 오류가 발생한 필드명 |
| `getDefaultMessage()` | String | 어노테이션에 지정한 message 값 |

---

### ExController — 유효성 검증 실습 (ex01~06)

```java
@Controller @Slf4j @RequestMapping("/ex")
public class ExController {

    // EX01: @Valid + BindingResult 기본 — 오류 발생 여부 확인
    // GET /ex/ex01?username=hong&age=20&email=hong@test.com&password=abcd1234
    @GetMapping("/ex01")
    public void ex01(@Valid ExUserDto dto, BindingResult bindingResult) {
        log.info("EX01 오류 발생여부 : " + bindingResult.hasErrors());
    }

    // EX02: FieldError 순회하며 오류 메시지 콘솔 출력
    // GET /ex/ex02  (파라미터 생략 → 오류 유발)
    @GetMapping("/ex02")
    public void ex02(@Valid ExUserDto dto, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            for (FieldError e : bindingResult.getFieldErrors())
                log.info("EX02 field : " + e.getField() + ", message : " + e.getDefaultMessage());
        }
    }

    // EX03: 오류 메시지를 Model에 담아 뷰로 전달
    // JSP에서 ${username} 처럼 필드명으로 오류 메시지 출력 가능
    @GetMapping("/ex03")
    public void ex03(@Valid ExUserDto dto, BindingResult result, Model model) {
        if (result.hasErrors()) {
            for (FieldError e : result.getFieldErrors()) {
                model.addAttribute(e.getField(), e.getDefaultMessage());
            }
        }
    }

    // EX04: POST form 데이터 검증 + 오류 개수 출력
    // PowerShell: curl -Method POST "http://localhost:8090/ex/ex04" -Body "username=&age=5&email=bad&password=1"
    @PostMapping("/ex04")
    public void ex04(@Valid ExUserDto dto, BindingResult bindingResult) {
        log.info("EX04 오류 개수 : " + bindingResult.getErrorCount());
    }

    // EX05: 특정 필드 오류 확인
    // GET /ex/ex05?username=hong&age=20&email=bad-email&password=abcd1234
    @GetMapping("/ex05")
    public void ex05(@Valid ExUserDto dto, BindingResult bindingResult) {
        if (bindingResult.hasFieldErrors("email"))
            log.info("EX05 email 오류 여부 : " + bindingResult.hasFieldErrors("email"));
    }

    // EX06: JSP 폼 연동 — GET 폼 표시 / POST 검증 후 분기
    @GetMapping("/form")
    public void form_get() { }
    // → 반환 없음: /WEB-INF/views/ex/form.jsp 로 자동 이동

    @PostMapping("/form")
    public String form_post(@Valid ExUserDto dto, BindingResult bindingResult, Model model) {
        model.addAttribute("dto", dto);   // 입력값 유지용
        if (bindingResult.hasErrors()) {
            for (FieldError e : bindingResult.getFieldErrors())
                model.addAttribute(e.getField(), e.getDefaultMessage());
            return "ex/form";             // 오류 시 폼으로 복귀
        }
        return "ex/form_ok";             // 검증 통과 시 완료 페이지
    }
}
```

#### EX06 JSP 폼 연동 흐름

```
브라우저 GET /ex/form
    → form_get() → ex/form.jsp (입력 폼)

브라우저 POST /ex/form (잘못된 값)
    → form_post()
    → @Valid 검증 실패 → BindingResult에 오류 누적
    → Model에 dto + 각 필드 오류 메시지 추가
    → return "ex/form"  (폼으로 복귀, 입력값 유지 + 오류 메시지 표시)

브라우저 POST /ex/form (올바른 값)
    → form_post()
    → @Valid 검증 통과
    → return "ex/form_ok"
```

```jsp
<%-- ex/form.jsp 핵심 부분 --%>
<form action="/ex/form" method="post">
    <input name="username" value="${dto.username}" />
    <span class="err">${username}</span>   <%-- 오류 메시지 --%>

    <input name="age" value="${dto.age}" />
    <span class="err">${age}</span>

    <input name="email" value="${dto.email}" />
    <span class="err">${email}</span>

    <input type="password" name="password" value="${dto.password}" />
    <span class="err">${password}</span>
</form>
```

> `value="${dto.필드명}"` — 검증 실패 후 폼 복귀 시 이전 입력값 유지  
> `${필드명}` — `model.addAttribute("필드명", 오류메시지)` 로 세팅한 오류 메시지 출력

---

### MemoController — `@InitBinder` + 커스텀 DataBinder

```java
@Controller @Slf4j @RequestMapping("/memo")
public class MemoController {

    // @InitBinder — 이 컨트롤러의 모든 요청 전에 실행되어 바인더를 커스터마이징
    @InitBinder
    public void dataBinder(WebDataBinder webDataBinder) {
        // "customData" 파라미터를 LocalDate 타입으로 변환할 때 CustomDateEditor 사용
        webDataBinder.registerCustomEditor(LocalDate.class, "customData", new CustomDateEditor());
    }

    // 커스텀 에디터 — PropertyEditorSupport 상속
    private static class CustomDateEditor extends PropertyEditorSupport {
        @Override
        public void setAsText(String text) throws IllegalArgumentException {
            LocalDate date;
            if (text.isEmpty()) {
                date = LocalDate.now();               // 빈 값이면 오늘 날짜
            } else {
                text = text.replaceAll("~", "-");     // yyyy~MM~dd → yyyy-MM-dd 변환
                date = LocalDate.parse(text, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            }
            setValue(date);
        }
    }

    @GetMapping("/add")
    public void memoAdd() { }

    @PostMapping("/add")
    public void memoAddPost(@Valid MemoDTO memoDTO, BindingResult result, Model model) {
        if (result.hasErrors()) {
            for (FieldError error : result.getFieldErrors()) {
                model.addAttribute(error.getField(), error.getDefaultMessage());
            }
        }
    }
}
```

#### `@InitBinder` 동작 흐름

```
POST /memo/add (body: ...&customData=2025~06~01)
    │
    ▼
@InitBinder — dataBinder() 실행
    └── "customData" 파라미터 → CustomDateEditor.setAsText("2025~06~01")
            └── "2025~06~01".replaceAll("~","-") → "2025-06-01"
            └── LocalDate.parse("2025-06-01") → LocalDate(2025,6,1)
    │
    ▼
MemoDTO.customData = LocalDate(2025,6,1) 바인딩 완료
```

| 개념 | 설명 |
|---|---|
| `@InitBinder` | 해당 컨트롤러의 모든 요청 전에 `WebDataBinder` 설정을 커스터마이징 |
| `WebDataBinder.registerCustomEditor()` | 특정 타입·필드명에 커스텀 에디터 등록 |
| `PropertyEditorSupport` | 문자열 → 타입 변환 로직을 `setAsText()` 에 구현 |

---

### 핵심 정리

```
유효성 검증 흐름
  DTO에 제약 어노테이션 선언 (@NotBlank, @Min, @Email ...)
      ↓
  컨트롤러 파라미터에 @Valid 추가
      ↓
  BindingResult (반드시 @Valid 바로 뒤)가 오류를 수집
      ↓
  hasErrors() 로 분기 → 오류 시 폼 복귀, 통과 시 다음 단계

커스텀 바인더 흐름
  @InitBinder → WebDataBinder.registerCustomEditor(타입, 필드명, 에디터)
      ↓
  PropertyEditorSupport.setAsText() — 문자열 → 원하는 타입으로 변환
```

---

## 05_EXCEPTION — 예외 처리 (@ExceptionHandler / @ControllerAdvice)

> build.gradle 변경 없음. `ExceptionTestController`, `ExController`(예외 처리 버전), `GlobalExceptionHandler`, `MyBizException` 추가.

### 새로 추가된 구조

```
Controller/
├── ExceptionTestController.java   # /except/**  예외 발생 테스트
├── ExController.java              # /ex/**  지역 @ExceptionHandler 실습
├── MyBizException.java            # 커스텀 예외 + @ResponseStatus
└── GlobalException/
    └── GlobalExceptionHandler.java  # @ControllerAdvice 전역 핸들러

webapp/WEB-INF/views/
├── except/   error1.jsp / error2.jsp / ex2.jsp
├── global/   error.jsp / error1.jsp / error2.jsp / error3.jsp
└── ex/       error.jsp / error2.jsp / ex2.jsp
```

---

### 핵심 개념

| 개념 | 범위 | 설명 |
|---|---|---|
| `@ExceptionHandler` | 지역 (해당 컨트롤러) | 메서드에 선언. 그 컨트롤러 안 예외만 처리 |
| `@ControllerAdvice` | 전역 (모든 컨트롤러) | 별도 클래스에 선언. 어디서 발생하든 처리 |
| `@ResponseStatus` | 커스텀 예외 클래스 | 예외 발생 시 HTTP 상태코드를 지정 |
| `throw` | — | 예외를 강제로 발생시킴 |
| `throws` | 메서드 시그니처 | checked exception 전파 선언 |

> **처리 우선순위**: 지역 `@ExceptionHandler` > 전역 `@ControllerAdvice`  
> 같은 예외가 두 곳에 등록되어 있으면 컨트롤러 지역 핸들러가 먼저 실행됨

---

### ExceptionTestController — 예외 발생 테스트

```java
@Controller @Slf4j @RequestMapping("/except")
public class ExceptionTestController {

    // ex1: checked exception (FileNotFoundException) 강제 발생
    // → GlobalExceptionHandler.exceptionHandler_1() 이 처리 → global/error1.jsp
    @RequestMapping("/ex1")
    public void ex1() throws FileNotFoundException {
        throw new FileNotFoundException("파일을 찾을 수 없습니다.");
    }

    // ex2: 0 나누기 → ArithmeticException
    // 정상 요청: GET /except/ex2/10/2  → result=5 출력
    // 예외 요청: GET /except/ex2/10/0  → GlobalExceptionHandler.exceptionHandler_2() 처리
    @RequestMapping("/ex2/{num}/{div}")
    public String ex2(@PathVariable int num, @PathVariable int div, Model model) {
        model.addAttribute("result", (num / div));
        return "except/ex2";
    }
}
```

---

### MyBizException — 커스텀 예외 + `@ResponseStatus`

```java
@ResponseStatus(HttpStatus.BAD_REQUEST)   // HTTP 400 반환
@NoArgsConstructor
public class MyBizException extends Exception {
    public MyBizException(String message) {
        super(message);
    }
}
```

> `@ResponseStatus` — 예외가 발생하면 지정한 HTTP 상태코드를 클라이언트에 반환  
> `Exception` 상속 → checked exception. 컨트롤러 메서드에 `throws MyBizException` 필요

---

### ExController — `@ExceptionHandler` 지역 처리

```java
@Controller @Slf4j @RequestMapping("/ex")
public class ExController {

    // EX01: ArithmeticException 발생
    @GetMapping("/ex01")
    public void ex01() {
        int result = 10 / 0;   // ArithmeticException 발생
    }

    // 지역 핸들러 — ArithmeticException 처리 (이 컨트롤러 전용)
    // ExceptionTestController의 ArithmeticException은 여기서 처리 안 됨
    @ExceptionHandler(ArithmeticException.class)
    public String handleArithmetic(Exception e, Model model) {
        model.addAttribute("e", e);
        return "ex/error";
    }


    // EX03: NumberFormatException 발생 (문자열 → int 파싱 실패)
    // GET /ex/ex03/abc
    @GetMapping("/ex03/{num}")
    public void ex03(@PathVariable String num) {
        int n = Integer.parseInt(num);   // "abc" → NumberFormatException
    }

    // 여러 예외 타입을 하나의 핸들러로 처리
    @ExceptionHandler({NumberFormatException.class, NullPointerException.class})
    public String handlerParse(Exception e, Model model) {
        model.addAttribute("e", e);
        return "ex/error";
    }


    // EX04: 커스텀 예외 (MyBizException) 발생
    // GET /ex/ex04?id=-1  → id <= 0 이면 예외 발생
    @GetMapping("/ex04")
    public void ex04(@RequestParam int id) throws MyBizException {
        if (id <= 0) throw new MyBizException("잘못된 ID 입니다");
    }

    @ExceptionHandler(MyBizException.class)
    public String handlerBiz(Exception e, Model model) {
        model.addAttribute("e", e);
        return "ex/error";
    }


    // EX05: IllegalStateException — 지역 핸들러 없음 → 전역(GlobalExceptionHandler)이 처리
    @GetMapping("/ex05")
    public void ex05() {
        throw new IllegalStateException("전역에서 처리될 예외");
    }
}
```

---

### GlobalExceptionHandler — `@ControllerAdvice` 전역 처리

```java
@ControllerAdvice   // 모든 컨트롤러의 예외를 처리
@Slf4j
public class GlobalExceptionHandler {

    // FileNotFoundException 전용
    @ExceptionHandler(FileNotFoundException.class)
    public String exceptionHandler_1(Exception e, Model model) {
        model.addAttribute("e", e);
        return "global/error1";
    }

    // ArithmeticException 전용
    // ExController 안에서 발생하면 지역 핸들러가 먼저 처리 → 여기 안 옴
    @ExceptionHandler(ArithmeticException.class)
    public String exceptionHandler_2(Exception e, Model model) {
        model.addAttribute("e", e);
        return "global/error2";
    }

    // IllegalStateException 전용
    @ExceptionHandler(IllegalStateException.class)
    public String exceptionHandler_3(Exception e, Model model) {
        model.addAttribute("e", e);
        return "global/error";
    }

    // catch-all — 위에서 처리 못한 모든 예외
    @ExceptionHandler(Exception.class)
    public String exceptionHandler_ALL(Exception e, Model model) {
        model.addAttribute("e", e);
        return "global/error3";
    }
}
```

---

### 예외 처리 우선순위 흐름

```
예외 발생
    │
    ▼
해당 컨트롤러에 @ExceptionHandler(예외타입) 있음?
    ├── YES → 지역 핸들러 실행 (끝)
    └── NO
         ▼
    @ControllerAdvice 에 @ExceptionHandler(예외타입) 있음?
         ├── YES → 전역 핸들러 실행 (끝)
         └── NO
              ▼
         @ExceptionHandler(Exception.class) catch-all 있음?
              ├── YES → catch-all 전역 핸들러 실행 (끝)
              └── NO → Spring 기본 에러 처리 (500 / Whitelabel Error Page)
```

#### 예외별 처리 담당 정리

| 예외 발생 위치 | 예외 타입 | 처리 핸들러 | 이동 뷰 |
|---|---|---|---|
| `ExceptionTestController` | `FileNotFoundException` | Global | `global/error1` |
| `ExceptionTestController` | `ArithmeticException` (0 나누기) | Global | `global/error2` |
| `ExController` | `ArithmeticException` (EX01) | 지역 | `ex/error` |
| `ExController` | `NumberFormatException` (EX03) | 지역 | `ex/error` |
| `ExController` | `MyBizException` (EX04) | 지역 | `ex/error` |
| `ExController` | `IllegalStateException` (EX05) | Global | `global/error` |
| 어느 컨트롤러든 | 기타 모든 예외 | Global catch-all | `global/error3` |

---

### 핵심 정리

```
예외 처리 구조
  지역: 컨트롤러 안 @ExceptionHandler — 해당 컨트롤러 예외만 처리
  전역: @ControllerAdvice + @ExceptionHandler — 모든 컨트롤러 예외 처리
  우선순위: 지역 > 전역

커스텀 예외
  class MyBizException extends Exception
  @ResponseStatus(HttpStatus.XXX) → HTTP 상태코드 매핑

여러 타입 한 번에
  @ExceptionHandler({A.class, B.class}) → 두 예외 모두 이 핸들러로

catch-all
  @ExceptionHandler(Exception.class) → 나머지 모든 예외 처리
```

---

## 06_THYMELEAF — Thymeleaf 템플릿 엔진 (JSP 병행 구성)

> 05_EXCEPTION 구조 그대로 유지. Thymeleaf 의존성 + 설정 + `ThymeleafTestController` + HTML 템플릿 추가.

### 새로 추가된 구조

```
src/main/
├── java/com/example/demo/Controller/
│   └── ThymeleafTestController.java   # /th/** Thymeleaf 실습
└── resources/
    ├── application.properties         # Thymeleaf 설정 추가
    └── templates/
        └── th/
            ├── index.html             # Thymeleaf 메인 뷰
            └── fragments/
                ├── header.html        # 헤더 프래그먼트
                └── footer.html        # 푸터 프래그먼트 (2개)
```

> JSP 경로(`/WEB-INF/views/`) + Thymeleaf 경로(`classpath:/templates/`)를 **동시에** 사용.  
> 뷰 이름이 `th/`로 시작하면 Thymeleaf, 나머지는 JSP View Resolver가 처리.

---

### application.properties — Thymeleaf 설정 추가

```properties
# THYMELEAF
spring.thymeleaf.prefix:classpath:/templates/
spring.thymeleaf.view-name:th/*          # th/ 로 시작하는 뷰는 Thymeleaf가 처리
spring.thymeleaf.suffix:.html
spring.thymeleaf.mode:HTML5
spring.thymeleaf.cache:false             # 개발 중 캐시 비활성화 (수정 즉시 반영)
```

> JSP 설정(`spring.mvc.view.prefix/suffix`)과 Thymeleaf 설정이 **공존**.  
> `th/index` → `classpath:/templates/th/index.html` 으로 렌더링됨.

---

### ThymeleafTestController

```java
@Controller @Slf4j @RequestMapping("/th")
public class ThymeleafTestController {

    @GetMapping("/index")
    public void index(@RequestParam Boolean isAuth, Model model) {
        // 기본 문자열
        model.addAttribute("name", "hong");
        // DTO
        model.addAttribute("dto", new PersonDTO("nam", 55, "Deagu"));
        // List<DTO>
        List<PersonDTO> list = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            list.add(new PersonDTO("TEST" + i, i, ""));
        }
        model.addAttribute("list", list);
        model.addAttribute("isAuth", isAuth);
    }
}
```

> 요청: `GET /th/index?isAuth=true`  
> 뷰: `classpath:/templates/th/index.html`

---

### Thymeleaf 주요 문법

#### 1. `th:text` — 텍스트 출력

```html
<span th:text="${name}"></span>
<span th:text="${dto.name}"></span>
<span th:text="${dto.age}"></span>
```

> JSP `${name}` 과 역할은 같지만, HTML 태그 속성으로 작성 → 브라우저에서 HTML 파일 그대로 열어도 레이아웃이 깨지지 않음 (Natural Templates)

---

#### 2. `th:each` — 반복문

```html
<th:block th:each="dto:${list}">
    <div th:text="${dto}"></div>
</th:block>
```

| JSP | Thymeleaf |
|-----|-----------|
| `<c:forEach var="dto" items="${list}">` | `th:each="dto:${list}"` |

---

#### 3. `th:if` / `th:unless` — 분기문

```html
<th:block th:if="${isAuth}">
    <div>인증 완료</div>
</th:block>
<th:block th:unless="${isAuth}">
    <div>인증 실패</div>
</th:block>
```

| 조건 | 속성 |
|------|------|
| 조건 참일 때 표시 | `th:if="${...}"` |
| 조건 거짓일 때 표시 | `th:unless="${...}"` |

> `th:unless` = `th:if="!{...}"` 와 동일. JSP의 `<c:if test="!...">` 대응.

---

#### 4. `th:href` — URL 링크 (쿼리스트링 자동 생성)

```html
<!-- 일반 href -->
<a href="/param/p01?name=hong">/param/p01</a>

<!-- Thymeleaf 방식 — 변수 삽입 -->
<a th:href="@{/param/p01(name=${name})}">th:/param/p01</a>

<!-- 여러 파라미터 -->
<a th:href="@{/param/p06(name=${dto.name},age=${dto.age},add=${dto.addr})}">th:/param/p06</a>
```

> `@{경로(key=value)}` 문법 → 자동으로 `?key=value&...` 쿼리스트링 생성  
> URL 인코딩도 자동 처리

---

#### 5. `th:block` — 렌더링 없는 논리 블록

```html
<th:block th:each="...">...</th:block>
<th:block th:if="...">...</th:block>
```

> `<th:block>` 태그 자체는 HTML에 출력되지 않음.  
> 실제 DOM에 불필요한 `<div>` 나 `<span>` 을 남기지 않을 때 사용.

---

#### 6. Fragment — 레이아웃 분리 (`th:fragment` / `th:insert`)

**정의 — `fragments/header.html`**
```html
<header th:fragment="headerFragment">
    <div style="height: 100px; background-color: gray; color: white;">
        <h1>헤더 영역</h1>
    </div>
</header>
```

**정의 — `fragments/footer.html`** (여러 프래그먼트 동시 정의 가능)
```html
<footer th:fragment="footerFragment">
    <div style="background-color: black; color: white;">푸터 영역-1</div>
</footer>
<footer th:fragment="footerFragment-2">
    <div style="background-color: green; color: white;">푸터 영역-2</div>
</footer>
```

**사용 — `index.html`**
```html
<th:block th:insert="~{th/fragments/header::headerFragment}" />
<th:block th:insert="~{th/fragments/footer::footerFragment}" />
<th:block th:insert="~{th/fragments/footer::footerFragment-2}" />
```

> `~{파일경로::프래그먼트명}` 문법 — `templates/` 기준 상대경로 사용  
> `th:insert` = 해당 태그 안에 삽입 (vs `th:replace` = 태그 자체를 대체)

| 속성 | 동작 |
|------|------|
| `th:insert` | 대상 태그의 **내부**에 프래그먼트 삽입 |
| `th:replace` | 대상 태그 **자체**를 프래그먼트로 교체 |

---

#### 7. 인라인 JavaScript — `th:inline="javascript"`

```html
<script th:inline="javascript">
    console.log( [[ ${name} ]] );   // "hong"
    console.log( [[ ${dto} ]] );    // {name: 'nam', age: 55, addr: 'Deagu'}
    console.log( [[ ${list} ]] );   // [{...}, ...]
</script>
```

> `th:inline="javascript"` 를 `<script>` 태그에 선언 → `[[ ${...} ]]` 문법으로 JS 코드 안에서 서버 데이터 출력  
> 객체/리스트는 자동으로 JSON 직렬화됨

---

### JSP vs Thymeleaf 비교

| 기능 | JSP (JSTL) | Thymeleaf |
|------|-----------|-----------|
| 텍스트 출력 | `${name}` | `th:text="${name}"` |
| 반복문 | `<c:forEach var="x" items="${list}">` | `th:each="x:${list}"` |
| 조건문 (참) | `<c:if test="${isAuth}">` | `th:if="${isAuth}"` |
| 조건문 (거짓) | `<c:if test="${!isAuth}">` | `th:unless="${isAuth}"` |
| URL 링크 | `<c:url value="/path">` | `th:href="@{/path(key=val)}"` |
| 레이아웃 분리 | `<jsp:include>` | `th:insert="~{파일::프래그먼트}"` |
| JS 인라인 | `<%= %>` | `th:inline="javascript"` + `[[${...}]]` |
| 파일 위치 | `WEB-INF/views/*.jsp` | `resources/templates/**/*.html` |
| 브라우저 직접 열기 | 불가 (서버 필요) | 가능 (Natural Templates) |

---

### 흐름 요약

```
브라우저 GET /th/index?isAuth=true
    → ThymeleafTestController.index()
    → Model에 name, dto, list, isAuth 세팅
    → 뷰 이름 없음 (void) → 요청 경로 기반 → "th/index"
    → Thymeleaf: classpath:/templates/th/index.html 렌더링
        → th:insert로 header.html, footer.html Fragment 포함
        → th:text, th:each, th:if/unless, th:href 처리
        → th:inline="javascript"로 JS 인라인 데이터 직렬화
    → 완성된 HTML 응답
```

---

### 세팅 체크리스트

| 항목 | 값 |
|------|-----|
| 뷰 엔진 | JSP + Thymeleaf 병행 |
| Thymeleaf 템플릿 경로 | `src/main/resources/templates/` |
| Thymeleaf 뷰 접두어 | `th/` (이 경로로 시작하면 Thymeleaf 처리) |
| Fragment 경로 | `templates/th/fragments/*.html` |
| 캐시 | `false` (개발 중 수정 즉시 반영) |
| JS 인라인 | `th:inline="javascript"` + `[[${...}]]` |

---

## 07_DATASOURCE — DataSource + JDBC (HikariCP / Commons-DBCP2)

> 06_THYMELEAF 대비 변경: JSP 제거 → Thymeleaf 전용. MySQL JDBC 드라이버, HikariCP, Commons-DBCP2 추가.  
> `DataSourceConfig`, `MemoDAO`(CRUD), `MemoController`(CRUD), `ExBookDAO`(실습 스켈레톤) 추가.

### build.gradle 변경점 (06_THYMELEAF → 07_DATASOURCE)

```groovy
dependencies {
    // THYMELEAF
    implementation 'org.springframework.boot:spring-boot-starter-thymeleaf'

    // SPRING STARTER
    implementation 'org.springframework.boot:spring-boot-starter-web'

    // LOMBOK
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
    testCompileOnly 'org.projectlombok:lombok'
    testAnnotationProcessor 'org.projectlombok:lombok'

    // MYSQL CONNECTOR  ← 추가
    runtimeOnly 'com.mysql:mysql-connector-j'

    // JDBC API (JdbcTemplate 포함)  ← 추가
    implementation 'org.springframework.boot:spring-boot-starter-jdbc'

    // COMMONS-DBCP2 (BasicDataSource)  ← 추가
    implementation 'org.apache.commons:commons-dbcp2:2.14.0'

    // VALIDATION
    implementation 'org.springframework.boot:spring-boot-starter-validation'

    testImplementation 'org.springframework.boot:spring-boot-starter-test'
    testRuntimeOnly 'org.junit.platform:junit-platform-launcher'
}
```

---

### DataSource 설정 3가지 방법

#### 방법 1 — Spring Boot 자동 설정 (application.properties)

```properties
# application.properties에 설정하면 Spring Boot가 HikariCP 빈을 자동 생성
spring.datasource.url=jdbc:mysql://localhost:3306/testdb
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.username=root
spring.datasource.password=1234
```

> Spring Boot는 클래스패스에 HikariCP가 있으면 자동으로 `HikariDataSource` 빈 생성.  
> 빈 이름: `dataSource` (자동 설정). `@Autowired DataSource dataSource`로 주입.

---

#### 방법 2 — `@Configuration + @Bean` (HikariCP 수동 설정)

```java
@Configuration
public class DataSourceConfig {

    @Bean
    public DataSource dataSource() {
        HikariDataSource dataSource = new HikariDataSource();
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dataSource.setJdbcUrl("jdbc:mysql://localhost:3306/testdb");  // setUrl 아님 — setJdbcUrl
        dataSource.setUsername("root");
        dataSource.setPassword("1234");
        return dataSource;
    }
}
```

> HikariCP는 `setUrl()` 대신 `setJdbcUrl()`을 사용함에 주의.  
> 빈 이름: 메서드명 → `dataSource`

---

#### 방법 3 — `@Configuration + @Bean` (Commons-DBCP2 수동 설정)

```java
@Bean
public DataSource dataSource2() {
    BasicDataSource dataSource = new BasicDataSource();  // commons-dbcp2
    dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
    dataSource.setUrl("jdbc:mysql://localhost:3306/testdb");
    dataSource.setUsername("root");
    dataSource.setPassword("1234");
    // 커넥션 풀 크기 제어 (선택)
    // dataSource.setInitialSize(5);  // 초기 연결 개수
    // dataSource.setMaxTotal(10);    // 최대 연결 개수
    // dataSource.setMaxIdle(8);      // 최대 유휴 연결 수
    // dataSource.setMinIdle(3);      // 최소 유휴 연결 수
    return dataSource;
}
```

| 항목 | HikariCP | Commons-DBCP2 |
|------|----------|---------------|
| 클래스 | `HikariDataSource` | `BasicDataSource` |
| URL 설정 | `setJdbcUrl()` | `setUrl()` |
| Spring Boot 기본 | O (자동 설정 기본값) | X (명시적 추가 필요) |
| 성능 | 더 빠름 | 안정적 |

---

### 새로 추가된 구조

```
src/main/java/com/example/demo/
├── Config/
│   └── DataSourceConfig.java        # DataSource 빈 설정
├── Domain/Common/
│   ├── Daos/
│   │   ├── MemoDAO.java             # JDBC CRUD (try-with-resources)
│   │   └── ExBookDAO.java           # CRUD 실습 스켈레톤
│   └── Dtos/
│       ├── MemoDTO.java
│       └── BookDTO.java
└── Controller/
    ├── MemoController.java          # /memo/** CRUD
    └── ExBookController.java        # /book/** 실습

src/main/resources/templates/
├── index.html
├── memo/
│   ├── add.html   list.html   update.html   error.html
└── exbook/
    └── ...
```

---

### MemoDAO — JDBC CRUD (try-with-resources)

```java
@Repository
public class MemoDAO {

    @Autowired
    private DataSource dataSource;

    // INSERT
    public int insert(MemoDTO dto) throws SQLException {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                     "insert into tbl_memo values(null,?,?,?,?)")) {

            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getWriter());
            pstmt.setString(3, dto.getText());
            pstmt.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));
            return pstmt.executeUpdate();
        }
    }

    // SELECT ALL
    public List<MemoDTO> selectAll() throws SQLException {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                     "select * from tbl_memo order by id desc");
             ResultSet rs = pstmt.executeQuery()) {

            List<MemoDTO> list = new ArrayList<>();
            while (rs.next()) {
                list.add(MemoDTO.builder()
                        .id(rs.getLong("id"))
                        .title(rs.getString("title"))
                        .writer(rs.getString("writer"))
                        .text(rs.getString("text"))
                        .createAt(rs.getTimestamp("createAt").toLocalDateTime())
                        .build());
            }
            return list;
        }
    }

    // SELECT ONE
    public MemoDTO selectOne(Long id) throws SQLException {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                     "select * from tbl_memo where id=?")) {
            pstmt.setLong(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return MemoDTO.builder()
                            .id(rs.getLong("id"))
                            .title(rs.getString("title"))
                            .writer(rs.getString("writer"))
                            .text(rs.getString("text"))
                            .createAt(rs.getTimestamp("createAt").toLocalDateTime())
                            .build();
                }
                return null;
            }
        }
    }

    // UPDATE
    public int update(MemoDTO dto) throws SQLException {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                     "update tbl_memo set title=?,text=?,writer=? where id=?")) {
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getText());
            pstmt.setString(3, dto.getWriter());
            pstmt.setLong(4, dto.getId());
            return pstmt.executeUpdate();
        }
    }

    // DELETE
    public int delete(Long id) throws SQLException {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                     "delete from tbl_memo where id=?")) {
            pstmt.setLong(1, id);
            return pstmt.executeUpdate();
        }
    }
}
```

> `try-with-resources` — `Connection`, `PreparedStatement`, `ResultSet`은 `AutoCloseable`을 구현하므로  
> `try(...)` 블록 종료 시 자동으로 `close()` 호출 → 커넥션 누수 방지

---

### MemoController — CRUD 흐름

```java
@Controller @Slf4j @RequestMapping("/memo")
public class MemoController {

    @Autowired
    private MemoDAO memoDAO;

    // SQLException 발생 시 지역 핸들러로 처리
    @ExceptionHandler
    public String SQLExceptionHandler(Exception e, Model model) {
        model.addAttribute("ex", e.getMessage());
        return "memo/error";
    }

    // 등록 폼
    @GetMapping("/add")
    public void memoAdd() { }

    // 등록 처리
    @PostMapping("/add")
    public String memoAddPost(@Valid MemoDTO memoDTO, BindingResult bindingResult,
                              Model model, RedirectAttributes redirectAttributes) throws SQLException {
        if (bindingResult.hasErrors()) {
            for (FieldError error : bindingResult.getFieldErrors())
                model.addAttribute(error.getField(), error.getDefaultMessage());
            return "memo/add";
        }
        int result = memoDAO.insert(memoDTO);
        if (result > 0)
            redirectAttributes.addFlashAttribute("message", "메모추가 성공!");
        return "redirect:/memo/list";
    }

    // 목록
    @GetMapping("/list")
    public void list_get(Model model) throws SQLException {
        model.addAttribute("list", memoDAO.selectAll());
    }

    // 수정 폼
    @GetMapping("/update")
    public void memo_update(Long id, Model model) throws SQLException {
        MemoDTO dto = memoDAO.selectOne(id);
        if (dto != null) model.addAttribute("dto", dto);
    }

    // 수정 처리
    @PostMapping("/update")
    public String memo_update_post(MemoDTO dto, RedirectAttributes redirectAttributes) throws SQLException {
        int result = memoDAO.update(dto);
        redirectAttributes.addFlashAttribute("message",
                result > 0 ? dto.getId() + " 업데이트 성공!" : dto.getId() + " 업데이트 실패!");
        return "redirect:/memo/list";
    }

    // 삭제
    @GetMapping("/delete")
    public String memo_delete(Long id, RedirectAttributes redirectAttributes) throws SQLException {
        int result = memoDAO.delete(id);
        redirectAttributes.addFlashAttribute("message",
                result > 0 ? id + " 삭제 성공!" : id + " 삭제 실패!");
        return "redirect:/memo/list";
    }
}
```

#### CRUD 흐름 요약

```
등록: GET /memo/add → 폼 → POST /memo/add → DAO.insert() → redirect:/memo/list
목록: GET /memo/list → DAO.selectAll() → memo/list.html
수정: GET /memo/update?id=1 → DAO.selectOne() → 폼 → POST /memo/update → DAO.update() → redirect:/memo/list
삭제: GET /memo/delete?id=1 → DAO.delete() → redirect:/memo/list
```

---

### ExBookDAO — CRUD 실습 스켈레톤

```
tbl_book 테이블: id, title, author, price
EX01: DataSource 주입
EX02: insert()   — INSERT 1건
EX03: findAll()  — SELECT 전체 → List<BookDTO>
EX04: findById() — SELECT 단건 → BookDTO (없으면 null)
EX05: update()   — UPDATE (title/author/price)
EX06: delete()   — DELETE by id
```

> MemoDAO 참고하여 try-with-resources 패턴으로 직접 구현 연습

---

### 핵심 정리

```
DataSource 설정 방법
  1. application.properties  → Spring Boot 자동 HikariCP 빈 생성
  2. @Bean DataSource(HikariCP)  → setJdbcUrl() 사용
  3. @Bean DataSource(BasicDataSource)  → setUrl() 사용

JDBC CRUD 패턴
  try (Connection + PreparedStatement + ResultSet)  — AutoCloseable, 자동 close
  pstmt.setXxx(index, value)  — 1-based 인덱스
  pstmt.executeUpdate()  → INSERT/UPDATE/DELETE (영향 행 수 반환)
  pstmt.executeQuery()  → SELECT (ResultSet 반환)

DAO 레이어
  @Repository  — DB 접근 클래스에 붙임
  DataSource 주입 → getConnection() → PreparedStatement → 실행
```

---

## 08_SQLMAPPER_MYBATIS — MyBatis SQL Mapper

> 07_DATASOURCE 대비 변경: commons-dbcp2 제거, MyBatis 스타터 추가.  
> `MybatisConfig`, `MemoMapper` 인터페이스(어노테이션 + XML) 추가.

### build.gradle 변경점 (07_DATASOURCE → 08_SQLMAPPER_MYBATIS)

```groovy
dependencies {
    // commons-dbcp2 제거됨

    // MYBATIS  ← 추가
    implementation 'org.mybatis.spring.boot:mybatis-spring-boot-starter:3.0.5'
    testImplementation 'org.mybatis.spring.boot:mybatis-spring-boot-starter-test:3.0.5'

    // 나머지 의존성은 07_DATASOURCE와 동일
}
```

---

### 새로 추가된 구조

```
src/main/java/com/example/demo/
├── Config/
│   ├── DataSourceConfig.java          # HikariCP DataSource 빈 (07과 동일)
│   └── MybatisConfig.java             # SqlSessionFactory + SqlSessionTemplate 빈  ← 추가
└── Domain/Common/
    ├── Mapper/
    │   └── MemoMapper.java            # @Mapper 인터페이스 (어노테이션 + XML 혼합)  ← 추가
    └── Daos/
        └── MemoDAO.java               # SqlSessionTemplate으로 Mapper 호출

src/main/resources/
└── mapper/
    └── MemoMapper.xml                 # XML 기반 SQL  ← 추가
```

---

### MybatisConfig — SqlSessionFactory + SqlSessionTemplate

```java
@Configuration
public class MybatisConfig {

    @Autowired
    private DataSource dataSource;

    @Bean
    public SqlSessionFactory sqlSessionFactory() throws Exception {
        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
        sessionFactory.setDataSource(dataSource);

        // Mapper XML 파일 위치 지정 (classpath*:mapper/*.xml)
        PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        Resource[] resources = resolver.getResources("classpath*:mapper/*.xml");
        sessionFactory.setMapperLocations(resources);

        return sessionFactory.getObject();
    }

    @Bean
    public SqlSessionTemplate sqlSessionTemplate() throws Exception {
        return new SqlSessionTemplate(sqlSessionFactory());
    }
}
```

| 빈 | 역할 |
|---|---|
| `SqlSessionFactory` | MyBatis 설정 + Mapper XML 로드. `SqlSession` 생성 공장 |
| `SqlSessionTemplate` | 스레드 안전한 `SqlSession` 래퍼. 트랜잭션 관리 포함 |

---

### MemoMapper — 어노테이션 기반 SQL

```java
@Mapper
public interface MemoMapper {

    // INSERT + 삽입 후 생성된 PK 조회 (@SelectKey)
    @SelectKey(
        statement = "SELECT max(id) FROM testdb.tbl_memo",
        keyProperty = "id",
        before = false,        // INSERT 실행 후 실행 (before=true면 INSERT 전)
        resultType = Long.class
    )
    @Insert("insert into tbl_memo values(#{id},#{title},#{writer},#{text},#{createAt})")
    int insert(MemoDTO memoDTO);   // 실행 후 memoDTO.id에 생성된 PK가 세팅됨

    // UPDATE
    @Update("update tbl_memo set text=#{text} where id=#{id}")
    int update(MemoDTO memoDTO);

    // DELETE
    @Delete("delete from tbl_memo where id=#{id}")
    int delete(Long id);

    // SELECT 전체
    @Select("select * from tbl_memo")
    List<MemoDTO> selectALL();

    // SELECT 검색 — @Param으로 동적 컬럼명 사용
    @Select("select * from tbl_memo where ${type} like concat('%',#{keyword},'%')")
    List<MemoDTO> selectAllContains(
        @Param("type") String type,    // ${type} → 컬럼명 직접 삽입 (SQL injection 주의)
        String keyword                 // #{keyword} → PreparedStatement 바인딩 (안전)
    );

    // SELECT + @Results (컬럼 → 필드 커스텀 매핑)
    @Results(id = "MemoResultMap", value = {
        @Result(property = "text",   column = "text"),
        @Result(property = "writer", column = "writer")
    })
    @Select("select text,writer from tbl_memo")
    List<Map<String, Object>> selectAllWithResultMap();

    // XML Mapper 메서드 (구현은 MemoMapper.xml에)
    int insertXML(MemoDTO memoDTO);
    int updateXML(MemoDTO memoDTO);
    int deleteXML(Long id);
    MemoDTO selectOneXML(Long id);
    List<MemoDTO> selectALLXML();
    List<MemoDTO> selectAllContainsXML(@Param("type") String type, String keyword);
    List<Map<String, Object>> selectAllWithResultMapXML();
}
```

#### 어노테이션별 역할

| 어노테이션 | 역할 | 주요 속성 |
|---|---|---|
| `@Mapper` | 인터페이스를 MyBatis Mapper로 등록 (빈 자동 생성) | — |
| `@Insert` | INSERT SQL | value (SQL 문자열) |
| `@Update` | UPDATE SQL | value |
| `@Delete` | DELETE SQL | value |
| `@Select` | SELECT SQL | value |
| `@SelectKey` | INSERT/UPDATE 전후로 별도 SELECT 실행 (생성 키 조회) | `statement`, `keyProperty`, `before`, `resultType` |
| `@Results` / `@Result` | 컬럼명 ↔ 필드명 커스텀 매핑 | `id`, `property`, `column` |
| `@Param` | 파라미터가 여러 개일 때 SQL 내 이름 지정 | value |

---

#### `#{}` vs `${}` 차이

| | `#{}` | `${}` |
|---|---|---|
| 처리 방식 | PreparedStatement 바인딩 (`?` 치환) | 문자열 직접 삽입 |
| SQL Injection | 안전 | 위험 (사용자 입력에 직접 쓰면 안 됨) |
| 주요 사용처 | WHERE절 값, INSERT 값 | 동적 컬럼명/테이블명 |
| 예시 | `where id=#{id}` | `where ${type} like ...` |

---

### MemoMapper.xml — XML 기반 SQL

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<!-- namespace = Mapper 인터페이스 풀 경로 -->
<mapper namespace="com.example.demo.Domain.Common.Mapper.MemoMapper">

    <insert id="insertXML">
        insert into tbl_memo values(#{id},#{title},#{writer},#{text},#{createAt})
    </insert>

    <update id="updateXML">
        update tbl_memo set text=#{text} where id=#{id}
    </update>

    <delete id="deleteXML">
        delete from tbl_memo where id=#{id}
    </delete>

    <!-- resultType: 반환 타입 풀 경로, parameterType: 파라미터 타입 -->
    <select id="selectOneXML"
            resultType="com.example.demo.Domain.Common.Dtos.MemoDTO"
            parameterType="long">
        select * from tbl_memo where id=#{id}
    </select>

</mapper>
```

> `id` — Mapper 인터페이스의 메서드명과 일치해야 함  
> XML이 어노테이션보다 복잡한 동적 SQL(`<if>`, `<foreach>`, `<choose>` 등) 작성에 유리

---

### 테스트 — MemoMapperTest

```java
@SpringBootTest
class MemoMapperTest {

    @Autowired
    private MemoMapper memoMapper;

    @Test void t1() { memoMapper.insert(new MemoDTO(55L, "TITLE55", "a@a.com", "text55", LocalDateTime.now())); }

    @Test void t2() { memoMapper.update(new MemoDTO(55L, null, null, "text55!!!!", null)); }

    @Test void t3() { memoMapper.delete(55L); }

    @Test void t4() { memoMapper.selectALL().forEach(System.out::println); }

    // @SelectKey 확인 — insert 전 dto.id=null, 실행 후 dto.id=생성된PK
    @Test void t5() {
        MemoDTO dto = new MemoDTO(null, "TITLE55", "a@a.com", "text55", LocalDateTime.now());
        System.out.println(dto);      // id=null
        memoMapper.insert(dto);
        System.out.println(dto);      // id=생성된PK (before=false 이므로 INSERT 후 세팅)
    }

    @Test void t6() { memoMapper.selectAllWithResultMap().forEach(System.out::println); }

    @Test void t7() { memoMapper.selectAllContains("text", "a").forEach(System.out::println); }

    // XML Mapper 테스트
    @Test void t8() { memoMapper.insertXML(new MemoDTO(null, "TITLE88", "a@a.com", "text88", LocalDateTime.now())); }
    @Test void t9() { memoMapper.updateXML(new MemoDTO(58L, null, null, "text88!!!!", null)); }
    @Test void t10() { memoMapper.deleteXML(58L); }
    @Test void t11() { System.out.println(memoMapper.selectOneXML(58L)); }
}
```

---

### 어노테이션 방식 vs XML 방식 비교

| 항목 | 어노테이션 (`@Select` 등) | XML (`*.xml`) |
|---|---|---|
| 위치 | Mapper 인터페이스 | 별도 XML 파일 |
| 간단한 CRUD | 간결하고 직관적 | 상대적으로 장황 |
| 동적 SQL | 어렵 (`<script>` 태그 필요) | 쉬움 (`<if>`, `<foreach>` 등) |
| 유지보수 | SQL이 Java에 섞임 | SQL 분리로 관리 용이 |
| 주로 사용 | 단순 쿼리 | 복잡한 동적 쿼리 |

---

### [EX] Product 실습 — Controller → DAO → Mapper 계층 + 동적 SQL

> 실습 테이블: `tbl_product(id bigint PK, pname varchar(100), price int, stock int)`

#### ProductDTO

```java
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ProductDTO {
    private Long id;

    @NotBlank(message = "상품명은 필수 항목입니다.")
    private String pname;

    @NotNull(message = "가격은 필수 항목입니다.")
    private Integer price;

    @NotNull(message = "재고는 필수 항목입니다.")
    private Integer stock;
}
```

---

#### ProductMapper — 어노테이션 CRUD + XML 메서드 선언

```java
@Mapper
public interface ProductMapper {

    // EX01 — INSERT
    @Insert("insert into tbl_product values (#{id},#{pname},#{price},#{stock})")
    int insert(ProductDTO dto);

    // EX02 — SELECT 전체
    @Select("select * from tbl_product")
    List<ProductDTO> selectAll();

    // EX02 — SELECT 단건
    @Select("select * from tbl_product where id=#{id}")
    ProductDTO selectOne(Long id);

    // EX03 — UPDATE
    @Update("update tbl_product set pname=#{pname},price=#{price},stock=#{stock} where id=#{id}")
    int update(ProductDTO dto);

    // EX03 — DELETE
    @Delete("delete from tbl_product where id=#{id}")
    int delete(Long id);

    // EX04 — XML 전체 조회 (구현은 ProductMapper.xml)
    List<ProductDTO> selectAllXML();

    // EX05 — XML 동적 검색 (Map 파라미터: keyword, minStock)
    List<Map<String, Object>> searchXML(Map<String, Object> param);
}
```

---

#### ProductMapper.xml — 동적 SQL `<where>` / `<if>`

```xml
<mapper namespace="com.example.demo.Domain.Common.Mapper.ProductMapper">

    <!-- EX04 — 전체 조회 -->
    <select id="selectAllXML" resultType="com.example.demo.Domain.Common.Dtos.ProductDTO">
        select * from tbl_product
    </select>

    <!-- EX05 — 동적 검색: keyword(상품명 LIKE) + minStock(재고 이상) -->
    <select id="searchXML" resultType="java.util.Map" parameterType="java.util.Map">
        select * from tbl_product
        <where>
            <if test="keyword != null and keyword != ''">
                pname like concat('%', #{keyword}, '%')
            </if>
            <if test="minStock != null">
                and stock &gt;= #{minStock}
            </if>
        </where>
    </select>

</mapper>
```

#### 동적 SQL 태그 정리

| 태그 | 역할 |
|---|---|
| `<where>` | `WHERE` 키워드를 자동 추가. 조건이 없으면 WHERE 자체를 생략. 첫 조건의 불필요한 `AND/OR` 자동 제거 |
| `<if test="조건">` | 조건이 참일 때만 SQL 조각 포함 |
| `<foreach>` | 컬렉션 순회 (`IN (?,?,?)` 등) |
| `<choose>/<when>/<otherwise>` | `switch-case` 와 동일 |
| `&gt;` | XML 특수문자 이스케이프 (`>` → `&gt;`) |

> `<where>` 사용 이유: 조건이 하나도 없을 때 `WHERE` 가 남으면 SQL 오류 발생 → `<where>` 가 자동 처리

---

#### ProductDAO — Mapper를 감싸는 DAO 계층

```java
@Repository @Slf4j
public class ProductDAO {

    @Autowired
    private ProductMapper productMapper;   // DAO가 Mapper를 감싼다

    public int insert(ProductDTO dto) {
        return productMapper.insert(dto);
    }

    public List<ProductDTO> selectAll() {
        return productMapper.selectAllXML();
    }

    public ProductDTO selectOne(Long id) {
        return productMapper.selectOne(id);
    }

    public int update(ProductDTO dto) {
        return productMapper.update(dto);
    }

    public int delete(Long id) {
        return productMapper.delete(id);
    }

    // EX07 — 동적 검색: keyword/minStock → Map으로 묶어 searchXML 호출
    public List<Map<String, Object>> search(String keyword, Integer minStock) {
        Map<String, Object> param = new HashMap<>();
        param.put("keyword", keyword);
        param.put("minStock", minStock);
        return productMapper.searchXML(param);
    }
}
```

> **Controller → DAO → Mapper 흐름**  
> DAO가 없어도 Mapper를 직접 주입해 쓸 수 있지만,  
> DAO 계층을 두면 비즈니스 로직(파라미터 조합 등)을 Mapper와 분리할 수 있음

---

#### ProductController — 동적 검색 목록 + 등록

```java
@Controller @Slf4j @RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductDAO productDAO;

    // EX08 — 목록 + 동적 검색
    // GET /product/list?keyword=노트&minStock=5
    @GetMapping("/list")
    public String list(@RequestParam(required = false) String keyword,
                       @RequestParam(required = false) Integer minStock,
                       Model model) {
        model.addAttribute("list", productDAO.search(keyword, minStock));
        model.addAttribute("keyword", keyword);     // 검색어 유지
        model.addAttribute("minStock", minStock);
        return "product/list";
    }

    // EX08 — 등록 폼
    @GetMapping("/add")
    public void add() { }

    // EX08 — 등록 처리
    @PostMapping("/add")
    public String addPost(@Valid ProductDTO dto, BindingResult bindingResult,
                          Model model, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            for (FieldError error : bindingResult.getFieldErrors())
                model.addAttribute(error.getField(), error.getDefaultMessage());
            return "product/add";
        }
        productDAO.insert(dto);
        redirectAttributes.addFlashAttribute("message", "상품추가 성공!");
        return "redirect:/product/list";
    }
}
```

#### 동적 검색 흐름

```
GET /product/list?keyword=노트&minStock=5
    → ProductController.list(keyword="노트", minStock=5)
    → ProductDAO.search("노트", 5)
        → Map { keyword:"노트", minStock:5 }
        → ProductMapper.searchXML(param)
    → ProductMapper.xml <searchXML>
        → WHERE pname LIKE '%노트%' AND stock >= 5
    → model("list") → product/list.html 렌더링

GET /product/list  (파라미터 없음)
    → Map { keyword:null, minStock:null }
    → <where> 조건 없음 → WHERE 절 전체 생략
    → SELECT * FROM tbl_product  (전체 조회)
```

---

### 핵심 정리

```
MyBatis 설정 흐름
  DataSource 빈 → SqlSessionFactoryBean(DataSource + XML 위치)
      → SqlSessionFactory 빈
      → SqlSessionTemplate 빈

Mapper 등록
  @Mapper 인터페이스 → Spring이 구현체(프록시) 자동 생성 → @Autowired로 주입 가능

SQL 작성 방식
  어노테이션: @Insert/@Select/... + #{파라미터}
  XML: mapper/*.xml — namespace = 인터페이스 풀경로, id = 메서드명

@SelectKey
  INSERT/UPDATE 전후로 키 조회 쿼리 실행 → keyProperty 필드에 세팅
  before=false: INSERT 실행 후 → 삽입된 max(id) 조회해서 dto.id에 넣음

파라미터 바인딩
  #{} → PreparedStatement (안전, 값에 사용)
  ${} → 문자열 직접 삽입 (동적 컬럼명에만 사용, 사용자 입력 금지)
```

---

## 09_ORM_JPA — Spring Data JPA (ORM)

> 08_SQLMAPPER_MYBATIS 대비 변경: commons-dbcp2 제거, `spring-boot-starter-data-jpa` 추가.  
> Entity 클래스, JpaRepository, 페이징, 관계 매핑(1:N), JPQL `@Query` 실습.

### build.gradle 변경점 (08 → 09)

```groovy
dependencies {
    // THYMELEAF
    implementation 'org.springframework.boot:spring-boot-starter-thymeleaf'
    // SPRING STARTER
    implementation 'org.springframework.boot:spring-boot-starter-web'
    // LOMBOK
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
    testCompileOnly 'org.projectlombok:lombok'
    testAnnotationProcessor 'org.projectlombok:lombok'
    // MYSQL
    runtimeOnly 'com.mysql:mysql-connector-j'
    // JDBC API
    implementation 'org.springframework.boot:spring-boot-starter-jdbc'
    // commons-dbcp2 제거됨
    // JPA  ← 추가
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    // VALIDATION
    implementation 'org.springframework.boot:spring-boot-starter-validation'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
    testRuntimeOnly 'org.junit.platform:junit-platform-launcher'
}
```

---

### application.properties — JPA 설정

```properties
# JPA
spring.jpa.hibernate.ddl-auto=update   # none|update|create
spring.jpa.show-sql=true               # 실행 SQL 콘솔 출력
```

| `ddl-auto` 값 | 동작 |
|---|---|
| `none` | DDL 실행 안 함 (운영) |
| `update` | 엔티티 변경 시 ALTER TABLE 반영 (개발) |
| `create` | 실행마다 DROP → CREATE (초기화) |

---

### 프로젝트 구조

```
src/main/java/com/example/demo/
├── Domain/Common/
│   ├── Entity/
│   │   ├── Memo.java            # @Entity + @GeneratedValue (auto PK)
│   │   ├── Book.java            # @Entity + @Id (수동 PK)
│   │   ├── User.java            # @Entity + @Id (String PK)
│   │   ├── Lend.java            # @ManyToOne (User, Book) — 관계 매핑
│   │   └── ex/
│   │       ├── ExBoard.java     # 실습: 게시글 엔티티
│   │       └── ExReply.java     # 실습: 댓글 엔티티 (@ManyToOne ExBoard)
│   ├── Repository/
│   │   ├── MemoRepository.java      # JpaRepository<Memo, Long>
│   │   ├── BookRepository.java      # 명명 규칙 쿼리 메서드
│   │   ├── UserRepository.java      # @Query JPQL
│   │   ├── LendRepository.java      # @Query JOIN FETCH
│   │   └── ex/
│   │       ├── ExBoardRepository.java
│   │       └── ExReplyRepository.java   # findByBoard_Id
│   └── Dtos/
│       ├── PageDTO.java         # 페이징 요청 파라미터
│       └── PageBlock.java       # 페이지 블록 계산 (15건 단위)
└── Controller/
    ├── MemoController.java      # /memo/** JPA CRUD + 페이징
    └── ex/
        └── ExRelController.java # /exrel/** 관계매핑 실습 (게시글+댓글)
```

---

### JPA 핵심 개념

| 개념 | 설명 |
|---|---|
| ORM (Object-Relational Mapping) | 자바 객체 ↔ DB 테이블 자동 매핑 |
| `@Entity` | 클래스를 JPA 엔티티(테이블)로 선언 |
| `@Table(name="...")` | 매핑할 테이블명 지정 (생략 시 클래스명) |
| `@Id` | PK 필드 지정 |
| `@GeneratedValue` | PK 자동 생성 전략 지정 |
| `@Column` | 컬럼 속성 지정 (length, nullable 등) |
| `JpaRepository` | CRUD + 페이징 메서드 자동 제공 인터페이스 |

---

### Entity 클래스

#### Memo.java — 자동 PK (IDENTITY 전략)

```java
@Data @NoArgsConstructor @AllArgsConstructor @Builder
@Table(name = "memo")
@Entity
public class Memo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // AUTO_INCREMENT
    private Long id;

    @Column(length = 1024)
    private String title;

    @Column(length = 1024)
    private String text;

    @Column(length = 100, nullable = false)
    private String writer;

    @Column
    private LocalDateTime createAt;
}
```

#### Book.java — 수동 PK

```java
@Entity @Table(name = "book")
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class Book {
    @Id                      // @GeneratedValue 없음 → save() 시 직접 PK 값 지정
    private Long bookCode;
    private String bookName;
    private String publisher;
    private String isbn;
}
```

#### User.java — String PK

```java
@Entity @Table(name = "user")
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class User {
    @Id
    @Column(length = 100)
    private String username;   // 문자열을 PK로 사용

    @Column(length = 255, nullable = false)
    private String password;

    @Column(length = 255)
    private String role;
}
```

#### Lend.java — `@ManyToOne` 관계 매핑

```java
@Entity @Data @NoArgsConstructor @AllArgsConstructor @Builder
public class Lend {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 누가? (N:1 — 여러 대여가 한 명의 유저)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "username",
        foreignKey = @ForeignKey(
            name = "FK_LEND_USER",
            foreignKeyDefinition = "FOREIGN KEY (username) REFERENCES user(username) ON DELETE CASCADE ON UPDATE CASCADE"
        )
    )
    private User user;

    // 어떤 책? (N:1 — 여러 대여가 한 권의 책)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "bookCode",
        foreignKey = @ForeignKey(
            name = "FK_LEND_BOOK",
            foreignKeyDefinition = "FOREIGN KEY (book_code) REFERENCES book(book_code) ON DELETE CASCADE ON UPDATE CASCADE"
        )
    )
    private Book book;
}
```

| 어노테이션 | 역할 |
|---|---|
| `@ManyToOne` | N(Lend) : 1(User/Book) 관계 선언 |
| `fetch = FetchType.LAZY` | 연관 객체를 실제 접근 시점에 쿼리 (기본은 EAGER) |
| `@JoinColumn(name=...)` | FK 컬럼명 지정 |
| `@ForeignKey(foreignKeyDefinition=...)` | ON DELETE/UPDATE CASCADE 등 세부 FK 정의 |

---

### Repository 인터페이스

#### MemoRepository — 기본 CRUD 자동 제공

```java
@Repository
public interface MemoRepository extends JpaRepository<Memo, Long> {
    // JpaRepository가 save/findById/findAll/deleteById/count 자동 제공
}
```

#### JpaRepository 기본 메서드

| 메서드 | 설명 |
|---|---|
| `save(entity)` | INSERT (id null) / UPDATE (id 있음) |
| `findById(id)` | SELECT by PK → `Optional<T>` |
| `findAll()` | SELECT 전체 → `List<T>` |
| `findAll(pageable)` | 페이징 SELECT → `Page<T>` |
| `deleteById(id)` | DELETE by PK |
| `count()` | 전체 행 수 |

---

#### BookRepository — 명명 규칙 쿼리 메서드

```java
@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
    List<Book> findByBookName(String bookName);           // WHERE book_name = ?
    List<Book> findByPublisher(String publisher);
    List<Book> findByIsbn(String isbn);
    List<Book> findByBookNameAndPublisher(String bookName, String publisher);  // AND 조건
    List<Book> findByBookNameContains(String keyword);    // WHERE book_name LIKE '%keyword%'

    int countByBookName(String bookName);                 // COUNT WHERE book_name = ?
    int countByBookNameContains(String bookName);

    void deleteByBookName(String bookname);               // DELETE WHERE book_name = ?
}
```

##### JPA 명명 규칙 키워드

| 키워드 | 예시 | SQL |
|---|---|---|
| `findBy필드` | `findByBookName(String n)` | `WHERE book_name=?` |
| `And` | `findByAAndB(a,b)` | `WHERE a=? AND b=?` |
| `Or` | `findByAOrB(a,b)` | `WHERE a=? OR b=?` |
| `Contains` | `findByNameContains(k)` | `WHERE name LIKE '%k%'` |
| `StartingWith` | `findByNameStartingWith(p)` | `WHERE name LIKE 'p%'` |
| `Between` | `findByCodeBetween(s,e)` | `WHERE code BETWEEN s AND e` |
| `OrderByXxxAsc` | `findByAOrderByBAsc(a)` | `ORDER BY b ASC` |
| `countBy필드` | `countByBookName(n)` | `SELECT COUNT(*) WHERE ...` |
| `deleteBy필드` | `deleteByBookName(n)` | `DELETE WHERE ...` |

---

#### UserRepository — `@Query` JPQL

```java
@Repository
public interface UserRepository extends JpaRepository<User, String> {

    // 위치 기반 파라미터 (?1, ?2)
    @Query("SELECT u FROM User as u where u.role=?1")
    List<User> selectAllByRole(String role);

    @Query("SELECT u FROM User as u where u.role=?1 and u.password=?2")
    List<User> selectAllByRoleAndPwd(String role, String password);

    // 이름 기반 파라미터 (:role) + @Param
    @Query("SELECT u FROM User as u where u.role=:role")
    List<User> selectAllByRole_2(@Param("role") String r);

    // LIKE 검색
    @Query("SELECT u FROM User as u where u.username like concat('%',:user,'%')")
    List<User> selectAllLikeUsername(@Param("user") String username);
}
```

> JPQL은 **테이블명이 아닌 엔티티 클래스명**, **컬럼명이 아닌 필드명**을 사용

| JPQL | SQL |
|---|---|
| `FROM User as u` | `FROM user u` |
| `u.role=?1` | `role=?` (위치 기반) |
| `u.role=:role` | `role=?` (이름 기반) |

---

#### LendRepository — `@Query` JOIN FETCH (N+1 문제 해결)

```java
@Repository
public interface LendRepository extends JpaRepository<Lend, Long> {

    // JOIN FETCH: Lend를 가져올 때 user를 함께 즉시 로딩 (LAZY 무시)
    @Query("SELECT l FROM Lend AS l JOIN FETCH l.user WHERE l.user.username=:username")
    List<Lend> findAllLendsByUser(@Param("username") String username);

    @Query("SELECT l FROM Lend AS l JOIN FETCH l.book WHERE l.book.bookName=:bookName")
    List<Lend> findAllLendsByBook(@Param("bookName") String bookName);
}
```

> `JOIN FETCH` — `FetchType.LAZY` 설정이더라도 해당 쿼리에서만 즉시 로딩으로 동작.  
> N+1 문제: findAll() 후 각 Lend마다 user/book 조회 쿼리가 따로 나가는 문제를 방지.

---

### 페이징 처리

#### MemoRepositoryTest — Page<T> 사용법

```java
@Test
public void t6() {
    // PageRequest.of(페이지번호, 페이지당건수)  — 0-based 페이지 번호
    Pageable pageable = PageRequest.of(0, 10);
    Page<Memo> page = memoRepository.findAll(pageable);

    System.out.println("현재 페이지 번호 : "   + page.getNumber());
    System.out.println("한페이지에 표시할 건수 : " + page.getSize());
    System.out.println("총게시물 개수 : "       + page.getTotalElements());
    System.out.println("총페이지 개수 : "       + page.getTotalPages());
    System.out.println("첫번째 페이지인지 여부 : " + page.isFirst());
    System.out.println("다음페이지가 있는지 여부 : " + page.hasNext());
    System.out.println("이전페이지가 있는지 여부 : " + page.hasPrevious());

    List<Memo> list = page.getContent();              // 현재 페이지 데이터
    Page<Memo> nextPage = memoRepository.findAll(page.nextPageable());
    Page<Memo> prevPage = memoRepository.findAll(page.previousPageable());
}
```

#### Page<T> 주요 메서드

| 메서드 | 반환 | 설명 |
|---|---|---|
| `getNumber()` | int | 현재 페이지 번호 (0-based) |
| `getSize()` | int | 페이지당 건수 |
| `getTotalElements()` | long | 전체 데이터 수 |
| `getTotalPages()` | int | 전체 페이지 수 |
| `getContent()` | `List<T>` | 현재 페이지 데이터 목록 |
| `isFirst()` | boolean | 첫 페이지 여부 |
| `hasNext()` | boolean | 다음 페이지 존재 여부 |
| `hasPrevious()` | boolean | 이전 페이지 존재 여부 |
| `nextPageable()` | `Pageable` | 다음 페이지 Pageable |
| `previousPageable()` | `Pageable` | 이전 페이지 Pageable |

---

#### PageBlock — 페이지 블록 계산 (15건 단위)

```java
@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class PageBlock<E> {
    private PageDTO pageDto;
    private Page<E> page;

    private int pagePerBlock;   // 블록에 표시할 페이지 수 (15 고정)
    private int totalBlock;     // 전체 블록 수
    private int nowBlock;       // 현재 블록 번호
    private int startPage;      // 블록 시작 페이지 번호 (0-based)
    private int endPage;        // 블록 마지막 페이지 번호 (0-based)
    private boolean prev, next; // Prev/Next 버튼 표시 여부

    public PageBlock(PageDTO pageDto, Page<E> page) {
        this.pageDto = pageDto;
        this.page = page;
        int totalpage = page.getTotalPages();
        pagePerBlock = 15;
        totalBlock = (int) Math.ceil((1.0 * totalpage) / pagePerBlock);
        nowBlock = (int) Math.ceil((1.0 * (pageDto.getPageNo() + 1)) / pagePerBlock);
        prev = nowBlock > 1;
        next = nowBlock < totalBlock;
        this.endPage = (nowBlock * pagePerBlock < totalpage) ? nowBlock * pagePerBlock : totalpage;
        this.startPage = nowBlock * pagePerBlock - pagePerBlock + 1;
        this.endPage += -1;    // 0-based 보정
        this.startPage += -1;  // 0-based 보정
    }
}
```

#### MemoController — 페이징 적용

```java
@GetMapping("/list")
public void list_get(PageDTO pageDTO, Model model) {
    int pageNo = (pageDTO.getPageNo() != null) ? pageDTO.getPageNo() : 0;
    int amount = (pageDTO.getAmount() != null) ? pageDTO.getAmount() : 10;

    Pageable pageable = PageRequest.of(pageNo, amount, Sort.by("id").descending());
    Page<Memo> page = memoRepository.findAll(pageable);
    PageBlock pageBlock = new PageBlock(pageDTO, page);

    model.addAttribute("page", page);
    model.addAttribute("list", page.getContent());
    model.addAttribute("pageBlock", pageBlock);
}
```

---

### CRUD — JPA 방식 (vs JDBC 방식)

```java
// 등록 (INSERT)
Memo memo = Memo.builder()
        .text(dto.getText()).writer(dto.getWriter()).createAt(dto.getCreateAt()).build();
memoRepository.save(memo);          // id=null이면 INSERT

// 조회 (SELECT ONE)
Optional<Memo> memo = memoRepository.findById(id);
if (memo.isPresent()) model.addAttribute("dto", memo.get());

// 수정 (UPDATE)
Memo memo = Memo.builder()
        .id(dto.getId())            // id가 있으면 UPDATE
        .text(dto.getText()).writer(dto.getWriter()).createAt(dto.getCreateAt()).build();
memoRepository.save(memo);

// 삭제 (DELETE)
memoRepository.deleteById(id);
```

> `save(entity)` — id가 null이면 INSERT, id가 있으면 UPDATE (merge)

---

### 관계 매핑 실습 — ExBoard(1) : ExReply(N)

#### ExBoard.java — 게시글 (부모, "1" 쪽)

```java
@Data @NoArgsConstructor @AllArgsConstructor @Builder
@Entity @Table(name = "ex_board")
public class ExBoard {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 200, nullable = false)
    private String title;

    @Column(length = 2000)
    private String content;
}
```

#### ExReply.java — 댓글 (자식, "N" 쪽)

```java
@Data @NoArgsConstructor @AllArgsConstructor @Builder
@Entity @Table(name = "ex_reply")
public class ExReply {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 1000, nullable = false)
    private String content;

    // N(ExReply) : 1(ExBoard) — ex_reply 테이블에 board_id FK 컬럼 생성
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "board_id",
        foreignKey = @ForeignKey(
            name = "board_id FK",
            foreignKeyDefinition = "FOREIGN KEY (board_id) REFERENCES ex_board(id) ON DELETE CASCADE ON UPDATE CASCADE"
        )
    )
    private ExBoard board;
}
```

#### ExReplyRepository — 관계 기반 쿼리 메서드

```java
@Repository
public interface ExReplyRepository extends JpaRepository<ExReply, Long> {
    // board.id로 댓글 목록 조회 (연관 객체 필드 탐색: 언더스코어(_) 사용)
    List<ExReply> findByBoard_Id(Long boardId);
}
```

#### ExRelController — 게시글/댓글 CRUD

```java
@Controller @Slf4j @RequestMapping("/exrel")
public class ExRelController {

    @Autowired private ExBoardRepository exBoardRepository;
    @Autowired private ExReplyRepository exReplyRepository;

    // 게시글 목록 + 선택 게시글의 댓글 목록
    @GetMapping("/board")
    public String page(@RequestParam(required = false) Long boardId, Model model) {
        model.addAttribute("boards", exBoardRepository.findAll());
        if (boardId != null) {
            model.addAttribute("board", exBoardRepository.findById(boardId).orElse(null));
            model.addAttribute("replies", exReplyRepository.findByBoard_Id(boardId));
        }
        return "exrel/board";
    }

    // 게시글 등록
    @PostMapping("/board")
    public String addBoard(@RequestParam String title, @RequestParam String content,
                           RedirectAttributes redirectAttributes) {
        exBoardRepository.save(ExBoard.builder().title(title).content(content).build());
        redirectAttributes.addFlashAttribute("msg", "게시글 등록!");
        return "redirect:/exrel/board";
    }

    // 댓글 등록 — 게시글(FK) 연결
    @PostMapping("/reply")
    public String addReply(@RequestParam Long boardId, @RequestParam String content,
                           RedirectAttributes redirectAttributes) {
        ExBoard board = exBoardRepository.findById(boardId).orElseThrow();
        exReplyRepository.save(ExReply.builder().content(content).board(board).build());
        redirectAttributes.addFlashAttribute("msg", "댓글 등록!");
        return "redirect:/exrel/board?boardId=" + boardId;
    }
}
```

---

### Lend 테스트 — LAZY 로딩과 `@Transactional`

```java
@Test
@Transactional   // LAZY 연관 객체 접근은 트랜잭션 안에서만 가능
void t3() {
    System.out.println("1 start-----------");
    Lend lend = lendRepository.findById(1L).get();   // Lend 쿼리만 실행
    System.out.println("1 end-----------");

    System.out.println("2 start-----------");
    System.out.println(lend.getUser().getUsername()); // 이 시점에 User 쿼리 실행
    System.out.println("2 end-----------");

    System.out.println("3 start-----------");
    System.out.println(lend.getBook().getBookName()); // 이 시점에 Book 쿼리 실행
    System.out.println("3 end-----------");
}
```

> `FetchType.LAZY` — 연관 객체(`user`, `book`)는 실제 필드에 접근하는 시점에 SELECT 쿼리가 나감.  
> 트랜잭션 없이 LAZY 접근 시 `LazyInitializationException` 발생 → `@Transactional` 필수.

---

### JDBC vs MyBatis vs JPA 비교

| 항목 | JDBC (07) | MyBatis (08) | JPA (09) |
|---|---|---|---|
| SQL 작성 | 직접 작성 | 직접 작성 (어노테이션/XML) | 자동 생성 |
| 매핑 | 수동 (`rs.getString(...)`) | `@Results` / resultMap | 자동 (필드명 = 컬럼명) |
| CRUD 코드량 | 많음 | 중간 | 적음 |
| 복잡한 쿼리 | 자유롭게 작성 | XML 동적 SQL | JPQL / `@Query` |
| 관계 매핑 | 직접 JOIN | 직접 JOIN | `@ManyToOne` 등 자동 |
| 페이징 | 직접 LIMIT 작성 | 직접 작성 | `Pageable` 자동 처리 |

---

### 핵심 정리

```
JPA 설정
  @Entity + @Table → 클래스를 테이블에 매핑
  @Id + @GeneratedValue(IDENTITY) → AUTO_INCREMENT PK
  @Column(length, nullable) → 컬럼 속성 지정
  spring.jpa.hibernate.ddl-auto=update → 테이블 자동 생성/변경

JpaRepository
  extends JpaRepository<엔티티타입, PK타입>
  → save/findById/findAll/deleteById/count 자동 제공
  → 명명 규칙 메서드: findByXxx, countByXxx, deleteByXxx

@Query (JPQL)
  엔티티 클래스명 / 필드명 기준 쿼리 작성
  위치 기반: ?1, ?2    이름 기반: :param + @Param("param")
  JOIN FETCH → LAZY 연관 객체 즉시 로딩 (N+1 방지)

관계 매핑
  @ManyToOne → FK 컬럼 생성, fetch=LAZY 권장
  @JoinColumn(name=FK컬럼명) → FK 컬럼명 지정
  findByBoard_Id → 연관 객체 필드 탐색 (언더스코어로 구분)

페이징
  PageRequest.of(pageNo, size, Sort) → Pageable 생성
  Page<T>.getContent() → 현재 페이지 데이터
  Page<T>.getTotalPages() / getTotalElements() → 전체 정보
```

---

## 10_TX — Spring Transaction (JPA)

> 09_ORM_JPA 에서 **트랜잭션 수동 설정**을 추가한 버전.  
> `DataSourceConfig` · `JPAConfig` · `TxConfig` 를 Java Config 로 직접 구성하고,  
> `@Transactional` 의 롤백 동작을 `addMemo()` vs `addMemoTx()` 비교로 실습.

### build.gradle 변경점 (09 → 10)

```groovy
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.x'
    id 'io.spring.dependency-management' version '1.1.7'
    id 'org.jetbrains.kotlin.jvm'                           // ← 추가
    id "org.jetbrains.kotlin.plugin.jpa" version '2.3.21'   // ← 추가
    id "org.jetbrains.kotlin.plugin.spring" version '2.3.21'// ← 추가
}

dependencies {
    // 09와 동일 (thymeleaf, web, lombok, mysql, jdbc, data-jpa, validation, test)
    implementation 'org.springframework.boot:spring-boot-devtools'  // ← 추가
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk8"        // ← 추가
    implementation "org.jetbrains.kotlin:kotlin-stdlib"             // ← 추가
}
```

---

### 프로젝트 구조

```
src/main/java/com/example/demo/
├── Config/
│   ├── DataSourceConfig.java   # HikariCP DataSource 수동 빈 등록
│   ├── JPAConfig.java          # EntityManagerFactory 수동 구성
│   └── TxConfig.java           # JpaTransactionManager 빈 등록
└── Domain/Common/
    └── Service/
        ├── MemoService.java        # 인터페이스
        ├── MemoServiceImpl.java    # @Transactional 적용 구현체
        └── TxTestService.java      # 트랜잭션 비교 실습 (롤백 테스트)
```

---

### Config 클래스 3종

#### DataSourceConfig.java — HikariCP 수동 등록

```java
@Configuration
public class DataSourceConfig {
    @Bean
    public DataSource dataSource() {
        HikariDataSource ds = new HikariDataSource();
        ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
        ds.setJdbcUrl("jdbc:mysql://localhost:3306/testdb");
        ds.setUsername("root");
        ds.setPassword("1234");
        return ds;
    }
}
```

#### JPAConfig.java — EntityManagerFactory 수동 구성

```java
@Configuration
@EntityScan(basePackages = {"com.example.demo.Domain.Common.Entity"})
@EnableJpaRepositories(basePackages = {"com.example.demo.Domain.Common.Repository"})
public class JPAConfig {
    @Autowired
    private DataSource dataSource;

    @Bean
    LocalContainerEntityManagerFactoryBean entityManagerFactory() {
        LocalContainerEntityManagerFactoryBean emf = new LocalContainerEntityManagerFactoryBean();
        emf.setDataSource(dataSource);
        emf.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        emf.setPackagesToScan("com.example.demo.Domain.Common.Entity");

        Map<String, Object> props = new HashMap<>();
        props.put("hibernate.hbm2ddl.auto", "update");
        props.put("hibernate.show_sql", true);
        emf.setJpaPropertyMap(props);
        return emf;
    }
}
```

#### TxConfig.java — JpaTransactionManager

```java
@Configuration
@EnableTransactionManagement
public class TxConfig {
    @Autowired
    private DataSource dataSource;

    @Bean(name = "jpaTransactionManager")
    public JpaTransactionManager jpaTransactionManager(EntityManagerFactory emf) {
        JpaTransactionManager tm = new JpaTransactionManager();
        tm.setEntityManagerFactory(emf);
        tm.setDataSource(dataSource);
        return tm;
    }
}
```

---

### 트랜잭션 롤백 비교 — TxTestService

```java
@Service
@Slf4j
public class TxTestService {
    @Autowired
    private MemoRepository memoRepository;

    // 트랜잭션 없음 → 3건 INSERT 후 예외 발생해도 이미 커밋된 3건은 남음
    public void addMemo() throws Exception {
        Memo memo = Memo.builder().text("addMemoTx...").writer("a@a.com")
                        .createAt(LocalDateTime.now()).build();
        memoRepository.save(memo);
        memo.setId(null); memoRepository.save(memo);
        memo.setId(null); memoRepository.save(memo);
        memo.setId(null);
        throw new SQLException();   // 예외 발생 → DB에는 3건 남아 있음
    }

    // @Transactional(rollbackFor) → 예외 발생 시 3건 모두 롤백
    @Transactional(rollbackFor = SQLException.class,
                   transactionManager = "jpaTransactionManager")
    public void addMemoTx() throws Exception {
        Memo memo = Memo.builder().text("addMemoTx...").writer("a@a.com")
                        .createAt(LocalDateTime.now()).build();
        memoRepository.save(memo);
        memo.setId(null); memoRepository.save(memo);
        memo.setId(null); memoRepository.save(memo);
        memo.setId(null);
        throw new SQLException();   // 트랜잭션 롤백 → DB에 0건
    }
}
```

| 메서드 | `@Transactional` | 예외 발생 시 결과 |
|---|---|---|
| `addMemo()` | 없음 | 3건 DB에 남음 (부분 커밋) |
| `addMemoTx()` | `rollbackFor = SQLException.class` | 전체 롤백 (0건) |

---

### MemoServiceImpl — 서비스 전체에 @Transactional 적용

```java
@Service
public class MemoServiceImpl implements MemoService {
    @Autowired
    private MemoRepository memoRepository;

    @Override
    @Transactional(rollbackFor = SQLException.class,
                   transactionManager = "jpaTransactionManager")
    public boolean memoRegistration(MemoDTO memoDTO) throws Exception {
        memoDTO.setCreateAt(LocalDateTime.now());
        memoRepository.save(memoDTO.toEntity());
        return true;
    }

    @Override
    @Transactional(rollbackFor = SQLException.class,
                   transactionManager = "jpaTransactionManager")
    public Map<String, Object> getMemoList(PageDTO pageDTO) throws Exception {
        // PageRequest.of + memoRepository.findAll(pageable) → Page<Memo>
        // PageBlock 계산 후 page/pageBlock/list 를 Map 으로 반환
        ...
    }
    // updateMemo / memoDelete / getMemo 도 동일 어노테이션 적용
}
```

---

### 핵심 정리

```
트랜잭션 수동 설정 흐름
  DataSourceConfig → DataSource(HikariCP)
  JPAConfig       → EntityManagerFactory (Hibernate)
  TxConfig        → JpaTransactionManager (빈 이름: "jpaTransactionManager")

@Transactional 속성
  rollbackFor = SQLException.class   → checked 예외도 롤백
  transactionManager = "빈이름"     → 여러 TM 사용 시 명시 필요

롤백 조건
  RuntimeException → 기본 롤백
  CheckedException → 기본 커밋 → rollbackFor 로 명시해야 롤백
```

---

## 11_RESTCONTROLLER — @RestController + Jackson + 비동기 요청

> 10_TX 구조 그대로 유지. Jackson 의존성 추가. `RestTest1Controller`, `Memo_addRest_Controller` + XHR/Fetch/Ajax/Axios 뷰 템플릿 추가.

### build.gradle 변경점 (10_TX → 11_RESTCONTROLLER)

```groovy
dependencies {
    // 10_TX와 동일 (thymeleaf, web, lombok, mysql, data-jpa, validation, test)

    //RESTCONTROLLER  ← 추가
    implementation 'com.fasterxml.jackson.core:jackson-databind'
    implementation 'com.fasterxml.jackson.core:jackson-core'
    implementation 'com.fasterxml.jackson.core:jackson-annotations'
    implementation 'com.fasterxml.jackson.datatype:jackson-datatype-jsr310'   // Java 8 날짜/시간 타입 직렬화
    implementation 'com.fasterxml.jackson.dataformat:jackson-dataformat-xml'  // XML 직렬화 지원
}
```

> Spring Boot는 기본적으로 `jackson-databind`를 내장하지만, XML 응답(`APPLICATION_XML_VALUE`)과  
> `LocalDateTime` 직렬화(`jsr310`)를 쓰려면 위 의존성을 명시적으로 추가해야 함.

---

### 프로젝트 구조

```
src/main/java/com/example/demo/
├── Config/
│   ├── DataSourceConfig.java    # HikariCP (10_TX와 동일)
│   ├── JPAConfig.java           # EntityManagerFactory (10_TX와 동일)
│   └── TxConfig.java            # JpaTransactionManager (10_TX와 동일)
├── Controller/
│   ├── RestTest1Controller.java      # @RestController 기본 실습  ← 추가
│   └── Memo_addRest_Controller.java  # 기존 MemoController + REST 엔드포인트  ← 추가
└── Domain/Common/
    ├── Entity/  Memo, Book, User, Lend, ex/ExBoard, ex/ExReply
    ├── Repository/  MemoRepository, BookRepository, UserRepository, LendRepository, ex/
    ├── Service/
    │   ├── MemoService.java         # 인터페이스
    │   ├── MemoServiceImpl.java     # @Transactional CRUD
    │   └── TxTestService.java       # 롤백 테스트 (10_TX와 동일)
    └── Dtos/  MemoDTO, PageDTO, PageBlock, BookDTO

src/main/resources/templates/
├── memo/
│   ├── add.html   list.html   update.html   error.html
│   └── rest/
│       ├── xhr.html      # XMLHttpRequest 비동기 요청 실습  ← 추가
│       ├── fetch.html    # Fetch API 실습  ← 추가 (스켈레톤)
│       ├── ajax.html     # jQuery Ajax 실습  ← 추가 (스켈레톤)
│       └── axios.html    # Axios 실습  ← 추가 (스켈레톤)
└── exrel/  board.html article.html
```

---

### `@RestController` vs `@Controller`

| 항목 | `@Controller` | `@RestController` |
|------|--------------|-------------------|
| 구성 | `@Controller` 단독 | `@Controller` + `@ResponseBody` 합본 |
| 반환값 처리 | ViewResolver에 전달 (뷰 이름 반환) | 객체를 직접 HTTP 응답 바디로 직렬화 |
| 응답 포맷 | HTML (JSP/Thymeleaf 렌더링) | JSON / XML / TEXT 등 |
| 주 용도 | 페이지 렌더링 MVC | REST API |

> `@RestController` 클래스의 모든 메서드에 `@ResponseBody`가 자동 적용된 것과 같음.

---

### RestTest1Controller — `@RestController` 기본 실습

```java
@RestController
@Slf4j
@RequestMapping("/rest")
public class RestTest1Controller {

    // TEXT 응답
    @GetMapping(value="/getText", produces = MediaType.TEXT_PLAIN_VALUE)
    public String t1(){
        return "HELLOWORLD";   // "HELLOWORLD" 문자열 그대로 응답
    }

    // JSON 응답 — 객체 자동 직렬화
    @GetMapping(value="/getJson", produces = MediaType.APPLICATION_JSON_VALUE)
    public MemoDTO t2(){
        return new MemoDTO(1L,"title1","text1","a@a.com", LocalDateTime.now());
    }

    // XML 응답 — jackson-dataformat-xml 필요
    @GetMapping(value="/getXml", produces = MediaType.APPLICATION_XML_VALUE)
    public MemoDTO t3(){
        return new MemoDTO(1L,"title1","text1","a@a.com", LocalDateTime.now());
    }

    // List → JSON 배열
    @GetMapping(value="/getListJson", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<MemoDTO> t4(){
        List<MemoDTO> list = new ArrayList<>();
        for(long i=0; i<10; i++)
            list.add(new MemoDTO(i,"t"+i,"t"+i,"w"+i, LocalDateTime.now()));
        return list;
    }

    // List → XML
    @GetMapping(value="/getListXml", produces = MediaType.APPLICATION_XML_VALUE)
    public List<MemoDTO> t5(){
        ...
    }

    // ResponseEntity — 상태코드를 직접 제어
    @GetMapping(value="/getListJson2/{show}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<MemoDTO>> t6(@PathVariable("show") boolean show){
        List<MemoDTO> list = ...;
        if(show)
            return ResponseEntity.status(HttpStatus.OK).body(list);        // 200
        else
            return new ResponseEntity<>(null, HttpStatus.BAD_GATEWAY);    // 502
    }
}
```

---

### `produces` / `consumes` — MediaType 지정

| 속성 | 의미 |
|------|------|
| `produces` | 서버가 **응답**할 Content-Type 지정 |
| `consumes` | 서버가 **수신**할 요청의 Content-Type 지정 |

```java
// 클라이언트가 JSON을 보낼 때(consumes)만 매핑, 응답은 JSON(produces)
@PostMapping(
    value = "/rest/add",
    consumes = MediaType.APPLICATION_JSON_VALUE,
    produces = MediaType.APPLICATION_JSON_VALUE
)
```

#### 주요 MediaType 상수

| 상수 | 값 |
|------|----|
| `MediaType.TEXT_PLAIN_VALUE` | `"text/plain"` |
| `MediaType.APPLICATION_JSON_VALUE` | `"application/json"` |
| `MediaType.APPLICATION_XML_VALUE` | `"application/xml"` |

---

### `ResponseEntity<T>` — 상태코드 + 헤더 + 바디 제어

```java
// 방법 1: 생성자
return new ResponseEntity<>(body, HttpStatus.OK);       // 200
return new ResponseEntity<>(null, HttpStatus.BAD_GATEWAY); // 502

// 방법 2: 빌더 (권장)
return ResponseEntity.status(HttpStatus.OK).body(list);
return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(responseMap);
```

> `@RestController` 메서드에서 `ResponseEntity<T>`를 반환하면 상태코드까지 직접 지정 가능.  
> 단순 객체 반환 시 자동으로 200 OK.

---

### `@ResponseBody` — `@Controller`에서 REST 응답

```java
@Controller
@RequestMapping("/memo")
public class Memo_addRest_Controller {

    // 뷰 렌더링 대신 JSON 응답 반환 (기존 @Controller에서 REST 엔드포인트 추가할 때 사용)
    @ResponseBody
    @GetMapping(
        value = "/rest/list",
        consumes = MediaType.APPLICATION_JSON_VALUE,
        produces = MediaType.APPLICATION_JSON_VALUE
    )
    public ResponseEntity<Map<String,Object>> rest_list_get(PageDTO pageDTO, Model model) throws Exception {
        Map<String,Object> responseMap = new HashMap<>();
        Map<String,Object> r = memoService.getMemoList(pageDTO);
        responseMap.put("page", r.get("page"));
        responseMap.put("list", r.get("list"));
        responseMap.put("pageBlock", r.get("pageBlock"));
        return ResponseEntity.status(HttpStatus.OK).body(responseMap);
    }

    @ResponseBody
    @PostMapping(
        value = "/rest/add",
        consumes = MediaType.APPLICATION_JSON_VALUE,
        produces = MediaType.APPLICATION_JSON_VALUE
    )
    public ResponseEntity<Map<String,Object>> memoAddPost_rest(
            @RequestBody @Valid MemoDTO memoDTO,
            BindingResult bindingResult, ...) throws Exception {

        Map<String,Object> responseMap = new HashMap<>();

        // 유효성 오류 → 400 BAD_REQUEST + 오류 맵 반환
        if(bindingResult.hasErrors()){
            for(FieldError error : bindingResult.getFieldErrors())
                responseMap.put(error.getField(), error.getDefaultMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(responseMap);
        }

        // 정상 처리 → 200 OK + 메시지 반환
        memoService.memoRegistration(memoDTO);
        responseMap.put("message","메모추가 성공!");
        return ResponseEntity.status(HttpStatus.OK).body(responseMap);
    }
}
```

> `@Controller` + `@ResponseBody` 메서드 = `@RestController` 메서드와 동일 동작.  
> 기존 MVC 컨트롤러에 REST 엔드포인트를 추가할 때 `@ResponseBody`를 메서드 단위로 붙임.

---

### MemoDTO — `toEntity()` / `from()` 변환 메서드

```java
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemoDTO {
    private Long id;

    @NotBlank(message = "TITLE 는 필수 항목입니다.")
    private String title;

    @NotBlank(message = "WRITER 는 필수 항목입니다.")
    @Email(message="example@example.com 형식으로 입력하세요")
    private String writer;

    @NotBlank(message = "TEXT 는 필수 항목입니다.")
    private String text;

    private LocalDateTime createAt;

    // DTO → Entity 변환
    public Memo toEntity(){
        return Memo.builder()
                .title(this.title).id(this.id).writer(this.writer)
                .text(this.text).createAt(this.createAt).build();
    }

    // Entity → DTO 변환 (정적 팩토리)
    public static MemoDTO from(Memo memo){
        return MemoDTO.builder()
                .id(memo.getId()).title(memo.getTitle()).writer(memo.getWriter())
                .text(memo.getText()).createAt(memo.getCreateAt()).build();
    }
}
```

> `toEntity()` / `from()` 패턴 — DTO ↔ Entity 변환 책임을 DTO 클래스 내부에 캡슐화.  
> Service 레이어에서 `memoDTO.toEntity()`, `MemoDTO.from(entity)` 로 사용.

---

### PageDTO — 페이징 + 검색 파라미터

```java
@Data @AllArgsConstructor
public class PageDTO {
    private Integer pageNo;    // 현재 페이지 (0-based)
    private Integer amount;    // 페이지당 건수
    private String keyword;    // 검색어 (REST 요청 시 확장)
    private String type;       // 검색 타입
}
```

---

### 비동기 요청 방식 비교 (`/memo/rest/` 뷰 페이지)

컨트롤러에서 뷰 이름만 반환하고, 실제 REST 호출은 클라이언트 JavaScript가 처리.

```java
@GetMapping("/rest/xhr")   public String restIndex_xhr()   { return "memo/rest/xhr"; }
@GetMapping("/rest/fetch") public String restIndex_fetch() { return "memo/rest/fetch"; }
@GetMapping("/rest/ajax")  public String restIndex_ajax()  { return "memo/rest/ajax"; }
@GetMapping("/rest/axios") public String restIndex_axios() { return "memo/rest/axios"; }
```

---

### XHR (XMLHttpRequest) — `xhr.html`

```javascript
// LIST (GET)
function getList() {
    const pageNo = document.formList.pageNo.value;
    const amount = document.formList.amount.value;

    var httpRequest = new XMLHttpRequest();
    httpRequest.onreadystatechange = function() {
        if (httpRequest.readyState == XMLHttpRequest.DONE && httpRequest.status == 200) {
            const data = JSON.parse(httpRequest.responseText);
            console.log("list",     data.list);
            console.log("pageBlock",data.pageBlock);
            console.log("page",     data.page);
        }
    };
    httpRequest.open("GET", `/memo/rest/list?pageNo=${pageNo}&amount=${amount}`, true);
    httpRequest.setRequestHeader("Content-Type","application/json");
    httpRequest.send();
}

// ADD (POST + JSON body)
function addMemo() {
    const formAdd = document.formAdd;
    const body = {
        title:  formAdd.title.value,
        text:   formAdd.text.value,
        writer: formAdd.writer.value
    };
    const jsonBody = JSON.stringify(body);

    var httpRequest = new XMLHttpRequest();
    httpRequest.onreadystatechange = function() {
        if (httpRequest.readyState == XMLHttpRequest.DONE && httpRequest.status == 200) {
            const data = JSON.parse(httpRequest.responseText);
            console.log("data", data);
        }
    };
    httpRequest.open("POST", `/memo/rest/add`, true);
    httpRequest.setRequestHeader("Content-Type","application/json");
    httpRequest.send(jsonBody);   // JSON 문자열을 body로 전송
}
```

#### XHR 핵심 API

| 단계 | 코드 | 설명 |
|------|------|------|
| 생성 | `new XMLHttpRequest()` | XHR 객체 생성 |
| 콜백 | `.onreadystatechange` | 상태 변화 시 실행할 함수 |
| 완료 확인 | `readyState == DONE && status == 200` | 요청 완료 + 성공 |
| 설정 | `.open(method, url, async)` | 메서드·URL·비동기 여부 설정 |
| 헤더 | `.setRequestHeader("Content-Type","application/json")` | Content-Type 지정 |
| 전송 | `.send()` / `.send(jsonBody)` | 요청 전송 (GET: 인수 없음, POST: body) |
| 응답 | `JSON.parse(httpRequest.responseText)` | 응답 문자열 → JS 객체 |

---

### 비동기 요청 방식 4종 비교

| 방식 | 특징 | 상태 |
|------|------|------|
| **XHR** (XMLHttpRequest) | 브라우저 내장, 콜백 기반, 저수준 API | `xhr.html` 구현됨 |
| **Fetch API** | ES6+ 내장, Promise 기반, 간결한 문법 | `fetch.html` 스켈레톤 |
| **jQuery Ajax** | jQuery 라이브러리, `$.ajax()` / `$.get()` / `$.post()` | `ajax.html` 스켈레톤 |
| **Axios** | 외부 라이브러리, Promise 기반, 자동 JSON 변환 | `axios.html` 스켈레톤 |

---

### REST API 엔드포인트 목록

| 메서드 | URL | 응답 | 설명 |
|--------|-----|------|------|
| GET | `/rest/getText` | `text/plain` | 문자열 반환 |
| GET | `/rest/getJson` | `application/json` | MemoDTO 단건 JSON |
| GET | `/rest/getXml` | `application/xml` | MemoDTO 단건 XML |
| GET | `/rest/getListJson` | `application/json` | MemoDTO 목록 JSON |
| GET | `/rest/getListXml` | `application/xml` | MemoDTO 목록 XML |
| GET | `/rest/getListJson2/{show}` | `application/json` | ResponseEntity (상태코드 분기) |
| GET | `/memo/rest/list` | `application/json` | 페이징 목록 (XHR 연동) |
| POST | `/memo/rest/add` | `application/json` | 메모 등록 + 유효성 검증 |

---

### MemoService 인터페이스 → ServiceImpl 흐름

```
Controller (REST)
    ↓ @ResponseBody + ResponseEntity
MemoService (인터페이스)
    ↓ @Transactional(rollbackFor, transactionManager="jpaTransactionManager")
MemoServiceImpl
    ↓ memoRepository.save() / findById() / deleteById() / findAll(pageable)
MemoRepository extends JpaRepository<Memo, Long>
    ↓ Hibernate (JPA)
MySQL DB
```

---

### 핵심 정리

```
@RestController
  = @Controller + @ResponseBody 자동 적용
  → 반환 객체를 HTTP 바디로 직렬화 (Jackson이 JSON/XML 변환)

produces / consumes
  produces → 응답 Content-Type 지정
  consumes → 허용하는 요청 Content-Type 지정

ResponseEntity<T>
  상태코드 + 바디를 동시에 제어
  ResponseEntity.status(HttpStatus.OK).body(data)
  new ResponseEntity<>(data, HttpStatus.BAD_REQUEST)

@ResponseBody (메서드 단위)
  @Controller 내 특정 메서드에만 REST 응답 적용
  @RequestBody → JSON 요청 바디를 DTO로 역직렬화

Jackson 의존성
  jackson-databind / core / annotations  → JSON 직렬화
  jackson-datatype-jsr310               → LocalDateTime 등 Java 8 날짜 타입
  jackson-dataformat-xml                → XML 직렬화

XHR 흐름
  new XMLHttpRequest()
  → .open(method, url, async)
  → .setRequestHeader("Content-Type","application/json")
  → .send([JSON.stringify(body)])
  → onreadystatechange: readyState==DONE && status==200
  → JSON.parse(responseText)
```

---

## 10_TX_MYBATIS — Spring Transaction (MyBatis)

> 08_SQLMAPPER_MYBATIS 에서 **트랜잭션** + **Product 실습 도메인** + **동적 SQL 확장**을 추가.  
> `DataSourceTransactionManager` 로 MyBatis 트랜잭션을 관리하며,  
> `ProductMapper`/`ProductDAO` 로 어노테이션 CRUD + XML 동적 SQL(`<where>/<if>/<foreach>`)을 실습.

### build.gradle 변경점 (08 → 10_TX_MYBATIS)

```groovy
dependencies {
    // 08과 동일 (thymeleaf, web, lombok, mysql, jdbc, mybatis, validation, test)
    implementation 'org.springframework.boot:spring-boot-devtools'  // ← 추가
    // commons-dbcp2 제거됨 (주석 처리)
}
```

---

### 프로젝트 구조

```
src/main/java/com/example/demo/
├── Config/
│   ├── DataSourceConfig.java   # HikariCP DataSource
│   ├── MybatisConfig.java      # SqlSessionFactory + SqlSessionTemplate
│   └── TxConfig.java           # DataSourceTransactionManager
├── Controller/
│   ├── MemoController.java
│   └── ProductController.java  # ← 추가 (Product 실습)
└── Domain/Common/
    ├── Daos/
    │   ├── MemoDAO.java
    │   └── ProductDAO.java     # ← 추가
    ├── Dtos/
    │   ├── MemoDTO.java
    │   └── ProductDTO.java     # ← 추가 (id, pname, price, stock)
    ├── Mapper/
    │   ├── MemoMapper.java     # 기존 + XML 동적 SQL 확장
    │   └── ProductMapper.java  # ← 추가 (어노테이션 + XML)
    └── Service/
        └── TxTestService.java  # DataSourceTransactionManager 롤백 테스트

src/main/resources/mapper/
    ├── MemoMapper.xml          # 동적 SQL (if/choose/foreach)
    └── ProductMapper.xml       # selectAllXML, searchXML (동적 SQL)
```

---

### Config 클래스 3종

#### MybatisConfig.java

```java
@Configuration
public class MybatisConfig {
    @Autowired
    private DataSource dataSource;

    @Bean
    public SqlSessionFactory sqlSessionFactory() throws Exception {
        SqlSessionFactoryBean sf = new SqlSessionFactoryBean();
        sf.setDataSource(dataSource);
        Resource[] resources =
            new PathMatchingResourcePatternResolver()
                .getResources("classpath*:mapper/*.xml");
        sf.setMapperLocations(resources);
        return sf.getObject();
    }

    @Bean
    public SqlSessionTemplate sqlSessionTemplate() throws Exception {
        return new SqlSessionTemplate(sqlSessionFactory());
    }
}
```

#### TxConfig.java — DataSourceTransactionManager

```java
@Configuration
@EnableTransactionManagement
public class TxConfig {
    @Autowired
    private DataSource dataSource;

    @Bean(name = "dataSourceTransactionManager")
    public DataSourceTransactionManager transactionManager() {
        return new DataSourceTransactionManager(dataSource);
    }
}
```

---

### Product 실습 도메인

#### ProductDTO.java

```java
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ProductDTO {
    private Long id;
    @NotBlank(message = "상품명은 필수 항목입니다.")
    private String pname;
    @NotNull(message = "가격은 필수 항목입니다.")
    private Integer price;
    @NotNull(message = "재고는 필수 항목입니다.")
    private Integer stock;
}
```

#### ProductMapper.java — 어노테이션 CRUD + XML 위임

```java
@Mapper
public interface ProductMapper {
    @Insert("insert into tbl_product values(#{id},#{pname},#{price},#{stock})")
    int insert(ProductDTO dto);

    @Select("select * from tbl_product")
    List<ProductDTO> selectAll();

    @Select("select * from tbl_product where id=#{id}")
    ProductDTO selectOne(Long id);

    @Update("update tbl_product set pname=#{pname},price=#{price},stock=#{stock} where id=#{id}")
    int update(ProductDTO dto);

    @Delete("delete from tbl_product where id=#{id}")
    int delete(Long id);

    // XML 위임 메서드
    List<ProductDTO> selectAllXML();                           // [EX04]
    List<Map<String, Object>> searchXML(Map<String, Object> param); // [EX05] 동적 SQL
}
```

#### ProductMapper.xml — 동적 SQL

```xml
<mapper namespace="com.example.demo.Domain.Common.Mapper.ProductMapper">

    <!-- EX04: XML 전체 조회 -->
    <select id="selectAllXML" resultType="com.example.demo.Domain.Common.Dtos.ProductDTO">
        select * from tbl_product
    </select>

    <!-- EX05: 동적 검색 (keyword=상품명 LIKE, minStock=재고 이상) -->
    <select id="searchXML" resultType="java.util.Map" parameterType="java.util.Map">
        select * from tbl_product
        <where>
            <if test="keyword != null and keyword != ''">
                pname like concat('%', #{keyword}, '%')
            </if>
            <if test="minStock != null">
                and stock &gt;= #{minStock}
            </if>
        </where>
    </select>

</mapper>
```

#### ProductDAO.java — Mapper 래핑 DAO

```java
@Repository @Slf4j
public class ProductDAO {
    @Autowired
    private ProductMapper productMapper;

    public int insert(ProductDTO dto)            { return productMapper.insert(dto); }
    public List<ProductDTO> selectAll()          { return productMapper.selectAllXML(); }
    public ProductDTO selectOne(Long id)         { return productMapper.selectOne(id); }
    public int update(ProductDTO dto)            { return productMapper.update(dto); }
    public int delete(Long id)                   { return productMapper.delete(id); }

    public List<Map<String, Object>> search(String keyword, Integer minStock) {
        Map<String, Object> param = new HashMap<>();
        param.put("keyword", keyword);
        param.put("minStock", minStock);
        return productMapper.searchXML(param);
    }
}
```

---

### MemoMapper.xml — 동적 SQL 확장

```xml
<!-- if: 단일 조건 -->
<select id="selectAllIfXML" resultType="java.util.Map" parameterType="java.util.Map">
    select * from tbl_memo
    <if test="type!=null and type.equals('text')">
        where text like concat('%',#{keyword},'%')
    </if>
</select>

<!-- choose/when/otherwise: switch 문 역할 -->
<select id="selectAllChooseXML" resultType="java.util.Map" parameterType="java.util.Map">
    select * from tbl_memo
    <where>
        <if test="field != null">
            <choose>
                <when test="type == 'id'">   id like concat('%',#{keyword},'%') </when>
                <when test="type == 'text'"> text like concat('%',#{keyword},'%') </when>
                <otherwise>                 writer like concat('%',#{keyword},'%') </otherwise>
            </choose>
        </if>
    </where>
</select>

<!-- foreach: 복수 필드 AND 검색 -->
<select id="selectForEachAnd" parameterType="java.util.Map" resultType="java.util.Map">
    SELECT * FROM tbl_memo
    <where>
        <if test="fields != null and keyword != null">
            <foreach collection="fields" item="f" separator="AND">
                <choose>
                    <when test="f == 'id'">   id LIKE CONCAT('%', #{keyword}, '%') </when>
                    <when test="f == 'text'"> text LIKE CONCAT('%', #{keyword}, '%') </when>
                    <when test="f == 'writer'"> writer LIKE CONCAT('%', #{keyword}, '%') </when>
                </choose>
            </foreach>
        </if>
    </where>
</select>
```

---

### 트랜잭션 롤백 비교 — TxTestService (MyBatis)

```java
@Service @Slf4j
public class TxTestService {
    @Autowired
    private MemoMapper memoMapper;

    // 트랜잭션 없음 → 3건 INSERT 후 예외 발생해도 DB에 남음
    public void addMemo() throws Exception {
        MemoDTO memo = MemoDTO.builder().text("addMemoTx...").writer("a@a.com")
                             .createAt(LocalDateTime.now()).build();
        memoMapper.insert(memo);
        memo.setId(null); memoMapper.insert(memo);
        memo.setId(null); memoMapper.insert(memo);
        memo.setId(null);
        throw new SQLException();
    }

    // @Transactional → 예외 발생 시 전체 롤백
    @Transactional(rollbackFor = SQLException.class,
                   transactionManager = "dataSourceTransactionManager")
    public void addMemoTx() throws Exception {
        MemoDTO memo = MemoDTO.builder().text("addMemoTx...").writer("a@a.com")
                             .createAt(LocalDateTime.now()).build();
        memoMapper.insert(memo);
        memo.setId(null); memoMapper.insert(memo);
        memo.setId(null); memoMapper.insert(memo);
        memo.setId(null);
        throw new SQLException();   // 롤백 → 0건
    }
}
```

---

### JPA vs MyBatis 트랜잭션 비교

| 항목 | 10_TX (JPA) | 10_TX_MYBATIS (MyBatis) |
|---|---|---|
| TransactionManager | `JpaTransactionManager` | `DataSourceTransactionManager` |
| 빈 이름 | `"jpaTransactionManager"` | `"dataSourceTransactionManager"` |
| Config | `JPAConfig` + `TxConfig` | `MybatisConfig` + `TxConfig` |
| 데이터 접근 | `JpaRepository.save()` | `@Mapper` / XML |
| 어노테이션 | `@Transactional(transactionManager="jpaTransactionManager")` | `@Transactional(transactionManager="dataSourceTransactionManager")` |

---

### 핵심 정리

```
트랜잭션 공통 패턴
  1. DataSourceConfig  → DataSource(HikariCP) 빈
  2. ORM Config        → EntityManagerFactory(JPA) 또는 SqlSessionFactory(MyBatis)
  3. TxConfig          → TransactionManager 빈 (이름 지정 필수)
  4. Service 메서드    → @Transactional(rollbackFor=..., transactionManager="빈이름")

동적 SQL (MyBatis XML)
  <if>         → 단일 조건 분기
  <where>      → 앞의 AND/OR 자동 제거
  <choose>     → switch/when/otherwise
  <foreach>    → 컬렉션 반복 (separator="AND"/"," 등)

ProductDAO 패턴
  Controller → ProductDAO → ProductMapper(@Mapper) → XML
  DAO 는 Mapper 를 감싸는 계층 (로깅, 파라미터 조합 등 처리)
```

---

## 11_RESTCONTROLLER — REST API + 비동기 클라이언트 (XHR / Fetch / Axios / jQuery)

> 10_TX 구조 위에 `@RestController`, `ResponseEntity`, `@CrossOrigin`, 비동기 클라이언트 4종 추가.

### 새로 추가된 구조

```
src/main/java/com/example/demo/
└── Controller/
    ├── RestTest1Controller.java           # /rest/**  produces 실습 (Text/JSON/XML/List/ResponseEntity)
    ├── RestTest2Controller.java           # /api/items/**  메모리 기반 CRUD REST API
    └── Memo_addRest_Controller_cors.java  # /memo/**  JPA + REST + @CrossOrigin

src/main/resources/templates/memo/rest/
├── index.html    # 뷰 링크 모음 (비어있음)
├── xhr.html      # XMLHttpRequest 방식 CRUD
├── fetch.html    # Fetch API 방식 CRUD
├── axios.html    # Axios 방식 CRUD
└── jquery.html   # jQuery $.ajax 방식 CRUD
```

---

### `@Controller` vs `@RestController`

| | `@Controller` | `@RestController` |
|---|---|---|
| 반환 | 뷰 이름 (JSP/Thymeleaf) | 객체 → JSON/XML 직렬화 |
| `@ResponseBody` | 메서드마다 붙여야 함 | 클래스 전체에 자동 적용 |
| 주 용도 | 서버 사이드 렌더링(SSR) | REST API, 비동기 통신 |

> `@RestController` = `@Controller` + `@ResponseBody` 합본

---

### RestTest1Controller — `produces` / `ResponseEntity` 기초

```java
@RestController
@RequestMapping("/rest")
public class RestTest1Controller {

    // TEXT 반환
    @GetMapping(value="/getText", produces = MediaType.TEXT_PLAIN_VALUE)
    public String t1() { return "HELLOWORLD"; }

    // JSON 반환 (객체 → 자동 직렬화)
    @GetMapping(value="/getJson", produces = MediaType.APPLICATION_JSON_VALUE)
    public MemoDTO t2() {
        return new MemoDTO(1L,"title1","text1","a@a.com", LocalDateTime.now());
    }

    // XML 반환
    @GetMapping(value="/getXml", produces = MediaType.APPLICATION_XML_VALUE)
    public MemoDTO t3() { ... }

    // List → JSON 배열
    @GetMapping(value="/getListJson", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<MemoDTO> t4() { ... }

    // ResponseEntity — 상태코드 직접 제어
    @GetMapping(value="/getListJson2/{show}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<MemoDTO>> t6(@PathVariable boolean show) {
        if (show)
            return ResponseEntity.status(HttpStatus.OK).body(list);   // 200
        else
            return new ResponseEntity<>(null, HttpStatus.BAD_GATEWAY); // 502
    }
}
```

#### `produces` vs `consumes`

| 속성 | 방향 | 설명 |
|------|------|------|
| `produces` | 서버 → 클라이언트 | 서버가 반환하는 Content-Type |
| `consumes` | 클라이언트 → 서버 | 서버가 수신할 수 있는 Content-Type |

#### `ResponseEntity` 생성 방법

```java
// 방법 1: 정적 팩토리
ResponseEntity.ok(body)                         // 200 OK
ResponseEntity.status(HttpStatus.CREATED).body(body)  // 201
ResponseEntity.notFound().build()               // 404 (body 없음)
ResponseEntity.noContent().build()              // 204

// 방법 2: 생성자
new ResponseEntity<>(body, HttpStatus.OK)
new ResponseEntity<>(null, HttpStatus.BAD_GATEWAY)
```

---

### RestTest2Controller — 메모리 기반 CRUD REST API

```java
@RestController
@RequestMapping("/api/items")
public class RestTest2Controller {

    private final Map<Long, ItemResponse> store = new ConcurrentHashMap<>();
    private long seq = 1L;

    // GET /api/items?q=keyword  (목록 + 간단 검색)
    @GetMapping
    public ResponseEntity<List<ItemResponse>> list(@RequestParam(required = false) String q) { ... }

    // GET /api/items/{id}  (단건)
    @GetMapping("/{id}")
    public ResponseEntity<ItemResponse> get(@PathVariable Long id) { ... }

    // POST /api/items  (생성)
    @PostMapping
    public ResponseEntity<ItemResponse> create(@RequestBody ItemRequest req) { ... }

    // PUT /api/items/{id}  (전체 수정)
    @PutMapping("/{id}")
    public ResponseEntity<ItemResponse> update(@PathVariable Long id, @RequestBody ItemRequest req) { ... }

    // PATCH /api/items/{id}  (부분 수정)
    @PatchMapping("/{id}")
    public ResponseEntity<ItemResponse> patch(@PathVariable Long id, @RequestBody Map<String, Object> patch) { ... }

    // DELETE /api/items/{id}
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        ItemResponse removed = store.remove(id);
        if (removed == null) return ResponseEntity.notFound().build();
        return ResponseEntity.noContent().build();  // 204
    }
}
```

#### REST HTTP 메서드 매핑 어노테이션

| 어노테이션 | HTTP 메서드 | 주 용도 |
|---|---|---|
| `@GetMapping` | GET | 조회 |
| `@PostMapping` | POST | 생성 |
| `@PutMapping` | PUT | 전체 수정 |
| `@PatchMapping` | PATCH | 부분 수정 |
| `@DeleteMapping` | DELETE | 삭제 |

---

### Memo REST Controller — `@CrossOrigin` + JPA 연동

```java
@Controller
@RequestMapping("/memo")
@CrossOrigin(
    originPatterns = {
        "http://192.168.10.*:[*]",
        "http://localhost:[*]"
    },
    allowCredentials = "false",   // TOKEN 기반: false / SESSION 기반: true
    allowedHeaders = {"Content-Type","application/json"},
    methods = {RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE}
)
public class Memo_addRest_Controller_cors {

    @Autowired private MemoService memoService;

    // 뷰 핸들러 (Thymeleaf 템플릿으로 이동)
    @GetMapping("/rest/xhr")    public String restIndex_xhr()   { return "memo/rest/xhr"; }
    @GetMapping("/rest/fetch")  public String restIndex_fetch() { return "memo/rest/fetch"; }
    @GetMapping("/rest/jquery") public String restIndex_ajax()  { return "memo/rest/jquery"; }
    @GetMapping("/rest/axios")  public String restIndex_axios() { return "memo/rest/axios"; }

    // REST API 핸들러 — @ResponseBody 로 JSON 반환 (@Controller 안에서 부분적으로 사용)
    @ResponseBody
    @GetMapping(value="/rest/list",
                consumes = MediaType.APPLICATION_JSON_VALUE,
                produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String,Object>> rest_list_get(PageDTO pageDTO) throws Exception {
        Map<String,Object> r = memoService.getMemoList(pageDTO);
        Map<String,Object> responseMap = new HashMap<>();
        responseMap.put("page",      r.get("page"));
        responseMap.put("list",      r.get("list"));
        responseMap.put("pageBlock", r.get("pageBlock"));
        return ResponseEntity.status(HttpStatus.OK).body(responseMap);
    }

    @ResponseBody
    @PostMapping(value="/rest/add",
                 consumes = MediaType.APPLICATION_JSON_VALUE,
                 produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String,Object>> memoAddPost_rest(
            @RequestBody @Valid MemoDTO memoDTO, BindingResult bindingResult) throws Exception {
        Map<String,Object> responseMap = new HashMap<>();
        if (bindingResult.hasErrors()) {
            for (FieldError e : bindingResult.getFieldErrors())
                responseMap.put(e.getField(), e.getDefaultMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(responseMap);
        }
        memoService.memoRegistration(memoDTO);
        responseMap.put("message","메모추가 성공!");
        return ResponseEntity.status(HttpStatus.OK).body(responseMap);
    }

    @ResponseBody
    @PutMapping(value="/rest/update",
                consumes = MediaType.APPLICATION_JSON_VALUE,
                produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String,Object>> memoUpdatePut_rest(
            @RequestBody @Valid MemoDTO memoDTO, BindingResult bindingResult) throws Exception { ... }

    @ResponseBody
    @DeleteMapping(value="/rest/delete",
                   consumes = MediaType.APPLICATION_JSON_VALUE,
                   produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String,Object>> memoDelete_rest(@RequestBody MemoDTO dto) throws Exception {
        memoService.removeMemo(dto.getId());
        Map<String,Object> responseMap = new HashMap<>();
        responseMap.put("message","메모삭제 성공!");
        return ResponseEntity.status(HttpStatus.OK).body(responseMap);
    }
}
```

#### REST 핸들러 패턴 (1→2→3→4)

```
1. 파라미터 받기   @RequestBody @Valid DTO, BindingResult
2. 유효성 검증    bindingResult.hasErrors() → 400 BAD_REQUEST + 오류 Map
3. 서비스 실행    memoService.xxx()
4. 응답 반환     ResponseEntity.ok(responseMap)  /  ResponseEntity.status(xxx).body(...)
```

---

### `@CrossOrigin` — CORS 설정

```java
@CrossOrigin(
    originPatterns = {"http://localhost:[*]", "http://192.168.10.*:[*]"},
    allowCredentials = "false",    // JWT/Token 기반이면 false
    allowedHeaders = {"Content-Type","application/json"},
    methods = {RequestMethod.GET, RequestMethod.POST, ...}
)
```

| 속성 | 설명 |
|------|------|
| `origins` | 허용 출처 정확히 지정 (`http://localhost:5500`) |
| `originPatterns` | 와일드카드 패턴 허용 (`http://localhost:[*]`) |
| `allowCredentials` | 쿠키/세션 포함 여부. SESSION이면 `true`, TOKEN이면 `false` |
| `allowedHeaders` | 허용할 요청 헤더 |
| `methods` | 허용할 HTTP 메서드 |

> `origins={"*"}` + `allowCredentials="true"` 조합은 불가 (브라우저 보안 정책)  
> 와일드카드 출처 허용 시 `originPatterns` 사용

---

### 비동기 클라이언트 4종 비교

#### 공통 요청 구조 (LIST / ADD / UPDATE / DELETE)

모든 요청은 `Content-Type: application/json` 헤더 + JSON body 사용.

| 엔드포인트 | 메서드 | Body |
|------------|--------|------|
| `/memo/rest/list?pageNo=0&amount=10` | GET | — |
| `/memo/rest/add` | POST | `{title, text, writer}` |
| `/memo/rest/update` | PUT | `{id, title, text, writer}` |
| `/memo/rest/delete` | DELETE | `{id}` |

---

#### XHR (XMLHttpRequest) — xhr.html

```javascript
// LIST
function getList() {
    var httpRequest = new XMLHttpRequest();
    httpRequest.onreadystatechange = function() {
        if (httpRequest.readyState == XMLHttpRequest.DONE && httpRequest.status == 200) {
            const data = JSON.parse(httpRequest.responseText);
            console.log("list", data.list);
            console.log("pageBlock", data.pageBlock);
        }
    };
    httpRequest.open("GET", `/memo/rest/list?pageNo=${pageNo}&amount=${amount}`, true);
    httpRequest.setRequestHeader("Content-Type", "application/json");
    httpRequest.send();
}

// ADD / UPDATE / DELETE — body 전송 방식
httpRequest.open("POST", `/memo/rest/add`, true);
httpRequest.setRequestHeader("Content-Type", "application/json");
httpRequest.send(jsonBody);   // JSON.stringify({title,text,writer})
```

> 가장 원시적인 방식. `readyState == 4(DONE)` && `status == 200` 체크 필수.  
> `JSON.parse(httpRequest.responseText)` 로 수동 파싱.

---

#### Fetch API — fetch.html

```javascript
// LIST
async function getList() {
    const opt = { method: "GET", headers: {"Content-Type": "application/json"} };
    const response = await fetch(`/memo/rest/list?pageNo=${pageNo}&amount=${amount}`, opt);
    const data = await response.json();   // 자동 JSON 파싱
    console.log(data);
}

// ADD
async function addMemo() {
    const body = { title, text, writer };
    const opt = {
        method: "POST",
        headers: {"Content-Type": "application/json"},
        body: JSON.stringify(body)
    };
    const response = await fetch(`/memo/rest/add`, opt);
    const data = await response.json();
    console.log(data);
}

// DELETE — body 포함
const opt = {
    method: "DELETE",
    headers: {"Content-Type": "application/json"},
    body: JSON.stringify({id})
};
const response = await fetch(`/memo/rest/delete`, opt);
```

> `async/await` 기반. `response.json()`으로 바로 파싱.  
> XHR보다 간결하고 Promise 체이닝 가능.

---

#### Axios — axios.html

```html
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
```

```javascript
// LIST — .get()
axios.get(`/memo/rest/list?pageNo=${pageNo}&amount=${amount}`,
          { headers: {"Content-Type": "application/json"}, data: {} })
     .then(resp => { console.log(resp); })
     .catch(error => { console.log(error); });

// ADD — .post(url, body, config)
axios.post(`/memo/rest/add`, jsonBody, { headers: {"Content-Type": "application/json"} })
     .then(resp => { console.log(resp); });

// UPDATE — .put()
axios.put(`/memo/rest/update`, jsonBody, { headers: {"Content-Type": "application/json"} })
     .then(resp => { console.log(resp); });

// DELETE — .delete(url, config) — body는 config의 data에 넣어야 함
axios.delete(`/memo/rest/delete`,
             { headers: {"Content-Type": "application/json"}, data: jsonBody })
     .then(resp => { console.log(resp); });
```

> Axios DELETE는 `axios.delete(url, { data: body })` 형태로 body를 전달해야 함.  
> 자동 JSON 직렬화 / 역직렬화 지원.

---

#### jQuery $.ajax — jquery.html

```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
```

```javascript
// LIST
$.ajax({
    url: `/memo/rest/list?pageNo=${pageNo}&amount=${amount}`,
    method: "GET",
    contentType: "application/json",
    dataType: "json",
    success: function(data) { console.log(data); },
    error: function(xhr, status, error) { console.log(error); }
});

// ADD
$.ajax({
    url: `/memo/rest/add`,
    method: "POST",
    contentType: "application/json",
    dataType: "json",
    data: jsonBody,           // JSON.stringify({title,text,writer})
    success: function(data) { console.log(data); },
    error: function(xhr, status, error) { console.log(error); }
});

// DELETE — data에 jsonBody 그대로
$.ajax({ url:`/memo/rest/delete`, method:"DELETE", contentType:"application/json",
         dataType:"json", data:jsonBody, success:..., error:... });
```

> `contentType` → 서버로 보내는 타입.  
> `dataType` → 서버에서 받을 타입 (자동 파싱).  
> `success` / `error` 콜백으로 결과 처리.

---

### 4종 비교 정리

| | XHR | Fetch | Axios | jQuery $.ajax |
|---|---|---|---|---|
| 방식 | 콜백 | async/await | Promise/.then | 콜백 |
| JSON 파싱 | 수동 (`JSON.parse`) | `response.json()` | 자동 | `dataType:"json"` |
| DELETE body | `send(jsonBody)` | `body: jsonBody` | `{ data: jsonBody }` | `data: jsonBody` |
| 오류 처리 | `status` 직접 체크 | `response.ok` 체크 | `.catch()` | `error:` 콜백 |
| CDN 필요 | 없음 | 없음 | 필요 | 필요 |
| 코드량 | 많음 | 보통 | 적음 | 보통 |

---

### MemoService — JPA 페이징 처리

```java
@Service
public class MemoServiceImpl implements MemoService {

    @Autowired private MemoRepository memoRepository;

    // 등록
    @Transactional(rollbackFor = SQLException.class, transactionManager = "jpaTransactionManager")
    public boolean memoRegistration(MemoDTO dto) throws Exception {
        dto.setCreateAt(LocalDateTime.now());
        memoRepository.save(dto.toEntity());   // DTO → Entity 변환 후 저장
        return true;
    }

    // 목록 + 페이징
    @Transactional(transactionManager = "jpaTransactionManager")
    public Map<String,Object> getMemoList(PageDTO pageDTO) throws Exception {
        Pageable pageable = PageRequest.of(
            pageDTO.getPageNo(), pageDTO.getAmount(),
            Sort.by("id").descending()
        );
        Page<Memo> page = memoRepository.findAll(pageable);
        PageBlock pageBlock = new PageBlock(pageDTO, page);

        Map<String,Object> result = new HashMap<>();
        result.put("page",      page);
        result.put("list",      page.getContent());
        result.put("pageBlock", pageBlock);
        return result;
    }

    // 단건 조회
    public MemoDTO getMemo(Long id) throws Exception {
        Optional<Memo> opt = memoRepository.findById(id);
        return opt.map(MemoDTO::from).orElse(null);
    }

    // 수정 / 삭제
    public boolean updateMemo(MemoDTO dto) throws Exception { memoRepository.save(dto.toEntity()); return true; }
    public boolean removeMemo(Long id) throws Exception { memoRepository.deleteById(id); return true; }
}
```

#### MemoDTO — Entity 변환 메서드

```java
// DTO → Entity
public Memo toEntity() {
    return Memo.builder().id(id).title(title).writer(writer).text(text).createAt(createAt).build();
}

// Entity → DTO (정적 팩토리)
public static MemoDTO from(Memo memo) {
    return MemoDTO.builder()
        .id(memo.getId()).title(memo.getTitle())
        .writer(memo.getWriter()).text(memo.getText())
        .createAt(memo.getCreateAt()).build();
}
```

---

### 전체 흐름 요약

```
브라우저 (xhr.html / fetch.html / axios.html / jquery.html)
    │  JSON 요청 (Content-Type: application/json)
    ▼
Memo_addRest_Controller_cors  (@Controller + @ResponseBody)
    │  @CrossOrigin 허용 체크
    │  @RequestBody → MemoDTO 역직렬화
    │  @Valid + BindingResult → 유효성 검증
    │  실패 → 400 + 오류 Map
    ▼
MemoServiceImpl  (@Service)
    │  @Transactional(transactionManager="jpaTransactionManager")
    ▼
MemoRepository  (JpaRepository)
    │  findAll(Pageable) / save() / findById() / deleteById()
    ▼
DB (memo 테이블)

응답: ResponseEntity<Map<String,Object>>  →  JSON → 브라우저 콘솔
```

---

### 핵심 정리

```
@RestController     = @Controller + @ResponseBody (클래스 전체 JSON 반환)
@ResponseBody       = @Controller 안에서 특정 메서드만 JSON 반환
ResponseEntity<T>   = HTTP 상태코드 + body 직접 제어
produces/consumes   = 반환/수신 Content-Type 지정

@CrossOrigin        = CORS 허용 (클래스 또는 메서드 레벨)
allowCredentials    = SESSION 기반: true / TOKEN 기반: false

REST 비동기 클라이언트
  XHR    → readyState + status 콜백, JSON.parse() 수동
  Fetch  → async/await, response.json() 자동
  Axios  → .get/.post/.put/.delete(), DELETE body는 { data: ... }
  jQuery → $.ajax({ method, contentType, dataType, data, success, error })
```

---

## 12_RESTFULAPI — 외부API연동 (RestTemplate으로 공공/민간 API 호출)

> `RestTemplate` + `UriComponentsBuilder` 조합으로 외부 REST API를 호출하는 패턴.  
> 공공데이터포털(data.go.kr) API 3종 + OpenWeatherMap API 1종 실습.

---

### 핵심 도구

| 클래스 | 역할 |
|--------|------|
| `RestTemplate` | HTTP 요청 실행 클라이언트 |
| `UriComponentsBuilder` | URL + 쿼리파라미터 조립 (인코딩 자동 처리) |
| `ResponseEntity<T>` | HTTP 응답 전체 (상태코드 + 헤더 + body) |

#### 기본 패턴

```java
// 1. URL + 쿼리파라미터 조립
URI uri = UriComponentsBuilder.fromHttpUrl(server)
        .queryParam("key", value)
        .encode()       // URL 인코딩 (serviceKey 특수문자 등)
        .build()
        .toUri();

// 2. 요청 실행 — 응답 body를 Root.class로 역직렬화
RestTemplate restTemplate = new RestTemplate();
ResponseEntity<Root> response =
        restTemplate.exchange(uri, HttpMethod.GET, null, Root.class);

// 3. 응답 처리
System.out.println(response.getBody());
```

> `restTemplate.exchange(uri, 메서드, 요청엔티티, 응답타입)`  
> 요청 헤더/바디가 없으면 3번째 인자 `null` 전달.  
> 응답 JSON이 `Root.class` 구조와 일치하면 Jackson이 자동 역직렬화.

---

### C01OpenData — 공공데이터포털 API

#### 공통 구조

```
패키지: com.example.demo.외부API연동.C01OpenData
URL 기반: https://apis.data.go.kr/...
인증: serviceKey (URL 인코딩 필수)
```

---

#### OpenData_01 — 기상청 초단기 실황 조회

```
GET /Open/Weather
외부 API: https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst
```

```java
@RestController
@RequestMapping("Open/Weather")
public class OpenData_01_Controller {

    private String server = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst";
    private String serviceKey = "";
    private String base_date = "20260609";
    private String base_time = "1430";
    private String nx = "89";   // 격자 X
    private String ny = "90";   // 격자 Y

    @GetMapping
    public void get() {
        URI uri = UriComponentsBuilder.fromHttpUrl(server)
                .queryParam("serviceKey", serviceKey)
                .queryParam("pageNo", "1")
                .queryParam("numOfRows", "1000")
                .queryParam("dataType", "JSON")
                .queryParam("base_date", base_date)
                .queryParam("base_time", base_time)
                .queryParam("nx", nx)
                .queryParam("ny", ny)
                .encode().build().toUri();

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Root> response =
                restTemplate.exchange(uri, HttpMethod.GET, null, Root.class);
        System.out.println(response.getBody());
    }
}
```

**응답 DTO 구조 (Static Inner Class)**

```java
@Data private static class Root     { public Response response; }
@Data private static class Response { public Header header; public Body body; }
@Data private static class Header   { public String resultCode; public String resultMsg; }
@Data private static class Body     {
    public String dataType;
    public Items items;
    public int pageNo, numOfRows, totalCount;
}
@Data private static class Items    { public ArrayList<Item> item; }
@Data private static class Item     {
    public String baseDate, baseTime, category, obsrValue;
    public int nx, ny;
}
```

> `category` 값 예시: `T1H`(기온), `RN1`(1시간 강수량), `WSD`(풍속), `REH`(습도) 등

---

#### OpenData_02 — 대구 시내버스 실시간 도착 정보

```
GET /Open/Bus/{bsId}/{routeNo}
외부 API: https://apis.data.go.kr/6270000/dbmsapi02/getRealtime02
참고: 대구광역시 시내버스 노선 정보 https://www.data.go.kr/data/15156114/fileData.do
```

```java
@RestController
@RequestMapping("/Open/Bus")
public class OpenData_02_Controller {

    private String server = "https://apis.data.go.kr/6270000/dbmsapi02/getRealtime02";
    private String serviceKey = "";

    @GetMapping("/{bsId}/{routeNo}")
    public void get(
            @PathVariable(required = false) String bsId,    // 정류소ID (예: 7001001600)
            @PathVariable(required = false) String routeNo  // 버스번호 (예: 649)
    ) {
        URI uri = UriComponentsBuilder.fromHttpUrl(server)
                .queryParam("serviceKey", serviceKey)
                .queryParam("bsId", bsId)
                .queryParam("routeNo", routeNo)
                .encode().build().toUri();

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Root> response =
                restTemplate.exchange(uri, HttpMethod.GET, null, Root.class);
        System.out.println(response.getBody());
    }
}
```

**응답 DTO 구조**

```java
@Data private static class Root    { public Header header; public Body body; }
@Data private static class Header  { public boolean success; public String resultCode, resultMsg; }
@Data private static class Body    { public ArrayList<Item> items; public int totalCount; }
@Data private static class Item    { public String routeNo; public ArrayList<ArrList> arrList; }
@Data private static class ArrList {
    public String routeId, routeNo, moveDir, bsNm, vhcNo2;
    public String busTCd2, busTCd3, busAreaCd, arrState;
    public int bsGap, prevBsGap, arrTime;
}
```

> `@PathVariable(required = false)` — 경로 변수를 선택적으로 받음.  
> `arrTime` (초 단위 도착 예정 시간), `arrState` (도착 상태 문자열)

---

#### OpenData_03 — 대구광역시 사건사고 정보

```
GET /Open/DgIncident
외부 API: https://apis.data.go.kr/6270000/service/rest/dgincident
```

```java
@RestController
@RequestMapping("/Open/DgIncident")
public class OpenData_03_Controller {

    private String server = "https://apis.data.go.kr/6270000/service/rest/dgincident";
    private String serviceKey = "";

    @GetMapping
    public void t1() {
        URI uri = UriComponentsBuilder.fromHttpUrl(server)
                .queryParam("serviceKey", serviceKey)
                .queryParam("pageNo", "1")
                .queryParam("numOfRows", "10")
                .encode().build().toUri();

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response =        // DTO 없이 String으로 원문 수신
                restTemplate.exchange(uri, HttpMethod.GET, null, String.class);
        System.out.println(response.getBody());
    }
}
```

> 응답 타입을 `String.class`로 지정하면 역직렬화 없이 JSON 원문 그대로 받음.  
> 응답 구조가 불명확하거나 파싱 전 확인이 필요할 때 사용하는 방식.

---

### C02OpenWeatherMap — OpenWeatherMap API

```
패키지: com.example.demo.외부API연동.C02OpenWeatherMap
외부 API: https://api.openweathermap.org/data/2.5/weather
인증: appid (query param)
```

```java
@Controller
@RequestMapping("/OpenWeather")
public class OpenWeatherMapController {

    private String server = "https://api.openweathermap.org/data/2.5/weather";
    private String appid = "";

    // 뷰 페이지 반환 (JSP/Thymeleaf)
    @GetMapping("/index")
    public String page() {
        return "OpenWeather/index";
    }

    // 실제 API 호출 — @ResponseBody + @CrossOrigin
    @ResponseBody
    @CrossOrigin(originPatterns = "*")
    @GetMapping("/{lat}/{lon}")
    public ResponseEntity<Map<String, Object>> t1(
            @PathVariable String lat,
            @PathVariable String lon
    ) {
        URI uri = UriComponentsBuilder.fromHttpUrl(server)
                .queryParam("appid", appid)
                .queryParam("lat", lat)
                .queryParam("lon", lon)
                .encode().build().toUri();

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Root> response =
                restTemplate.exchange(uri, HttpMethod.GET, null, Root.class);

        // 필요한 필드만 추출해서 반환
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("weather", response.getBody().getWeather());
        responseData.put("main",    response.getBody().getMain());
        responseData.put("wind",    response.getBody().getWind());
        return ResponseEntity.status(HttpStatus.OK).body(responseData);
    }
}
```

**응답 DTO 구조**

```java
@Data private static class Root {
    public Coord coord;
    public ArrayList<Weather> weather;
    public String base;
    public Main main;
    public int visibility, dt, timezone, id, cod;
    public Wind wind;
    public Clouds clouds;
    public Sys sys;
    public String name;
}
@Data private static class Coord   { public int lon, lat; }
@Data private static class Weather { public int id; public String main, description, icon; }
@Data private static class Main    {
    public double temp, feels_like, temp_min, temp_max;
    public int pressure, humidity, sea_level, grnd_level;
}
@Data private static class Wind    { public double speed, gust; public int deg; }
@Data private static class Clouds  { public int all; }
@Data private static class Sys     { public String country; public int sunrise, sunset; }
```

**포인트**

- `@Controller` (RestController 아님) + 특정 메서드만 `@ResponseBody` — 뷰 반환과 JSON 반환 혼용
- 응답 전체 대신 필요한 필드(`weather`, `main`, `wind`)만 `Map`에 담아 반환
- `@CrossOrigin(originPatterns = "*")` — 프론트엔드 fetch/axios 호출 허용

---

### OpenData vs OpenWeatherMap 비교

| 항목 | C01OpenData | C02OpenWeatherMap |
|------|-------------|-------------------|
| 컨트롤러 타입 | `@RestController` | `@Controller` + `@ResponseBody` |
| 인증 방식 | `serviceKey` (공공데이터포털) | `appid` (OpenWeatherMap) |
| 응답 처리 | `Root.class` 역직렬화 or `String` 원문 | `Root.class` 역직렬화 후 필요 필드 추출 |
| CORS | 미설정 | `@CrossOrigin(originPatterns = "*")` |
| 동적 파라미터 | `@PathVariable` (버스 API) | `@PathVariable` (위경도) |

---

### 핵심 정리

```
외부 API 호출 3단계
  1. UriComponentsBuilder로 URL + 쿼리파라미터 조립 (.encode() 필수)
  2. RestTemplate.exchange(uri, HttpMethod.GET, null, 응답타입.class)
  3. response.getBody()로 역직렬화 결과 사용

응답 타입 선택
  구조 파악 완료  → 내부 static @Data 클래스로 역직렬화 (Root.class)
  구조 불명확     → String.class로 원문 수신 후 확인

serviceKey 주의사항
  .encode() 없이 빌드하면 특수문자(+, = 등) 포함 키가 이중 인코딩될 수 있음
  → UriComponentsBuilder 체인에서 .encode().build().toUri() 순서 준수
```

---

> 패키지: `com.example.demo.외부API연동.C03Kakao`  
> 뷰: `src/main/resources/templates/Kakao/`

### 전체 구조

```
C03Kakao/
├── C01KakaoMapController.java     # GET /Kakao/map — 카카오 지도
├── C02KakaoLoginController.java   # GET /Kakao/login ~ — 카카오 로그인 + 메시지 + 친구
├── C03KakaoChannelController.java # GET /Kakao/channel — 카카오 채널 추가
└── C04KakaoPayController.java     # GET /Kakao/pay — 카카오페이 결제

templates/Kakao/
├── map.html      # 카카오 지도 SDK — 키워드 장소 검색
├── main.html     # 로그인 후 프로필 + 로그아웃 버튼
└── channel.html  # 카카오채널 추가 버튼
```

---

### C01 — 카카오 지도 (`map.html`)

**컨트롤러** — `C01KakaoMapController.java`

```java
@Controller @Slf4j @RequestMapping("/Kakao")
public class C01KakaoMapController {

    @GetMapping("/map")
    public void main() {
        log.info("GET /kakao/map");
        // 반환 없음 → templates/Kakao/map.html
    }
}
```

**map.html 핵심**

```html
<!-- Kakao Maps SDK 로드 (appkey 필요) -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=&libraries=services"></script>
<script>
    var map = new kakao.maps.Map(mapContainer, {
        center: new kakao.maps.LatLng(37.566826, 126.9786567),
        level: 3
    });

    var ps = new kakao.maps.services.Places();   // 장소 검색 객체

    // 키워드 검색
    ps.keywordSearch(keyword, placesSearchCB);

    function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {
            displayPlaces(data);      // 마커 + 목록 표출
            displayPagination(pagination);
        }
    }
</script>
```

**기능 요약**

| 항목 | 내용 |
|------|------|
| SDK 로드 | `dapi.kakao.com/v2/maps/sdk.js?appkey=...&libraries=services` |
| 지도 생성 | `new kakao.maps.Map(container, options)` |
| 장소 검색 | `kakao.maps.services.Places().keywordSearch()` |
| 마커 | 스프라이트 이미지 번호 마커 (`marker_number_blue.png`) |
| 페이지네이션 | `pagination.gotoPage(i)` 로 결과 페이지 이동 |
| 인포윈도우 | 마커 mouseover/mouseout 이벤트로 장소명 표시/숨김 |

---

### C02 — 카카오 로그인 (OAuth 2.0)

**컨트롤러** — `C02KakaoLoginController.java`

#### 전체 엔드포인트

| 메서드 | 경로 | 역할 |
|--------|------|------|
| GET | `/Kakao/login` | 카카오 인가 코드 요청 (redirect → kakao) |
| GET | `/Kakao/callback` | 인가 코드 수신 → 액세스 토큰 교환 |
| GET | `/Kakao` | 사용자 프로필 조회 → main.html 렌더링 |
| GET | `/Kakao/logout1` | 서비스에서만 로그아웃 (`/v1/user/logout`) |
| GET | `/Kakao/logout2` | 카카오 연결 해제 (`/v1/user/unlink`) |
| GET | `/Kakao/logout3` | 카카오 계정과 함께 로그아웃 (redirect → kakao) |
| GET | `/Kakao/getMessageCode` | 메시지·친구 권한 추가 인가 (`scope=talk_message,friends`) |
| GET | `/Kakao/message/me/{message}` | 나에게 카카오톡 메시지 전송 |
| GET | `/Kakao/message/friends/{message}` | 친구 전체에게 카카오톡 메시지 전송 |
| GET | `/Kakao/friends` | 카카오 친구 목록 조회 |

#### 로그인 흐름

```
1. GET /Kakao/login
   └─ redirect: kauth.kakao.com/oauth/authorize?client_id=...&response_type=code

2. GET /Kakao/callback?code=인가코드
   └─ POST kauth.kakao.com/oauth/token (code → access_token 교환)
   └─ KakaoTokenResponse 저장
   └─ redirect: /Kakao

3. GET /Kakao
   └─ GET kapi.kakao.com/v2/user/me (Authorization: Bearer access_token)
   └─ KakaoProfileResponse 저장 → Model에 담아 Kakao/main.html 렌더링
```

#### 토큰 교환 코드 패턴

```java
// 인가 코드 → 액세스 토큰
String url = "https://kauth.kakao.com/oauth/token";

MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
params.add("grant_type", "authorization_code");
params.add("client_id", CLIENT_ID);
params.add("redirect_uri", REDIRECT_URI);
params.add("code", code);

HttpHeaders header = new HttpHeaders();
header.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(params, header);
RestTemplate restTemplate = new RestTemplate();
ResponseEntity<KakaoTokenResponse> response =
        restTemplate.exchange(url, HttpMethod.POST, entity, KakaoTokenResponse.class);

this.kakaoTokenResponse = response.getBody();
```

#### 내부 DTO 클래스 (static inner class)

```java
@Data
private static class KakaoTokenResponse {
    public String access_token;
    public String token_type;
    public String refresh_token;
    public int expires_in;
    public String scope;
    public int refresh_token_expires_in;
}

@Data
private static class KakaoProfileResponse {
    public long id;
    public Date connected_at;
    public Properties properties;      // nickname, profile_image, thumbnail_image
    public KakaoAccount kakao_account; // email, profile{nickname, ...}
}

@Data
private static class KakaoFriendsResponse {
    public ArrayList<Element> elements;  // uuid, profile_nickname, ...
    public int total_count;
    public Object after_url;
    public int favorite_count;
}
```

#### 로그아웃 3가지 비교

| 방식 | 엔드포인트 | 효과 |
|------|-----------|------|
| `logout1` | `POST kapi.kakao.com/v1/user/logout` | 서비스 토큰만 만료, 카카오 계정 로그인 상태 유지 |
| `logout2` | `POST kapi.kakao.com/v1/user/unlink` | 앱 연결 해제 (재로그인 시 동의 화면 다시 표시) |
| `logout3` | `redirect kauth.kakao.com/oauth/logout` | 카카오 계정까지 함께 로그아웃 |

#### 메시지 전송 (나에게)

```java
// POST kapi.kakao.com/v2/api/talk/memo/default/send
JSONObject template_Object = new JSONObject();
template_Object.put("object_type", "text");
template_Object.put("text", message);
template_Object.put("link", new JSONObject());
template_Object.put("button_title", ".");

params.add("template_object", template_Object.toJSONString());
header.add("Authorization", "Bearer " + kakaoTokenResponse.getAccess_token());
```

#### 메시지 전송 (친구에게)

```java
// POST kapi.kakao.com/v1/api/talk/friends/message/default/send
// 친구 uuid 배열을 receiver_uuids로 전달
String[] uuids = kakaoFriendsResponse.getElements()
        .stream().map(el -> el.getUuid())
        .collect(Collectors.toList()).toArray(String[]::new);

JSONArray receiver_uuids = new JSONArray();
for (String uuid : uuids) receiver_uuids.add(uuid);

params.add("receiver_uuids", receiver_uuids);
params.add("template_object", template_Object.toJSONString());
```

**main.html 핵심**

```html
<a href="/Kakao/logout1">로그아웃</a> |
<a href="/Kakao/logout2">연결해제</a> |
<a href="/Kakao/logout3">카카오 계정과 함께 로그아웃</a>

<div th:text="${kakaoProfileResponse}"></div>
<div th:text="${kakaoProfileResponse.id}"></div>
<div th:text="${kakaoProfileResponse.connected_at}"></div>
<div th:text="${kakaoProfileResponse.properties}"></div>
```

---

### C03 — 카카오 채널 추가

**컨트롤러** — `C03KakaoChannelController.java`

```java
@Controller @Slf4j @RequestMapping("/Kakao/channel")
public class C03KakaoChannelController {

    @GetMapping
    public void channel() {
        log.info("GET /Kakao/channel...");
        // 반환 없음 → templates/Kakao/channel.html
    }
}
```

**channel.html**

```html
<!-- Kakao JS SDK 로드 -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/v1/kakao.min.js"></script>
<script>
    Kakao.init("앱 키");   // 앱 키 초기화

    Kakao.Channel.createAddChannelButton({
        container: "#kakao-add-channel-button",
        channelPublicId: "_YXNnX",   // 채널 홈 URL의 ID
    });
</script>
```

> 카카오채널 추가 버튼을 자바스크립트 SDK로 동적 생성. `channelPublicId`는 채널 홈 URL에서 확인.

---

### C04 — 카카오페이 결제 준비

**컨트롤러** — `C04KakaoPayController.java`

```java
@Controller @Slf4j @RequestMapping("/Kakao/pay")
public class C04KakaoPayController {

    private String SECRET_KEY = "";

    // 결제 준비 요청
    @GetMapping
    @ResponseBody
    public void req() {
        String url = "https://open-api.kakaopay.com/online/v1/payment/ready";

        HttpHeaders header = new HttpHeaders();
        header.add("Authorization", "SECRET_KEY " + SECRET_KEY);
        header.add("Content-Type", "application/json");

        JSONObject params = new JSONObject();
        params.put("cid",              "TC0ONETIME");          // 테스트용 CID
        params.put("partner_order_id", "shop_1111");
        params.put("partner_user_id",  "shop_p_1111");
        params.put("item_name",        "초코파이");
        params.put("quantity",         "1");
        params.put("total_amount",     "2200");
        params.put("tax_free_amount",  "200");
        params.put("approval_url",     "http://127.0.0.1:8080/Kakao/pay/success");
        params.put("cancel_url",       "http://127.0.0.1:8080/Kakao/pay/cancel");
        params.put("fail_url",         "http://127.0.0.1:8080/Kakao/pay/fail");

        HttpEntity<JSONObject> entity = new HttpEntity<>(params, header);
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response =
                restTemplate.exchange(url, HttpMethod.POST, entity, String.class);

        System.out.println(response.getBody());
    }

    @GetMapping("/success") @ResponseBody
    public void success() { log.info("GET /Kakao success... 결제성공후 이동되는 위치"); }

    @GetMapping("/cancel")  @ResponseBody
    public void cancel()  { log.info("GET /Kakao cancel... 결제취소후 이동되는 위치"); }

    @GetMapping("/fail")    @ResponseBody
    public void fail()    { log.info("GET /Kakao fail... 결제실패후 이동되는 위치"); }
}
```

**결제 준비 파라미터 정리**

| 파라미터 | 값 | 설명 |
|----------|----|------|
| `cid` | `TC0ONETIME` | 테스트용 가맹점 코드 (단건 결제) |
| `partner_order_id` | `shop_1111` | 가맹점 주문 번호 |
| `partner_user_id` | `shop_p_1111` | 가맹점 회원 ID |
| `item_name` | `초코파이` | 상품명 |
| `quantity` | `1` | 수량 |
| `total_amount` | `2200` | 총 결제 금액 (원) |
| `tax_free_amount` | `200` | 비과세 금액 |
| `approval_url` | `/Kakao/pay/success` | 결제 성공 후 리디렉션 URL |
| `cancel_url` | `/Kakao/pay/cancel` | 결제 취소 후 리디렉션 URL |
| `fail_url` | `/Kakao/pay/fail` | 결제 실패 후 리디렉션 URL |

> `Content-Type: application/json` → body를 `JSONObject`로 전달 (form-data 아님)  
> Authorization 헤더 형식: `SECRET_KEY {시크릿 키}` (Bearer 아님 — 카카오페이 전용)

---

### 카카오 API 전체 비교

| 컨트롤러 | 경로 | 인증 방식 | 사용 API |
|----------|------|-----------|----------|
| C01 카카오 지도 | `/Kakao/map` | JS SDK appkey | Maps SDK (프론트엔드) |
| C02 카카오 로그인 | `/Kakao/login~` | OAuth 2.0 (access_token) | kauth + kapi REST |
| C03 카카오 채널 | `/Kakao/channel` | JS SDK init key | Channel JS SDK (프론트엔드) |
| C04 카카오페이 | `/Kakao/pay` | SECRET_KEY | KakaoPay REST API |

### 카카오 API 공통 패턴

```
RestTemplate 사용 공통 흐름
  1. MultiValueMap 또는 JSONObject 로 params 구성
  2. HttpHeaders 에 Authorization + Content-Type 설정
  3. HttpEntity<파라미터타입> entity = new HttpEntity<>(params, header)
  4. restTemplate.exchange(url, HttpMethod.POST/GET, entity, 응답타입.class)
  5. response.getBody() 로 결과 처리

인증 헤더 형식
  카카오 로그인/메시지/친구  → "Bearer {access_token}"
  카카오페이                 → "SECRET_KEY {secret_key}"
```

---

## 12_RESTFULAPI — 외부 API 연동 C04 Naver

### 파일 구조

```
외부API연동/C04Naver/
├── NaverSearchController.java   # GET /Naver/search/book/{keyword} — 책 검색
└── NaverLoginController.java    # GET /Naver/login ~ — 네이버 로그인

templates/Naver/
└── main.html                    # 로그인 결과 페이지 (토큰 + 프로필 표시)
```

---

### NaverSearchController — 책 검색

**컨트롤러** — `NaverSearchController.java`

```java
@Slf4j
@Controller
@RequestMapping("/Naver/search")
public class NaverSearchController {

    private String CLIENT_ID = "";
    private String CLEINT_SECRET = "";

    @GetMapping("/book/{keyword}")
    @ResponseBody
    public String search(@PathVariable String keyword) {
        log.info("GET /Naver/search...{}", keyword);
        String url = "https://openapi.naver.com/v1/search/book.json?query=" + keyword;

        HttpHeaders header = new HttpHeaders();
        header.add("X-Naver-Client-Id", CLIENT_ID);
        header.add("X-Naver-Client-Secret", CLEINT_SECRET);

        HttpEntity entity = new HttpEntity<>(header);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response =
                restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

        return response.getBody();
    }
}
```

#### 요청 흐름

```
GET /Naver/search/book/{keyword}
    │
    ▼
X-Naver-Client-Id / X-Naver-Client-Secret 헤더 설정
    │
    ▼
https://openapi.naver.com/v1/search/book.json?query={keyword}
    │
    ▼
@ResponseBody → JSON 문자열 그대로 응답
```

> 네이버 검색 API는 헤더 인증 방식 (카카오의 Authorization Bearer 와 달리 `X-Naver-*` 헤더 사용)

---

### NaverLoginController — OAuth 2.0 로그인

**컨트롤러** — `NaverLoginController.java`

```java
@Controller
@Slf4j
@RequestMapping("/Naver")
public class NaverLoginController {

    private String CLIENT_ID = "";
    private String CLEINT_SECRET = "";
    private String CALLBACK_URL = "http://127.0.0.1:8080/Naver/callback";

    private NaverTokenResponse naverTokenResponse;
    private NaverProfileResponse naverProfileResponse;

    // 1단계: 네이버 로그인 페이지로 리다이렉트
    @GetMapping("/login")
    public String login() {
        return "redirect:https://nid.naver.com/oauth2.0/authorize"
                + "?response_type=code"
                + "&client_id=" + CLIENT_ID
                + "&state=STATE_STRING"
                + "&redirect_uri=" + CALLBACK_URL;
    }

    // 2단계: 인증 코드 수신 → access_token 교환
    @GetMapping("/callback")
    public String callback(String code, String state, String error, String error_description) {
        String url = "https://nid.naver.com/oauth2.0/token";

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", CLIENT_ID);
        params.add("client_secret", CLEINT_SECRET);
        params.add("code", code);
        params.add("state", state);

        HttpHeaders header = new HttpHeaders();
        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(params, header);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<NaverTokenResponse> response =
                restTemplate.exchange(url, HttpMethod.POST, entity, NaverTokenResponse.class);

        this.naverTokenResponse = response.getBody();
        return "redirect:/Naver";
    }

    // 3단계: access_token으로 프로필 조회
    @GetMapping
    public String main(Model model) {
        String url = "https://openapi.naver.com/v1/nid/me";

        HttpHeaders header = new HttpHeaders();
        header.add("Authorization", "Bearer " + naverTokenResponse.getAccess_token());
        HttpEntity entity = new HttpEntity(header);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<NaverProfileResponse> response =
                restTemplate.exchange(url, HttpMethod.POST, entity, NaverProfileResponse.class);

        this.naverProfileResponse = response.getBody();
        model.addAttribute("naverTokenResponse", naverTokenResponse);
        model.addAttribute("naverProfileResponse", naverProfileResponse);
        return "Naver/main";
    }

    // 4단계: 동기 로그아웃 (네이버 세션 + 앱 세션)
    @GetMapping("logout")
    public String logout() {
        return "redirect:https://nid.naver.com/nidlogin.logout"
                + "?returl=http://127.0.0.1:8080/Naver/login";
    }

    // 내부 DTO
    @Data
    private static class NaverTokenResponse {
        public String access_token;
        public String refresh_token;
        public String token_type;
        public String expires_in;
    }

    @Data
    private static class Profile {
        public String id;
        public String nickname;
        public String email;
        public String name;
    }

    @Data
    private static class NaverProfileResponse {
        public String resultcode;
        public String message;
        @JsonProperty(value = "response")
        public Profile profile;
    }
}
```

#### OAuth 2.0 로그인 전체 흐름

```
브라우저 GET /Naver/login
    │ redirect
    ▼
https://nid.naver.com/oauth2.0/authorize (네이버 로그인 페이지)
    │ 사용자 로그인 완료
    ▼
GET /Naver/callback?code=xxx&state=xxx
    │ code + state → POST https://nid.naver.com/oauth2.0/token
    ▼
NaverTokenResponse { access_token, refresh_token, ... } 저장
    │ redirect
    ▼
GET /Naver
    │ Authorization: Bearer {access_token} → POST https://openapi.naver.com/v1/nid/me
    ▼
NaverProfileResponse { resultcode, message, profile { id, nickname, email, name } }
    │
    ▼
Naver/main.html 렌더링
```

---

### 로그아웃 2가지 방식

#### 방식 1 — 동기 리다이렉트

```html
<a href="/Naver/logout">로그아웃(동기)</a>
```

```
GET /Naver/logout
    → redirect: https://nid.naver.com/nidlogin.logout?returl=http://127.0.0.1:8080/Naver/login
```

> 네이버 로그아웃 페이지로 이동 후 `returl`로 지정한 페이지로 돌아옴

#### 방식 2 — 팝업창 이용 (JS 비동기)

```html
<a href="javascript:requestNaverLogout()">로그아웃(팝업창이용)</a>
```

```javascript
async function requestNaverLogout() {
    // 10x10 팝업으로 네이버 로그아웃 페이지 열기
    const popup = window.open(
        "https://nid.naver.com/nidlogin.logout",
        "naverLogout",
        "width=10,height=10,left=0,top=0"
    );
    if (popup) { window.focus(); }

    // 2.5초 후 팝업 닫고 로그인 페이지로 이동
    setTimeout(function () {
        if (popup) popup.close();
        alert("로그아웃 완료");
        location.href = "Naver/login";
    }, 2500);
}
```

> 현재 페이지를 유지하면서 팝업으로 네이버 세션만 종료 → 팝업 닫힌 후 앱 내 로그인 페이지로 이동

---

### Naver/main.html — 결과 뷰

```html
<body>
    <h1>MAIN PAGE /Naver</h1>
    <a href="/Naver/logout">로그아웃(동기)</a> |
    <a href="javascript:requestNaverLogout()">로그아웃(팝업창이용)</a>

    <h2>naverTokenResponse</h2>
    <div th:text="${naverTokenResponse}"></div>

    <h2>naverProfileResponse</h2>
    <div th:text="${naverProfileResponse}"></div>
</body>
```

> Thymeleaf `th:text` 로 토큰 정보(`access_token`, `token_type` 등)와 프로필 정보(`id`, `nickname`, `email`, `name`) 출력

---

### 내부 DTO 구조

```
NaverTokenResponse
├── access_token   : String   — API 호출용 토큰
├── refresh_token  : String   — 갱신 토큰
├── token_type     : String   — "bearer"
└── expires_in     : String   — 유효 시간(초)

NaverProfileResponse
├── resultcode     : String   — "00" 성공
├── message        : String   — "success"
└── profile (Profile)
    ├── id         : String
    ├── nickname   : String
    ├── email      : String
    └── name       : String
```

> `@JsonProperty(value = "response")` — 네이버 API 응답의 `"response"` 키를 `profile` 필드에 매핑

---

### 네이버 vs 카카오 API 비교

| 항목 | 네이버 | 카카오 |
|------|--------|--------|
| 검색 인증 | `X-Naver-Client-Id` / `X-Naver-Client-Secret` 헤더 | `Authorization: KakaoAK {REST_API_KEY}` |
| 로그인 OAuth | `nid.naver.com/oauth2.0/authorize` | `kauth.kakao.com/oauth/authorize` |
| 토큰 교환 | `nid.naver.com/oauth2.0/token` | `kauth.kakao.com/oauth/token` |
| 프로필 조회 | `openapi.naver.com/v1/nid/me` | `kapi.kakao.com/v2/user/me` |
| 프로필 인증 헤더 | `Authorization: Bearer {access_token}` | `Authorization: Bearer {access_token}` |
| 로그아웃 URL | `nid.naver.com/nidlogin.logout` | `kauth.kakao.com/oauth/logout` |

### Naver API 공통 패턴

```
검색 API (X-Naver 헤더 인증)
  HttpHeaders.add("X-Naver-Client-Id", CLIENT_ID)
  HttpHeaders.add("X-Naver-Client-Secret", CLIENT_SECRET)
  → HttpMethod.GET, 응답타입 String.class

로그인 OAuth 흐름
  1. redirect → nid.naver.com/oauth2.0/authorize (code 발급)
  2. POST nid.naver.com/oauth2.0/token (code → access_token)
  3. POST openapi.naver.com/v1/nid/me (Bearer access_token → 프로필)

로그아웃
  동기: redirect nid.naver.com/nidlogin.logout?returl=...
  팝업: window.open() + setTimeout으로 팝업 닫고 앱 내 이동
```

---

## 12_RESTFULAPI — 외부 API 연동 C05 Google

### 파일 구조

```
외부API연동/C05Google/
├── GoogleLoginController.java    # GET /google/login~  — Google OAuth 2.0 로그인
├── GoogleMailAPIController.java  # GET /google/mail/{recv}/{text} — Gmail 발송
├── GoogleCalendarController.java # POST /google/cal  — Google Calendar 이벤트 추가/삭제/조회
└── FullCalendarController.java   # GET /google/cal   — FullCalendar 뷰 페이지

templates/google/
└── index.html                    # 로그인 결과 페이지 (프로필 표시)
```

---

### C05-1 GoogleLoginController — Google OAuth 2.0 로그인

카카오/네이버와 동일한 `login → callback → getAccessToken → main` 4단계 패턴.  
로그인 시 `scope`에 `calendar` 권한까지 포함해 캘린더 API도 같은 토큰으로 사용.

```java
@Controller @Slf4j @RequestMapping("/google")
public class GoogleLoginController {

    private String CLIENT_ID = "";
    private String CLIENT_SECRET = "";
    private String REDIRECT_URI = "http://localhost:8080/google/callback";

    private String code;
    public static GoogleTokenResponse googleTokenResponse;  // 캘린더에서 재사용 (static)

    // 1) 인가코드 요청 → 구글 로그인 동의화면
    // scope: userinfo.profile + userinfo.email + calendar
    // access_type=offline → refresh_token 함께 발급
    @GetMapping("/login")
    public String login() {
        return "redirect:https://accounts.google.com/o/oauth2/v2/auth"
                + "?client_id=" + CLIENT_ID
                + "&redirect_uri=" + REDIRECT_URI
                + "&response_type=code"
                + "&scope=https://www.googleapis.com/auth/userinfo.profile"
                +   "%20https://www.googleapis.com/auth/userinfo.email"
                +   "%20https://www.googleapis.com/auth/calendar"
                + "&access_type=offline";
    }

    // 2) 인가코드 수신 → 토큰 발급으로 forward
    @GetMapping("/callback")
    public String getCode(String code) {
        this.code = code;
        return "forward:/google/getAccessToken";
    }

    // 3) 인가코드 → access_token 교환
    // TOKEN ENDPOINT: https://oauth2.googleapis.com/token
    @GetMapping("/getAccessToken")
    public String getAccessToken() {
        String url = "https://oauth2.googleapis.com/token";

        HttpHeaders header = new HttpHeaders();
        header.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", CLIENT_ID);
        params.add("client_secret", CLIENT_SECRET);
        params.add("redirect_uri", REDIRECT_URI);
        params.add("code", code);

        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(params, header);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<GoogleTokenResponse> response =
                restTemplate.exchange(url, HttpMethod.POST, entity, GoogleTokenResponse.class);
        this.googleTokenResponse = response.getBody();
        return "redirect:/google";
    }

    // 4) 프로필 조회 → 뷰 전달
    // USERINFO ENDPOINT (OIDC 표준): https://openidconnect.googleapis.com/v1/userinfo
    @GetMapping
    public String main(Model model) {
        String url = "https://openidconnect.googleapis.com/v1/userinfo";

        HttpHeaders header = new HttpHeaders();
        header.add("Authorization", "Bearer " + googleTokenResponse.getAccess_token());
        HttpEntity entity = new HttpEntity(header);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<GoogleProfileResponse> response =
                restTemplate.exchange(url, HttpMethod.GET, entity, GoogleProfileResponse.class);

        GoogleProfileResponse profile = response.getBody();
        model.addAttribute("profile", profile);
        model.addAttribute("name", profile.getName());
        model.addAttribute("email", profile.getEmail());
        model.addAttribute("image_url", profile.getPicture());
        return "google/index";
    }

    // 5-1) 로그아웃 — 토큰 폐기 (access_token 무효화)
    // REVOKE ENDPOINT: https://oauth2.googleapis.com/revoke
    @GetMapping("/logout1") @ResponseBody
    public void logout1() {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("token", googleTokenResponse.getAccess_token());

        HttpHeaders header = new HttpHeaders();
        header.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

        RestTemplate restTemplate = new RestTemplate();
        restTemplate.exchange("https://oauth2.googleapis.com/revoke",
                HttpMethod.POST, new HttpEntity<>(params, header), String.class);
    }

    // 5-2) 로그아웃 — 구글 계정 로그아웃 페이지로 이동
    @GetMapping("/logout2") @ResponseBody
    public String logout2() {
        return "redirect:https://accounts.google.com/Logout";
    }

    // 내부 DTO
    @Data
    public static class GoogleTokenResponse {
        public String access_token;
        public String expires_in;
        public String refresh_token;
        public String scope;
        public String token_type;
        public String id_token;
    }

    @Data
    private static class GoogleProfileResponse {
        public String sub;             // 사용자 고유 ID (OIDC 표준: id → sub)
        public String email;
        public boolean email_verified; // OIDC 표준: verified_email → email_verified
        public String name;
        public String given_name;
        public String family_name;
        public String picture;
        public String locale;
    }
}
```

#### Google OAuth 2.0 전체 흐름

```
브라우저 GET /google/login
    │ redirect (scope: profile + email + calendar, access_type=offline)
    ▼
https://accounts.google.com/o/oauth2/v2/auth (구글 로그인 동의 화면)
    │ 사용자 로그인 완료
    ▼
GET /google/callback?code=xxx
    │ forward
    ▼
GET /google/getAccessToken
    │ POST https://oauth2.googleapis.com/token (code → access_token + refresh_token)
    │ static googleTokenResponse 에 저장
    ▼
redirect /google
    │ GET https://openidconnect.googleapis.com/v1/userinfo (Bearer access_token)
    ▼
google/index.html 렌더링 (name, email, picture)
```

#### 네이버 vs 구글 OAuth 비교

| 항목 | 네이버 | 구글 |
|------|--------|------|
| 인가 엔드포인트 | `nid.naver.com/oauth2.0/authorize` | `accounts.google.com/o/oauth2/v2/auth` |
| 토큰 교환 | `nid.naver.com/oauth2.0/token` | `oauth2.googleapis.com/token` |
| 프로필 조회 | `POST openapi.naver.com/v1/nid/me` | `GET openidconnect.googleapis.com/v1/userinfo` |
| 프로필 사용자 ID 필드 | `id` | `sub` (OIDC 표준) |
| 이메일 검증 필드 | `email` | `email_verified` |
| 로그아웃 | `nid.naver.com/nidlogin.logout` redirect | `oauth2.googleapis.com/revoke` POST (토큰 폐기) |
| offline access | 별도 파라미터 없음 | `access_type=offline` (refresh_token 발급) |

> 구글 프로필은 `email_verified` 필드(boolean)로 이메일 인증 여부를 명시하며,  
> 사용자 고유 ID는 카카오/네이버처럼 `id`가 아닌 OIDC 표준 `sub` 필드를 사용한다.

---

### C05-2 GoogleMailAPIController — Gmail 발송 (JavaMailSender)

구글 OAuth 토큰 방식이 아닌 **Spring Mail + SMTP** 방식.  
`application.properties`에 Gmail SMTP 설정 + 앱 비밀번호를 세팅하면 `JavaMailSender`가 자동 빈으로 등록됨.

```java
@Controller @Slf4j @RequestMapping("/google/mail")
public class GoogleMailAPIController {

    @Autowired
    JavaMailSender javaMailSender;

    // GET /google/mail/{받는사람}/{본문}
    @GetMapping("/{recv}/{text}")
    @ResponseBody
    public void send_mail(@PathVariable String recv, @PathVariable String text) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(recv);
        message.setSubject("[WEB발신] 메일 테스트...");
        message.setText(text);
        javaMailSender.send(message);
    }
}
```

**application.properties 설정 (Gmail SMTP)**

```properties
# Gmail SMTP (앱 비밀번호 사용 — 구글 계정 2단계 인증 필수)
spring.mail.host=smtp.gmail.com
spring.mail.port=587
spring.mail.username=your@gmail.com
spring.mail.password=앱비밀번호16자리
spring.mail.properties.mail.smtp.auth=true
spring.mail.properties.mail.smtp.starttls.enable=true
```

> `JavaMailSender` — Spring Boot가 `spring.mail.*` 설정을 읽어 자동 빈으로 등록.  
> `SimpleMailMessage` — 텍스트 메일 전용. HTML 메일은 `MimeMessage` + `MimeMessageHelper` 사용.

---

### C05-3 GoogleCalendarController — Google Calendar 이벤트 추가

`GoogleLoginController.googleTokenResponse` (static) 를 재사용 — 별도 로그인 불필요.  
로그인 scope에 `calendar` 권한이 포함되어 있어야 함.

```java
@Slf4j @Controller @RequestMapping("google/cal")
public class GoogleCalendarController {

    private String CALENDAR_ID = "";

    // FullCalendar 뷰 — GET /google/cal
    // (FullCalendarController에서 처리)

    // 이벤트 추가
    // ENDPOINT: POST https://www.googleapis.com/calendar/v3/calendars/{calendarId}/events
    @PostMapping
    public void post(
            @RequestParam("start") LocalDateTime start,
            @RequestParam("end") LocalDateTime end,
            @RequestParam("summary") String summary,
            @RequestParam("description") String description
    ) {
        String url = "https://www.googleapis.com/calendar/v3/calendars/" + CALENDAR_ID + "/events";

        HttpHeaders header = new HttpHeaders();
        header.add("Authorization", "Bearer " + GoogleLoginController.googleTokenResponse.getAccess_token());
        header.add("Content-Type", "application/json");

        // 종일(all-day) 일정: end.date 는 배타적(exclusive) → 시작일 +1 일
        JSONObject startJSON = new JSONObject();
        startJSON.put("date", start.toLocalDate().toString());
        JSONObject endJSON = new JSONObject();
        endJSON.put("date", end.toLocalDate().toString());

        JSONObject events = new JSONObject();
        events.put("summary", summary);
        events.put("description", description);
        events.put("start", startJSON);
        events.put("end", endJSON);

        RestTemplate restTemplate = new RestTemplate();
        restTemplate.exchange(url, HttpMethod.POST, new HttpEntity<>(events, header), String.class);
    }

    // 이벤트 삭제
    // ENDPOINT: DELETE https://www.googleapis.com/calendar/v3/calendars/{calendarId}/events/{eventId}
    // (생략 — Bearer 헤더 + HttpMethod.DELETE 사용)

    // 이벤트 목록 조회
    // ENDPOINT: GET https://www.googleapis.com/calendar/v3/calendars/{calendarId}/events
    // (생략 — Bearer 헤더 + HttpMethod.GET 사용)
}
```

#### Google Calendar API 포인트

| 작업 | HTTP Method | 엔드포인트 |
|------|-------------|-----------|
| 이벤트 추가 | `POST` | `/calendar/v3/calendars/{calendarId}/events` |
| 이벤트 삭제 | `DELETE` | `/calendar/v3/calendars/{calendarId}/events/{eventId}` |
| 이벤트 목록 | `GET` | `/calendar/v3/calendars/{calendarId}/events` |

> - 인증: `Authorization: Bearer {access_token}` + `Content-Type: application/json`  
> - 종일 일정은 `start.date` / `end.date` (ISO 8601 날짜 문자열) 사용  
> - `end.date`는 배타적(exclusive) → 1박 2일 일정은 end를 종료일 +1로 설정  
> - Google Cloud Console에서 **"Google Calendar API"** 를 사용 설정(Enable)해야 함

---

### Google API 전체 비교

| 컨트롤러 | 경로 | 인증 방식 | 사용 API |
|----------|------|-----------|----------|
| GoogleLoginController | `/google/login~` | OAuth 2.0 (access_token) | accounts.google.com + openidconnect |
| GoogleMailAPIController | `/google/mail/{recv}/{text}` | Gmail SMTP (앱 비밀번호) | JavaMailSender (Spring Mail) |
| GoogleCalendarController | `/google/cal` POST | Bearer (로그인 토큰 재사용) | Google Calendar API v3 |

### Google API 공통 패턴

```
OAuth 2.0 로그인 흐름 (네이버/카카오와 동일)
  1. redirect accounts.google.com/o/oauth2/v2/auth (code 발급)
  2. POST oauth2.googleapis.com/token (code → access_token)
  3. GET openidconnect.googleapis.com/v1/userinfo (Bearer → 프로필)

로그아웃
  POST oauth2.googleapis.com/revoke?token={access_token}  (토큰 폐기)

캘린더 API (토큰 재사용)
  scope에 calendar 포함 + Google Cloud Console에서 Calendar API 활성화
  static 변수로 access_token 공유 → GoogleLoginController.googleTokenResponse

Gmail 발송 (OAuth 아님)
  spring.mail.* SMTP 설정 → JavaMailSender 자동 빈
  SimpleMailMessage로 텍스트 메일 전송
```

---

## 12_RESTFULAPI — 외부 API 연동 C06 Portone (아임포트)

### 파일 구조

```
외부API연동/C06Portone/
└── PortoneController.java   # GET /Portone/** — 본인인증 · 결제 조회 · 결제 취소
```

---

### PortoneController — 아임포트 REST API

포트원(아임포트) v1 API. 모든 API 호출 전 `getToken()`으로 access_token을 발급한 뒤 Bearer 인증.

```java
@Controller @Slf4j @RequestMapping("/Portone")
public class PortoneController {

    private String HOST = "https://api.iamport.kr";
    private String IMP_KEY = "";
    private String IMP_SECRET = "";

    private PortOneTokenResponse portOneTokenResponse;

    // 토큰 발급 (내부 공통 메서드 — 모든 API 호출 전 실행)
    // ENDPOINT: POST https://api.iamport.kr/users/getToken
    private void getToken() {
        String url = HOST + "/users/getToken";

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("imp_key", IMP_KEY);
        params.add("imp_secret", IMP_SECRET);

        HttpHeaders header = new HttpHeaders();
        header.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<PortOneTokenResponse> response =
                restTemplate.exchange(url, HttpMethod.POST,
                        new HttpEntity<>(params, header), PortOneTokenResponse.class);
        this.portOneTokenResponse = response.getBody();
    }

    // 본인인증 결과 조회
    // ENDPOINT: GET https://api.iamport.kr/certifications/{imp_uid}
    @GetMapping("/certifications/{imp_uid}")
    @ResponseBody
    public ResponseEntity<CertificationResponse> certification(@PathVariable String imp_uid) {
        getToken();
        String url = HOST + "/certifications/" + imp_uid;

        HttpHeaders header = new HttpHeaders();
        header.add("Authorization", "Bearer " + portOneTokenResponse.getResponse().getAccess_token());
        header.add("Content-Type", "application/json");

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<CertificationResponse> response =
                restTemplate.exchange(url, HttpMethod.GET, new HttpEntity(header), CertificationResponse.class);
        this.certificationResponse = response.getBody();
        return ResponseEntity.status(HttpStatus.OK).body(certificationResponse);
    }

    // 결제 정보 단건 조회
    // ENDPOINT: GET https://api.iamport.kr/payments?merchant_uid[]={merchant_uid}
    @GetMapping("/payments/{merchant_uid}")
    public ResponseEntity<?> payments(@PathVariable String merchant_uid) {
        getToken();
        String url = HOST + "/payments?imp_uid[]=&merchant_uid[]=" + merchant_uid;

        HttpHeaders header = new HttpHeaders();
        header.add("Authorization", "Bearer " + portOneTokenResponse.getResponse().getAccess_token());
        header.add("Content-Type", "application/json");

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response =
                restTemplate.exchange(url, HttpMethod.GET, new HttpEntity(header), String.class);
        return ResponseEntity.status(HttpStatus.OK).body(null);
    }

    // 결제 목록 조회 (결제 상태별)
    // ENDPOINT: GET https://api.iamport.kr/payments/status/{payment_status}
    // payment_status: all / ready / paid / cancelled / failed
    @GetMapping("/payments/status/{payment_status}")
    @ResponseBody
    public String payments_all(@PathVariable String payment_status) {
        if (payment_status == null) payment_status = "all";
        getToken();

        String url = HOST + "/payments/status/" + payment_status;
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("page", "1");
        params.add("limit", "1");

        HttpHeaders header = new HttpHeaders();
        header.add("Authorization", "Bearer " + portOneTokenResponse.getResponse().getAccess_token());
        header.add("Content-Type", "application/json");

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response =
                restTemplate.exchange(url, HttpMethod.GET,
                        new HttpEntity<>(params, header), String.class);
        return response.getBody();
    }

    // 결제 취소
    // ENDPOINT: POST https://api.iamport.kr/payments/cancel
    @GetMapping("/payments/cancel")
    @ResponseBody
    public void payments_cancel() {
        getToken();
        String url = HOST + "/payments/cancel";

        JSONObject params = new JSONObject();
        params.put("merchant_uid", "test_merchand1781501542464");

        HttpHeaders header = new HttpHeaders();
        header.add("Authorization", "Bearer " + portOneTokenResponse.getResponse().getAccess_token());
        header.add("Content-Type", "application/json");

        RestTemplate restTemplate = new RestTemplate();
        restTemplate.exchange(url, HttpMethod.POST,
                new HttpEntity<>(params, header), String.class);
    }

    // 내부 DTO
    @Data private static class Response {
        public String access_token;
        public int now;
        public int expired_at;
    }
    @Data private static class PortOneTokenResponse {
        public int code;
        public Object message;
        public Response response;
    }
    @Data private static class CResponse {
        public String birthday; public boolean certified;
        public boolean foreigner; public String gender;
        public String imp_uid;  public String merchant_uid;
        public String name;     public String phone;
        public String pg_provider; public String unique_key;
    }
    @Data private static class CertificationResponse {
        public int code; public Object message; public CResponse cresponse;
    }
}
```

#### Portone API 전체 비교

| 엔드포인트 | HTTP | 설명 |
|-----------|------|------|
| `POST /users/getToken` | POST | imp_key + imp_secret → access_token 발급 |
| `GET /certifications/{imp_uid}` | GET | 본인인증 결과 조회 (이름, 생년월일, 성별, 전화번호) |
| `GET /payments?merchant_uid[]={id}` | GET | 결제 단건 조회 |
| `GET /payments/status/{status}` | GET | 결제 목록 조회 (all/ready/paid/cancelled/failed) |
| `POST /payments/cancel` | POST | 결제 취소 (merchant_uid 또는 imp_uid 지정) |

#### CertificationResponse — 본인인증 응답 주요 필드

| 필드 | 타입 | 설명 |
|------|------|------|
| `certified` | boolean | 인증 성공 여부 |
| `name` | String | 인증된 이름 |
| `birthday` | String | 생년월일 |
| `gender` | String | 성별 (male/female) |
| `phone` | String | 휴대폰 번호 |
| `foreigner` | boolean | 외국인 여부 |
| `imp_uid` | String | 아임포트 고유 번호 |
| `unique_key` | String | 동일인 식별 고유 키 |

#### Portone 공통 패턴

```
모든 API 호출 전 공통 작업
  1. POST /users/getToken (imp_key + imp_secret → access_token)
  2. Authorization: Bearer {access_token} 헤더 추가

본인인증 흐름 (프론트엔드 연동)
  1. 프론트에서 아임포트 JS SDK로 본인인증 팝업 실행
  2. 완료 후 imp_uid 를 백엔드로 전송
  3. 백엔드: GET /certifications/{imp_uid} → 인증 결과 검증

결제 취소 Body 형식
  Content-Type: application/json → JSONObject로 전달
  { "merchant_uid": "xxx" }  또는  { "imp_uid": "xxx" }
```

---

## 12_RESTFULAPI — 외부 API 연동 C07 CoolSMS (솔라피)

### 파일 구조

```
외부API연동/C07CollSMS/
└── CoolSmsController.java   # GET /coolsms/send — SMS 단건 발송
```

---

### CoolSmsController — HMAC-SHA256 인증 + SMS 발송

솔라피(구 CoolSMS) REST API. API Key/Secret 기반 **HMAC-SHA256 서명** 인증 방식 사용.  
사업자 없이 개인 회원가입 후 본인 번호를 발신번호로 등록하면 무료 충전금으로 테스트 가능.

```java
@RestController @Slf4j @RequestMapping("/coolsms")
public class CoolSmsController {

    private String API_KEY = "";      // 솔라피 콘솔에서 발급
    private String API_SECRET = "";   // 솔라피 콘솔에서 발급
    private String FROM = "";         // 사전 등록된 발신번호

    private final String SEND_URL = "https://api.solapi.com/messages/v4/send";

    // SMS 단건 발송
    // GET /coolsms/send?to=01012345678&text=hello
    @GetMapping("/send")
    public ResponseEntity<String> send(
            @RequestParam("to") String to,
            @RequestParam("text") String text
    ) throws Exception {

        // 1) HMAC-SHA256 인증 헤더 구성
        // date + salt 를 API_SECRET 으로 서명 → signature
        String date = ZonedDateTime.now(ZoneOffset.UTC)
                .format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"));
        String salt = UUID.randomUUID().toString().replace("-", "");
        String signature = hmacSha256(date + salt, API_SECRET);

        HttpHeaders header = new HttpHeaders();
        header.add("Content-Type", "application/json");
        header.add("Authorization",
                "HMAC-SHA256 apiKey=" + API_KEY
                        + ", date=" + date
                        + ", salt=" + salt
                        + ", signature=" + signature);

        // 2) 요청 바디: { "message": { "to", "from", "text" } }
        JSONObject message = new JSONObject();
        message.put("to", to);
        message.put("from", FROM);
        message.put("text", text);

        JSONObject params = new JSONObject();
        params.put("message", message);

        HttpEntity<String> entity = new HttpEntity<>(params.toJSONString(), header);

        // 3) 발송 요청
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response =
                restTemplate.exchange(SEND_URL, HttpMethod.POST, entity, String.class);
        return response;
    }

    // HMAC-SHA256 서명 생성 유틸 (hex 문자열 반환)
    private String hmacSha256(String data, String secret) throws Exception {
        Mac mac = Mac.getInstance("HmacSHA256");
        mac.init(new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), "HmacSHA256"));
        byte[] raw = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));
        StringBuilder sb = new StringBuilder();
        for (byte b : raw) sb.append(String.format("%02x", b));
        return sb.toString();
    }
}
```

#### HMAC-SHA256 인증 흐름

```
1. date  = UTC 현재 시각 (yyyy-MM-dd'T'HH:mm:ss.SSS'Z')
2. salt  = UUID 랜덤 문자열 (하이픈 제거)
3. data  = date + salt
4. signature = HMAC-SHA256(data, API_SECRET) → hex string

Authorization 헤더:
  "HMAC-SHA256 apiKey={API_KEY}, date={date}, salt={salt}, signature={signature}"
```

> - `date`와 `salt`는 매 요청마다 새로 생성 → 리플레이 공격 방지  
> - `signature`는 `data = date + salt` 를 `API_SECRET`으로 서명한 hex 값  
> - `javax.crypto.Mac` + `SecretKeySpec` 으로 Java 기본 라이브러리만 사용 (외부 의존성 없음)

#### 요청 바디 구조

```json
{
  "message": {
    "to": "01012345678",
    "from": "등록된발신번호",
    "text": "메시지 내용"
  }
}
```

> `@RestController` 사용 — `@ResponseBody` 없이도 반환값이 JSON/String으로 직접 응답됨

#### CoolSMS vs 다른 외부 API 인증 방식 비교

| API | 인증 방식 | Authorization 헤더 |
|-----|----------|-------------------|
| 네이버 검색 | API Key 헤더 | `X-Naver-Client-Id` / `X-Naver-Client-Secret` |
| 카카오/네이버/구글 로그인 | OAuth 2.0 Bearer | `Bearer {access_token}` |
| 카카오페이 | SECRET_KEY | `SECRET_KEY {secret_key}` |
| 포트원(아임포트) | Bearer (자체 토큰) | `Bearer {imp_access_token}` |
| 솔라피(CoolSMS) | HMAC-SHA256 서명 | `HMAC-SHA256 apiKey=..., date=..., salt=..., signature=...` |

#### 솔라피 준비사항

| 항목 | 내용 |
|------|------|
| 콘솔(키 발급) | `console.solapi.com/credentials` |
| 발신번호 등록 | 콘솔 → 발신번호 관리 → 본인 휴대폰 번호 등록 (인증 필요) |
| 무료 충전금 | 가입 시 지급 — 사업자 없이 테스트 가능 |
| 발송 API | `POST https://api.solapi.com/messages/v4/send` |
| 인증 문서 | `developers.solapi.com/references/authentication/` |

---

## 12_RESTFULAPI — 외부 API 연동 C08 FCM (Firebase Cloud Messaging)

### 개요

Firebase Admin SDK를 사용해 서버에서 브라우저(웹 푸시)로 알림을 발송하는 구조.  
`receive.html`에서 기기 토큰을 발급·등록하고, `send.html`에서 등록된 모든 토큰으로 일괄 발송.

### 파일 구조

```
외부API연동/C08FCM/
├── FirebaseInitializer.java   # 앱 기동 시 Firebase Admin SDK 초기화 (@PostConstruct)
├── FcmToken.java              # FCM 기기 토큰 엔티티 (테이블: fcm_tokens)
├── FcmTokenRepository.java    # JpaRepository — 토큰 CRUD
├── FcmService.java            # 단일 기기 FCM 발송 로직
├── FcmTokenService.java       # (동일 기능 별도 서비스 — 참고용)
├── FcmTokenController.java    # POST /api/fcm/token — 기기 토큰 등록
├── FcmTestController.java     # POST /api/fcm/send  — 전체 토큰 일괄 발송
├── FcmTunnelController.java   # POST /api/fcm/tunnel — Cloudflare 빠른 터널 생성
└── FcmViewController.java     # GET /fcm/send, /fcm/receive — 화면 라우팅

resources/
└── firebase-adminsdk.json     # 서비스계정 키 (비밀, .gitignore 처리)
```

---

### FirebaseInitializer — Firebase Admin SDK 초기화

```java
@Component
public class FirebaseInitializer {

    @PostConstruct
    public void initialize() throws IOException {
        FileInputStream serviceAccount =
                new FileInputStream("src/main/resources/firebase-adminsdk.json");

        FirebaseOptions options = FirebaseOptions.builder()
                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                .build();

        if (FirebaseApp.getApps().isEmpty()) {   // 중복 초기화 방지
            FirebaseApp.initializeApp(options);
        }
    }
}
```

> `@PostConstruct` — 스프링 빈 생성 직후 1회 실행. 이 초기화 이후에 `FcmService`의 발송이 동작함.

---

### FcmToken — 엔티티

```java
@Entity @Table(name = "fcm_tokens")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class FcmToken {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String username;

    @Column(length = 500, nullable = false, unique = true)
    private String token;           // FCM 기기 토큰 (중복 불가)

    private LocalDateTime registeredAt;

    @PrePersist
    public void onCreate() {
        this.registeredAt = LocalDateTime.now();
    }
}
```

---

### FcmTokenRepository

```java
public interface FcmTokenRepository extends JpaRepository<FcmToken, Long> {
    Optional<FcmToken> findByToken(String token);
    List<FcmToken> findByUsername(String username);
    boolean existsByToken(String token);   // 중복 등록 방지 체크용
    void deleteByToken(String token);      // 만료/해지 시 삭제
}
```

---

### FcmService — 단일 기기 발송

```java
@Service
public class FcmService {

    public String sendFcmMessage(String targetToken, String title, String body)
            throws FirebaseMessagingException {

        Message message = Message.builder()
                .setToken(targetToken)
                .setNotification(Notification.builder()
                        .setTitle(title)
                        .setBody(body)
                        .build())
                .build();

        return FirebaseMessaging.getInstance().send(message);  // 발송 성공 시 메시지 ID 반환
    }
}
```

---

### FcmTokenController — 기기 토큰 등록

```java
@RestController @RequestMapping("/api/fcm") @RequiredArgsConstructor
public class FcmTokenController {

    private final FcmTokenRepository fcmTokenRepository;

    @PostMapping("/token")
    public ResponseEntity<?> saveToken(@RequestBody Map<String, String> payload) {
        String username = payload.get("username");
        String token    = payload.get("token");

        if (!fcmTokenRepository.existsByToken(token)) {  // 중복 방지
            fcmTokenRepository.save(FcmToken.builder()
                    .username(username).token(token).build());
        }
        return ResponseEntity.ok().build();
    }
}
```

---

### FcmTestController — 전체 토큰 일괄 발송

```java
@RestController @RequestMapping("/api/fcm") @RequiredArgsConstructor
public class FcmTestController {

    private final FcmTokenRepository fcmTokenRepository;
    private final FcmService fcmService;

    @PostMapping("/send")
    public ResponseEntity<String> send(@RequestBody Map<String, String> payload) {
        String title = payload.get("title");
        String body  = payload.get("body");

        List<FcmToken> tokens = fcmTokenRepository.findAll();
        if (tokens.isEmpty()) {
            return ResponseEntity.ok("등록된 토큰이 없습니다. 먼저 수신 페이지(/fcm/receive)를 여세요.");
        }

        int success = 0, fail = 0;
        for (FcmToken token : tokens) {
            try {
                fcmService.sendFcmMessage(token.getToken(), title, body);
                success++;
            } catch (Exception e) {
                fail++;
            }
        }
        return ResponseEntity.ok("발송 완료 - 성공 " + success + ", 실패 " + fail);
    }
}
```

---

### FcmTunnelController — Cloudflare 빠른 터널

웹 푸시는 HTTPS 또는 localhost에서만 동작하므로, 외부기기(폰 등)에서 테스트하려면 HTTPS 터널이 필요.

```java
@RestController @RequestMapping("/api/fcm")
public class FcmTunnelController {

    private static final Pattern URL_PATTERN =
            Pattern.compile("https://[a-z0-9-]+\\.trycloudflare\\.com");

    private Process tunnelProcess;
    private volatile String tunnelUrl;   // volatile: 멀티스레드 가시성 보장

    @PostMapping("/tunnel")
    public ResponseEntity<String> createTunnel() {
        // 이미 살아있는 터널이 있으면 재사용
        if (tunnelUrl != null && tunnelProcess != null && tunnelProcess.isAlive()) {
            return ResponseEntity.ok(tunnelUrl);
        }

        ProcessBuilder pb = new ProcessBuilder(
                "cloudflared", "tunnel", "--url", "http://localhost:8080");
        pb.redirectErrorStream(true);
        tunnelProcess = pb.start();

        BufferedReader reader = new BufferedReader(
                new InputStreamReader(tunnelProcess.getInputStream(), StandardCharsets.UTF_8));

        long deadline = System.currentTimeMillis() + 30_000;
        String line;
        while (System.currentTimeMillis() < deadline && (line = reader.readLine()) != null) {
            Matcher m = URL_PATTERN.matcher(line);
            if (m.find()) {
                tunnelUrl = m.group();
                drainAsync(reader);   // 버퍼 막힘 방지용 비동기 drain
                return ResponseEntity.ok(tunnelUrl);
            }
        }
        return ResponseEntity.status(500).body("터널 URL을 가져오지 못했습니다.");
    }
}
```

---

### FcmViewController — 화면 라우팅

```java
@Controller
public class FcmViewController {

    @GetMapping("/fcm/send")
    public String send() { return "fcm/send"; }       // templates/fcm/send.html

    @GetMapping("/fcm/receive")
    public String receive() { return "fcm/receive"; } // templates/fcm/receive.html
}
```

---

### 전체 발송 흐름

```
[receive.html]
  JS: firebase.getToken() → 기기 토큰 발급
  POST /api/fcm/token → FcmTokenController → DB(fcm_tokens) 저장

[send.html]
  입력: title / body
  POST /api/fcm/send → FcmTestController
    → fcmTokenRepository.findAll() (등록된 모든 토큰)
    → 토큰별 FcmService.sendFcmMessage()
    → FirebaseMessaging.getInstance().send(message)
    → Firebase 서버 → 각 브라우저 수신

[외부기기 테스트]
  POST /api/fcm/tunnel → FcmTunnelController
    → cloudflared 실행 → trycloudflare.com 주소 반환
    → 외부기기 브라우저에서 HTTPS 접속 가능
```

---

### FCM 준비사항

| 항목 | 내용 |
|------|------|
| Firebase 프로젝트 | Firebase 콘솔에서 프로젝트 생성 |
| 서비스계정 키 | 콘솔 → 프로젝트 설정 → 서비스 계정 → `firebase-adminsdk.json` 다운로드 |
| 키 파일 위치 | `src/main/resources/firebase-adminsdk.json` (.gitignore 처리 필수) |
| cloudflared | 외부기기 테스트 시 설치 필요 (`winget install Cloudflare.cloudflared`) |
| 의존성 | `com.google.firebase:firebase-admin` |

---

## 13_FILEUPDOWNLOAD — 파일 업로드 / 다운로드

### 개요

`MultipartFile`을 사용해 파일을 서버 로컬 디렉토리에 저장하고, `FileSystemResource`로 다운로드 응답을 반환하는 패턴.

### 파일 구조

```
13_FILEUPDOWNLOAD/src/main/java/com/example/demo/
├── Controller/
│   └── FileUpDownloadController.java   # 업로드·목록·다운로드 엔드포인트
├── Dtos/
│   └── FileDTO.java                    # 다중 파일 + 메타데이터 DTO
└── Config/
    └── WebMvcConfig.java               # Multipart 크기 제한 / 정적 자원 경로
```

---

### FileDTO

```java
@Data @NoArgsConstructor @AllArgsConstructor
public class FileDTO {
    private long id;
    private String category;
    MultipartFile[] files;   // 다중 파일을 DTO로 묶어 받기
}
```

---

### FileUpDownloadController

```java
@Controller @Slf4j @RequestMapping("/file")
public class FileUpDownloadController {

    private String ROOT_PATH   = "c:";      // Linux: "/"
    private String UPLOAD_PATH = "upload";

    // ── 단일 파일 업로드 ──────────────────────────────────────────────────
    @PostMapping("/upload")
    @ResponseBody
    public void upload_post(@RequestParam("file") MultipartFile file) throws IOException {
        String uploadPath = ROOT_PATH + File.separator + UPLOAD_PATH + File.separator;

        File dir = new File(uploadPath);
        if (!dir.exists()) dir.mkdir();         // 폴더 없으면 생성

        File fileObject = new File(uploadPath, file.getOriginalFilename());
        file.transferTo(fileObject);            // 실제 저장
    }

    // ── 다중 파일 업로드 (배열) ──────────────────────────────────────────
    @PostMapping("/uploads")
    @ResponseBody
    public void uploads_post(@RequestParam("files") MultipartFile[] files) throws IOException {
        String uploadPath = ROOT_PATH + File.separator + UPLOAD_PATH + File.separator;
        File dir = new File(uploadPath);
        if (!dir.exists()) dir.mkdirs();

        for (MultipartFile file : files) {
            File fileObject = new File(uploadPath, file.getOriginalFilename());
            file.transferTo(fileObject);
        }
    }

    // ── 다중 파일 업로드 (DTO) ───────────────────────────────────────────
    @PostMapping("/upload_dto")
    @ResponseBody
    public void upload_post_dto(FileDTO dto) throws IOException {
        String uploadPath = ROOT_PATH + File.separator + UPLOAD_PATH + File.separator;
        File dir = new File(uploadPath);
        if (!dir.exists()) dir.mkdirs();

        for (MultipartFile file : dto.getFiles()) {
            File fileObject = new File(uploadPath, file.getOriginalFilename());
            file.transferTo(fileObject);
        }
    }

    // ── 업로드 파일 목록 ─────────────────────────────────────────────────
    @GetMapping("/list")
    public void list(Model model) {
        String uploadPath = ROOT_PATH + File.separator + UPLOAD_PATH + File.separator;
        File[] lists = new File(uploadPath).listFiles();

        List<String> fileList = new ArrayList<>();
        for (File item : lists) fileList.add(item.getName());

        model.addAttribute("fileList", fileList);
    }

    // ── 파일 다운로드 ─────────────────────────────────────────────────────
    @GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    @ResponseBody
    public ResponseEntity<Resource> download(@RequestParam("filename") String filename)
            throws UnsupportedEncodingException {

        String path = ROOT_PATH + File.separator + UPLOAD_PATH + File.separator + filename;
        Resource resource = new FileSystemResource(path);

        HttpHeaders headers = new HttpHeaders();
        // 한글 파일명 깨짐 방지: UTF-8 → ISO-8859-1 변환
        headers.add("Content-Disposition",
                "attachment:filename=" + new String(filename.getBytes("UTF-8"), "ISO-8859-1"));

        return new ResponseEntity<>(resource, headers, HttpStatus.OK);
    }
}
```

---

### WebMvcConfig — Multipart 크기 설정

```java
@Configuration @EnableWebMvc
public class WebMvcConfig implements WebMvcConfigurer {

    @Bean
    public MultipartConfigElement multipartConfigElement() {
        MultipartConfigFactory factory = new MultipartConfigFactory();
        factory.setMaxFileSize(DataSize.ofGigabytes(1));        // 파일 1개 최대 1GB
        factory.setMaxRequestSize(DataSize.ofGigabytes(1));     // 요청 전체 최대 1GB
        factory.setFileSizeThreshold(DataSize.ofGigabytes(1));  // 메모리 임계치
        return factory.createMultipartConfig();
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("resources/css/**").addResourceLocations("classpath:/css/");
        registry.addResourceHandler("resources/js/**").addResourceLocations("classpath:/js/");
    }
}
```

---

### 업로드 / 다운로드 흐름

```
[업로드]
  form enctype="multipart/form-data"
    → @RequestParam MultipartFile / MultipartFile[] / FileDTO
    → file.transferTo(new File(uploadPath, filename))
    → 서버 로컬 디렉토리 저장

[다운로드]
  GET /file/download?filename=xxx
    → FileSystemResource(path)
    → Content-Disposition: attachment; filename=<ISO-8859-1 변환>
    → ResponseEntity<Resource> + APPLICATION_OCTET_STREAM
```

### 업로드 방식 비교

| 방식 | 어노테이션/타입 | 특징 |
|------|----------------|------|
| 단일 파일 | `@RequestParam MultipartFile` | 파일 1개 |
| 다중 파일 (배열) | `@RequestParam MultipartFile[]` | 여러 파일, 파라미터명 동일 |
| 다중 파일 (DTO) | `FileDTO` (DTO 필드에 `MultipartFile[]`) | 파일 + 메타데이터 함께 전송 |

> `File.separator` — Windows `\`, Linux `/` 자동 선택  
> `dir.mkdir()` vs `dir.mkdirs()` — `mkdirs()`는 중간 디렉토리까지 모두 생성

---

## 14_AOP — Spring AOP (Aspect-Oriented Programming)

### 개요

공통 관심사(로깅·트랜잭션·보안 등)를 비즈니스 로직에서 분리해 별도 Aspect로 관리.  
`@Aspect` + `@Component`로 등록하고, Pointcut 표현식으로 적용 대상을 지정.

### 파일 구조

```
14_AOP/src/main/java/com/example/demo/
└── Aop/
    └── LogginAspect.java         # @Aspect — 서비스 레이어 실행시간 측정

Domain/Common/Service/
└── AopTestService.java           # AOP 동작 검증용 더미 서비스
```

---

### LogginAspect

```java
@Component @Slf4j @Aspect
public class LogginAspect {

    // ── Before / After (비활성화 예시) ────────────────────────────────────
    // @Before("execution(* com.example.demo.Domain.Common.Service.AopTestService.run1(..))")
    // public void logginBefore(JoinPoint joinPoint) { log.info("[AOP] BEFORE..." + joinPoint); }

    // @After("execution(* com.example.demo.Domain.Common.Service.AopTestService.*(..))")
    // public void logginAfter(JoinPoint joinPoint)  { log.info("[AOP] After..."  + joinPoint); }

    // ── Around (실행 시간 측정) ───────────────────────────────────────────
    @Around("execution(* com.example.demo.Domain.Common.Service.*.*(..))")
    public Object logginAround(ProceedingJoinPoint pjp) throws Throwable {
        long start = System.currentTimeMillis();
        log.info("[AOP] AROUND BEFORE");

        Object returnValue = pjp.proceed();          // 타겟 메서드 실행
        log.info("타겟 함수 리턴값 : " + returnValue);

        log.info("[AOP] AROUND AFTER");
        log.info("[AOP] 소요시간 : " + (System.currentTimeMillis() - start) + "ms");
        return returnValue;
    }
}
```

---

### AopTestService — 검증용 더미 서비스

```java
@Service @Slf4j
public class AopTestService {

    public String run1(String params) {
        log.info("[AopTestService] run1 invoke...");
        return "param : " + params;
    }

    public String run2(String params) {
        log.info("[AopTestService] run2 invoke...");
        return "param : " + params;
    }
}
```

---

### AOP 핵심 개념

| 용어 | 설명 |
|------|------|
| **Aspect** | 공통 관심사 모듈 (`@Aspect` 클래스) |
| **Advice** | 실제 실행 코드 (`@Before`, `@After`, `@Around` 등) |
| **JoinPoint** | Advice가 끼어들 수 있는 지점 (메서드 실행 등) |
| **Pointcut** | 어떤 JoinPoint에 Advice를 적용할지 표현식으로 지정 |
| **ProceedingJoinPoint** | `@Around`에서만 사용 — `pjp.proceed()`로 타겟 메서드 실행 |

### Advice 종류

| 어노테이션 | 실행 시점 | 비고 |
|-----------|----------|------|
| `@Before` | 타겟 메서드 실행 **전** | 리턴값 없음 |
| `@After` | 타겟 메서드 실행 **후** (성공/예외 무관) | 리턴값 없음 |
| `@AfterReturning` | 정상 반환 **후** | 리턴값 참조 가능 |
| `@AfterThrowing` | 예외 발생 **후** | 예외 객체 참조 가능 |
| `@Around` | 실행 **전·후 모두** | `pjp.proceed()` 직접 호출 |

### Pointcut 표현식

```
execution(접근제한자 반환타입 패키지.클래스.메서드(파라미터))

execution(* com.example.demo.Domain.Common.Service.AopTestService.run1(..))
  → AopTestService 의 run1 메서드만

execution(* com.example.demo.Domain.Common.Service.AopTestService.*(..))
  → AopTestService 의 모든 메서드

execution(* com.example.demo.Domain.Common.Service.*.*(..))
  → Service 패키지 모든 클래스의 모든 메서드
```

### 실행 로그 흐름 (Around 기준)

```
[AOP] AROUND BEFORE
[AopTestService] run1 invoke...
타겟 함수 리턴값 : param : HELLO1
[AOP] AROUND AFTER
[AOP] 소요시간 : Xms
```

---

## 15_INTERCEPTOR — Filter / Interceptor

### 개요

HTTP 요청을 컨트롤러 진입 전/후에 가로채는 두 가지 메커니즘 비교.  
**Filter**는 서블릿 레이어(Spring 외부), **Interceptor**는 Spring MVC 레이어(DispatcherServlet 내부).

### 파일 구조

```
15_INTERCEPTOR/src/main/java/com/example/demo/
├── Filter/
│   └── MemoFilter.java          # javax.servlet.Filter 구현체
├── Interceptor/
│   └── MemoInterceptor.java     # HandlerInterceptor 구현체
└── Config/
    ├── FilterConfig.java         # FilterRegistrationBean으로 Filter 등록
    └── WebMvcConfig.java         # InterceptorRegistry로 Interceptor 등록
```

---

### MemoFilter — 서블릿 Filter

```java
// @WebFilter("/memo/*")   ← 어노테이션 방식 (주석 처리됨 — FilterConfig 방식 사용)
@Slf4j
public class MemoFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        log.info("[FILTER] MemoFilter START");   // 전처리

        chain.doFilter(request, response);       // 다음 필터 또는 서블릿으로 넘김

        log.info("[FILTER] MemoFilter END");     // 후처리
    }
}
```

---

### FilterConfig — Filter 등록 (Bean 방식)

```java
@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean<MemoFilter> memoFilter() {
        FilterRegistrationBean<MemoFilter> bean = new FilterRegistrationBean<>();
        bean.setFilter(new MemoFilter());
        bean.addUrlPatterns("/memo/*");   // 적용 URL 패턴
        bean.setOrder(1);                 // 필터 실행 순서 (낮을수록 먼저)
        return bean;
    }
}
```

> `@WebFilter` 어노테이션 방식과 `FilterRegistrationBean` 방식 두 가지 존재.  
> Bean 방식은 실행 순서(`setOrder`) 제어가 가능해 다중 필터 관리에 유리.

---

### MemoInterceptor — Spring Interceptor

```java
@Component @Slf4j
public class MemoInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception {
        // 컨트롤러 진입 전 — false 반환 시 요청 차단
        log.info("[INTERCEPTOR] Memo컨트롤러 실행 전 : " + request.getRequestURI());
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object handler, ModelAndView modelAndView) throws Exception {
        // 컨트롤러 완료 후, 뷰 렌더링 전
        log.info("[INTERCEPTOR] Memo컨트롤러 실행 후 : " + request.getRequestURI());
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
                                Object handler, Exception ex) throws Exception {
        // 뷰 렌더링 완료 후 (응답 전송 완료)
        log.info("[INTERCEPTOR] Memo컨트롤러 요청-응답 완료 후 : " + request.getRequestURI());
    }
}
```

---

### WebMvcConfig — Interceptor 등록

```java
@Configuration @EnableWebMvc
public class WebMvcConfig implements WebMvcConfigurer {

    @Autowired
    MemoInterceptor memoInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(memoInterceptor)
                .addPathPatterns("/memo/**")                              // 적용 경로
                .excludePathPatterns("resources/css/**", "resources/js/**");  // 제외 경로
    }
}
```

---

### Filter vs Interceptor 비교

| 구분 | Filter | Interceptor |
|------|--------|-------------|
| 레이어 | 서블릿 컨테이너 (Spring 외부) | Spring MVC (DispatcherServlet 내부) |
| 인터페이스 | `javax.servlet.Filter` | `HandlerInterceptor` |
| 등록 방법 | `@WebFilter` 또는 `FilterRegistrationBean` | `WebMvcConfigurer.addInterceptors()` |
| 실행 시점 | DispatcherServlet 도달 **전/후** | 컨트롤러 진입 **전/후**, 뷰 렌더링 **후** |
| Spring 빈 접근 | 제한적 (직접 getBean 필요) | 가능 (`@Autowired` 사용) |
| 용도 | 인코딩·보안·CORS 등 전역 처리 | 인증·로깅·공통 모델 주입 등 MVC 단 처리 |

### 요청 처리 흐름

```
HTTP 요청
  │
  ▼
[Filter.doFilter() — 전처리]          ← MemoFilter START
  │
  ▼
DispatcherServlet
  │
  ▼
[Interceptor.preHandle()]              ← return true → 진행 / false → 차단
  │
  ▼
Controller (Handler 실행)
  │
  ▼
[Interceptor.postHandle()]             ← 뷰 렌더링 전
  │
  ▼
View 렌더링
  │
  ▼
[Interceptor.afterCompletion()]        ← 뷰 렌더링 후
  │
  ▼
[Filter.doFilter() — 후처리]          ← MemoFilter END
  │
  ▼
HTTP 응답
```

---

## 16_SCHEDULER — Spring Scheduler

### 개요

Spring Boot의 `@Scheduled` 어노테이션으로 정해진 주기나 시각에 메서드를 자동 실행.  
`@EnableScheduling`이 활성화된 상태에서 `@Scheduled`가 붙은 메서드가 등록됨.

### 파일 구조

```
16_SCHEDULER/src/main/java/com/example/demo/
└── Scheduled/
    └── ScheduledTask.java   # @Scheduled 메서드 모음
```

---

### ScheduledTask

```java
@Component
@Slf4j
public class ScheduledTask {

    // fixedRate  — 이전 작업 시작 시각 기준으로 주기 고정 (작업 실행 시간 포함)
    // @Scheduled(fixedRate = 3000)
    // public void task1() { log.info("task1..."); }

    // fixedDelay — 이전 작업 종료 시각 기준으로 다음 실행 (작업 실행 시간 제외)
    // @Scheduled(fixedDelay = 3000)
    // public void task2() { log.info("task2..."); }

    // cron — 초 분 시 일 월 요일 형식의 6자리 표현식
    @Scheduled(cron = "0 * * * * *")   // 매 분 0초마다 실행
    public void task3() {
        log.info("task3..." + System.currentTimeMillis());
    }
}
```

---

### @Scheduled 옵션 비교

| 옵션 | 기준 | 특징 |
|------|------|------|
| `fixedRate` | 이전 작업 **시작** 시각 | 작업이 오래 걸려도 주기 고정 (겹칠 수 있음) |
| `fixedDelay` | 이전 작업 **종료** 시각 | 작업 완료 후 대기 → 순차 보장 |
| `cron` | 시각 표현식 | 특정 시각/요일/날짜 지정 가능 |
| `initialDelay` | 첫 실행 전 대기 ms | `fixedRate`/`fixedDelay`와 함께 사용 |

---

### Cron 표현식

```
형식: 초  분  시  일  월  요일
      0   *   *   *   *   *
```

| 위치 | 범위/특수값 | 설명 |
|------|------------|------|
| 초 (Seconds) | 0–59 | `0`, `15`, `*/10` |
| 분 (Minutes) | 0–59 | `0`, `30`, `*/5` |
| 시 (Hours) | 0–23 | `0`, `12`, `9-18` |
| 일 (Day of Month) | 1–31, `?`, `L`, `W` | `1`, `15`, `L`, `15W` |
| 월 (Month) | 1–12, JAN–DEC | `1`, `6`, `3-5` |
| 요일 (Day of Week) | 0–7 (0/7=일), SUN–SAT, `?`, `L`, `#` | `MON-FRI`, `2#1` |

**자주 쓰는 패턴**

```
"0 0 * * * *"       → 매 시 정각 실행
"0 */5 * * * *"     → 5분마다 실행
"0 0 9 * * MON-FRI" → 평일 오전 9시마다 실행
"0 0 0 * * *"       → 매일 자정 실행
"0 0 0 1 * *"       → 매달 1일 자정 실행
"0 0 23 L * *"      → 매달 마지막 날 23시 실행
"0 0 10 ? * 2#1"    → 매달 첫 번째 월요일 오전 10시 실행
```

---

### build.gradle (16_SCHEDULER)

```groovy
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-thymeleaf'
    implementation 'org.springframework.boot:spring-boot-starter-web'
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}
```

> 별도 Scheduler 의존성 없음 — `spring-boot-starter-web`에 포함된 `spring-context`가 `@Scheduled` 지원.  
> `DemoApplication`에 `@EnableScheduling` 어노테이션 추가 필요.

---

## 17_LISTENER — Filter / Interceptor / Listener

> 16_SCHEDULER 구조에 `Filter` + `Interceptor` + `Listener` 세 계층을 추가.  
> 요청 전후 처리를 각 계층이 담당하며, Listener는 Spring 이벤트 시스템으로 동작.

### 추가된 구조

```
src/main/java/com/example/demo/
├── Filter/
│   └── MemoFilter.java                          # Jakarta Filter 구현
├── Interceptor/
│   └── MemoInterceptor.java                     # HandlerInterceptor 구현
├── Listener/
│   ├── C01CustomContextRefreshedListener.java   # 앱 시작 이벤트 리스너
│   ├── C02RequestHandledEventListener.java      # 요청 완료 이벤트 리스너
│   ├── MemoAddEvent.java                        # 커스텀 이벤트
│   └── MemoAddEventListener.java                # 커스텀 이벤트 리스너
└── Config/
    ├── FilterConfig.java                        # Filter 빈 등록
    └── WebMvcConfig.java                        # Interceptor + Listener 등록
```

---

### 세 계층 비교

| 계층 | 인터페이스/클래스 | 동작 범위 | 등록 방법 |
|------|-----------------|----------|----------|
| Filter | `jakarta.servlet.Filter` | DispatcherServlet 진입 전/후 (Servlet 레벨) | `FilterRegistrationBean` |
| Interceptor | `HandlerInterceptor` | 컨트롤러 진입 전/후, 뷰 렌더링 후 (Spring MVC 레벨) | `WebMvcConfigurer.addInterceptors()` |
| Listener | `ApplicationListener<E>` | Spring 이벤트 발생 시점 (비동기 가능) | `@Bean` 등록 |

---

### 1) Filter — MemoFilter

```java
@Slf4j
public class MemoFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest r = (HttpServletRequest) request;
        log.info("[FILTER] MemoFilter START " + r.getRequestURI());   // 요청 전

        chain.doFilter(request, response);   // 다음 Filter 또는 Servlet으로 전달

        log.info("[FILTER] MemoFilter END");   // 요청 후
    }
}
```

```java
// FilterConfig.java — FilterRegistrationBean으로 등록
@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean<MemoFilter> memoFilter() {
        FilterRegistrationBean<MemoFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new MemoFilter());
        registrationBean.addUrlPatterns("/memo/*");   // 적용 URL 패턴
        registrationBean.setOrder(1);                 // Filter 실행 순서
        return registrationBean;
    }
}
```

> `chain.doFilter()` 전후로 코드 배치 → 요청 전처리 / 후처리 가능.  
> `@WebFilter` 어노테이션 대신 `FilterRegistrationBean` 사용 시 URL 패턴·순서를 코드로 제어 가능.

---

### 2) Interceptor — MemoInterceptor

```java
@Component
@Slf4j
public class MemoInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                              Object handler) throws Exception {
        // 컨트롤러 진입 전
        log.info("[INTERCEPTOR] Memo컨트롤러 실행 전 : " + request.getRequestURI());
        return true;   // false 반환 시 요청 중단
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object handler, ModelAndView modelAndView) throws Exception {
        // 컨트롤러 실행 완료 후, 뷰 렌더링 전
        log.info("[INTERCEPTOR] Memo컨트롤러 실행 후 : " + request.getRequestURI());
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
                                Object handler, Exception ex) throws Exception {
        // 뷰 렌더링 완료 후 (응답 완전히 끝난 후)
        log.info("[INTERCEPTOR] Memo컨트롤러 요청-응답 완료 후 : " + request.getRequestURI());
    }
}
```

```java
// WebMvcConfig.java — addInterceptors()로 등록
@Autowired
MemoInterceptor memoInterceptor;

@Override
public void addInterceptors(InterceptorRegistry registry) {
    registry.addInterceptor(memoInterceptor)
            .addPathPatterns("/memo/**")
            .excludePathPatterns("resources/css/**", "resources/js/**");
}
```

| 메서드 | 실행 시점 | 반환값 |
|--------|----------|--------|
| `preHandle` | 컨트롤러 실행 전 | `true`: 진행 / `false`: 중단 |
| `postHandle` | 컨트롤러 실행 후, 뷰 렌더링 전 | void |
| `afterCompletion` | 뷰 렌더링 완료 후 | void |

---

### 3) Listener — Spring 이벤트 시스템

#### Spring 기본 이벤트 리스너

```java
// 앱 컨텍스트 초기화 완료 시 발생
public class C01CustomContextRefreshedListener
        implements ApplicationListener<ContextRefreshedEvent> {

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        System.out.println("C01...onApplicationEvent invoke..." + event);
    }
}
```

```java
// DispatcherServlet이 HTTP 요청 처리 완료 시 발생
public class C02RequestHandledEventListener
        implements ApplicationListener<RequestHandledEvent> {

    @Override
    public void onApplicationEvent(RequestHandledEvent event) {
        DispatcherServlet d = (DispatcherServlet) event.getSource();
        System.out.println("C02...onApplicationEvent invoke..." + d);
    }
}
```

| 이벤트 | 발생 시점 |
|--------|----------|
| `ContextRefreshedEvent` | 앱 시작 시 Spring 컨텍스트 초기화 완료 |
| `RequestHandledEvent` | DispatcherServlet이 HTTP 요청 처리 완료 |

#### 커스텀 이벤트

```java
// 이벤트 객체 — ApplicationEvent 상속
public class MemoAddEvent extends ApplicationEvent {

    private MemoDTO dto;

    public MemoAddEvent(Object source, MemoDTO dto) {
        super(source);   // 이벤트 발행자 객체 전달
        this.dto = dto;
    }

    @Override
    public String toString() {
        return "MemoAddEvent{dto=" + dto + '}';
    }
}
```

```java
// 이벤트 리스너
public class MemoAddEventListener implements ApplicationListener<MemoAddEvent> {

    @Override
    public void onApplicationEvent(MemoAddEvent event) {
        System.out.println("[LISTENER] MEMO ADD EVENT " + event);
    }
}
```

```java
// 이벤트 발행 — MemoServiceImpl
@Service
public class MemoServiceImpl implements MemoService {

    @Autowired
    private ApplicationEventPublisher applicationEventPublisher;

    @Override
    @Transactional(rollbackFor = SQLException.class, transactionManager = "jpaTransactionManager")
    public boolean memoRegistration(MemoDTO memoDTO) throws Exception {
        memoDTO.setCreateAt(LocalDateTime.now());
        memoRepository.save(memoDTO.toEntity());
        applicationEventPublisher.publishEvent(new MemoAddEvent(this, memoDTO));   // 이벤트 발행
        return true;
    }
}
```

```java
// WebMvcConfig.java — Listener를 @Bean으로 등록
@Bean
public C01CustomContextRefreshedListener c01CustomContextRefreshedListener() {
    return new C01CustomContextRefreshedListener();
}
@Bean
public C02RequestHandledEventListener c02RequestHandledEventListener() {
    return new C02RequestHandledEventListener();
}
@Bean
public MemoAddEventListener memoAddEventListener() {
    return new MemoAddEventListener();
}
```

> `ApplicationListener<E>` 구현 클래스를 `@Bean`으로 등록하면 Spring이 자동으로 이벤트 구독 처리.  
> `publishEvent()` 는 기본 동기 실행 — 리스너 완료 후 다음 코드 실행.

---

### 전체 요청 처리 흐름

```
HTTP 요청 (POST /memo/add)
    │
    ▼  [FILTER] MemoFilter.doFilter() — 전처리
    │
    ▼  DispatcherServlet
    │
    ▼  [INTERCEPTOR] MemoInterceptor.preHandle()
    │
    ▼  MemoController.memoAddPost()
         └── MemoServiceImpl.memoRegistration()
                  └── memoRepository.save()
                  └── publishEvent(new MemoAddEvent())
                           └── [LISTENER] MemoAddEventListener.onApplicationEvent()
    │
    ▼  [INTERCEPTOR] MemoInterceptor.postHandle()
    │
    ▼  뷰 렌더링 (redirect:/memo/list)
    │
    ▼  [INTERCEPTOR] MemoInterceptor.afterCompletion()
    │
    ▼  [FILTER] MemoFilter.doFilter() — 후처리
    │
    ▼  응답 완료
         └── [LISTENER] C02RequestHandledEventListener.onApplicationEvent()
```

---

## 18_HANDLER_MAPPING — HandlerMapping 커스터마이징

> 17_LISTENER 구조에 `Handler/` 추가. `@RequestMapping` 어노테이션 없이 3가지 방식으로 URL ↔ 핸들러를 수동 매핑.

### 추가된 구조

```
src/main/java/com/example/demo/
└── Handler/
    ├── CustomHandler.java          # Controller 인터페이스 구현 핸들러
    └── RequestCustomHandler.java   # 일반 클래스 핸들러 (Reflection 매핑)
```

---

### HandlerMapping 3가지 방식

#### 1) BeanNameUrlHandlerMapping — 빈 이름 = URL

```java
// WebMvcConfig.java
@Bean
BeanNameUrlHandlerMapping beanNameUrlHandlerMapping() {
    System.out.println("[HANDLER_MAPPER] beanNameUrlHandlerMapping init..");
    return new BeanNameUrlHandlerMapping();
}

@Bean(name = "/custom_01")   // 빈 이름이 곧 매핑 URL
public CustomHandler customHandler() {
    return new CustomHandler();
}
```

```java
// CustomHandler.java — Controller 인터페이스 구현 필수
public class CustomHandler implements Controller {

    @Override
    public ModelAndView handleRequest(HttpServletRequest request,
                                      HttpServletResponse response) throws Exception {
        System.out.println("[HANDLER] CustomHandler's handleRequest invoke..");
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("memo/add");
        return modelAndView;
    }
}
```

> `GET /custom_01` → `@Bean(name="/custom_01")`인 `CustomHandler` 빈을 찾아 실행.  
> `Controller` 인터페이스(`org.springframework.web.servlet.mvc.Controller`) 구현 필수.

---

#### 2) SimpleUrlHandlerMapping — Map으로 명시적 매핑

```java
@Bean
SimpleUrlHandlerMapping simpleUrlHandlerMapping() {
    SimpleUrlHandlerMapping handlerMapping = new SimpleUrlHandlerMapping();

    Map<String, Object> map = new HashMap<>();
    map.put("/custom_02", new CustomHandler());   // URL → 핸들러 인스턴스 직접 지정

    handlerMapping.setUrlMap(map);
    handlerMapping.setOrder(0);   // 우선순위 (낮을수록 먼저 검색)

    return handlerMapping;
}
```

> `setOrder(0)` — Integer.MAX_VALUE가 기본값. 0으로 설정하면 가장 먼저 검색.  
> 정적 자원 매핑(`ResourceHttpRequestHandler`)도 기본적으로 `SimpleUrlHandlerMapping`이 처리.

---

#### 3) RequestMappingHandlerMapping — Reflection 기반 수동 등록

```java
// RequestCustomHandler.java — 일반 클래스, 인터페이스 불필요
public class RequestCustomHandler {

    public String helloWorld() {
        System.out.println("[HANDLER] RequestCustomHandler's helloWorld invoke..");
        return "memo/add";   // 뷰 이름 반환
    }

    @ResponseBody
    public String helloWorld2() {
        System.out.println("[HANDLER] RequestCustomHandler's helloWorld2 invoke..");
        return "HELLOWORLD!!!!!!!";   // @ResponseBody → 바디 직접 출력
    }
}
```

```java
// WebMvcConfig.java
@Bean
RequestMappingHandlerMapping requestMappingHandlerMapping2() throws NoSuchMethodException {
    RequestMappingHandlerMapping handlerMapping = new RequestMappingHandlerMapping();

    Method method = RequestCustomHandler.class.getMethod("helloWorld", null);  // Reflection

    RequestMappingInfo info = RequestMappingInfo
            .paths("/custom_03")
            .methods(RequestMethod.GET)
            .build();

    handlerMapping.registerMapping(info, new RequestCustomHandler(), method);
    return handlerMapping;
}

@Bean
RequestMappingHandlerMapping requestMappingHandlerMapping3() throws NoSuchMethodException {
    RequestMappingHandlerMapping handlerMapping = new RequestMappingHandlerMapping();

    Method method = RequestCustomHandler.class.getMethod("helloWorld2", null);

    RequestMappingInfo info = RequestMappingInfo
            .paths("/custom_04")
            .methods(RequestMethod.GET)
            .produces(MediaType.APPLICATION_JSON_VALUE)   // Accept 헤더 조건
            .build();

    handlerMapping.registerMapping(info, new RequestCustomHandler(), method);
    return handlerMapping;
}
```

> `RequestMappingInfo` 빌더로 URL / HTTP 메서드 / Content-Type 조건을 조합.  
> `registerMapping(info, handlerObject, method)` — 어노테이션 없이 코드로 매핑 등록.  
> `/custom_04`는 `produces(APPLICATION_JSON_VALUE)` 조건 + `@ResponseBody` → JSON 응답.

---

### HandlerMapping 방식 비교

| 방식 | 매핑 기준 | 핸들러 조건 | URL 예시 |
|------|----------|-------------|---------|
| `BeanNameUrlHandlerMapping` | 빈 이름 = URL | `Controller` 인터페이스 구현 | `/custom_01` |
| `SimpleUrlHandlerMapping` | `Map<URL, 핸들러>` 명시 | `Controller` 인터페이스 구현 | `/custom_02` |
| `RequestMappingHandlerMapping` | `RequestMappingInfo` (Reflection) | 일반 클래스 | `/custom_03`, `/custom_04` |
| 일반 `@RequestMapping` | 어노테이션 스캔 | `@Controller` 클래스 | 기존 방식 |

---

### 요청 처리 흐름

```
HTTP 요청
    │
    ▼  DispatcherServlet
    │
    ▼  HandlerMapping 체인 (order 순서)
         ├── SimpleUrlHandlerMapping (order=0)       → /custom_02 매칭 시 CustomHandler
         ├── BeanNameUrlHandlerMapping               → /custom_01 매칭 시 CustomHandler
         └── RequestMappingHandlerMapping            → /custom_03, /custom_04 매칭 시 RequestCustomHandler
    │
    ▼  HandlerAdapter가 핸들러 실행
         ├── /custom_01, /custom_02  → CustomHandler.handleRequest() → ModelAndView("memo/add")
         ├── /custom_03              → helloWorld()                  → ModelAndView("memo/add")
         └── /custom_04              → helloWorld2() + @ResponseBody → "HELLOWORLD!!!!!!!" 직접 출력
    │
    ▼  ViewResolver (/custom_04 제외)
    └── memo/add.html 렌더링
```

---

### 핵심 정리

```
BeanNameUrlHandlerMapping
  @Bean(name="/url") → 빈 이름이 URL, 핸들러는 Controller 인터페이스 구현

SimpleUrlHandlerMapping
  Map<"/url", handlerObject> + setOrder(int) → 우선순위 포함 명시적 매핑

RequestMappingHandlerMapping
  Method method = Class.getMethod("메서드명")           // Reflection으로 메서드 선택
  RequestMappingInfo info = .paths().methods().build()  // 요청 조건 조합
  handlerMapping.registerMapping(info, handler, method) // 등록
```

---

## 19_SPRING_SECURITY / 01_INIT — Spring Security 기본 (Form Login + DB 인증)

### 프로젝트 구조

```
01_INIT/
├── build.gradle
└── src/main/java/com/example/demo/
    ├── DemoApplication.java
    ├── Config/
    │   ├── SecurityConfig.java                   # Security 필터체인 + 권한/로그인/로그아웃/예외처리
    │   ├── DataSourceConfig.java                 # HikariCP DataSource (MySQL)
    │   ├── JPAConfig.java                        # EntityManagerFactory + Hibernate
    │   ├── TxConfig.java                         # JpaTransactionManager
    │   └── auth/
    │       ├── PrincipalDetails.java             # UserDetails 구현체
    │       ├── PrincipalDetailsService.java      # UserDetailsService 구현체
    │       └── Handler/
    │           ├── CustomLoginSuccessHandler.java   # 로그인 성공 → 권한별 리다이렉트
    │           ├── CustomLoginFailurHandler.java    # 로그인 실패 → /login?error=...
    │           ├── CustomLogoutHandler.java         # 로그아웃 직접처리 (세션 무효화)
    │           ├── CustomLogoutSuccessHandler.java  # 로그아웃 완료 → /login?logout=...
    │           ├── CustomAuthenticationEntryPoint.java  # 미인증 접근 예외
    │           └── CustomAccessDeniedHandler.java       # 권한 부족 예외
    ├── Controller/
    │   ├── HomeController.java    # GET /
    │   └── UserController.java   # GET|POST /login, GET|POST /join, GET /user|/manager|/admin
    └── Domain/Common/
        ├── Entity/User.java       # JPA 엔티티 (username PK, password, role)
        ├── Dtos/UserDTO.java
        └── Repository/UserRepository.java   # JpaRepository<User, String>
```

---

### build.gradle

```groovy
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.5.15'
    id 'io.spring.dependency-management' version '1.1.7'
}

java { toolchain { languageVersion = JavaLanguageVersion.of(21) } }

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-security'
    implementation 'org.springframework.boot:spring-boot-starter-thymeleaf'
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.thymeleaf.extras:thymeleaf-extras-springsecurity6'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    runtimeOnly 'com.mysql:mysql-connector-j'
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
    testImplementation 'org.springframework.security:spring-security-test'
//  implementation 'org.springframework.session:spring-session-jdbc'  // 분산 세션 필요 시
}
```

> - `spring-boot-starter-security` — Spring Security 자동 설정 포함  
> - `thymeleaf-extras-springsecurity6` — Thymeleaf에서 `sec:authorize`, `sec:authentication` 등 Security 태그 사용 가능  
> - `spring-session-jdbc` — DB 기반 세션 공유 시 추가 (현재 주석)

---

### application.properties

```properties
spring.application.name=demo
server.port=8090
```

> DataSource 설정은 `DataSourceConfig`에서 직접 코드로 처리 (properties 미사용)

---

### 핵심 클래스

#### SecurityConfig.java — 필터체인 설정

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    protected SecurityFilterChain configure(HttpSecurity http) throws Exception {

        // CSRF 비활성화 (GET 로그아웃 허용 목적)
        http.csrf(config -> config.disable());

        // 권한 설정
        http.authorizeHttpRequests(auth -> {
            auth.requestMatchers("/", "join", "login").permitAll();
            auth.requestMatchers("/user").hasAnyRole("USER", "ADMIN");
            auth.requestMatchers("/manager").hasAnyRole("MANAGER");
            auth.requestMatchers("/admin").hasAnyRole("ADMIN");
            auth.anyRequest().authenticated();
        });

        // Form 로그인
        http.formLogin(login -> {
            login.permitAll();
            login.loginPage("/login");
            login.successHandler(new CustomLoginSuccessHandler());
            login.failureHandler(new CustomLoginFailurHandler());
        });

        // 로그아웃
        http.logout(logout -> {
            logout.permitAll();
            logout.addLogoutHandler(new CustomLogoutHandler());
            logout.logoutSuccessHandler(new CustomLogoutSuccessHandler());
        });

        // 예외 처리
        http.exceptionHandling(ex -> {
            ex.authenticationEntryPoint(new CustomAuthenticationEntryPoint());  // 미인증
            ex.accessDeniedHandler(new CustomAccessDeniedHandler());            // 권한 부족
        });

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
```

> **`hasRole` vs `hasAnyRole`**: Spring Security는 role에 자동으로 `ROLE_` 접두사를 붙임.  
> `hasRole("USER")` = DB에 `ROLE_USER` 저장된 권한과 매칭.

---

#### User.java — JPA 엔티티

```java
@Entity
@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class User {
    @Id
    private String username;   // PK = 아이디
    private String password;
    private String role;       // "ROLE_USER" 또는 "ROLE_USER,ROLE_ADMIN" 등 콤마 구분
}
```

---

#### UserDTO.java

```java
@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class UserDTO {
    private String username;
    private String password;
    private String role;
}
```

---

#### PrincipalDetails.java — `UserDetails` 구현체

```java
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class PrincipalDetails implements UserDetails {

    private UserDTO userDTO;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> authorities = new ArrayList<>();
        // "ROLE_USER,ROLE_ADMIN" → 콤마로 분리 → 각각 GrantedAuthority 추가
        for (String role : userDTO.getRole().split(",")) {
            authorities.add(new SimpleGrantedAuthority(role));
        }
        return authorities;
    }

    @Override public String getPassword() { return userDTO.getPassword(); }
    @Override public String getUsername() { return userDTO.getUsername(); }
    @Override public boolean isAccountNonExpired()     { return true; }
    @Override public boolean isAccountNonLocked()      { return true; }
    @Override public boolean isCredentialsNonExpired() { return true; }
    @Override public boolean isEnabled()               { return true; }
}
```

---

#### PrincipalDetailsService.java — `UserDetailsService` 구현체

```java
@Service @Slf4j
public class PrincipalDetailsService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        log.info("PrincipalDetailsService's loadUserByUsername...{}", username);
        User user = userRepository.findById(username)
                .orElseThrow(() -> new UsernameNotFoundException(username + "이 존재하지 않습니다."));

        UserDTO userDTO = UserDTO.builder()
                .username(user.getUsername())
                .password(user.getPassword())
                .role(user.getRole())
                .build();
        return new PrincipalDetails(userDTO);
    }
}
```

> Spring Security가 로그인 시 `loadUserByUsername(입력한 ID)` 를 자동 호출 →  
> 반환된 `UserDetails`의 `getPassword()`와 입력 비밀번호를 `PasswordEncoder.matches()`로 비교

---

#### Handler 클래스 6종

**CustomLoginSuccessHandler** — 권한별 리다이렉트
```java
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
    @Override
    public void onAuthenticationSuccess(HttpServletRequest req, HttpServletResponse res,
                                        Authentication auth) throws IOException {
        String redirectUrl = "/user";  // 기본
        for (GrantedAuthority authority : auth.getAuthorities()) {
            String role = authority.getAuthority();
            if (role.contains("ROLE_ADMIN"))   { redirectUrl = "/admin";   break; }
            else if (role.contains("ROLE_MANAGER")) { redirectUrl = "/manager"; break; }
        }
        res.sendRedirect(redirectUrl);
    }
}
```

**CustomLoginFailurHandler** — 실패 메시지 전달
```java
public class CustomLoginFailurHandler implements AuthenticationFailureHandler {
    @Override
    public void onAuthenticationFailure(HttpServletRequest req, HttpServletResponse res,
                                        AuthenticationException ex) throws IOException {
        res.sendRedirect("/login?error=" + URLEncoder.encode(ex.getMessage(), "utf-8"));
    }
}
```

**CustomLogoutHandler** — 세션 직접 무효화
```java
public class CustomLogoutHandler implements LogoutHandler {
    @Override
    public void logout(HttpServletRequest req, HttpServletResponse res, Authentication auth) {
        HttpSession session = req.getSession(false);
        if (session != null) session.invalidate();
    }
}
```

**CustomLogoutSuccessHandler** — 로그아웃 완료 후 이동
```java
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {
    @Override
    public void onLogoutSuccess(HttpServletRequest req, HttpServletResponse res,
                                Authentication auth) throws IOException {
        res.sendRedirect("/login?logout=" + URLEncoder.encode("로그아웃 성공", "utf-8"));
    }
}
```

**CustomAuthenticationEntryPoint** — 미인증 접근 처리
```java
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {
    @Override
    public void commence(HttpServletRequest req, HttpServletResponse res,
                         AuthenticationException ex) throws IOException {
        // 미인증 상태에서 보호된 엔드포인트 접근 시 로그인 페이지로 이동
        res.sendRedirect("/login?error=" + URLEncoder.encode(ex.getMessage(), "utf-8"));
    }
}
```

**CustomAccessDeniedHandler** — 권한 부족 처리
```java
public class CustomAccessDeniedHandler implements AccessDeniedHandler {
    @Override
    public void handle(HttpServletRequest req, HttpServletResponse res,
                       AccessDeniedException ex) throws IOException {
        // 인증은 됐지만 권한이 부족할 때
        res.sendRedirect("/login?error=" + URLEncoder.encode(ex.getMessage(), "utf-8"));
    }
}
```

---

#### UserController.java

```java
@Controller @Slf4j
public class UserController {

    @Autowired private UserRepository userRepository;
    @Autowired private PasswordEncoder passwordEncoder;

    @GetMapping("/login")
    public void login() { }

    @GetMapping("join")
    public void join_get() { }

    @PostMapping("join")
    public String join_post(UserDTO userDTO) {
        User user = User.builder()
                .username(userDTO.getUsername())
                .password(passwordEncoder.encode(userDTO.getPassword()))  // BCrypt 암호화
                .role("ROLE_USER")
                .build();
        userRepository.save(user);
        return "redirect:/login";
    }

    @GetMapping("/user")    public void user()    { }
    @GetMapping("/manager") public void manager() { }
    @GetMapping("/admin")   public void admin()   { }
}
```

---

#### DataSourceConfig.java / JPAConfig.java / TxConfig.java

```java
// DataSourceConfig — HikariCP (MySQL)
@Configuration
public class DataSourceConfig {
    @Bean
    public DataSource dataSource() {
        HikariDataSource ds = new HikariDataSource();
        ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
        ds.setJdbcUrl("jdbc:mysql://localhost:3306/testdb");
        ds.setUsername("root");
        ds.setPassword("1234");
        return ds;
    }
}

// JPAConfig — EntityManagerFactory
@Configuration
@EntityScan("com.example.demo.Domain.Common.Entity")
@EnableJpaRepositories(
    basePackages = "com.example.demo.Domain.Common.Repository",
    transactionManagerRef = "jpaTransactionManager"
)
public class JPAConfig {
    @Autowired DataSource dataSource;

    @Bean
    LocalContainerEntityManagerFactoryBean entityManagerFactory() {
        LocalContainerEntityManagerFactoryBean emf = new LocalContainerEntityManagerFactoryBean();
        emf.setDataSource(dataSource);
        emf.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        emf.setPackagesToScan("com.example.demo.Domain.Common.Entity");
        Map<String, Object> props = new HashMap<>();
        props.put("hibernate.hbm2ddl.auto", "update");
        props.put("hibernate.show_sql", true);
        emf.setJpaPropertyMap(props);
        return emf;
    }
}

// TxConfig — JpaTransactionManager
@Configuration @EnableTransactionManagement
public class TxConfig {
    @Autowired DataSource dataSource;

    @Bean("jpaTransactionManager")
    public JpaTransactionManager jpaTransactionManager(EntityManagerFactory emf) {
        JpaTransactionManager tm = new JpaTransactionManager();
        tm.setEntityManagerFactory(emf);
        tm.setDataSource(dataSource);
        return tm;
    }
}
```

---

### 인증 흐름

```
POST /login (username, password)
    │
    ▼
Spring Security UsernamePasswordAuthenticationFilter
    │
    ▼
PrincipalDetailsService.loadUserByUsername(username)
    → UserRepository.findById(username)
    → UserDTO 생성 → PrincipalDetails 반환
    │
    ▼
BCryptPasswordEncoder.matches(입력PW, DB의 인코딩PW)
    ├── 일치 → CustomLoginSuccessHandler (권한별 리다이렉트)
    └── 불일치 → CustomLoginFailurHandler → /login?error=...
```

---

### 권한 처리 흐름

```
요청 URL 접근
    │
    ▼
authorizeHttpRequests 룰 확인
    ├── permitAll() 경로 → 통과
    ├── 미인증 + 보호 경로 → CustomAuthenticationEntryPoint → /login?error=...
    └── 인증됨 + 권한 부족 → CustomAccessDeniedHandler → /login?error=...
```

---

### 세팅 체크리스트

| 항목 | 값 |
|------|-----|
| Spring Boot | 3.5.15 |
| Java | 21 |
| 포트 | 8090 |
| 뷰 엔진 | Thymeleaf |
| DB | MySQL (`testdb`) |
| 비밀번호 암호화 | BCryptPasswordEncoder |
| 역할 저장 형식 | `ROLE_USER`, `ROLE_ADMIN` 등 (콤마로 다중 역할 가능) |
| 세션 방식 | 기본 HttpSession (in-memory) |
| DataSource 설정 방식 | `@Configuration + @Bean` 수동 설정 |

---

## 19_SPRING_SECURITY / 02_OAUTH2_CLIENT — OAuth2 소셜 로그인 (카카오 / 네이버 / 구글)

> 01_INIT 구조에서 `spring-boot-starter-oauth2-client` 추가.  
> Form 로그인은 그대로 유지하면서 `oauth2Login()` 을 추가해 소셜 로그인을 병행.  
> `PrincipalDetails`가 `UserDetails + OAuth2User` 를 동시에 구현해 로컬/소셜 인증을 단일 객체로 통합.

### 01_INIT 대비 추가/변경 사항

| 파일 | 변경 내용 |
|------|----------|
| `build.gradle` | `spring-boot-starter-oauth2-client` 추가 |
| `SecurityConfig` | `http.oauth2Login()` 블록 추가 |
| `PrincipalDetails` | `OAuth2User` 인터페이스 추가 구현, `attributes` 필드 추가 |
| `PrincipalDetailsOauth2Service` | 신규 — `DefaultOAuth2UserService` 상속, 소셜 계정 → 로컬 DB 연동 |
| `Provider/` | 신규 — `OAuth2UserInfo` 인터페이스 + Kakao / Naver / Google 구현체 |

---

### 프로젝트 구조 (추가분)

```
Config/auth/
├── PrincipalDetails.java              # UserDetails + OAuth2User 동시 구현 (변경)
├── PrincipalDetailsService.java       # Form 로그인용 (01_INIT과 동일)
├── PrincipalDetailsOauth2Service.java # OAuth2 로그인용 (신규)
└── Provider/
    ├── OAuth2UserInfo.java            # 공통 인터페이스
    ├── KakaoUserInfo.java             # 카카오 응답 파싱
    ├── NaverUserInfo.java             # 네이버 응답 파싱
    └── GoogleUserInfo.java            # 구글 응답 파싱
```

---

### build.gradle (추가 의존성)

```groovy
implementation 'org.springframework.boot:spring-boot-starter-security'
implementation 'org.springframework.boot:spring-boot-starter-oauth2-client'  // ← 추가
testImplementation 'org.springframework.security:spring-security-test'
```

---

### application.properties — OAuth2 클라이언트 설정

```properties
server.port=8090

# ── KAKAO ──────────────────────────────────────────────────────────
spring.security.oauth2.client.registration.kakao.client-id=
spring.security.oauth2.client.registration.kakao.client-secret=
spring.security.oauth2.client.registration.kakao.client-authentication-method=client_secret_post
spring.security.oauth2.client.registration.kakao.redirect-uri=http://localhost:8090/login/oauth2/code/kakao
spring.security.oauth2.client.registration.kakao.authorization-grant-type=authorization_code
spring.security.oauth2.client.registration.kakao.scope=profile_nickname,profile_image,account_email
spring.security.oauth2.client.registration.kakao.client-name=Kakao

spring.security.oauth2.client.provider.kakao.authorization-uri=https://kauth.kakao.com/oauth/authorize
spring.security.oauth2.client.provider.kakao.token-uri=https://kauth.kakao.com/oauth/token
spring.security.oauth2.client.provider.kakao.user-info-uri=https://kapi.kakao.com/v2/user/me
spring.security.oauth2.client.provider.kakao.user-name-attribute=id

# ── NAVER ──────────────────────────────────────────────────────────
spring.security.oauth2.client.registration.naver.client-id=
spring.security.oauth2.client.registration.naver.client-secret=
spring.security.oauth2.client.registration.naver.redirect-uri=http://localhost:8090/login/oauth2/code/naver
spring.security.oauth2.client.registration.naver.scope=name,email,profile_image
spring.security.oauth2.client.registration.naver.client-name=Naver
spring.security.oauth2.client.registration.naver.authorization-grant-type=authorization_code
spring.security.oauth2.client.registration.naver.provider=naver

spring.security.oauth2.client.provider.naver.authorization-uri=https://nid.naver.com/oauth2.0/authorize
spring.security.oauth2.client.provider.naver.token-uri=https://nid.naver.com/oauth2.0/token
spring.security.oauth2.client.provider.naver.user-info-uri=https://openapi.naver.com/v1/nid/me
spring.security.oauth2.client.provider.naver.user-name-attribute=response

# ── GOOGLE ─────────────────────────────────────────────────────────
spring.security.oauth2.client.registration.google.client-id=
spring.security.oauth2.client.registration.google.client-secret=
spring.security.oauth2.client.registration.google.scope=email,profile
# Google은 provider 정보가 Spring Boot에 내장되어 있어 provider 블록 불필요
```

> **user-name-attribute 포인트**  
> - Kakao: 최상위 키가 `id` (숫자) → `provider.kakao.user-name-attribute=id`  
> - Naver: 최상위 키가 `response` (Map) → `provider.naver.user-name-attribute=response`  
> - Google: Spring Boot 내장 provider 사용 → 설정 불필요 (`sub` 키가 기본)

---

### SecurityConfig.java — oauth2Login() 추가

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    protected SecurityFilterChain configure(HttpSecurity http) throws Exception {
        http.csrf(config -> config.disable());

        http.authorizeHttpRequests(auth -> {
            auth.requestMatchers("/", "join", "login").permitAll();
            auth.requestMatchers("/user").hasAnyRole("USER", "ADMIN");
            auth.requestMatchers("/manager").hasAnyRole("MANAGER");
            auth.requestMatchers("/admin").hasAnyRole("ADMIN");
            auth.anyRequest().authenticated();
        });

        // Form 로그인 (01_INIT과 동일)
        http.formLogin(login -> {
            login.permitAll();
            login.loginPage("/login");
            login.successHandler(new CustomLoginSuccessHandler());
            login.failureHandler(new CustomLoginFailurHandler());
        });

        http.logout(logout -> {
            logout.permitAll();
            logout.addLogoutHandler(new CustomLogoutHandler());
            logout.logoutSuccessHandler(new CustomLogoutSuccessHandler());
        });

        http.exceptionHandling(ex -> {
            ex.authenticationEntryPoint(new CustomAuthenticationEntryPoint());
            ex.accessDeniedHandler(new CustomAccessDeniedHandler());
        });

        // OAuth2 소셜 로그인 ← 추가
        http.oauth2Login(oauth2 -> {
            oauth2.loginPage("/login");   // 커스텀 로그인 페이지 (소셜 버튼이 있는 페이지)
        });

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
```

> `oauth2Login().loginPage("/login")` 만 설정하면 Spring Security가 자동으로  
> `PrincipalDetailsOauth2Service.loadUser()` 를 호출해 소셜 계정 정보를 처리함.

---

### OAuth2UserInfo.java — 공통 인터페이스

```java
public interface OAuth2UserInfo {
    String getName();        // 닉네임/이름
    String getEmail();       // 이메일
    String getProvider();    // "Kakao" | "Naver" | "Google"
    String getProviderId();  // 각 플랫폼의 고유 ID
    Map<String, Object> getAttribute();  // 원본 계정 정보 Map
}
```

---

### Provider 구현체 3종

**KakaoUserInfo**
```java
public class KakaoUserInfo implements OAuth2UserInfo {
    private Long id;
    private LocalDateTime connected_at;
    private Map<String,Object> properties;     // nickname, profile_image
    private Map<String,Object> kakao_account;  // email 등

    @Override public String getProvider()   { return "Kakao"; }
    @Override public String getProviderId() { return id != null ? id.toString() : "-1"; }
    @Override public String getName()       { return (String) properties.get("nickname"); }
    @Override public String getEmail()      { return (String) properties.get("email"); }
    @Override public Map<String,Object> getAttribute() { return kakao_account; }
}
```

> 카카오 응답 구조:  
> `{ id, connected_at, properties: { nickname, profile_image }, kakao_account: { email, ... } }`

**NaverUserInfo**
```java
public class NaverUserInfo implements OAuth2UserInfo {
    private String resultcode;
    private String message;
    private Map<String,Object> response;  // id, name, email, profile_image

    @Override public String getProvider()   { return "Naver"; }
    @Override public String getProviderId() { return (String) response.get("id"); }
    @Override public String getName()       { return (String) response.get("name"); }
    @Override public String getEmail()      { return (String) response.get("email"); }
    @Override public Map<String,Object> getAttribute() { return response; }
}
```

> 네이버 응답 구조: `{ resultcode, message, response: { id, name, email, ... } }`  
> `user-name-attribute=response` → attributes.get("response") 로 접근

**GoogleUserInfo**
```java
public class GoogleUserInfo implements OAuth2UserInfo {
    private Map<String,Object> attributes;  // sub, name, email, picture ...

    @Override public String getProvider()   { return "Google"; }
    @Override public String getProviderId() { return (String) attributes.get("sub"); }
    @Override public String getName()       { return (String) attributes.get("name"); }
    @Override public String getEmail()      { return (String) attributes.get("email"); }
    @Override public Map<String,Object> getAttribute() { return attributes; }
}
```

> 구글은 응답이 flat Map → attributes에서 바로 꺼냄. `sub`이 고유 ID.

---

### PrincipalDetailsOauth2Service.java — 소셜 로그인 처리 핵심

```java
@Service @Slf4j
public class PrincipalDetailsOauth2Service extends DefaultOAuth2UserService {

    @Autowired private PasswordEncoder passwordEncoder;
    @Autowired private UserRepository userRepository;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        // 1. 부모 호출 → 액세스 토큰으로 사용자 정보 조회
        OAuth2User oAuth2User = super.loadUser(userRequest);

        String provider = userRequest.getClientRegistration().getClientName(); // "Kakao" | "Naver" | "Google"
        Map<String, Object> attributes = oAuth2User.getAttributes();

        // 2. provider별로 OAuth2UserInfo 구현체 생성
        OAuth2UserInfo oAuth2UserInfo = null;
        String username = null;

        if (provider.startsWith("Kakao")) {
            Long id = (Long) attributes.get("id");
            LocalDateTime connected_at = OffsetDateTime.parse(attributes.get("connected_at").toString()).toLocalDateTime();
            Map<String,Object> properties    = (Map<String,Object>) attributes.get("properties");
            Map<String,Object> kakao_account = (Map<String,Object>) attributes.get("kakao_account");
            oAuth2UserInfo = new KakaoUserInfo(id, connected_at, properties, kakao_account);

        } else if (provider.startsWith("Naver")) {
            String resultcode = (String) attributes.get("resultcode");
            String message    = (String) attributes.get("message");
            Map<String,Object> response = (Map<String,Object>) attributes.get("response");
            oAuth2UserInfo = new NaverUserInfo(resultcode, message, response);

        } else if (provider.startsWith("Google")) {
            oAuth2UserInfo = new GoogleUserInfo(attributes);
        }

        username = oAuth2UserInfo.getProvider() + "_" + oAuth2UserInfo.getProviderId();
        // ex) "Kakao_1234567890", "Naver_abcde12345", "Google_11223344"

        // 3. 최초 로그인 시 DB에 로컬 계정 자동 생성 (이후엔 조회만)
        String password = passwordEncoder.encode("1234");
        UserDTO userDTO;

        if (!userRepository.existsById(username)) {
            User user = User.builder()
                    .username(username).password(password).role("ROLE_USER").build();
            userRepository.save(user);
            userDTO = UserDTO.builder()
                    .username(username).password(password).role("ROLE_USER").build();
        } else {
            User user = userRepository.findById(username).get();
            userDTO = UserDTO.builder()
                    .username(user.getUsername()).password(user.getPassword()).role(user.getRole()).build();
        }

        // 4. PrincipalDetails(userDTO + attributes) 반환 → SecurityContext에 저장
        return PrincipalDetails.builder().userDTO(userDTO).attributes(attributes).build();
    }
}
```

---

### PrincipalDetails.java — UserDetails + OAuth2User 통합

```java
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class PrincipalDetails implements UserDetails, OAuth2User {

    private UserDTO userDTO;

    // ── UserDetails (Form 로그인) ──────────────────────────────────
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> authorities = new ArrayList<>();
        for (String role : userDTO.getRole().split(","))
            authorities.add(new SimpleGrantedAuthority(role));
        return authorities;
    }
    @Override public String getPassword()              { return userDTO.getPassword(); }
    @Override public String getUsername()              { return userDTO.getUsername(); }
    @Override public boolean isAccountNonExpired()     { return true; }
    @Override public boolean isAccountNonLocked()      { return true; }
    @Override public boolean isCredentialsNonExpired() { return true; }
    @Override public boolean isEnabled()               { return true; }

    // ── OAuth2User (소셜 로그인) ──────────────────────────────────
    Map<String, Object> attributes;  // 소셜 응답 원본

    @Override public Map<String, Object> getAttributes() { return attributes; }
    @Override public String getName() { return userDTO.getUsername(); }
}
```

> `UserDetails`만 구현하면 Form 로그인만 처리 가능.  
> `OAuth2User`도 같이 구현하면 소셜 로그인 후 반환 객체를 동일한 `PrincipalDetails`로 통일할 수 있음.  
> Form 로그인 시 `attributes`는 `null`, 소셜 로그인 시 `attributes`에 원본 응답 Map이 담김.

---

### OAuth2 인증 흐름

```
브라우저 → GET /oauth2/authorization/kakao  (로그인 버튼 클릭)
    │
    ▼
Spring Security → 카카오 인증 서버로 리다이렉트
    │     (authorization-uri + client-id + redirect-uri + scope)
    ▼
사용자 카카오 로그인 완료
    │
    ▼
카카오 → 콜백: GET /login/oauth2/code/kakao?code=xxx
    │
    ▼
Spring Security → token-uri로 액세스 토큰 교환
    │
    ▼
PrincipalDetailsOauth2Service.loadUser(userRequest)
    ├── super.loadUser() → user-info-uri로 사용자 정보 조회
    ├── provider 판별 → KakaoUserInfo / NaverUserInfo / GoogleUserInfo 생성
    ├── username = "Kakao_1234567890" 형식으로 조합
    ├── DB에 없으면 → User 엔티티 생성 + 저장 (최초 1회)
    └── PrincipalDetails(userDTO + attributes) 반환
    │
    ▼
SecurityContext에 Authentication 저장
    │
    ▼
CustomLoginSuccessHandler → 권한별 리다이렉트
```

---

### 소셜별 응답 구조 비교

| 항목 | Kakao | Naver | Google |
|------|-------|-------|--------|
| user-name-attribute | `id` | `response` | (내장) |
| 고유 ID 키 | `attributes["id"]` (Long) | `response["id"]` | `attributes["sub"]` |
| 닉네임 키 | `properties["nickname"]` | `response["name"]` | `attributes["name"]` |
| 이메일 키 | `properties["email"]` | `response["email"]` | `attributes["email"]` |
| provider 블록 | 필요 (비표준) | 필요 (비표준) | 불필요 (Spring Boot 내장) |
| 인증 방식 | `client_secret_post` | 기본 | 기본 |

---

### 세팅 체크리스트

| 항목 | 값 |
|------|-----|
| 추가 의존성 | `spring-boot-starter-oauth2-client` |
| 콜백 URL 패턴 | `/login/oauth2/code/{registrationId}` |
| username 생성 규칙 | `{Provider}_{ProviderId}` (ex. `Kakao_1234`) |
| 최초 로그인 처리 | `existsById()` 확인 후 없으면 User 엔티티 자동 생성 |
| 비밀번호 | `passwordEncoder.encode("1234")` (소셜 계정용 더미) |
| 역할 | 소셜 로그인 시 `ROLE_USER` 고정 |

---

## 19_SPRING_SECURITY / 03_JWT_TOKEN — JWT 토큰 인증 (Stateless)

> 02_OAUTH2_CLIENT 구조에 JWT 토큰 발급/검증/갱신 로직 추가.
> 세션을 완전히 제거(`STATELESS`)하고, 인증 상태를 Cookie(access-token) + DB(refresh-token)로 관리.

### 02_OAUTH2_CLIENT 대비 추가/변경 사항

| 파일 | 변경 내용 |
|------|----------|
| `build.gradle` | jjwt-api / jjwt-impl / jjwt-jackson 추가 |
| `SecurityConfig` | `SessionCreationPolicy.STATELESS` + `addFilterBefore(jwtFilter, LogoutFilter)` |
| `jwt/JWTProperties` | 신규 — 만료시간·쿠키명 상수 |
| `jwt/JWTTokenProvider` | 신규 — 토큰 발급 / 파싱 / 검증 |
| `jwt/JWTAuthorizationFilter` | 신규 — `OncePerRequestFilter` 쿠키 토큰 검사 |
| `jwt/TokenInfo` | 신규 — accessToken + refreshToken DTO |
| `jwt/KeyGenerator` | 신규 — HMAC 서명 키 생성 |
| `Entity/JwtToken` | 신규 — access+refresh+username+auth DB 저장 |
| `Entity/Signature` | 신규 — 서명 키 바이트를 DB에 영속 |
| `Handler/CustomLoginSuccessHandler` | 변경 — 로그인 시 토큰 발급 + 쿠키 응답 + DB 저장 |

---

### 프로젝트 구조

```
03_JWT_TOKEN/src/main/java/com/example/demo/
├── Config/auth/
│   ├── Handler/
│   │   ├── CustomLoginSuccessHandler.java     # 토큰 발급 + 쿠키 + DB 저장
│   │   ├── CustomLoginFailureHandler.java
│   │   ├── CustomLogoutHandler.java
│   │   ├── CustomLogoutSuccessHandler.java
│   │   ├── CustomAuthenticationEntryPoint.java
│   │   └── CustomAccessDeniedHandler.java
│   ├── jwt/
│   │   ├── JWTProperties.java                 # 만료시간·쿠키명 상수
│   │   ├── JWTTokenProvider.java              # 토큰 발급 / 파싱 / 검증
│   │   ├── JWTAuthorizationFilter.java        # OncePerRequestFilter
│   │   ├── TokenInfo.java                     # accessToken + refreshToken DTO
│   │   └── KeyGenerator.java                  # HMAC 서명 키 바이트 생성
│   └── Provider/ (OAuth2UserInfo / KakaoUserInfo / NaverUserInfo / GoogleUserInfo)
└── Domain/Common/
    ├── Entity/
    │   ├── JwtToken.java      # access+refresh+username+auth 저장
    │   └── Signature.java     # 서명 키 바이트 DB 영속
    └── Repository/ (JwtTokenRepository / SignatureRepository)
```

---

### build.gradle

```groovy
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    implementation 'org.springframework.boot:spring-boot-starter-security'
    implementation 'org.springframework.boot:spring-boot-starter-thymeleaf'
    implementation 'org.thymeleaf.extras:thymeleaf-extras-springsecurity6'
    implementation 'org.springframework.boot:spring-boot-starter-oauth2-client'
    runtimeOnly 'com.mysql:mysql-connector-j'
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
    testImplementation 'org.springframework.security:spring-security-test'

    // JWT
    implementation 'io.jsonwebtoken:jjwt-api:0.13.0'
    runtimeOnly 'io.jsonwebtoken:jjwt-impl:0.13.0'
    runtimeOnly 'io.jsonwebtoken:jjwt-jackson:0.13.0'
}
```

---

### JWTProperties.java — 상수 모음

```java
public class JWTProperties {
    public static final int    ACCESS_TOKEN_EXPIRATION_TIME  = 1000 * 60 * 5;   // 5분 (밀리초)
    public static final int    REFRESH_TOKEN_EXPIRATION_TIME = 1000 * 60 * 10;  // 10분 (밀리초)
    public static final String ACCESS_TOKEN_COOKIE_NAME      = "access-token";
    public static final String REFRESH_TOKEN_COOKIE_NAME     = "refresh-token";
}
```

---

### JWTTokenProvider.java — 토큰 발급 / 파싱 / 검증

```java
@Slf4j @Component
public class JWTTokenProvider {

    private Key key;

    // 앱 기동 시 DB에서 키 로드 (없으면 새로 생성 후 저장) — 재시작해도 기존 토큰 유효
    @PostConstruct
    public void init() {
        List<Signature> list = signatureRepository.findAll();
        if (list.isEmpty()) {
            byte[] keyBytes = KeyGenerator.keyGen();
            this.key = Keys.hmacShaKeyFor(keyBytes);
            Signature sig = new Signature();
            sig.setKeyBytes(keyBytes);
            sig.setCreateAt(LocalDate.now());
            signatureRepository.save(sig);
        } else {
            this.key = Keys.hmacShaKeyFor(list.get(0).getKeyBytes());
        }
    }

    // access(5분) + refresh(10분) 발급
    public TokenInfo generateToken(Authentication authentication) {
        String authorities = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.joining(","));   // "ROLE_USER,ROLE_ADMIN"

        long now = new Date().getTime();
        String accessToken = Jwts.builder()
                .setSubject(authentication.getName())
                .setExpiration(new Date(now + JWTProperties.ACCESS_TOKEN_EXPIRATION_TIME))
                .signWith(key, SignatureAlgorithm.HS256)
                .claim("username", authentication.getName())
                .claim("auth", authorities)
                .compact();

        String refreshToken = Jwts.builder()
                .setSubject("Refresh_Token_Title")
                .setExpiration(new Date(now + JWTProperties.REFRESH_TOKEN_EXPIRATION_TIME))
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();

        return TokenInfo.builder()
                .grantType("Bearer").accessToken(accessToken).refreshToken(refreshToken)
                .build();
    }

    // access-token -> Authentication 변환
    public Authentication getAuthentication(String accessToken) {
        Claims claims = Jwts.parser().setSigningKey(key).build()
                            .parseClaimsJws(accessToken).getBody();
        String username = (String) claims.get("username");
        String auth     = (String) claims.get("auth");  // "ROLE_USER,ROLE_ADMIN"

        Collection<GrantedAuthority> authorities = Arrays.stream(auth.split(","))
                .map(SimpleGrantedAuthority::new).collect(Collectors.toList());

        if (userRepository.existsById(username)) {
            UserDTO dto = new UserDTO();
            dto.setUsername(username); dto.setRole(auth); dto.setPassword(null);
            return new UsernamePasswordAuthenticationToken(new PrincipalDetails(dto, null), null, authorities);
        }
        return null;
    }

    // 유효성 검사 — 만료 시 ExpiredJwtException 던짐
    public boolean validateToken(String token) throws Exception {
        Jwts.parser().setSigningKey(key).build().parseClaimsJws(token);
        return true;
    }
}
```

> **validateToken 예외 종류**
> `SecurityException` — 서명 불일치 | `MalformedJwtException` — JWT 구조 깨짐
> `ExpiredJwtException` — 만료 | `UnsupportedJwtException` — 미지원 형식

---

### JwtToken.java — DB 엔티티

```java
@Entity @Data @Builder @NoArgsConstructor @AllArgsConstructor
public class JwtToken {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(columnDefinition = "TEXT", nullable = false) private String accessToken;
    @Column(columnDefinition = "TEXT", nullable = false) private String refreshToken;
    @Column private String username;
    @Column private String auth;  // "ROLE_USER,ROLE_ADMIN"
    @Column(name = "createdAt", columnDefinition = "DATETIME", nullable = false)
    private LocalDateTime createAt;
}
```

---

### CustomLoginSuccessHandler.java — 로그인 성공 처리

```java
@Override
public void onAuthenticationSuccess(HttpServletRequest request,
                                    HttpServletResponse response,
                                    Authentication authentication) throws IOException {
    // 1) 토큰 발급
    TokenInfo tokenInfo = jwtTokenProvider.generateToken(authentication);

    // 2) access-token 쿠키 (HttpOnly — XSS 탈취 방지)
    Cookie cookie = new Cookie(JWTProperties.ACCESS_TOKEN_COOKIE_NAME, tokenInfo.getAccessToken());
    cookie.setMaxAge(JWTProperties.ACCESS_TOKEN_EXPIRATION_TIME);
    cookie.setPath("/"); cookie.setHttpOnly(true);
    response.addCookie(cookie);

    // 3) refresh-token DB 저장
    PrincipalDetails principal = (PrincipalDetails) authentication.getPrincipal();
    jwtTokenRepository.save(JwtToken.builder()
            .accessToken(tokenInfo.getAccessToken())
            .refreshToken(tokenInfo.getRefreshToken())
            .username(authentication.getName())
            .auth(principal.getUserDTO().getRole())
            .createAt(LocalDateTime.now())
            .build());

    // 4) 권한별 리다이렉트
    String redirectUrl = "/user";
    for (GrantedAuthority a : authentication.getAuthorities()) {
        if (a.getAuthority().contains("ROLE_ADMIN"))   { redirectUrl = "/admin";   break; }
        if (a.getAuthority().contains("ROLE_MANAGER")) { redirectUrl = "/manager"; break; }
    }
    response.sendRedirect(redirectUrl);
}
```

---

### JWTAuthorizationFilter.java — OncePerRequestFilter

```java
@Component
public class JWTAuthorizationFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        // 1) access-token 쿠키 추출
        Cookie[] cookies = request.getCookies();
        String token = (cookies == null) ? null :
            Arrays.stream(cookies)
                  .filter(c -> c.getName().equals(JWTProperties.ACCESS_TOKEN_COOKIE_NAME))
                  .findFirst().map(Cookie::getValue).orElse(null);

        if (token != null) {
            try {
                // 2) 유효 -> SecurityContextHolder 등록
                if (jwtTokenProvider.validateToken(token)) {
                    Authentication auth = jwtTokenProvider.getAuthentication(token);
                    if (auth != null) SecurityContextHolder.getContext().setAuthentication(auth);
                }
            } catch (ExpiredJwtException e1) {
                // 3) access-token 만료 -> DB 조회 -> refresh 확인
                JwtToken entity = jwtTokenRepository.findByAccessToken(token);
                if (entity != null) {
                    try {
                        if (jwtTokenProvider.validateToken(entity.getRefreshToken())) {
                            // 4) access-token 재발급 -> 쿠키 갱신 + DB 갱신
                            String newToken = Jwts.builder()
                                    .setSubject(entity.getUsername())
                                    .setExpiration(new Date(System.currentTimeMillis()
                                            + JWTProperties.ACCESS_TOKEN_EXPIRATION_TIME))
                                    .signWith(jwtTokenProvider.getKey(), SignatureAlgorithm.HS256)
                                    .claim("username", entity.getUsername())
                                    .claim("auth", entity.getAuth())
                                    .compact();

                            Cookie newCookie = new Cookie(JWTProperties.ACCESS_TOKEN_COOKIE_NAME, newToken);
                            newCookie.setMaxAge(JWTProperties.ACCESS_TOKEN_EXPIRATION_TIME);
                            newCookie.setPath("/"); newCookie.setHttpOnly(true);
                            response.addCookie(newCookie);

                            entity.setAccessToken(newToken);
                            jwtTokenRepository.save(entity);

                            Authentication auth = jwtTokenProvider.getAuthentication(newToken);
                            if (auth != null) SecurityContextHolder.getContext().setAuthentication(auth);
                        }
                    } catch (ExpiredJwtException e2) {
                        // 5) refresh도 만료 -> 쿠키 삭제 + DB 삭제
                        Cookie expire = new Cookie(JWTProperties.ACCESS_TOKEN_COOKIE_NAME, null);
                        expire.setMaxAge(0); response.addCookie(expire);
                        jwtTokenRepository.deleteById(entity.getId());
                    }
                }
            }
        }
        filterChain.doFilter(request, response);
    }
}
```

---

### SecurityConfig.java — STATELESS + JWTFilter

```java
// SESSION 비활성화
http.sessionManagement(s -> s.sessionCreationPolicy(SessionCreationPolicy.STATELESS));

// JWT 필터를 LogoutFilter 앞에 삽입
http.addFilterBefore(jwtAuthorizationFilter, LogoutFilter.class);
```

---

### 인증 흐름

```
POST /login
    |-> UsernamePasswordAuthenticationFilter
    |-> PrincipalDetailsService.loadUserByUsername()
    |-> BCryptPasswordEncoder.matches()
    |
    +-- 성공 -> CustomLoginSuccessHandler
    |           -> generateToken() -> access(5분) + refresh(10분)
    |           -> access-token 쿠키 (HttpOnly)
    |           -> JwtToken DB 저장 (access+refresh+username+auth)
    |           -> 권한별 리다이렉트
    +-- 실패 -> CustomLoginFailureHandler -> /login?error=...

매 요청
    |-> JWTAuthorizationFilter (OncePerRequestFilter)
    |
    +-- access-token 쿠키 있음
    |   +-- 유효 -> SecurityContextHolder 등록
    |   +-- 만료 -> DB 조회(findByAccessToken)
    |              +-- refresh 유효 -> access 재발급, 쿠키 갱신, DB 갱신
    |              +-- refresh 만료 -> 쿠키 삭제 + DB 삭제
    +-- access-token 없음 -> 미인증 처리
```

---

### 세팅 체크리스트

| 항목 | 값 |
|------|-----|
| JWT 라이브러리 | `io.jsonwebtoken:jjwt-api:0.13.0` |
| 서명 알고리즘 | HS256 (HMAC-SHA256) |
| 서명 키 | `Signature` 엔티티로 DB 영속 (재시작해도 기존 토큰 유효) |
| access-token 만료 | 5분 (`1000*60*5` 밀리초) |
| refresh-token 만료 | 10분 (`1000*60*10` 밀리초) |
| 토큰 전달 방식 | Cookie (HttpOnly) |
| refresh-token 저장 | MySQL `jwt_token` 테이블 |
| 세션 방식 | `STATELESS` |
| 필터 위치 | `LogoutFilter` 앞 |

---

## 19_SPRING_SECURITY / 04_REDIS — JWT + Redis (Refresh Token 저장소 전환)

> 03_JWT_TOKEN 구조에서 refresh-token 저장소를 MySQL DB -> Redis로 전환.
> username 쿠키를 추가로 발급해 Redis 키(`RT:{username}`) 조회에 사용.

### 03_JWT_TOKEN 대비 추가/변경 사항

| 파일 | 변경 내용 |
|------|----------|
| `build.gradle` | `spring-boot-starter-data-redis` + `spring-session-data-redis` 추가 |
| `application.properties` | `spring.redis.host`, `spring.redis.port` 추가 |
| `redis/RedisConfig` | 신규 — `LettuceConnectionFactory` + `RedisTemplate` 빈 |
| `redis/RedisProperties` | 신규 — `@Value` 바인딩 (host, port) |
| `redis/Redis` | 신규 — `@RedisHash("JwtToken")` 엔티티 |
| `redis/RedisUtil` | 신규 — Redis CRUD 유틸 |
| `CustomLoginSuccessHandler` | 변경 — DB 저장 제거, Redis 저장 + username 쿠키 추가 |
| `JWTAuthorizationFilter` | 변경 — DB 조회 제거, Redis 조회(`RT:{username}`)로 교체 |

---

### 프로젝트 구조 (추가분)

```
04_REDIS/src/main/java/com/example/demo/Config/auth/
+-- redis/
    +-- RedisConfig.java       # LettuceConnectionFactory + RedisTemplate
    +-- RedisProperties.java   # @Value host/port
    +-- Redis.java             # @RedisHash("JwtToken") 엔티티
    +-- RedisUtil.java         # Redis CRUD 유틸
```

---

### build.gradle (추가)

```groovy
// JWT (03과 동일)
implementation 'io.jsonwebtoken:jjwt-api:0.13.0'
runtimeOnly 'io.jsonwebtoken:jjwt-impl:0.13.0'
runtimeOnly 'io.jsonwebtoken:jjwt-jackson:0.13.0'

// Redis 추가
implementation 'org.springframework.boot:spring-boot-starter-data-redis'
implementation 'org.springframework.session:spring-session-data-redis'
```

---

### application.properties (추가)

```properties
spring.redis.host=localhost
spring.redis.port=6379
```

---

### RedisProperties.java

```java
@Component @Data
public class RedisProperties {
    @Value("${spring.redis.port}") private int port;
    @Value("${spring.redis.host}") private String host;
}
```

---

### RedisConfig.java

```java
@Configuration @EnableRedisRepositories @RequiredArgsConstructor
public class RedisConfig {

    @Autowired private RedisProperties redisProperties;

    @Bean
    public RedisConnectionFactory redisConnectionFactory() {
        RedisStandaloneConfiguration config = new RedisStandaloneConfiguration();
        config.setHostName(redisProperties.getHost());
        config.setPort(redisProperties.getPort());
        return new LettuceConnectionFactory(config);
    }

    @Bean
    public RedisTemplate<?, ?> redisTemplate() {
        RedisTemplate<String, String> redisTemplate = new RedisTemplate<>();
        redisTemplate.setConnectionFactory(redisConnectionFactory());
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setValueSerializer(new StringRedisSerializer());
        return redisTemplate;
    }
}
```

---

### Redis.java — @RedisHash 엔티티

```java
@RedisHash(value = "JwtToken", timeToLive = JWTProperties.REFRESH_TOKEN_EXPIRATION_TIME)
@AllArgsConstructor @Data
public class Redis {
    @Id
    private String username;    // Redis 키: "JwtToken:{username}"
    private String refreshToken;
}
```

> `timeToLive` = refresh-token 만료시간 -> Redis TTL 자동 관리

---

### RedisUtil.java

```java
@Component @RequiredArgsConstructor
public class RedisUtil {

    private final RedisTemplate<String, String> redisTemplate;
    private final ObjectMapper objectMapper = new ObjectMapper();

    public void save(String key, String value) {
        redisTemplate.opsForValue().set(key, value);
    }

    // 키 예: "RT:username"
    public String getRefreshToken(String key) {
        return redisTemplate.opsForValue().get(key);
    }

    public void delete(String key) {
        redisTemplate.delete(key);
    }

    // TTL(초) 포함 저장
    public void setDataExpire(String key, String value, long durationSeconds) {
        redisTemplate.opsForValue().set(key, value, durationSeconds, TimeUnit.SECONDS);
    }

    // Map -> JSON 직렬화 후 TTL 저장
    public void setDataExpire(String key, Map<String, String> value, long durationSeconds) {
        try {
            redisTemplate.opsForValue().set(key, objectMapper.writeValueAsString(value), durationSeconds, TimeUnit.SECONDS);
        } catch (Exception e) { throw new RuntimeException("Failed to convert map to JSON", e); }
    }

    public boolean hasKey(String key) {
        return Boolean.TRUE.equals(redisTemplate.hasKey(key));
    }
}
```

---

### 변경된 CustomLoginSuccessHandler.java

```java
// 03_JWT_TOKEN: DB 저장
// jwtTokenRepository.save(JwtToken.builder()...build());

// 04_REDIS: Redis 저장으로 교체
// username 쿠키 (refresh-token 조회 키로 사용)
Cookie usernameCookie = new Cookie("username", authentication.getName());
usernameCookie.setMaxAge(JWTProperties.REFRESH_TOKEN_EXPIRATION_TIME / 1000);  // 초 단위
usernameCookie.setPath("/"); usernameCookie.setHttpOnly(true);
response.addCookie(usernameCookie);

// "RT:{username}" 키로 Redis에 TTL(초)과 함께 저장
redisUtil.setDataExpire(
    "RT:" + authentication.getName(),
    tokenInfo.getRefreshToken(),
    JWTProperties.REFRESH_TOKEN_EXPIRATION_TIME / 1000
);
```

> - access-token: Cookie (HttpOnly, 5분)
> - refresh-token: Redis `RT:{username}` 키 (10분 TTL 자동 만료)
> - username: 별도 Cookie (Redis 키 구성에 사용)

---

### 변경된 JWTAuthorizationFilter.java — Redis 조회

```java
// access-token + username 쿠키 동시 추출
String token    = /* access-token 쿠키 */;
String username = /* username 쿠키 */;

if (token != null) {
    try {
        // 유효 -> SecurityContextHolder 등록
        if (jwtTokenProvider.validateToken(token)) { ... }
    } catch (ExpiredJwtException e1) {
        // access-token 만료 -> Redis에서 refresh-token 조회
        String refreshToken = (username != null)
                ? redisUtil.getRefreshToken("RT:" + username) : null;

        if (refreshToken != null) {
            try {
                if (jwtTokenProvider.validateToken(refreshToken)) {
                    // access-token 재발급 (User 엔티티에서 role 조회)
                    User user = userRepository.findById(username).orElse(null);
                    String newToken = Jwts.builder()
                            .setSubject(username)
                            .claim("username", username).claim("auth", user.getRole())
                            .setExpiration(new Date(now + JWTProperties.ACCESS_TOKEN_EXPIRATION_TIME))
                            .signWith(jwtTokenProvider.getKey(), SignatureAlgorithm.HS256)
                            .compact();
                    // 쿠키 갱신 (DB 갱신 없음 — Redis는 TTL로 자동 만료)
                }
            } catch (ExpiredJwtException e2) {
                // refresh도 만료 -> 쿠키 2개 삭제 + Redis 키 삭제
                Cookie c1 = new Cookie(JWTProperties.ACCESS_TOKEN_COOKIE_NAME, null);
                c1.setMaxAge(0); response.addCookie(c1);

                Cookie c2 = new Cookie("username", null);
                c2.setMaxAge(0); c2.setPath("/"); response.addCookie(c2);

                redisUtil.delete("RT:" + username);
            }
        }
    }
} else {
    // access-token 없음 + username 쿠키 있음 -> refresh로 재발급 시도 (동일 로직)
}
```

---

### 03_JWT_TOKEN vs 04_REDIS 핵심 비교

| 항목 | 03_JWT_TOKEN | 04_REDIS |
|------|-------------|----------|
| refresh-token 저장 | MySQL `jwt_token` 테이블 | Redis `RT:{username}` 키 |
| refresh-token 조회 | `jwtTokenRepository.findByAccessToken(token)` | `redisUtil.getRefreshToken("RT:"+username)` |
| refresh-token 만료 처리 | DB row 삭제 | Redis key 삭제 (`redisUtil.delete`) |
| username 전달 경로 | JwtToken 엔티티에서 조회 | `username` 쿠키로 별도 전달 |
| TTL 관리 | 코드로 직접 만료 판단 | Redis TTL 자동 만료 |
| 의존성 추가 | 없음 | `spring-boot-starter-data-redis` + `spring-session-data-redis` |
| 연결 클라이언트 | 없음 | Lettuce (`LettuceConnectionFactory`) |

---

### 인증 흐름 (04_REDIS)

```
POST /login
    |-> 인증 성공 -> CustomLoginSuccessHandler
    |   -> generateToken() -> access(5분) + refresh(10분)
    |   -> access-token 쿠키 (HttpOnly, 5분)
    |   -> username 쿠키 (HttpOnly, 10분)
    |   -> redisUtil.setDataExpire("RT:{username}", refreshToken, 600초)

매 요청
    |-> JWTAuthorizationFilter
    |
    +-- access-token 유효 -> SecurityContextHolder 등록
    |
    +-- access-token 만료
    |   -> redisUtil.getRefreshToken("RT:{username}")
    |   +-- refresh 유효 -> access 재발급 -> 쿠키 갱신 (DB 갱신 없음)
    |   +-- refresh 만료 -> 쿠키 2개 삭제 + Redis 키 삭제
    |
    +-- access-token 없음 + username 쿠키 있음
        -> redisUtil.getRefreshToken("RT:{username}")
        +-- refresh 유효 -> access 발급 -> 쿠키 응답
```

---

### 세팅 체크리스트

| 항목 | 값 |
|------|-----|
| JWT 라이브러리 | `io.jsonwebtoken:jjwt-api:0.13.0` |
| Redis 클라이언트 | Lettuce (Spring Data Redis 기본) |
| Redis 주소 | `localhost:6379` |
| refresh-token 키 패턴 | `RT:{username}` |
| TTL 관리 | `setDataExpire(key, value, 초)` — Redis 자동 만료 |
| access-token 만료 | 5분 |
| refresh-token 만료 | 10분 |
| 쿠키 | `access-token` (5분) + `username` (10분), 모두 HttpOnly |
| 세션 방식 | `STATELESS` |

---

## 22_BATCH — Spring Batch

### 개요

Spring Batch는 대용량 데이터를 정해진 순서(Job → Step)로 처리하는 프레임워크.  
Job은 여러 Step으로 구성되며, 각 Step은 `Tasklet` 또는 `Chunk` 방식으로 처리.  
`JobRepository`가 실행 이력을 DB에 저장 → `spring.batch.jdbc.initialize-schema=always`로 메타 테이블 자동 생성.

### 파일 구조

```
22_BATCH/src/main/java/com/example/demo/
├── Batch/
│   └── BatchConfig.java         # Job / Step 빈 정의
├── Scheduled/
│   ├── ScheduledTask.java       # (참고용 — 비활성화 상태)
│   └── BatchScheduled.java      # @Scheduled로 Job 주기적 실행
└── Config/
    ├── DataSourceConfig.java     # HikariCP DataSource (MySQL)
    ├── JPAConfig.java            # EntityManagerFactory / Hibernate 설정
    └── TxConfig.java             # JpaTransactionManager 빈 등록
```

---

### BatchConfig — Job / Step 정의

```java
@Slf4j @Configuration
public class BatchConfig {

    // Job — step1 → step2 순서로 실행
    @Bean
    public Job basicJob(JobRepository jobRepository, Step step1, Step step2) {
        return new JobBuilder("basicJob", jobRepository)
                .start(step1)
                .next(step2)
                .build();
    }

    // Step1 — Tasklet 방식 (단순 작업 단위)
    @Bean
    public Step step1(JobRepository jobRepository, JpaTransactionManager tx) {
        return new StepBuilder("step1", jobRepository)
                .tasklet((contribution, chunkContext) -> {
                    // contribution: Step 상태값 보관
                    // chunkContext: chunk 간 연결 컨텍스트
                    log.info("[STEP1] - Hello World batch..");
                    return RepeatStatus.FINISHED;
                }, tx)
                .build();
    }

    // Step2 — 반복 로깅
    @Bean
    public Step step2(JobRepository jobRepository, JpaTransactionManager tx) {
        return new StepBuilder("step2", jobRepository)
                .tasklet((contribution, chunkContext) -> {
                    for (int i = 0; i <= 5; i++) log.info("[STEP2] - Bye World batch.." + i);
                    return RepeatStatus.FINISHED;
                }, tx)
                .build();
    }
}
```

---

### BatchScheduled — 스케줄로 Job 실행

```java
@Component @Slf4j
public class BatchScheduled {

    @Autowired JobLauncher jobLauncher;
    @Autowired Job basicJob;

    // 앱 기동 3초 후 첫 실행, 이후 10초 주기 반복
    @Scheduled(initialDelay = 3000, fixedDelay = 10000)
    public void batchScheduled_1() throws Exception {
        log.info("batchScheduled-1 invoke...");

        JobParameters params = new JobParametersBuilder()
                .addLong("time", System.currentTimeMillis())  // 매 실행마다 고유 파라미터
                .toJobParameters();

        jobLauncher.run(basicJob, params);
    }
}
```

> `addLong("time", System.currentTimeMillis())` — Spring Batch는 동일 `JobParameters`로 같은 Job을 재실행하지 않으므로, 매 실행마다 고유값(타임스탬프)을 파라미터로 추가.

---

### 설정 파일

**application.properties**
```properties
spring.application.name=demo
spring.batch.jdbc.initialize-schema=always   # Batch 메타 테이블 자동 생성
```

**DataSourceConfig.java** — HikariCP MySQL 연결
```java
@Configuration
public class DataSourceConfig {
    @Bean
    public DataSource dataSource() {
        HikariDataSource ds = new HikariDataSource();
        ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
        ds.setJdbcUrl("jdbc:mysql://localhost:3306/testdb");
        ds.setUsername("root");
        ds.setPassword("1234");
        return ds;
    }
}
```

**TxConfig.java** — JPA 트랜잭션 매니저
```java
@Configuration @EnableTransactionManagement
public class TxConfig {
    @Bean(name = "jpaTransactionManager")
    public JpaTransactionManager jpaTransactionManager(EntityManagerFactory emf) {
        JpaTransactionManager tm = new JpaTransactionManager();
        tm.setEntityManagerFactory(emf);
        tm.setDataSource(dataSource);
        return tm;
    }
}
```

**JPAConfig.java** — EntityManagerFactory / Hibernate
```java
@Configuration
@EntityScan(basePackages = {"com.example.demo.Domain.Common.Entity"})
@EnableJpaRepositories(basePackages = {"com.example.demo.Domain.Common.Repository"})
public class JPAConfig {
    @Bean
    LocalContainerEntityManagerFactoryBean entityManagerFactory() {
        LocalContainerEntityManagerFactoryBean emf = new LocalContainerEntityManagerFactoryBean();
        emf.setDataSource(dataSource);
        emf.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        emf.setPackagesToScan("com.example.demo.Domain.Common.Entity");

        Map<String, Object> props = new HashMap<>();
        props.put("hibernate.hbm2ddl.auto", "update");
        props.put("hibernate.show_sql", true);
        emf.setJpaPropertyMap(props);
        return emf;
    }
}
```

---

### build.gradle (22_BATCH)

```groovy
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-thymeleaf'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    implementation 'org.springframework.boot:spring-boot-starter-jdbc'
    implementation 'org.springframework.boot:spring-boot-starter-validation'
    implementation 'org.springframework.boot:spring-boot-starter-batch'   // Spring Batch
    testImplementation 'org.springframework.batch:spring-batch-test'
    runtimeOnly 'com.mysql:mysql-connector-j'
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}
```

---

### Spring Batch 핵심 개념

```
Job
  └── Step 1 (Tasklet or Chunk)
  └── Step 2
  └── Step N

JobRepository — 실행 이력 DB 저장 (BATCH_JOB_INSTANCE, BATCH_JOB_EXECUTION 등 메타 테이블)
JobLauncher  — Job을 파라미터와 함께 실행
JobParameters — 실행 구분 키 (동일 파라미터로 완료된 Job 재실행 불가)

Tasklet  — 단순 작업 (RepeatStatus.FINISHED 반환으로 종료)
Chunk    — 대량 데이터 처리 (ItemReader → ItemProcessor → ItemWriter)
```

### Scheduler + Batch 결합 패턴

```
앱 기동
  ↓ 3초 후
@Scheduled(initialDelay=3000, fixedDelay=10000)
  → JobLauncher.run(basicJob, params)
      → step1 (Hello World)
      → step2 (Bye World × 6)
  ↓ 10초 후 재실행 (params.time이 다르므로 새 Job으로 인식)
```


---