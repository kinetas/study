# JAVA01

---

## 1. Programming Language

| 어원 | 의미 |
|------|------|
| **PRO** | 앞으로, 미리 |
| **GRAM** | 적다, 쓰다 (like write) |
| **Language** | 언어 |

---

## 2. Computer 구조

> **COMPUTE** : 계산하다 → 계산기  
> 피연산자(DATA, 자료) 저장 후 연산

| 역할 | 하드웨어 | 소프트웨어 |
|------|----------|------------|
| 연산 | CPU / 프로세서 | — |
| 임시저장 (주기억장치) | RAM | 프로세스 |
| 보조기억장치 | DISK | 프로그램 |

---

## 3. JAVA 특징

- **절차지향 + 객체지향**
- **플랫폼 독립성** : 플랫폼, 운영체제가 달라도 JVM으로 사용 가능
- **자동 메모리 관리** : 메모리 누수를 최소화
- **멀티스레드 지원** : 병렬처리 가능
- **보안성**

---

## 4. 자료형 개요

> 데이터 선저장 후 처리

### 정형 데이터

```
숫자
├── 정수
│   ├── 양수
│   └── 음수
└── 실수

문자
├── 단일문자
└── 문자열
```

### Primitive 자료형 (기본 타입)

| 자료형 | 크기 | 부호 | 비고 |
|--------|------|------|------|
| `byte` | 1 byte | signed | |
| `char` | 2 byte | unsigned | |
| `short` | 2 byte | signed | |
| `int` | 4 byte | signed | **기본 정수형** |
| `float` | 4 byte | — | |
| `double` | 8 byte | — | **기본 실수형** |

### Class 자료형 (참조 타입)

- `String`

---

## Ch00 — HelloWorld

```java
package CH00;	// 패키지명

public class HelloWorld	// 클래스 선언부 - 객체지향문법 적용영역
{

	// 메서드(함수) 종류
	// 라이브러리 메서드  : 미리 만들어져 제공되는 메서드
	// 사용자정의 메서드  : 개발자에 의해 만들어지는 메서드
	// main 메서드       : 최초 실행되는 메서드

	public static void main(String[] args) {   // main 메서드 선언부 - 절차지향문법 적용영역
	    System.out.println("Hello, Java!");    // 라이브러리 메서드
	   
	}
	//글자크기조정 : ctrl + '+' or '-'
	//주석처리 : ctrl + '/'
	//한줄복사 : ctrl + alt + '↓'
	//한줄삭제 : ctrl + d
}
```

---

## Ch01 — 기본 자료형 & 입출력

### C01 — SystemOut (printf)

```java
package CH01;

public class C01SystemOut {

	public static void main(String[] args) {
		// System.out.print()
		// \n : 개행, 줄바꿈
		// \b : 백스페이스
		// \t : 탭길이(기본 8칸) 만큼 커서 이동
//		System.out.print("HELLOWORLD\n");
//		System.out.print("HELLOWORLD\n");
//		System.out.print("HELLOWORLD\n");
//		System.out.print("HELLOWORLD\n");
//		System.out.print("HELLOWORLD\n");

		// format : 형식, 서식
		// %d : 10진수 정수 서식문자
		// %f : 10진수 실수 서식문자
		// %c : 한문자 서식문자
		// %s : 문자열 서식문자
		System.out.printf("%d %d %d \n", 10, 20, 30);
		System.out.printf("10,20,30 \n");
		System.out.printf("%f %f %f \n", 10.1, 20.1, 30.1);
		System.out.printf("%c %c %c \n", 'A', 'B', 'C');
		System.out.printf("%s %s %s \n", "This is", " String ", "Test");
		System.out.printf("%d.%s : %d\n", 1, "국어", 100);

	}

}
```

---

### C02 — 진수

```java
package CH01;

public class C02진수 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		10진수			2진수
//		0			   0
//		1			   1
//		2			  10
//		3			  11
//		4			 100
//		5			 101
//		6			 110
//		7			 111
//		8			1000
//		9			1001
//		------------------------------
//		1bit : 2^1 = 2(0~1)
//		2bit : 2^2 = 4(0~3)
//		3bit : 2^3 = 8(0~7)
//		4bit : 2^4 = 16(0~15)
//		5bit : 2^5 = 32(0~31)
//		6bit : 2^6 = 64(0~63)
//		7bit : 2^7 = 128(0~127)
//		8bit : 2^8 = 256(0~255)
//		9bit : 2^9 = 512(0~511)
//		10bit: 2^19 =1024(0~1023)
//		--------------------------------
//		1	1	1	1	1	1	1	1
//		*	*	*	*	*	*	*	*
//		2^7	2^6	2^5	2^4	2^3	2^2	2^1	2^0
//
//		128	64	32	16	8	4	2	1

		// 2진수 -> 10진수
		// 10101100 = 128 + 32 + 8 + 4
		// 10011010 = 128 + 16 + 8 + 2
		// 01101001 = 64 + 32 + 8 + 1
		// 10010010 = 128 + 16 + 2
		// 11001100 = 204
		// 00110101 = 53
		// 10100110 = 166

		// 10진수 -> 2진수
		// 192 -> 11000000
		// 158 -> 10011110
		// 224 -> 11100000
		// 252 -> 11111100
		// 88  -> 01011000
		// 179 -> 10110011
		// 12  -> 00001100
		// 15  -> 00001111

		// %d : 10진수 서식문자
		// %o : 8진수 서식문자
		// %x : 16진수 서식문자
		// 코드 이쁘게 정리하기 : ctrl + shift + f
		
		System.out.printf("10진수 : %d\n",0b00001111); // 2진수 (0b :2진수를 의미하는 접두사)
		System.out.printf("10진수 : %d\n",173);        // 10진수
		System.out.printf("10진수 : %d\n",0255);       // 8진수 (0 :8진수를 의미하는 접두사)
		System.out.printf("10진수 : %d\n",0xAD);       // 16진수 (0x:16진수를 의미하는 접두사)

		
		System.out.println();
		System.out.printf("8진수 : %o\n",173);  // 10진수
		System.out.printf("8진수 : %o\n",0255); // 8진수 (0 :8진수를 의미하는 접두사)
		System.out.printf("8진수 : %o\n",0xAD); // 16진수 (0x:16진수를 의미하는 접두사)

		System.out.println();
		System.out.printf("16진수 : %x\n",173);  // 10진수
		System.out.printf("16진수 : %x\n",0255); // 8진수 (0 :8진수를 의미하는 접두사)
		System.out.printf("16진수 : %x\n",0xAD); // 16진수 (0x:16진수를 의미하는 접두사)

	}

}
```

---

### C03 — 음수

```java
package CH01;

public class C03음수 {

	public static void main(String[] args) {
		/*
			컴퓨터(CPU)는 구조상 덧셈연산을 할 수 있다(o)
			컴퓨터(CPU)는 구조상 뺄셈연산을 할 수 있다(x)
			보수 개념 + 가산처리 를 통해서 뺄셈 결과를 만들어 낸다(o)

		 	7 - 4 = 3
		 	7 + 6 = 3
		 	77 - 32 = 45
		 	77 + 68 = 45
		 	
		 	5 - 5 = 0
		 	5 + 5 = 0
		 	
		 	00000101 = 5
		 	00000000
		 	11111010 = 5에 대한 1의 보수(-6)
		 +	11111011 = 5에 대한 2의 보수(-5)
		 	-----------------------------
		    00000000 = 0
		    
		 	
		 	11111010 = -128 + 64 + 32 + 16 + 8 + 2 = -6
		 			 
			    	//문제
			//음수값임을 고려하여 풉니다
			//10 진수 	-> 2진수
			//111 		-> 01101111
			//-111 		-> 10010001 
			//96		-> 01100000 
			//-96		-> 10100000 
			//31 		-> 00011111 
			//-31		-> 11100001 
			
			//2진수		-> 10진수
			//10101111 	-> -81 
			//00110101	-> 53
			//11001100	-> -52 
			//10101010	-> -86 
		 	
		 */
		



	}

}
```

---

### C04 — 변수 & 자료형 (기초)

> 실수 : 소수점 이하 가지는 수  
> `지수부.가수부`  
> - **고정소수점** : 빠른 저장, 메모리공간 낭비  
> - **부동소수점** : 기본값

```java
package CH01;

public class C04변수_자료형 {

	public static void main(String[] args) {
		
		int num1;					// int만큼 크기(4byte)의 공간형성 + num1이름 부여(변수 정의)
		num1= 10;					// 10이라고 하는값(리터럴상수)을 상수POOL에 저장, num1공간에 대입(복사)
		int num2 = 4;				// 4라는 값(리터럴상수)을 상수 POOL저장, 4byte정수공간 num2 초기화
		int num3 = num1 + num2;		// num1의 값과 num2의 값을 가져와 + 연산결과(CPU가산처리)를 4byte 정수공간 num3에 초기화
		System.out.println(num3);	// num3의 값을 println메서드로 전달해서 내부적으로 표준출력 처리
		
		
		// Data(수, 자료) : 선 저장 / 후 처리
		// 변수 : 개발자의 유지보수 측면에서 유리하도록 하기 위해 지정한 수(바뀔 예정인 수)
		// 변수명 : 저장되어져 있는 변수 공간에 접근하기 위한 문자 형태의 주소
		// 자료형 : Data(수,자료)를 저장하기 위한 공간을 형성하고 저장될 자료의 형태를 제안하는 예약어
		// =연산자 :
		// lv(공간) = rv(값) rv를 먼저 처리(저장 or 연산) 한 다음 lv에 대입
		
	}

}
```

---

### C05 — 변수 & 자료형 (상세)

```java
package CH01;

import java.nio.charset.StandardCharsets;

public class C05변수_자료형 {

	public static void main(String[] args) {
//		//--------------------
//		//정수 int - 4byte 정수 부호 o
//		//--------------------
//		int n1 = 0b10101101;
//		int n2 = 173;			//10진정수값
//		int n3 = 0255;			//8진수
//		int n4 = 0xad;			//16진수
//		System.out.printf("%d %d %d %d\n",n1,n2,n3,n4);

		//--------------------
		//정수 byte - 1byte 정수 부호 o
		//--------------------
//		byte n5 = (byte)-129;		//?				 
//		byte n6 = -30;
//		byte n7 = 30;
//		byte n8 = 127;
//		byte n9 = (byte)129;		//?
////		System.out.println("n6 : " + n6);
//		System.out.println("n9 : " + n9);
//		System.out.println(Integer.toBinaryString(129));	
	

		//--------------------
		//정수 short-2byte정수 부호o | char-2byte정수 부호x(양수만)
		//--------------------
		
//		char n1 = 65535;  		//	(0~2^16-1)	(0~65535)
//		short n2 = 32767; 		//	(-2^15 ~ +2^15-1)(-32768 ~ + 32767)
//		
//		System.out.printf("n1 : " + n1);	//왜 0 이 나올까요?
//		short n4 = (short)n1; 			//문제발생... 왜??
//		
//		System.out.printf("%d\n",n4);
//		System.out.println(Integer.toBinaryString(65535));	
		
		//--------------------
		//정수 long-8byte 정수 부호o
		//--------------------
////		
//		long n1 = 2150000000L;	//10억
//		long n2 = 20;	//L,l (리터럴접미사) : long 자료형 사용하여 값 저장 
//		
//		long n3 = 10000000000l;//문제발생.. 왜?
//		long n4 = 10000000000L;		
		

//		//--------------------
//		//실수
//		//--------------------
//		//유리수와 무리수의 통칭
//		//소숫점이하값을 가지는 수 123.456
//		//float : 4byte 실수(6-9자리)
//		//double : 8byte 실수(15-18자리),기본자료형
//		
//		//정밀도 확인
//		float n1 = 0.123456789123456789F; //f,F:float형 접미사
//		double n2 = 0.123456789123456789;		
//		
//		System.out.println(n1);
//		System.out.println(n2);	
//		
//		//오차 확인
//		float num = 0.1F;
//		for(int i=0;i<=1E5;i++) {
//				num=num+0.1F;
//				System.out.println(i);
//		}
//		System.out.println("num : "  + num);		
		
		
		//--------------------
		//단일문자 char 2byte 정수
		//--------------------
//		char ch1 = 'a';
//		System.out.println(ch1);
//		System.out.println((int)ch1);
//		System.out.println(Integer.toBinaryString(ch1));
//		System.out.println("------------------");
//
//		char ch2 = 98;
//		System.out.println(ch2);
//		System.out.println((int)ch2);
//		System.out.println(Integer.toBinaryString(ch2));		
//		System.out.println("------------------");
//		
//		char ch3 = 'b' + 1;
//		System.out.println(ch3);
//		System.out.println((int)ch3);
//		System.out.println(Integer.toBinaryString(ch3));	
//		System.out.println("------------------");
//		
//		System.out.println((char)0b1010110000000000);
//		char ch4 = 0xac02;
//		System.out.println(ch4);
//		System.out.println((int)ch4);
//		System.out.println(Integer.toBinaryString(ch4));		
//		
//		System.out.println("------------------");
//		// \\u : 유니코드 이스케이프문자
//		System.out.printf("%c\n", 0xac03);
//		System.out.printf("%c\n", '\uac03');
		
//		//--------------------
//		//boolean : 논리형(true/false 저장)
//		//--------------------		
//		boolean flag = (10>11); 	// 참(긍정)
//		
//		if(flag) 
//		{
//			System.out.println("참인경우 실행");
//		}
//		else 
//		{
//			System.out.println("거짓인경우 실행");
//		}
		
		//--------------------
		//문자열 : String (클래스자료형)
		//--------------------
		//기본자료형(원시타입)
		//byte n1;
		//short n2;
		//double n3;
		//long n4;
		
		//클래스자료형
		//클래스자료형으로 만든변수는 '참조변수'라고 하고
		//참조변수는 데이터가 저장된 위치정보(메모리주소값)이 저장된다.
		int n1 = 10;
		byte n2 = 20;
		char n3 = 40;
		
		String name = "홍길동";
		String job = "프로그래머";
		
		System.out.println("UTF-8기준 지정 크기: " + name.getBytes(StandardCharsets.UTF_8).length);
		System.out.println("UTF-8기준 지정 크기: " + job.getBytes(StandardCharsets.UTF_8).length);

		
		// 사이즈 확인
		char ch = '홍';		//16bit == 2byte 사용
		String str= "홍";	//24bit == 3byte 사용
		
		System.out.println("ch 실제 크기(bit): " + Integer.toBinaryString(ch).length());
		System.out.println("str 실제 크기(byte): " + str.getBytes(StandardCharsets.UTF_8).length);
		
	}

}
```

---

### C06 — 상수

> **상수** : 항상 같은 값

| 종류 | 설명 | 특징 |
|------|------|------|
| **리터럴 상수** | 이름 없음, 상수 POOL에 저장 | 단순한 수치/값 |
| **심볼릭 상수** | 이름 있음, `final` 예약어 사용 | 변경 불가 |

**리터럴 접미사** (저장되는 자료형 지정)
- `l`, `L` → `long` 자료형
- `f`, `F` → `float` 자료형

```java
int n1 = 100;         // 100은 리터럴 상수
final int n2 = 200;   // n2는 심볼릭 상수
final double PI = 3.14;
double result = PI * 4 * 4;
```

---

### C07 — 정리문제

#### 자료형 크기 정리

| 크기 | 정수 타입 | 실수 타입 | 논리 타입 |
|------|-----------|-----------|-----------|
| 1byte | `byte` | — | `boolean` |
| 2byte | `char`(unsigned), `short` | — | — |
| 4byte | `int` (기본) | `float` | — |
| 8byte | `long` | `double` (기본) | — |

#### 코드 유효성 확인

| 코드 | 결과 | 이유 |
|------|------|------|
| `byte var = 200;` | X | byte 범위 -128~127 초과 |
| `char var='AB';` | X | char는 한 문자만 가능 |
| `char var=65;` | O | 유니코드 값 직접 대입 가능 |
| `long var=50000000000;` | X | 리터럴 기본형이 int → `L` 필요 |
| `float var = 3.14;` | X | 기본 실수형이 double → `F` 필요 |
| `double var = 100.0;` | O | |
| `String var = "나의직업은 "개발자" 입니다.";` | X | 내부 `"` 앞에 `\` 필요 |
| `boolean var = 0;` | X | Java는 `true`/`false`만 허용 |
| `int v2 = 1e2;` | X | `1e2`는 `double` 타입 |
| `float = 1e2f;` | X | 변수명 없음 |

---

## Ch02 — 형변환 (Type Conversion)

### 개요

| 종류 | 설명 | 특징 |
|------|------|------|
| **자동 형변환** (묵시적) | 컴파일러에 의해 자동 처리 | 작은 → 큰 자료형, 데이터 손실 없음 |
| **강제 형변환** (명시적) | 프로그래머가 직접 지정 | `(자료형)` 캐스팅, 데이터 손실 가능 |

**자동 형변환 순서** (작은 → 큰)
```
byte → short, char → int → long → float → double
```

### C01 — 자동 형변환

```java
byte byteValue = 10;
int intValue = byteValue;       // byte → int 자동 변환

char charValue = '가';
intValue = charValue;           // char → int (유니코드 값)

long longValue = intValue;      // int → long
float floatValue = longValue;   // long → float
double doubleValue = floatValue;// float → double
```

### C02 — 강제 형변환

```java
int intValue = 20000;
char charValue = (char)intValue;  // int → char

long longValue = 500;
intValue = (int)longValue;        // long → int

double doubleValue = 3.14;
intValue = (int)doubleValue;      // 소수점 이하 손실 → 3
```

### C03 — 데이터 손실 (비트 잘림)

```java
int num1 = 129; // 00000000 00000000 00000000 10000001
byte ch1 = (byte)num1; // 10000001 → 부호비트 1 → 음수 출력
```

### C04 — 연산식 자동 형변환 규칙

- `byte`, `short`, `char` 간 연산 → **int** 로 자동 변환 (CPU 연산 공간이 int 기준)
- int보다 큰 타입이 포함되면 → **큰 타입**으로 자동 변환

```java
byte var1 = 10;
int var2 = 100;
long var3 = 1000L;
int result = (int)(var1 + var2 + var3); // long으로 자동 변환 후 명시 캐스팅
```

### C05 — 정수 나눗셈 주의

```java
int num1 = 10, num2 = 4;
double dnum1 = (double)num1 / num2; // 2.5 — 먼저 캐스팅 후 나눔
double dnum2 = (num1 * 1.0) / num2; // 2.5 — 1.0 곱해 double 변환
double dnum3 = num1 / num2;         // 2.0 — 정수 나눗셈 후 대입
```

### C06 — char ↔ short 부호 차이

```java
char n1 = 60000;      // unsigned 2byte: 비트열 11101010 01100000
short n2 = (short)n1; // signed 2byte: 부호비트 1 → 음수
```

### C07 — 문자열 형변환

```java
// 문자열 + 숫자 → 숫자를 문자열로 해석 (연결)
System.out.println("문자열1" + 2);      // "문자열12"

// 숫자 + 숫자 + 문자열 → 먼저 숫자끼리 더함
System.out.println(',' + '!' + "문자열1");  // 숫자 합산 후 연결

// 문자열 → 숫자형 변환 (Wrapper 클래스)
int n1 = Integer.parseInt("10");
double n3 = Double.parseDouble("10.5");
short n5 = Short.parseShort("5");

// 문자열에서 char 추출
String strValue = "A";
char var = strValue.charAt(0);  // (char) 캐스팅 불가
```

### C08 — 정리문제

#### 문제 1 — 자동 타입 변환, 컴파일 에러 발생하는 것은?

```java
byte byteValue = 10;
char charValue = 'A';

1) int intValue = byteValue;       // O - byte(1) → int(4), 범위 확장
2) int intValue = charValue;       // O - char(2) → int(4), 범위 확장
3) short shortValue = charValue;   // X ← 정답
4) double doubleValue = byteValue; // O - byte(1) → double(8), 범위 확장
```

> **3번이 틀린 이유** : `char`는 unsigned(0~65535), `short`는 signed(-32768~32767)  
> char의 허용 범위가 short보다 넓어서 자동 형변환 불가 → 강제 캐스팅 필요

---

#### 문제 2 — 강제 타입 변환, 컴파일 에러 발생하는 것은?

```java
int intValue = 10;
char charValue = 'A';
double doubleValue = 5.7;
String strValue = "A";

1) double var = (double)intValue;  // O - 캐스팅 후 넓은 타입으로 저장
2) byte var = (byte)intValue;      // O - 강제 캐스팅, 데이터 손실 가능하지만 문법 OK
3) int var = (int)doubleValue;     // O - 소수점 버림, 문법 OK
4) char var = (Char)strValue;      // X ← 정답
```

> **4번이 틀린 이유** : `String`은 클래스 자료형(참조타입)이므로 `(char)` 원시 캐스팅 불가  
> → `strValue.charAt(0)` 으로 변환해야 함

---

#### 문제 3 — 연산식 타입 변환, 컴파일 에러 발생하는 것은?

```java
byte byteValue = 10;
float floatValue = 2.5F;
double doubleValue = 2.5;

1) byte result = byteValue + byteValue; // X ← 정답
2) int result = 5 + byteValue;          // O - 결과 int, 저장도 int
3) float result = 5 + floatValue;       // O - 5가 float로 자동변환
4) double result = 5 + doubleValue;     // O - 5가 double로 자동변환
```

> **1번이 틀린 이유** : `byte + byte` 연산 시 CPU가 int 공간에서 연산 → 결과가 `int`  
> `byte` 변수에 바로 대입 불가 → `byte result = (byte)(byteValue + byteValue);` 필요

---

#### 문제 4 — 컴파일 에러 위치와 이유

```java
short s1 = 1;
short s2 = 2;
int i1 = 3;
int i2 = 4;

short result = s1 + s2; // X ← 에러
int result = i1 + i2;   // O
```

> **`short result = s1 + s2;` 가 에러인 이유** : `short + short` 연산 결과는 `int`  
> → `short result = (short)(s1 + s2);` 로 명시 캐스팅 필요

---

#### 문제 5 — char 연산 후 저장

```java
char c1 = 'a';
char c2 = c1 + 1; // X ← 에러
System.out.println(c2);
```

> **에러 이유** : `c1 + 1` 연산 결과는 `int` 타입 → `char` 변수에 직접 대입 불가  
> **수정** : `char c2 = (char)(c1 + 1);`

---

#### 문제 6 — 정수 나눗셈 결과 타입

```java
int x = 5;
int y = 2;
int result = x / y;       // 결과: 2
System.out.println(result);
```

> **이유** : `int / int` 연산 결과는 `int` → 소수점 이하 버림 → `2.5`가 아닌 `2`

---

#### 문제 7 — 나눗셈 결과를 2.5로 만들기

```java
int x = 5;
int y = 2;
double result = (double)x / y;  // 2.5
// 또는: x / (double)y
// 또는: (double)x / (double)y
```

> **이유** : 피연산자 중 하나를 `double`로 캐스팅하면 나머지도 `double`로 자동변환

---

#### 문제 8 — 실수 합산 후 소수점 버리기

```java
double var1 = 3.5;
double var2 = 2.7;
int result = (int)(var1 + var2); // 6 (6.2에서 소수점 버림)
```

---

#### 문제 9 — 혼합 타입 합산 결과를 int 9로 만들기

```java
long var1 = 2L;
float var2 = 1.8f;
double var3 = 2.5;
String var4 = "3.9";

int result = (int)var1 + (int)((double)var2 + var3) + (int)Double.parseDouble(var4);
// 2 + (int)(1.8 + 2.5) + (int)3.9
// 2 + (int)4.3 + 3
// 2 + 4 + 3 = 9
```

---

#### 문제 10 — 문자열 + 연산 결과

```java
String str1 = 2 + 3 + "";   // (2+3) 먼저 → 5 → "5"
String str2 = 2 + "" + 3;   // "2" + 3 → "23"
String str3 = "" + 2 + 3;   // "2" + 3 → "23"
```

| 변수 | 연산 과정 | 결과 |
|------|-----------|------|
| `str1` | `2+3` → `5` → `5+""` | `"5"` |
| `str2` | `2+""` → `"2"` → `"2"+3` | `"23"` |
| `str3` | `""+2` → `"2"` → `"2"+3` | `"23"` |

> **규칙** : `+` 연산은 왼쪽부터 순서대로 처리, 한쪽이 `String`이면 나머지도 문자열로 변환

---

#### 문제 11 — 문자열 → 기본 타입 변환 메서드

```java
byte value   = Byte.parseByte("10");
int value    = Integer.parseInt("100");
float value  = Float.parseFloat("20.5");
double value = Double.parseDouble("3.14159");
```

---

## Ch03 — Scanner (표준 입력)

### 개념

- **스트림** : 데이터의 논리적 이동 채널 (단방향)
  - `System.in` : 표준 입력 스트림
  - `System.out` : 표준 출력 스트림
- `new Scanner(System.in)` : 표준 입력 스트림에 연결된 Scanner 객체 생성 (HEAP에 저장)

```java
import java.util.Scanner;
Scanner sc = new Scanner(System.in);
```

### 주요 메서드

| 메서드 | 설명 | 구분자 |
|--------|------|--------|
| `sc.nextInt()` | 정수 입력 | 엔터, 스페이스 |
| `sc.nextDouble()` | 실수 입력 | 엔터, 스페이스 |
| `sc.next()` | 문자열 입력 (띄어쓰기 포함 X) | 엔터, 스페이스 |
| `sc.nextLine()` | 문자열 입력 (띄어쓰기 포함 O) | 엔터만 |
| `sc.close()` | 스트림 닫기 | — |

### nextLine() 주의사항

`nextInt()` 등 다른 입력 후 `nextLine()` 사용 시, 이전 엔터(`\n`)가 남아 스킵됨 → **더미 `nextLine()` 호출 필요**

```java
int num = sc.nextInt();
sc.nextLine();        // 버퍼에 남은 \n 제거
String str = sc.nextLine();
```

### C01 — 기본 정수 3개 입력

```java
Scanner sc = new Scanner(System.in);
int num1 = sc.nextInt();
int num2 = sc.nextInt();
int num3 = sc.nextInt();
System.out.printf("%d %d %d\n", num1, num2, num3);
sc.close();
```

### C02 — 정수/실수/문자열 입력

```java
Scanner sc = new Scanner(System.in);
int num1 = sc.nextInt();
double num2 = sc.nextDouble();
sc.nextLine();                  // 버퍼 비우기
String str1 = sc.nextLine();    // 띄어쓰기 포함 문자열
sc.close();
```

### C03 — 이름/나이/주소 입력

```java
Scanner sc = new Scanner(System.in);
String name = sc.next();
int age = sc.nextInt();
sc.nextLine();                  // 버퍼 비우기
String addr = sc.nextLine();
System.out.printf("%s 님의 나이는 %d 주소는 %s입니다.",name,age,addr);
```

---

## Ch04 — 연산자 (Operator)

### 개요

| 종류 | 연산자 | 설명 |
|------|--------|------|
| **기본 산술** | `+` `-` `*` `/` `%` | 사칙연산 + 나머지 |
| **대입** | `=` | rv를 먼저 처리 후 lv에 대입 |
| **복합 대입** | `+=` `-=` `*=` `/=` `%=` | 산술연산 + 대입 |
| **비교** | `==` `!=` `>` `>=` `<` `<=` | 결과 boolean |
| **논리** | `&&` `\|\|` `!` | 논리곱/합/부정, 결과 boolean |
| **비트** | `&` `\|` `^` `~` | 비트 단위 연산 |
| **시프트** | `<<` `>>` | 비트 이동 |
| **증감** | `++` `--` | 1 증가/감소 |
| **삼항** | `(조건)?A:B` | 조건 true → A, false → B |

---

### C01 — 기본 연산자

```java
// 산술 연산자
int a = 10, b = 20;
System.out.println("a+b=" + (a + b));  // 30
System.out.println("a-b=" + (a - b));  // -10
System.out.println("a*b=" + (a * b));  // 200
System.out.println("b/a=" + (b / a));  // 2  (몫)
System.out.println("a%b=" + (a % b));  // 10 (나머지)

// 복합 대입 연산자
int x = 10;
x += 10; // x = x + 10  → 20
x -= 5;  // x = x - 5   → 15
x *= 3;  // x = x * 3   → 45

// 비교 연산자
System.out.println(a == b); // false
System.out.println(a != b); // true
System.out.println(a > b);  // false

// 논리 연산자
// && : 양쪽 모두 true 일 때만 true
// || : 양쪽 중 하나라도 true 이면 true
// !  : true → false, false → true
System.out.println((a >= b) && (a > 5));  // false
System.out.println((a != b) || (b > 15)); // true

// 증감 연산자
// ++a / --a : 전치 — 먼저 1증감 후 다른 연산 처리
// a++ / a-- : 후치 — 다른 연산 처리 후 1증감
int c = 10, d = 10, e;
e = --c + d++; // c=9(전치), d=10 먼저 연산 → e=19, 이후 d=11
System.out.printf("c=%d, d=%d, e=%d", c, d, e); // c=9, d=11, e=19

// 삼항 연산자 : (조건식) ? 참 : 거짓
int score = 85;
char grade = (score > 90) ? 'A' : ((score > 80) ? 'B' : 'C');
System.out.println(score + "점은 " + grade + "등급입니다."); // 85점은 B등급입니다.
```

> **단락 평가(Short-circuit)** : `&&`에서 왼쪽이 false이면 오른쪽은 평가 안 함, `||`에서 왼쪽이 true이면 오른쪽은 평가 안 함

---

### C02 — 연산자 활용 예제

```java
// 예제 1 : 합격/불합격 (삼항 + 논리)
Scanner sc = new Scanner(System.in);
int kor = sc.nextInt(), eng = sc.nextInt(), math = sc.nextInt();
double avg = (double)(kor + eng + math) / 3;
System.out.printf("%s\n", kor >= 40 && eng >= 40 && math >= 40 && avg >= 70 ? "합격" : "불합격");

// 예제 2 : 합의 짝홀 판별 (% 연산자)
int n1 = sc.nextInt(), n2 = sc.nextInt();
System.out.printf("%d + %d의 합 %d는 %s\n", n1, n2, n1+n2, (n1+n2)%2==0 ? "짝수입니다." : "홀수입니다.");
```

---

### C03 — % 연산자 활용

```java
// 수의 범위 제한
// N%2  = 0~1   (짝홀수 구분)
// N%5  = 0~4   (5의 배수 구분)
// N%10 = 0~9   (끝자리 제한)
// N%100 = 0~99

// 난수 생성
Random rnd = new Random();
System.out.println(rnd.nextInt(45) + 1); // 1~45 난수 (로또)

// Math.random() 활용
System.out.println((int)(Math.random() * 100) % 15); // 0~14 난수

// 끝자리 추출
int num = 56789;
System.out.println("끝 1자리 : " + (num % 10));     // 9
System.out.println("끝 2자리 : " + (num % 100));    // 89
System.out.println("앞 1자리 : " + (num / 10000));  // 5
System.out.println("앞 2자리 : " + (num / 1000));   // 56
```

---

### C04 — 비트 연산자

| 연산자 | 이름 | 설명 |
|--------|------|------|
| `&` | AND | 둘 다 1일 때만 1 |
| `\|` | OR | 하나라도 1이면 1 |
| `^` | XOR | 서로 다를 때 1 |
| `~` | NOT | 비트 반전 |

```java
int num1 = 15; // 00000000 00000000 00000000 00001111
int num2 = 20; // 00000000 00000000 00000000 00010100

System.out.println("AND : " + (num1 & num2)); // 00000100 = 4
System.out.println("OR  : " + (num1 | num2)); // 00011111 = 31
System.out.println("XOR : " + (num1 ^ num2)); // 00011011 = 27
System.out.println("NOT : " + (~num1));        // 11110000 = -16
```

---

### C05 — 시프트 연산자

| 연산자 | 설명 | 효과 |
|--------|------|------|
| `<<` | 왼쪽 시프트 | n칸 이동 = × 2ⁿ |
| `>>` | 오른쪽 시프트 | n칸 이동 = ÷ 2ⁿ |

```java
int num = 20; // 00000000 00000000 00000000 00010100

int left  = num << 3; // 00000000 00000000 00000000 10100000 = 160 (20 × 2³)
int right = num >> 3; // 00000000 00000000 00000000 00000010 = 2   (20 ÷ 2³)

System.out.println("<< 결과 : " + left);  // 160
System.out.println(">> 결과 : " + right); // 2
```

---

### C06 — 논리 연산자 단락 평가

```java
int a = 1, b = 1;
boolean c;

// || 왼쪽이 true → 오른쪽 평가 안 함 (b 증감 미발생)
c = (++a > 0) || (++b > 0);
// a=2, b=1 (b는 평가 안 됨), c=true
System.out.printf("a=%d, b=%d, c=%s\n", a, b, c);

// || 왼쪽이 false → 오른쪽 평가
a = 1; b = 1;
c = (--a > 0) || (++b > 0);
// a=0, b=2 (b는 평가됨), c=true
System.out.printf("a=%d, b=%d, c=%s\n", a, b, c);
```

> **핵심** : `||`에서 왼쪽이 true면 오른쪽은 실행되지 않아 증감 연산자도 동작하지 않음

---

### C07 — 증감 연산자 복합 예제

```java
int a=5, b=6, c=10, d;
boolean e;

d = ++a * b--;     // a=6(전치 먼저), b=6(후치 나중) → d=36, 이후 b=5
System.out.printf("a=%d, b=%d, d=%d\n", a, b, d); // a=6, b=5, d=36

d = a++ + ++c - b--;  // a=6, c=11, b=5 → d=6+11-5=12, 이후 a=7, b=4
System.out.printf("a=%d, b=%d, c=%d, d=%d\n", a, b, c, d); // a=7, b=4, c=11, d=12

a=1; b=0;
e = (a++ > 0) || ((b * d / c) > 0); // 왼쪽 true → 오른쪽 미평가
// a=2(후치), b=0 그대로, e=true
System.out.printf("a=%d, b=%d, c=%d, d=%d, e=%b\n", a, b, c, d, e);
```

---

### C08 — 정리문제

#### 문제 1 — 컴파일 에러 위치와 이유

```java
byte b = 5;      // O
b = -b;          // X ← 에러
int result = 10 / b;
System.out.println(result);
```

> **이유** : `-b` 부호 연산 결과는 `int` 타입 → `byte` 변수에 직접 대입 불가  
> **수정** : `b = (byte)(-b);`

---

#### 문제 2 — 증감 연산자 결과

```java
int x = 10;
int y = 20;
int z = (++x) + (y--); // x=11(전치), y=20(후치 먼저 연산) → z=31, 이후 y=19
System.out.println(z); // 31
```

---

#### 문제 3 — 나눗셈 결과 수정

```java
// 문제 코드 (결과 4)
int var1 = 5, var2 = 2;
double var3 = var1 / var2;         // 정수 나눗셈 → 2.0
int var4 = (int)(var3 * var2);     // (int)(2.0*2) = 4

// 수정 코드 (결과 5)
double var3 = (double)var1 / var2; // 실수 나눗셈 → 2.5
int var4 = (int)(var3 * var2);     // (int)(2.5*2) = 5
```

---

#### 문제 4 — 비교/논리 연산 결과

```java
int x = 10, y = 5;
System.out.println((x > 7) && (y <= 5));          // true
System.out.println((x % 3 == 2) || (y % 2 != 1)); // false
```

---

#### 문제 5 — 복합 대입 연산자로 변환

```java
int value = 0;
value = value + 10; // → value += 10;
value = value - 10; // → value -= 10;
value = value * 10; // → value *= 10;
value = value / 10; // → value /= 10;
```

---

#### 문제 6 — 삼항 연산자 결과

```java
int score = 85;
String result = (!(score > 90)) ? "가" : "나";
System.out.println(result); // 가
```

> **이유** : `score > 90`은 false, `!false` = true → `"가"` 출력

---

## Ch05 — 조건문 (if / switch)

### 개요

| 구문 | 특징 | 적합한 상황 |
|------|------|------------|
| `if` | 범위 조건 가능, boolean 표현식 | 범위 비교, 복합 조건 |
| `switch` | 특정 값과의 일치 비교 | 정수/문자/문자열 분기 |

---

### C01 — if 문

#### 단순 if

```java
// 조건이 true 일 때만 블록 실행
if (age >= 8) {
    System.out.println("학교에 다닙니다.");
}
```

#### if-else

```java
if (age >= 8) {
    System.out.println("학교에 다닙니다.");
} else {
    System.out.println("학교에 다니지 않습니다.");
}
```

#### if-else if-else (다중 분기)

```java
// 시험 점수 → 등급 출력
// else if 체인 : 앞 조건이 false일 때만 다음 조건 검사
Scanner sc = new Scanner(System.in);
int score = sc.nextInt();

if (score >= 90)
    System.out.println("A");
else if (score >= 80)
    System.out.println("B");
else if (score >= 70)
    System.out.println("C");
else if (score >= 60)
    System.out.println("D");
else
    System.out.println("F");
```

> **포인트** : `else if`는 앞 조건이 이미 false임이 보장되므로 `score < 90 && score >= 80` 처럼 범위 전체를 쓸 필요 없음

#### 중첩 if (nested if)

```java
// 3의 배수 → 출력, 그 중 5의 배수도 → 추가 출력
int n1 = sc.nextInt();
if (n1 % 3 == 0) {
    System.out.println(n1);
    if (n1 % 5 == 0)
        System.out.println("3의 배수이면서 5의 배수입니다.");
}
```

#### if 활용 예제

```java
// 두 정수 중 큰 수 출력
int n1 = sc.nextInt(), n2 = sc.nextInt();
if (n1 > n2) System.out.println(n1);
else         System.out.println(n2);

// 세 정수 중 큰 수 출력
int n1 = sc.nextInt(), n2 = sc.nextInt(), n3 = sc.nextInt();
if      (n1 >= n2 && n1 >= n3) System.out.println(n1);
else if (n2 >= n1 && n2 >= n3) System.out.println(n2);
else                            System.out.println(n3);

// 합격/불합격 (4과목 각 40점 이상 && 평균 60점 이상)
int kor = sc.nextInt(), eng = sc.nextInt(), math = sc.nextInt(), sci = sc.nextInt();
double avg = (double)(kor + eng + math + sci) / 4;

if (kor < 40 || eng < 40 || math < 40 || sci < 40 || avg < 60)
    System.out.println("불합격");
else
    System.out.println("합격");
```

---

### C02 — switch 문

```
switch (변수 또는 표현식) {
    case 값1:
        실행코드;
        break;      // break 없으면 다음 case 로 fall-through
    case 값2:
        실행코드;
        break;
    default:        // 일치하는 case 없을 때 실행
        실행코드;
}
```

> **주의** : `break` 생략 시 해당 case 이후 모든 case가 순서대로 실행됨 (fall-through)

```java
// 순위 → 메달 색상 출력
Scanner sc = new Scanner(System.in);
int ranking = sc.nextInt();
char medalColor;

switch (ranking) {
    case 1:
        medalColor = 'G';
        System.out.println("메달 색상 : G");
        break;
    case 2:
        medalColor = 'S';
        System.out.println("메달 색상 : S");
        break;
    case 3:
        medalColor = 'B';
        System.out.println("메달 색상 : B");
        break;
    default:
        medalColor = 'C';
        System.out.println("메달 색상 : C");
}
System.out.println(ranking + "등 메달의 색은 " + medalColor + " 입니다.");
```

---

### C03 — switch + while 메뉴 구조

```java
// 반복 메뉴 + switch 분기 + System.exit(-1) 종료
Scanner sc = new Scanner(System.in);
int num = 0;

while (true) {
    System.out.println("---------- JOIN MENU ----------");
    System.out.println("1 이메일 인증");
    System.out.println("2 개인정보 입력");
    System.out.println("3 회원가입 요청");
    System.out.println("4 종료");
    System.out.print("번호 입력 : ");
    num = sc.nextInt();

    switch (num) {
        case 1: System.out.println("이메일 인증처리 작업"); break;
        case 2: System.out.println("개인정보 입력 작업");  break;
        case 3: System.out.println("회원가입 처리 작업");  break;
        case 4:
            System.out.println("JOIN 메뉴 종료");
            System.exit(-1);  // 프로그램 강제 종료
            break;
        default: System.out.println("잘못된 메뉴번호입니다"); break;
    }
}
```

> **`System.exit(-1)`** : JVM 강제 종료, 음수는 비정상 종료를 의미

---

## Ch06 — 반복문 : while

### 개요

```
while (조건식) {
    // 조건식이 true인 동안 반복 실행
}
```

| 구성 요소 | 역할 |
|-----------|------|
| 탈출용 변수 | 반복 횟수 추적 (`int i = 0`) |
| 탈출 조건식 | false가 되면 루프 종료 (`i < 10`) |
| 탈출 연산식 | 조건이 false로 수렴하게 변경 (`i++`) |

---

### C01 — while 기본 패턴

```java
// 01 고정 N회 출력
int i = 0;
while (i < 10) {
    System.out.println("HELLO WORLD");
    i++;
}

// 02 입력받은 N회 출력 (N > 0 검증 포함)
Scanner sc = new Scanner(System.in);
int n = sc.nextInt();
if (n <= 0) {
    System.out.println("N은 0보다 커야함");
    System.exit(-1);
}
int i = 0;
while (i < n) {
    System.out.println("HELLO WORLD");
    i++;
}

// 03 1부터 10까지 합
int i = 1, sum = 0;
while (i <= 10) {
    sum += i;
    i++;
}
System.out.println(sum); // 55
```

---

### C01 — while 응용 문제

```java
// 1부터 n까지의 합
Scanner sc = new Scanner(System.in);
int n = sc.nextInt();
int i = 1, sum = 0;
while (i <= n) {
    sum += i;
    i++;
}
System.out.println(sum);

// n부터 m까지의 합 (n > m이면 swap)
int n = sc.nextInt(), m = sc.nextInt();
if (n > m) {          // swap
    int temp = n;
    n = m;
    m = temp;
}
int i = n, sum = 0;
while (i <= m) {
    sum += i;
    i++;
}
System.out.println(sum);

// n부터 m까지 짝수 합 / 홀수 합 분리 출력
int i = n, odd = 0, even = 0;
while (i <= m) {
    if (i % 2 == 0) even += i;
    else            odd  += i;
    i++;
}
System.out.printf("짝수 : %d, 홀수 : %d", even, odd);

// 구구단 N단 출력
int n = sc.nextInt();
int i = 1;
while (i <= 9) {
    System.out.println(n + " x " + i + " = " + (n * i));
    i++;
}
```

> **swap 패턴** : 두 변수 값 교환 시 임시 변수 `temp` 활용

---

### C02 — 이중 while / 구구단 / 별찍기

#### 구구단

```java
// 2~9단 전체
int dan = 2;
while (dan < 10) {
    int i = 1;
    while (i < 10) {
        System.out.printf("%d x %d = %d\t", dan, i, dan * i);
        i++;
    }
    dan++;
    System.out.println();
}

// n~9단 (입력 검증 포함)
Scanner sc = new Scanner(System.in);
int n = sc.nextInt();
while (n > 9 || n < 2) {
    System.out.print("2이상 9이하 값 입력 : ");
    n = sc.nextInt();
}
while (n < 10) {
    int i = 1;
    while (i < 10) {
        System.out.printf("%d x %d = %d\t", n, i, n * i);
        i++;
    }
    n++;
    System.out.println();
}
sc.close();

// n~m단 (n < m, 2 이상 9 이하 검증)
int n = sc.nextInt(), m = sc.nextInt();
while (n > 9 || n < 2 || n >= m || m <= 2 || m >= 10) {
    System.out.print("2이상 9이하 값 입력 or n>m 불만족 : ");
    n = sc.nextInt();
    m = sc.nextInt();
}
while (n <= m) {
    int i = 1;
    while (i < 10) {
        System.out.printf("%d x %d = %d\t", n, i, n * i);
        i++;
    }
    n++;
    System.out.println();
}

// n~m단 역순 출력 (각 단 내부 9→1)
while (n <= m) {
    int i = 9;
    while (i > 0) {
        System.out.printf("%d x %d = %d\t", n, i, n * i);
        i--;
    }
    n++;
    System.out.println();
}

// n~m단 역순 출력 (m단부터 n단 방향, 각 단 내부 9→1)
while (n < m) {
    int i = 9;
    while (i > 0) {
        System.out.printf("%d x %d = %d\t", m, i, m * i);
        i--;
    }
    m--;
    System.out.println();
}
```

---

#### 별찍기 패턴

```
1) 고정 5×5
*****
*****
*****
*****
*****
```
```java
int i = 0;
while (i < 5) {
    int j = 0;
    while (j < 5) { System.out.print("*"); j++; }
    System.out.println();
    i++;
}
```

---

```
2) 변수 높이 h×h
```
```java
int h = 4, i = 0;
while (i < h) {
    int j = 0;
    while (j < h) { System.out.print("*"); j++; }
    System.out.println();
    i++;
}
```

---

```
3) 좌측 계단 고정       4) 좌측 계단 변수 h
*                       j < i+1
**
***
****
```
```java
int i = 0;
while (i < 4) {
    int j = 0;
    while (j < i + 1) { System.out.print("*"); j++; }
    System.out.println();
    i++;
}
```

---

```
5) 역계단 변수 h
****
***
**
*       → j < h-i
```
```java
int h = 4, i = 0;
while (i < h) {
    int j = 0;
    while (j < h - i) { System.out.print("*"); j++; }
    System.out.println();
    i++;
}
```

---

```
6) 홀수 증가 (공백 없음)
*
***
*****
*******     → j < 2*i+1
```
```java
int h = 4, i = 0;
while (i < h) {
    int j = 0;
    while (j < 2 * i + 1) { System.out.print("*"); j++; }
    System.out.println();
    i++;
}
```

---

```
7) 홀수 감소
*******
*****
***
*           → j < (2*h)-(2*i)-1
```
```java
int h = 4, i = 0;
while (i < h) {
    int j = 0;
    while (j < (2 * h) - (2 * i) - 1) { System.out.print("*"); j++; }
    System.out.println();
    i++;
}
```

---

```
8) 다이아몬드 고정 7행 (공백 없음)
*
***
*****
*******
*****
***
*
```
```java
int i = 0, k = 0;
while (i < 7) {
    int j = 0;
    while (j < (2 * i) - (4 * k) + 1) { System.out.print("*"); j++; }
    if (i >= 3) k++;
    System.out.println();
    i++;
}
```

---

```
9) 다이아몬드 변수 h (공백 없음)
h=7: 1→3→5→7→5→3→1    별: (2*h)-(2*k)+1
```
```java
int h = 7, i = 0, k = h;
while (i < h) {
    int j = 0;
    while (j < (2 * h) - (2 * k) + 1) { System.out.print("*"); j++; }
    System.out.println();
    i++;
    if (h % 2 == 1) {
        if (i >= (h / 2) + 1) k++;
        else k--;
    } else {
        if (i > (h / 2)) k++;
        else if (i == (h / 2)) continue;
        else k--;
    }
}
```

---

```
10) 역다이아몬드 변수 h (공백 없음)
*******
*****
***
*
***
*****
*******
```
```java
int h = 7, i = 0, k = h;
while (i < h) {
    int j = (2 * k + 1) % (h + 1);
    while (j > 0) { System.out.print("*"); j--; }
    System.out.println();
    i++;
    if (h % 2 == 1) {
        if (i >= (h / 2) + 1) k++;
        else k--;
    } else {
        if (i > (h / 2)) k++;
        else if (i == (h / 2)) continue;
        else k--;
    }
}
```

---

```
11) 정삼각형 (공백 포함)
   *
  ***
 *****
*******     공백: h-i-1, 별: 2*i+1
```
```java
int h = 4, i = 0;
while (i < h) {
    int j = 0;
    while (j < h - i - 1) { System.out.print(" "); j++; }
    int k = 0;
    while (k < 2 * i + 1) { System.out.print("*"); k++; }
    System.out.println();
    i++;
}
```

---

```
12) 역삼각형 (공백 포함)
*******
 *****
  ***
   *        공백: i, 별: 2*h-2*i-1
```
```java
int h = 4, i = 0;
while (i < h) {
    int j = 0;
    while (j < i) { System.out.print(" "); j++; }
    int k = 0;
    while (k < 2 * h - 2 * i - 1) { System.out.print("*"); k++; }
    System.out.println();
    i++;
}
```

---

```
13) 다이아몬드 고정 (공백 포함, 높이 7)
   *                공백: 3-i+2*l
  ***               별:   2*i-4*l+1
 *****
*******
 *****
  ***
   *
```
```java
int i = 0, l = 0;
while (i < 7) {
    int j = 0;
    while (j < 3 - i + 2 * l) { System.out.print(" "); j++; }
    int k = 0;
    while (k < 2 * i - 4 * l + 1) { System.out.print("*"); k++; }
    System.out.println();
    i++;
    if (i >= 4) l++;
}
```

---

```
14) 다이아몬드 변수 h (공백 포함)
초기: spaces=(h-1)/2, stars=1, dir=1
```
```java
int h = 8, i = 0;
int spaces = (h - 1) / 2, stars = 1, dir = 1;
while (i < h) {
    int j = 0;
    while (j < spaces) { System.out.print(" "); j++; }
    int k = 0;
    while (k < stars) { System.out.print("*"); k++; }
    System.out.println();
    i++;
    if (dir == 1) {
        if (i > h / 2)       { dir = -1; spaces++; stars -= 2; }
        else if (spaces > 0) { spaces--; stars += 2; }
    } else { spaces++; stars -= 2; }
}
```

---

```
15) 역다이아몬드 변수 h (공백 포함)
*******     초기: spaces=0, stars=h, dir=1
 *****
  ***
   *
  ***
 *****
*******
```
```java
int h = 7, i = 0;
int spaces = 0, stars = h, dir = 1;
while (i < h) {
    int j = 0;
    while (j < spaces) { System.out.print(" "); j++; }
    int k = 0;
    while (k < stars) { System.out.print("*"); k++; }
    System.out.println();
    i++;
    if (dir == 1) {
        if (i > h / 2)                  { dir = -1; spaces--; stars += 2; }
        else if (spaces < (h - 1) / 2) { spaces++; stars -= 2; }
    } else { spaces--; stars += 2; }
}
```

> **다이아몬드 공식 요약**  
> - **공백 없음**: 별 `(2*h)-(2*k)+1`, k는 h에서 시작해 감소 후 중간 기점 이후 증가  
> - **공백 포함 고정**: 공백 `3-i+2*l`, 별 `2*i-4*l+1`, `l`은 `i>=4`부터 매 행 증가  
> - **공백 포함 변수**: `spaces/stars/dir` 방식 — dir=1 구간에서 공백--·별+2, 중간 이후 공백++·별-2

---

### C03 — continue / break

#### break

```java
// -1 입력 전까지 누적합
Scanner sc = new Scanner(System.in);
int n = 0, sum = 0;
while (true) {
    n = sc.nextInt();
    if (n == -1) break;
    sum += n;
}
System.out.println("SUM : " + sum);
sc.close();

// 한 줄 축약
while ((n = sc.nextInt()) != -1) sum += n;

// flag로 이중 while 전체 탈출 (7×7까지)
int dan = 2;
boolean isExit = false;
while (dan < 10) {
    int i = 1;
    while (i < 10) {
        System.out.printf("%d x %d = %d\t", dan, i, dan * i);
        if (dan == 7 && i == 7) { isExit = true; break; }
        i++;
    }
    if (isExit) break;
    dan++;
    System.out.println();
}

// 레이블(label)로 이중 while 전체 탈출
int dan = 2;
Exit:
while (dan < 10) {
    int i = 1;
    while (i < 10) {
        System.out.printf("%d x %d = %d\t", dan, i, dan * i);
        if (dan == 7 && i == 7) break Exit;
        i++;
    }
    dan++;
    System.out.println();
}
```

#### continue

```java
// 1~10 중 3의 배수 제외하고 합 출력
int i = 1, sum = 0;
while (i <= 10) {
    if (i % 3 == 0) { i++; continue; }
    System.out.println("i : " + i);
    sum += i;
    i++;
}
System.out.println("SUM : " + sum);
```

> **break vs continue**  
> - `break` : 현재 반복문 즉시 탈출  
> - `continue` : 이후 코드 건너뛰고 다음 반복으로  
> - `레이블:` + `break 레이블` : 중첩 반복문 전체 탈출 (flag 변수 없이 가능)

---

### C04 — for문

#### for 기본 구조

```
for (초기화; 조건식; 증감식) { }
```

| | while | for |
|---|-------|-----|
| 구조 | 초기화·증감식이 외부에 분리 | 3요소를 한 줄에 표현 |
| 적합 | 입력 검증처럼 update가 복잡한 경우 | 고정 횟수 반복 |
| 빈 슬롯 | — | `for (; 조건; 업데이트)` 가능 |

#### 빈 초기화·증감 — 입력 검증

```java
// n~9단 검증
Scanner sc = new Scanner(System.in);
int n = sc.nextInt();
for (; n > 9 || n < 2; n = sc.nextInt()) {
    System.out.print("2이상 9이하 값 입력 : ");
}

// 홀수만 받기
int h = sc.nextInt();
for (; h % 2 == 0 || h <= 1; h = sc.nextInt()) {
    System.out.println("재입력(홀수) : ");
}
```

#### 구구단

```java
// 2~9단
for (int dan = 2; dan < 10; dan++) {
    for (int i = 1; i < 10; i++) {
        System.out.printf("%d x %d = %d\t", dan, i, dan * i);
    }
    System.out.println();
}

// n~m단
for (; n > 9 || n < 2 || n >= m || m <= 2 || m >= 10;) {
    System.out.print("2이상 9이하 값 입력 or n>m 불만족 : ");
    n = sc.nextInt(); m = sc.nextInt();
}
for (; n <= m; n++) {
    for (int i = 1; i < 10; i++) {
        System.out.printf("%d x %d = %d\t", n, i, n * i);
    }
    System.out.println();
}

// n~m단 역순 (각 단 9→1)
for (; n <= m; n++) {
    for (int i = 9; i > 0; i--) {
        System.out.printf("%d x %d = %d\t", n, i, n * i);
    }
    System.out.println();
}

// n~m단 역순 (m단→n단 방향)
for (; n < m; m--) {
    for (int i = 9; i > 0; i--) {
        System.out.printf("%d x %d = %d\t", m, i, m * i);
    }
    System.out.println();
}
```

#### 별찍기 (공백 없음)

```java
// 1) 고정 5×5
for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) System.out.print("*");
    System.out.println();
}

// 3) 좌측 계단  /  5) 역계단  /  6) 홀수 증가  /  7) 홀수 감소
for (int i = 0; i < h; i++) {
    for (int j = 0; j < i + 1; j++)            System.out.print("*"); // 3
    for (int j = 0; j < h - i; j++)            System.out.print("*"); // 5
    for (int j = 0; j < 2 * i + 1; j++)        System.out.print("*"); // 6
    for (int j = 0; j < (2*h)-(2*i)-1; j++)    System.out.print("*"); // 7
    System.out.println();
}

// 8) 다이아몬드 고정 7행
int k = 0;
for (int i = 0; i < 7; i++) {
    for (int j = 0; j < (2 * i) - (4 * k) + 1; j++) System.out.print("*");
    if (i >= 3) k++;
    System.out.println();
}

// 9) 다이아몬드 변수 h
int h = 7, k = h;
for (int i = 0; i < h; i++) {
    for (int j = 0; j < (2 * h) - (2 * k) + 1; j++) System.out.print("*");
    System.out.println();
    if (h % 2 == 1) { if (i >= (h / 2) + 1) k++; else k--; }
    else { if (i > (h / 2)) k++; else if (i == (h / 2)) continue; else k--; }
}

// 10) 역다이아몬드 변수 h
int h = 7, k = h;
for (int i = 0; i < h; i++) {
    for (int j = (2 * k + 1) % (h + 1); j > 0; j--) System.out.print("*");
    System.out.println();
    if (h % 2 == 1) { if (i >= (h / 2) + 1) k++; else k--; }
    else { if (i > (h / 2)) k++; else if (i == (h / 2)) continue; else k--; }
}
```

#### 별찍기 (공백 포함)

```java
// 11) 정삼각형
for (int i = 0; i < h; i++) {
    for (int j = 0; j < h - i - 1; j++) System.out.print(" ");
    for (int k = 0; k < 2 * i + 1; k++) System.out.print("*");
    System.out.println();
}

// 12) 역삼각형
int h = 5;
for (int i = 0; i < h; i++) {
    for (int j = 0; j < i; j++) System.out.print(" ");
    for (int k = 0; k <= 2 * (h - i - 1); k++) System.out.print("*");
    System.out.println();
}

// 13) 다이아몬드 고정 (l 카운터 방식)
int l = 0;
for (int i = 0; i < 7; i++) {
    for (int j = 0; j < 3 - i + 2 * l; j++) System.out.print(" ");
    for (int k = 0; k <= 2 * i - 4 * l; k++) System.out.print("*");
    System.out.println();
    if (i >= 4) l++;
}

// 13) 다이아몬드 고정 (if-else 분기 방식)
for (int i = 0; i < 7; i++) {
    if (i < 4) {
        for (int j = 0; j < 3 - i; j++) System.out.print(" ");
        for (int k = 0; k <= 2 * i; k++) System.out.print("*");
    } else {
        for (int j = 0; j < i - 3; j++) System.out.print(" ");
        for (int k = 0; k <= 2 * (7 - i - 1); k++) System.out.print("*");
    }
    System.out.println();
}

// 14) 다이아몬드 변수 h — spaces/stars/dir 방식
int h = 8;
int spaces = (h - 1) / 2, stars = 1, dir = 1;
for (int i = 0; i < h; i++) {
    for (int j = 0; j < spaces; j++) System.out.print(" ");
    for (int k = 0; k < stars; k++) System.out.print("*");
    System.out.println();
    if (dir == 1) {
        if (i >= h / 2)      { dir = -1; spaces++; stars -= 2; }
        else if (spaces > 0) { spaces--; stars += 2; }
    } else { spaces++; stars -= 2; }
}

// 14) 다이아몬드 변수 h — if-else 분기 방식 (홀수 h만)
Scanner sc = new Scanner(System.in);
int h = sc.nextInt();
for (; h % 2 == 0 || h <= 1; h = sc.nextInt()) {
    System.out.println("재입력(홀수) : ");
}
for (int i = 0; i < h; i++) {
    if (i < h / 2 + 1) {
        for (int j = 0; j < h / 2 - i; j++) System.out.print(" ");
        for (int k = 0; k <= 2 * i; k++) System.out.print("*");
    } else {
        for (int j = 0; j < i - h / 2; j++) System.out.print(" ");
        for (int k = 0; k <= 2 * (h - i - 1); k++) System.out.print("*");
    }
    System.out.println();
}
sc.close();

// 15) 역다이아몬드 변수 h — spaces/stars/dir 방식
int h = 7;
int spaces = 0, stars = h, dir = 1;
for (int i = 0; i < h; i++) {
    for (int j = 0; j < spaces; j++) System.out.print(" ");
    for (int k = 0; k < stars; k++) System.out.print("*");
    System.out.println();
    if (dir == 1) {
        if (i >= h / 2)                  { dir = -1; spaces--; stars += 2; }
        else if (spaces < (h - 1) / 2) { spaces++; stars -= 2; }
    } else { spaces--; stars += 2; }
}

// 15) 역다이아몬드 변수 h — if-else 분기 방식
int h = 7;
for (int i = 0; i < h; i++) {
    if (i < h / 2 + 1) {
        for (int j = 0; j < i; j++) System.out.print(" ");
        for (int k = 0; k < h - 2 * i; k++) System.out.print("*");
    } else {
        for (int j = 0; j < h - i - 1; j++) System.out.print(" ");
        for (int k = 0; k < 2 * (i + 1) - h; k++) System.out.print("*");
    }
    System.out.println();
}
```

> **while → for 변환 포인트**  
> - `i++` 위치가 for 증감식으로 이동 → 내부에서 `continue` 쓸 때 `i++` 누락 주의 없음  
> - 다이아몬드 9·10번의 `i > h/2` (while, i++ 후 검사) → `i >= h/2` (for, i++ 전 검사)

---

### C05 — 기타 반복 처리

```java
// List 생성 및 요소 추가
List<String> lists = new ArrayList();
lists.add("JAVA");        // index 0
lists.add("JSP");         // index 1
lists.add("SERVLET");     // index 2
lists.add("SPRINGBOOT");  // index 3
lists.add("NODEJS");      // index 4
lists.add("REACT");       // index 5
lists.add("DOCKER_COMPOSE"); // index 6

// 1) 기본 for
for (int i = 0; i < lists.size(); i++) {
    System.out.println(lists.get(i));
}

// 2) 개량 for (enhanced for)
for (String subject : lists) {
    System.out.println(subject);
}

// 3) 스트림 + 람다식
lists.stream().forEach(item -> System.out.println(item));
```

| 방식 | 특징 |
|------|------|
| 기본 for | 인덱스 직접 접근 가능, 역순·건너뛰기 등 제어 자유로움 |
| 개량 for | 인덱스 불필요, 컬렉션·배열 순회에 간결 |
| 스트림 람다 | 함수형 스타일, 메서드 체이닝(filter·map 등)과 조합 가능 |

---

# JAVA02 — 객체지향 프로그래밍 (OOP)

---

## Ch01 — 객체지향 기초

---

### C00 — OOP 개념 / 메모리 구조

#### 객체(Object)란

> 독점적이고 배타적인 공간(VOLUME)을 차지하는 사물

| 구성 요소 | 설명 | Java 표현 |
|-----------|------|-----------|
| **속성 (Attribute)** | 객체마다 구별되는 데이터 | 멤버 변수 (필드) |
| **기능 (Function)** | 객체가 수행할 수 있는 공통 ACTION | 메서드 (함수) |

#### 객체지향(OOP)이란

현실 세계의 여러 객체 정보(속성/기능) 중 문제 해결에 필요한 일부만 **추출(추상화)** 하여  
Java 프로그램 내의 메모리 공간에 적재하기 위해 고안된 문법 체계

#### 클래스(Class)란

동일한 종류의 객체에 필요한 메모리 공간을 제공하기 위해 선언된 **자료형**

- 클래스로 객체를 생성하기 전에는 기본적으로 메모리를 차지하지 않음
- 객체가 정의(생성)되는 순간 클래스에서 선언한 속성·기능대로 공간 형성

#### 자바의 메모리 영역

| 영역 | 설명 | 저장 대상 |
|------|------|-----------|
| **스택(Stack)** | `{}` 내에서 생성되고 소멸 | 지역 변수, 기본 타입 변수 |
| **클래스(=메서드) 영역** | 공유 메모리 | 생성자, 일반 메서드, static 메서드, static 변수 |
| **힙(Heap)** | 객체 저장 영역 | `new` 예약어 사용 시 할당 |

```java
Scanner sc = new Scanner(System.in);
//  ↑참조변수(Stack)  ↑new → Heap에 객체 생성  ↑생성자(초기값 부여)
```

> `new` → Heap에 Scanner 객체 생성 → 시작 메모리 주소를 Stack의 참조변수 `sc`에 저장

---

### C01 / C02 — 클래스 기본 (속성)

```java
// 클래스 선언 (별도 파일 또는 같은 파일에 작성)
class Person {
    // 속성(멤버 변수, 필드) — 기본값으로 초기화됨
    public String name;    // null
    public int age;        // 0
    public float height;   // 0.0F
    public double weight;  // 0.0
}

// 객체 생성 및 사용
Person hong = new Person();
System.out.printf("%s %d %f %f\n", hong.name, hong.age, hong.height, hong.weight);
// 출력: null 0 0.000000 0.000000

hong.name   = "홍길동";
hong.age    = 15;
hong.height = 177.5f;
hong.weight = 70.5;
System.out.printf("%s %d %f %f\n", hong.name, hong.age, hong.height, hong.weight);
// 출력: 홍길동 15 177.500000 70.500000
```

> **멤버 변수 기본값** : `String` → `null`, `int` → `0`, `float` → `0.0F`, `double` → `0.0`

---

### C03 — 메서드 추가 (기능)

```java
class Person {
    public String name;
    public int age;
    public float height;
    public double weight;

    // 반환값 없는 메서드
    void talk() { System.out.printf("%s님이 말합니다.\n", this.name); }
    void walk() { System.out.printf("%s님이 걷습니다.\n", this.name); }

    // 반환값 있는 메서드
    String showInfo() {
        return "name : " + this.name +
               " age : " + this.age +
               " height : " + this.height +
               " weight : " + this.weight;
    }

    // toString 오버라이드 — System.out.println(객체) 시 자동 호출
    @Override
    public String toString() {
        return "Person [name=" + name + ", age=" + age +
               ", height=" + height + ", weight=" + weight + "]";
    }
}

// 사용
Person hong = new Person();
hong.name = "홍길동"; hong.age = 15; hong.height = 177.5f; hong.weight = 70.5;

hong.talk();                     // 홍길동님이 말합니다.
hong.walk();                     // 홍길동님이 걷습니다.
System.out.println(hong.showInfo());  // name : 홍길동 age : 15 ...
System.out.println(hong.toString());  // Person [name=홍길동, age=15, ...]
```

> **`this`** : 현재 객체 자신을 가리키는 참조 — 멤버 변수와 지역 변수 이름이 겹칠 때 명시적으로 구분

---

### C04 — 메서드 유형 4가지

| 유형 | 파라미터 | 반환값 | 특징 |
|------|----------|--------|------|
| `sum1` | O (외부 전달) | O (`int`) | 호출부에서 값 전달·결과 수신 |
| `sum2` | X | O (`int`) | 메서드 내부에서 Scanner로 직접 입력 |
| `sum3` | O (외부 전달) | X (`void`) | 메서드 내에서 출력 처리 |
| `sum4` | X | X (`void`) | 내부 입력 + 내부 출력 |

```java
class Cal {
    Scanner sc = new Scanner(System.in); // 멤버 변수로 Scanner 보유

    public int sum1(int n1, int n2) { return n1 + n2; }
    public int sum2()               { return sc.nextInt() + sc.nextInt(); }
    public void sum3(int n1, int n2){ System.out.println("SUM3 : " + (n1 + n2)); }
    public void sum4()              { System.out.println("SUM4 : " + (sc.nextInt() + sc.nextInt())); }
}

Cal c = new Cal();
System.out.println("SUM1 : " + c.sum1(10, 20)); // 파라미터 전달
System.out.println("SUM2 : " + c.sum2());        // 메서드 내부에서 입력
c.sum3(5, 15);                                    // 파라미터 전달, 내부 출력
c.sum4();                                         // 내부 입력 + 내부 출력
```

---

### C05 — 변수 종류

| 변수 종류 | 선언 위치 | 생존 범위 | 용도 |
|-----------|-----------|-----------|------|
| **멤버 변수** | 클래스 내부, 메서드 외부 | 객체가 살아있는 동안 | 객체 개별 데이터 저장 |
| **지역 변수** | 메서드(또는 `{}`) 내부 | 해당 `{}` 종료 시 소멸 | 임시 계산·처리용 |
| **파라미터 변수** | 메서드 선언부 `()` 안 | 해당 메서드 내부 | 외부에서 값 전달 수신 |
| **static 변수** | 클래스 내부 (`static` 키워드) | 프로그램 종료 시까지 | 동일 클래스 객체 간 공유 |

```java
class Simple {
    int num = 10; // 멤버 변수

    void Func1() {
        num++;              // 멤버 변수 사용 → 11
        System.out.println(num);   // 11
        int num = 20;       // 지역 변수 num 정의 (멤버 변수와 이름 중복)
        num++;              // 지역 변수 ++ → 21
        this.num++;         // 멤버 변수 ++ → 12
        System.out.println(num);       // 21 (지역 변수)
        System.out.println(this.num);  // 12 (멤버 변수)
    }

    void Func2() {
        System.out.println(num);   // 멤버 변수
        if (num > 0) {
            int num = 100;         // if 블록 지역 변수
            System.out.println(num);   // 100
        }
        System.out.println(num);   // 다시 멤버 변수
        while (num < 15) {
            int num = 100;         // while 블록 지역 변수
            System.out.println(num);   // 100
            num++;                 // 지역 변수 ++
            this.num++;            // 멤버 변수 ++
        }
    }

    void Func3(int num) {          // 파라미터 변수
        this.num = num;            // 파라미터 → 멤버 변수에 대입
    }
}
```

> **`this.num` vs `num`** : 같은 이름이 겹칠 때 `this.`를 붙이면 멤버 변수, 없으면 가장 가까운 지역 변수

---

### C06 — 메서드 오버로딩 (Method Overloading)

같은 이름의 메서드를 **매개변수의 타입·개수·순서**를 다르게 하여 여러 개 선언하는 것. 리턴 타입은 오버로딩 조건에 해당하지 않음.

```java
class Calc {
    Scanner sc = new Scanner(System.in);

    public int sum(int n1, int n2)               { return n1 + n2; }
    public int sum()                             { return sc.nextInt() + sc.nextInt(); }
    public int sum(int n1, int n2, int n3)       { return n1 + n2 + n3; }
    public int sum(int n1, int n2, int n3, int n4) { return n1 + n2 + n3 + n4; }
}

Calc c = new Calc();
c.sum(10, 20);        // int sum(int, int) 호출
c.sum();              // int sum() 호출
c.sum(10, 20, 30);    // int sum(int, int, int) 호출
c.sum(10, 20, 30, 40);// int sum(int, int, int, int) 호출
```

---

### C07 — 가변인자 (Varargs)

매개변수 개수가 불확실할 때 `타입... 변수명` 으로 선언. 내부적으로 **배열**로 처리됨.

```java
class C07Simple {
    int sum(int ...arg) {   // int[] arg 와 동일하게 동작
        int s = 0;
        for (int item : arg) {
            s += item;
        }
        return s;
    }
}

C07Simple obj = new C07Simple();
obj.sum(10, 20);        // 누적 합 : 30
```

---

### C08 — 생성자 메서드 (Constructor)

| 특징 | 설명 |
|---|---|
| 호출 시점 | 객체 생성 시 **1회만** 호출 |
| 이름 | 클래스 이름과 동일 |
| 반환형 | 없음 (void도 아님) |
| 역할 | 메모리 공간 형성 + 필드 초기값 부여 |
| 디폴트 생성자 | 생성자를 명시하지 않으면 컴파일러가 자동 삽입, 명시하면 삽입 안 됨 |

```java
class C08Simple {
    int n1; double n2; boolean n3; String n4;

    // 기본 생성자 — 하드코딩 초기값
    C08Simple() {
        this.n1 = 11; this.n2 = 22.22;
        this.n3 = true; this.n4 = "HELLO WORLD";
    }

    // 오버로딩 생성자들
    public C08Simple(int n1)                              { this.n1 = n1; }
    public C08Simple(int n1, double n2)                   { this.n1 = n1; this.n2 = n2; }
    public C08Simple(int n1, double n2, boolean n3)       { this.n1 = n1; this.n2 = n2; this.n3 = n3; }
    public C08Simple(int n1, double n2, boolean n3, String n4) {
        this.n1 = n1; this.n2 = n2; this.n3 = n3; this.n4 = n4;
    }

    @Override
    public String toString() {
        return "C08Simple [n1=" + n1 + ", n2=" + n2 + ", n3=" + n3 + ", n4=" + n4 + "]";
    }
}

C08Simple ob1 = new C08Simple();                    // 기본 생성자
C08Simple ob2 = new C08Simple(99, 88.88, true, "HI WORLD"); // 오버로딩 생성자
```

---

### C09 — 클래스 연습 — TV / 객체 기초 (C09Ex)

```java
class TV {
    String brand; int year; int size;

    public TV(String brand, int year, int size) {
        this.brand = brand; this.year = year; this.size = size;
    }

    void show() {
        System.out.printf("%s에서 만든 %d년형 %d인치 TV", brand, year, size);
    }
}

TV myTV = new TV("LG", 2017, 32);
myTV.show(); // LG에서 만든 2017년형 32인치 TV
```

#### 객체지향 개념 O/X 정리 (이것이자바다 1~7번)

| 번호 | 핵심 내용 | 정답 |
|---|---|---|
| 1 | 하나의 클래스로 하나의 객체만 생성할 수 있다 | **틀림** — 여러 인스턴스 생성 가능 |
| 2 | 로컬 변수는 클래스 구성 멤버이다 | **틀림** — 필드·생성자·메서드가 구성 멤버 |
| 3 | 클래스는 반드시 필드와 메서드를 가져야 한다 | **틀림** — 구성 멤버는 생략 가능 |
| 4 | 필드는 반드시 생성자 선언 전에 선언해야 한다 | **틀림** — `{}` 블록 어디서든 선언 가능 |
| 5 | 객체를 생성하려면 생성자 호출이 반드시 필요한 것은 아니다 | **틀림** — 생성자 호출 없이 객체 생성 불가 |
| 6 | 메서드 이름은 중복 선언할 수 없다 | **틀림** — 오버로딩으로 중복 선언 가능 |
| 7 | 오버로딩 조건: 반드시 리턴 타입이 달라야 한다 | **틀림** — 매개변수 타입·수·순서가 달라야 함 |

---

### C10 — 파라미터 타입 — Primitive vs Reference (C10Ex)

```java
class Person {
    String name; int age;
    public Person(String name, int age) { this.name = name; this.age = age; }
}

public static void func1(int num)       // Primitive — 데이터 값(복사본) 전달
public static void func2(Person obj)    // Reference  — 객체의 주소값 전달
public static Object func3(String name, int age) {
    return new Person(name, age);       // Object 타입으로 반환 (다형성)
}

func1(10);
func2(new Person("홍길동", 10));
Object ob = func3("티모", 100);
```

| 구분 | Primitive | Reference |
|---|---|---|
| 저장 내용 | 데이터 값 자체 | 힙 영역의 객체 주소값 |
| 예 | `int`, `double`, `boolean` | 클래스 객체, 배열 |

---

### C11 — 클래스 연습 — Grade 평균 계산 (C11EX_GRADE)

```java
class Grade {
    private int math, science, english;

    public Grade(int math, int science, int english) {
        this.math = math; this.science = science; this.english = english;
    }

    public double average() {
        return (double)(math + science + english) / 3;
    }
}

Scanner sc = new Scanner(System.in);
int math = sc.nextInt(); int science = sc.nextInt(); int english = sc.nextInt();
Grade me = new Grade(math, science, english);
System.out.println("평균은 " + me.average());
// 입력: 90 88 96 → 출력: 평균은 91.33...
```

> **포인트**: 필드를 `private`으로 캡슐화하고, 생성자로 초기값을 받아 `average()` 메서드로 계산 결과만 반환

---

### 객체 상호작용 연습 — 구매자 / 판매자 패턴

두 클래스가 서로 메서드를 호출하며 상호작용하는 구조. 공통 흐름:

```
구매자.구매메서드(판매자, 금액)
  → 판매자.판매메서드(금액) : 수량 반환
  → 구매자 금액 차감 + 수량 누적
```

### C12Ex — 고객(Buyer) / 사과장수(Seller)

```java
class Buyer {
    private int myMoney;
    private int appleCnt;

    public void pay(Seller seller, int money) {
        int receivedAppCnt;
        if (this.myMoney < money) {         // 잔액 부족이면 가진 돈 전부 사용
            receivedAppCnt = seller.sales(this.myMoney);
            this.myMoney = 0;
        } else {
            receivedAppCnt = seller.sales(money);
            this.myMoney -= money;
        }
        this.appleCnt += receivedAppCnt;
    }
}

class Seller {
    private int myMoney;
    private int appleCnt;
    private int price;

    public int sales(int money) {
        this.myMoney += money;
        int calAppCnt = money / price;
        this.appleCnt -= calAppCnt;
        return calAppCnt;
    }
}

// 사용
Buyer b1 = new Buyer(100000, 0);
Buyer b2 = new Buyer(50000, 0);
Seller s1 = new Seller(100000, 100, 1000); // 사과 1개 = 1000원
b1.pay(s1, 20000); // b1 → 20개 구매
b2.pay(s1, 10000); // b2 → 10개 구매
```

> **포인트**: `myMoney < money` 분기로 잔액 부족 상황 처리

---

### C13Ex — 학생(Student) / 서점주인(BookSeller)

```java
class Student {
    private int myMoney;
    private int bookCnt;

    public void buy(BookSeller seller, int money) {
        this.myMoney -= money;
        int receiveBookCnt = seller.sell(money);
        this.bookCnt += receiveBookCnt;
    }
}

class BookSeller {
    private int myMoney;
    private int bookCnt;
    private int price;

    public int sell(int money) {
        this.myMoney += money;
        int calBookCnt = money / price;
        this.bookCnt -= calBookCnt;
        return calBookCnt;
    }
}

// 사용
Student s = new Student(50000, 0);
BookSeller bs = new BookSeller(100000, 100, 5000); // 책 1권 = 5000원
s.buy(bs, 5000); // 책 1권 구매
```

---

### C14Ex — 손님(Customer) / 카페사장(CafeOwner)

```java
class Customer {
    private int myMoney;
    private int coffeeCnt;

    public void order(CafeOwner owner, int money) {
        this.myMoney -= money;
        int recieveCoffeeCnt = owner.make(money);
        this.coffeeCnt += recieveCoffeeCnt;
    }
}

class CafeOwner {
    private int myMoney;
    private int coffeeCnt;
    private int price;

    public int make(int money) {
        this.myMoney += money;
        int calCoffeeCnt = money / price;
        this.coffeeCnt -= calCoffeeCnt;
        return calCoffeeCnt;
    }
}

// 사용
Customer c = new Customer(100000, 0);
CafeOwner co = new CafeOwner(100000, 100, 10000); // 커피 1잔 = 10000원
c.order(co, 10000); // 커피 1잔 주문
```

---

### C15Ex — 관객(Audience) / 매표원(TicketSeller)

```java
class Audience {
    private int myMoney;
    private int ticketCnt;

    public void reserve(TicketSeller seller, int money) {
        this.myMoney -= money;
        int recieveTicketCnt = seller.issue(money);
        this.ticketCnt += recieveTicketCnt;
    }
}

class TicketSeller {
    private int myMoney;
    private int ticketCnt;
    private int price;

    public int issue(int money) {
        this.myMoney += money;
        int calTicketCnt = money / price;
        this.ticketCnt -= calTicketCnt;
        return calTicketCnt;
    }
}

// 사용
Audience a = new Audience(100000, 0);
TicketSeller ts = new TicketSeller(100000, 100, 10000); // 티켓 1장 = 10000원
a.reserve(ts, 10000); // 티켓 1장 예매
```

---

### 4개 예제 공통 구조 비교

| 파일 | 구매자 클래스 | 판매자 클래스 | 구매 메서드 | 판매 메서드 |
|---|---|---|---|---|
| C12Ex | `Buyer` | `Seller` | `pay()` | `sales()` |
| C13Ex | `Student` | `BookSeller` | `buy()` | `sell()` |
| C14Ex | `Customer` | `CafeOwner` | `order()` | `make()` |
| C15Ex | `Audience` | `TicketSeller` | `reserve()` | `issue()` |

> **핵심**: 필드는 `private` 캡슐화, 두 객체가 메서드를 통해서만 상호작용 — 객체지향의 **책임 분리** 원칙

---

## Ch02 — 캡슐화

### C01 — 접근 한정자 (Access Modifier) — 정보 은닉

멤버/클래스의 접근 범위를 제한하는 예약어.

| 한정자 | 접근 범위 |
|---|---|
| `public` | 모든 클래스에서 접근 가능 |
| `private` | 해당 클래스 내부에서만 접근 가능 |
| `protected` | 상속 관계에 있는 클래스에서 접근 가능 |
| `default` (생략) | 동일 패키지 내 클래스에서 접근 가능 |

```java
class C01Person {
    private String name;
    private int age;
    private String addr;

    public C01Person(String name, int age, String addr) {
        this.name = name; this.age = age; this.addr = addr;
    }

    // getter / setter 로만 외부 접근 허용
    public void setName(String name) { this.name = name; }
    public String getName()          { return this.name; }
    public int getAge()              { return age; }
    public void setAge(int age)      { this.age = age; }
    public String getAddr()          { return addr; }
    public void setAddr(String addr) { this.addr = addr; }

    @Override
    public String toString() {
        return "C01Person [name=" + name + ", age=" + age + ", addr=" + addr + "]";
    }
}

C01Person ob = new C01Person("홍길동", 55, "대구");
// ob.name = "남길동";  // 컴파일 에러 — private 접근 불가
ob.setName("남길동");   // setter 로만 수정 가능
System.out.println(ob);
```

---

### C02 — 캡슐화 (Encapsulation)

특정 목적의 기능을 구현하는 데 필요한 **세부 기능들을 하나로 묶어** 처리하는 방법.  
내부 구현(세부 공정)을 외부에 노출하지 않으려고 정보 은닉을 함께 사용한다.

```java
class Engine {
    private void 흡입() { System.out.println("외부로부터 공기를 흡입한다."); }
    private void 압축() { System.out.println("가둔 공기를 압축시킨다."); }
    private void 폭발() { System.out.println("일정 수준 압축되면 폭발"); }
    private void 배기() { System.out.println("가스를 외부로 보낸다."); }

    // 4개의 세부 공정을 캡슐화 — 외부에서는 이 메서드만 호출
    public void engineStart() {
        흡입(); 압축(); 폭발(); 배기();
    }
}

class Car {
    private Engine engine;
    Car() { this.engine = new Engine(); }
    void run() { engine.engineStart(); }  // Car 도 Engine 내부를 모름
}
```

> 외부(Car, 사용자)는 `engineStart()` / `run()` 만 알면 됨 — 내부 공정은 은닉

---

### C03 — this 예약어

| 사용 형태 | 역할 |
|---|---|
| `this` | 현재 객체의 메모리 주소(해시코드값) |
| `this.멤버변수` | 멤버 변수와 지역 변수(파라미터)를 구별 |
| `this()` | 오버로딩된 **다른 생성자** 호출 (생성자 첫 줄에만 사용 가능) |

```java
class C03Simple {
    int x, y;

    public C03Simple() {
        this(10, 10);                          // C03Simple(int, int) 호출
        System.out.println("C03Simple() Call");
    }
    public C03Simple(int x) {
        this(x, 10);                           // C03Simple(int, int) 호출
        System.out.println("C03Simple(int x) Call");
    }
    public C03Simple(int x, int y) {
        this.x = x; this.y = y;                // this. 로 멤버변수 구별
        System.out.println("C03Simple(int x, int y) Call");
    }

    public C03Simple getThis() { return this; } // 자기 자신 반환
}

// 실행 결과
C03Simple ob1 = new C03Simple();
// → C03Simple(int x, int y) Call  (this(10,10) 으로 먼저 호출됨)
// → C03Simple() Call

C03Simple ob2 = new C03Simple(11);
// → C03Simple(int x, int y) Call
// → C03Simple(int x) Call
```

> `this()` 호출 시 **호출된 생성자가 먼저 실행**된 후 현재 생성자의 나머지 코드가 실행된다

---

### C04 — String 저장 방식 — 리터럴 vs new

```java
String str1 = "java";          // 상수 Pool에 저장
String str2 = "java";          // Pool에서 재사용 → str1 과 같은 주소
String str3 = new String("java"); // Heap에 새 객체 생성
String str4 = new String("java"); // Heap에 또 다른 새 객체 생성
```

| 비교 | 결과 | 이유 |
|---|---|---|
| `str1 == str2` | `true` | 같은 Pool 주소 |
| `str3 == str4` | `false` | 각각 다른 Heap 객체 |
| `str1 == str3` | `false` | Pool 주소 ≠ Heap 주소 |
| `str1.equals(str2)` | `true` | 값 비교 |
| `str3.equals(str4)` | `true` | 값 비교 |
| `str1.equals(str3)` | `true` | 값 비교 |

> **`==`** 은 주소(참조) 비교, **`equals()`** 는 값(내용) 비교  
> String 은 항상 `equals()` 로 비교할 것

---

### C05 — String 주요 메서드 & StringBuilder

#### String + 연산의 문제점

`+` 또는 `concat()` 으로 문자열을 이을 때마다 **새로운 Heap 객체**가 생성된다 → 반복 시 메모리 낭비(누수).

| 방법 | 저장 위치 | 특징 |
|---|---|---|
| `String +` / `concat()` | Heap (매번 새 객체) | 반복 사용 시 메모리 낭비 |
| `StringBuilder` | Heap (동일 객체 재사용) | 빠름, 단일 스레드용 |
| `StringBuffer` | Heap (동일 객체 재사용) | 느림, 멀티 스레드 안전 |

`System.identityHashCode()` 로 실제 주소(해시코드)를 찍어보면 차이가 확인된다.

```java
// String + / concat() : 연산마다 새 Heap 객체 → 주소가 매번 바뀜
String str1 = "Java Powerful";
String str2 = new String("java Programming");
String str3 = str1 + str2;         // Heap — 새 객체
String str4 = str1.concat(str2);   // Heap — 새 객체
String str5 = str1.concat(str2);   // Heap — 또 새 객체 (str4 ≠ str5)
String str6 = str1 + str2;         // Heap — 또 새 객체 (str3 ≠ str6)

System.out.printf("%x%n", System.identityHashCode(str3)); // 주소1
System.out.printf("%x%n", System.identityHashCode(str4)); // 주소2 (다름)
System.out.printf("%x%n", System.identityHashCode(str5)); // 주소3 (다름)

// String + 반복 : += 할 때마다 주소가 계속 바뀜
String str7 = "Hello World";
System.out.printf("%x%n", System.identityHashCode(str7)); // 주소A
str7 += 1;
System.out.printf("%x%n", System.identityHashCode(str7)); // 주소B (바뀜)
str7 += 2;
System.out.printf("%x%n", System.identityHashCode(str7)); // 주소C (바뀜)

System.out.println("----------------------");

// StringBuilder : append 해도 동일 객체 유지 → 주소 불변
StringBuilder builder = new StringBuilder("Hello World");
System.out.printf("%x%n", System.identityHashCode(builder)); // 주소X
builder.append("1");
System.out.printf("%x%n", System.identityHashCode(builder)); // 주소X (동일)
builder.append("2");
System.out.printf("%x%n", System.identityHashCode(builder)); // 주소X (동일)
builder.append("3");
```

#### 자주 쓰는 String 메서드

```java
String str1 = "Java Powerful";

str1.length()           // 13       — 문자열 길이
str1.charAt(2)          // 'v'      — 인덱스 위치 한 문자
str1.indexOf('a')       // 1        — 앞에서 첫 번째 위치
str1.lastIndexOf('a')   // 3        — 뒤에서 첫 번째 위치
str1.contains("va")     // true     — 부분 문자열 포함 여부
str1.contains("abs")    // false
str1.substring(2, 6)    // "va P"   — 인덱스 [2, 6) 구간 추출

String str6 = "등산,탁구,축구,골프,독서,영화감상";
String[] result = str6.split(",");  // 구분자로 분리 → String 배열
for (String hobby : result) System.out.println(hobby);
```

---

### C06 — 종합 예제 : Profile 클래스

캡슐화 + 생성자 오버로딩 + String 메서드(`split`, `contains`, `equals`) 응용.

```java
class Profile {
    private String name, addr, job, major;

    // 디폴트 생성자
    public Profile() { super(); }

    // 모든 필드를 인자로 받는 생성자
    public Profile(String name, String addr, String job, String major) {
        this.name = name; this.addr = addr;
        this.job  = job;  this.major = major;
    }

    // CSV 문자열 한 줄로 받는 생성자 — split 으로 분리해 저장
    public Profile(String s) {
        String[] result = s.split(",");
        this.name = result[0]; this.addr = result[1];
        this.job  = result[2]; this.major = result[3];
    }

    // getter / setter (name, addr, job, major 각각)
    public String getName()  { return name; }
    public void setName(String name)   { this.name  = name;  }
    public String getAddr()  { return addr; }
    public void setAddr(String addr)   { this.addr  = addr;  }
    public String getJob()   { return job;  }
    public void setJob(String job)     { this.job   = job;   }
    public String getMajor() { return major; }
    public void setMajor(String major) { this.major = major; }

    @Override
    public String toString() {
        return "Profile [name=" + name + ", addr=" + addr
             + ", job=" + job + ", major=" + major + "]";
    }

    // findstr 이 name/addr/job/major 중 하나라도 포함되면 true
    boolean isContain(String findstr) {
        return name.contains(findstr) || addr.contains(findstr)
            || job.contains(findstr)  || major.contains(findstr);
    }

    // CSV 문자열을 split 해 각 필드와 완전히 일치하면 true
    boolean isEquals(String str) {
        String[] r = str.split(",");
        return name.equals(r[0]) && addr.equals(r[1])
            && job.equals(r[2])  && major.equals(r[3]);
    }
}
```

```java
Profile hong = new Profile("홍길동,대구,프로그래머,컴퓨터공학");

System.out.println(hong);
// Profile [name=홍길동, addr=대구, job=프로그래머, major=컴퓨터공학]

hong.isContain("길동");    // true  — name 에 포함
hong.isContain("컴퓨터");  // true  — major 에 포함

hong.isEquals("홍길동,대구,프로그래머,컴퓨터공학");  // true
hong.isEquals("홍길동,울산,프로그래머,컴퓨터공학");  // false — addr 불일치
```

---

## Ch03 — 배열 (Array)

### C01 — 1차원 배열 기본 & 최대/최소

```java
int[] arr1 = new int[5];   // 크기 5짜리 int 배열 선언
// Scanner 로 값 입력
arr1[0] = sc.nextInt();  arr1[1] = sc.nextInt();  // ...

// 배열 길이
System.out.println("배열길이 : " + arr1.length);

// 순회 3가지
for (int i = 0; i < arr1.length; i++) System.out.println(arr1[i]);  // 일반 for
for (int el : arr1) System.out.println(el);                          // 향상된 for
Arrays.stream(arr1).forEach(el -> System.out.println(el));           // Stream
```

#### 최대값 / 최소값

**방법 1 — for 루프 직접 비교**

```java
int max = arr1[0];
for (int el : arr1) {
    if (el > max) max = el;
}

int min = arr1[0];
for (int el : arr1) {
    if (el < min) min = el;
}
System.out.println("max : " + max);
System.out.println("min : " + min);
```

**방법 2 — Arrays.stream (간결)**

```java
System.out.println("MAX : " + Arrays.stream(arr1).max().getAsInt());
System.out.println("MIN : " + Arrays.stream(arr1).min().getAsInt());
```

---

### C02 — 얕은 복사 vs 깊은 복사

| 종류 | 방법 | 결과 |
|---|---|---|
| **얕은 복사** (주소 복사) | `arr2 = arr1` | 같은 배열 공유 → 한쪽 수정이 양쪽에 반영 |
| **깊은 복사** (값 복사) | `for` 루프 직접 복사 | 독립된 새 배열 |
| **깊은 복사** (API) | `Arrays.copyOf(arr, len)` | 독립된 새 배열 |

```java
int[] arr1 = {10, 20, 30};

// 얕은 복사
int[] arr2 = arr1;
arr1[0] = 100;
// arr2[0] 도 100 — 같은 주소

// 깊은 복사 (for)
int[] arr3 = new int[arr1.length];
for (int i = 0; i < arr1.length; i++) arr3[i] = arr1[i];

// 깊은 복사 (Arrays API)
int[] arr4 = Arrays.copyOf(arr1, arr1.length);

// arr1 == arr2  → true  (같은 주소)
// arr1 == arr3  → false (다른 주소)
// arr1 == arr4  → false (다른 주소)
```

---

### C03 — 2차원 배열 (가변 배열)

각 행의 열 개수가 달라도 된다 — Java의 2차원 배열은 **배열의 배열**.

```java
int[][] arr = {
    {10, 20, 30},
    {40, 50, 60, 65, 67},
    {70, 80, 90, 96, 11, 56},
    {100, 110, 120, 15, 22, 33, 44}
};

arr.length      // 4  — 행 수
arr[0].length   // 3  — 0행의 열 수
arr[1].length   // 5
arr[2].length   // 6
arr[3].length   // 7
```

> `arr[i]` 는 각각 독립된 1차원 배열 → 행마다 길이가 달라도 OK

---

### C04 — 객체 배열

배열 선언 시 **참조변수 공간만 생성**됨 — 각 요소에 `new` 로 객체를 직접 넣어야 한다.

```java
class C04Person {
    String name;
    int age;
    public C04Person() { super(); }
    public C04Person(String name, int age) { this.name = name; this.age = age; }

    @Override
    public String toString() {
        return "C04Person [name=" + name + ", age=" + age + "]";
    }
}

C04Person[] list = new C04Person[3]; // 참조변수 3칸만 생성, 객체 X

list[0] = new C04Person(); list[0].name = "홍길동"; list[0].age = 55;
list[1] = new C04Person(); list[1].name = "김영희"; list[1].age = 35;
list[2] = new C04Person(); list[2].name = "김범수"; list[2].age = 40;

for (C04Person person : list) System.out.println(person);
// C04Person [name=홍길동, age=55]
// C04Person [name=김영희, age=35]
// C04Person [name=김범수, age=40]
```

---

### C05 — main 파라미터 (args)

`main(String[] args)` 의 `args` 는 실행 시 전달하는 **커맨드라인 인수** 배열.

```java
public static void main(String[] args) {
    System.out.println("length : " + args.length);
    for (String param : args) System.out.println(param);
}
```

```
# 실행 예
java C05MainParam hello world 123
// length : 3
// hello
// world
// 123
```

---

### C06 — 종합 예제 : 1차원 배열 + 2차원 배열

#### 파트 1 — 1차원 배열 : 최대값 / 최소값 / 전체합

```java
int[] numb = new int[5];
numb[0] = sc.nextInt();
numb[1] = sc.nextInt();
numb[2] = sc.nextInt();
numb[3] = sc.nextInt();
numb[4] = sc.nextInt();

System.out.println("최대값 : " + Arrays.stream(numb).max().getAsInt());
System.out.println("최소값 : " + Arrays.stream(numb).min().getAsInt());
System.out.println("전체합 : " + Arrays.stream(numb).sum());
```

#### 파트 2 — 2차원 배열 : 학생 점수 합 / 평균

```java
// 5명 × 3과목 점수 입력
int[][] studentScore = new int[5][3];
String[] subjects = {"국어", "영어", "수학"};

for (int i = 0; i < studentScore.length; i++) {
    System.out.println("학생" + (i + 1) + "의 국영수점수 : ");
    studentScore[i][0] = sc.nextInt();
    studentScore[i][1] = sc.nextInt();
    studentScore[i][2] = sc.nextInt();
}

// 학생별 합 / 평균
for (int i = 0; i < studentScore.length; i++) {
    int sum = 0;
    for (int score : studentScore[i]) sum += score;
    double avg = (double) sum / studentScore[i].length;
    System.out.println("학생" + (i + 1) + "의 점수 합 : " + sum + ", 평균 : " + avg);
}

// 과목별 합 / 평균 — 열(column) 방향 순회
for (int i = 0; i < subjects.length; i++) {
    int sum = 0;
    for (int j = 0; j < studentScore.length; j++) sum += studentScore[j][i];
    double avg = (double) sum / studentScore.length;
    System.out.println(subjects[i] + "의 점수 합 : " + sum + ", 평균 : " + avg);
}
```

> 학생별 순회 → **행(row) 고정, 열 변화** / 과목별 순회 → **열(column) 고정, 행 변화**

---

## Ch04 — static & 싱글톤 패턴

### C01 — static 변수 (클래스 변수)

`static` 으로 선언된 변수는 **클래스(메서드) 영역**에 적재 — 객체 생성과 무관하게 공간이 할당되고 모든 인스턴스가 공유한다.

| 구분 | 선언 | 저장 위치 | 공유 |
|---|---|---|---|
| 인스턴스 변수 | `int n2` | Heap (객체마다 별도) | 객체별 독립 |
| 클래스(static) 변수 | `static int n1` | 클래스(메서드) 영역 | 모든 객체 공유 |

```java
class C01Simple {
    static int n1;  // 클래스 변수 — 공유
    int n2;         // 인스턴스 변수 — 객체별 독립
}

C01Simple.n1 = 1234;        // 객체 없이 클래스명으로 접근 가능

C01Simple ob1 = new C01Simple();
C01Simple ob2 = new C01Simple();

ob1.n1 = 2233;
// ob1.n1 == 2233, ob2.n1 == 2233  ← 같은 공간 공유

ob2.n1 = 56789;
// ob1.n1 == 56789, ob2.n1 == 56789  ← 한쪽 수정이 모두 반영
```

---

### C02 — static 메서드

`static` 메서드는 객체 생성 전에 메모리에 올라오므로, **인스턴스 변수/메서드를 사용할 수 없다** — `static` 변수나 지역 변수만 사용 가능.

```java
class C02Simple {
    static int n1;
    int n2;

    void func1() {
        n1 = 100;   // OK — static 변수
        n2 = 200;   // OK — 인스턴스 메서드에서 인스턴스 변수 접근 가능
    }

    static void func2() {
        n1 = 300;   // OK — static 변수
        // n2 = 400; // 컴파일 에러 — static 메서드에서 인스턴스 변수 사용 불가
    }
}
```

> `static` 메서드는 이미 적재되어 있지만, `n2` 는 아직 객체가 없어 존재하지 않기 때문

---

### C03 — 싱글톤 패턴 (Singleton Pattern)

**프로그램 전체에서 단 하나의 객체만 생성**되도록 보장하는 디자인 패턴.

```
1. 생성자를 private 으로 막음 → 외부에서 new 불가
2. static 필드에 단일 인스턴스 보관
3. public static getInstance() 로만 접근 허용 → 없으면 생성, 있으면 기존 반환
```

```java
class Company {
    private static Company instance;  // 유일한 인스턴스 보관

    private Company() {}              // 외부 new 차단

    public static Company getInstance() {
        if (instance == null)
            instance = new Company(); // 최초 1회만 생성
        return instance;
    }

    int n1, n2;

    @Override
    public String toString() {
        return "Company [n1=" + n1 + ", n2=" + n2 + "]";
    }
}

Company com1 = Company.getInstance();
Company com2 = Company.getInstance();

com1.n1 = 100;
com2.n2 = 200;

System.out.println("com1 : " + com1); // Company [n1=100, n2=200]
System.out.println("com2 : " + com2); // Company [n1=100, n2=200]
// com1 == com2 → true (같은 객체)
```

---

### C04 — static 메서드 예제 : ArrayUtils

두 배열을 이어 붙이는 `concat()`과 배열을 출력하는 `print()`를 static 메서드로 구현.  
객체 생성 없이 `ArrayUtils.메서드명()` 으로 바로 호출한다.

#### concat(int[] a, int[] b)

배열 a와 b를 이어 붙인 크기 `a.length + b.length` 의 새 배열을 반환.

```
a[] = {1, 5, 7, 9}        인덱스 0~3
b[] = {3, 6, -1, 100, 77} 인덱스 0~4
                           ↓
c[] = {1, 5, 7, 9, 3, 6, -1, 100, 77}
      ← a.length →← b.length →
```

**방법 1 — for 루프 직접 복사**

```java
int[] c = new int[a.length + b.length];
for (int i = 0; i < a.length; i++) c[i] = a[i];
for (int i = 0; i < b.length; i++) c[i + a.length] = b[i];
```

**방법 2 — System.arraycopy() (최종 코드)**

```java
public static int[] concat(int[] a, int[] b) {
    int[] c = new int[a.length + b.length];
    System.arraycopy(a, 0, c, 0,        a.length); // a → c[0]부터
    System.arraycopy(b, 0, c, a.length, b.length); // b → c[a.length]부터
    return c;
}
// System.arraycopy(src, srcPos, dest, destPos, length)
```

#### print(int[] a)

배열 요소를 출력하는 3가지 방식.

```java
// 방법 1 — 향상된 for + printf
for (int el : a) System.out.printf("%d ", el);

// 방법 2 — Stream + 메서드 참조
Arrays.stream(a).forEach(System.out::println);

// 방법 3 — Stream + 람다 (최종 코드)
Arrays.stream(a).forEach(el -> System.out.println(el));
```

#### 실행

```java
int[] array1 = {1, 5, 7, 9};
int[] array2 = {3, 6, -1, 100, 77};
int[] array3 = ArrayUtils.concat(array1, array2);
ArrayUtils.print(array3);
// 출력 : 1 5 7 9 3 6 -1 100 77
```

---

### C05 — 싱글톤 패턴 연습 : ShopService

```java
class ShopService {
    private static ShopService instance;

    private ShopService() {}

    public static ShopService getInstance() {
        if (instance == null)
            instance = new ShopService();
        return instance;
    }
}

ShopService obj1 = ShopService.getInstance();
ShopService obj2 = ShopService.getInstance();

System.out.println(obj1 == obj2); // true — 같은 객체
// "같은 ShopService 객체입니다."
```

> **싱글톤 핵심 3요소** : `private` 생성자 / `private static` 인스턴스 필드 / `public static getInstance()`

---

## Ch05 — 상속 (Inheritance)

### C00 — 상속 개념

```
상속(Inheritance) : 상위(부모, super) 클래스의 속성과 기능을
                    하위(자식, sub) 클래스에서 그대로 받아 사용할 수 있도록 허용한 문법

- 하위 클래스는 물려받은 것 외에 속성/기능을 추가할 수 있다
- 하위 클래스는 물려받은 기능을 고쳐서 사용할 수 있다 → 오버라이딩(Overriding)
- extends 예약어 사용
```

---

### C01 — 기본 상속 (Point2D → Point3D)

C01은 가장 단순한 형태 — 디폴트 생성자만 있는 버전.

```java
class Point2D {
    int x;
    int y;

    Point2D() {
        System.out.println("Point2D 디폴트생성자 호출");
    }

    @Override
    public String toString() {
        return "Point2D [x=" + x + ", y=" + y + "]";
    }
}

class Point3D extends Point2D {
    int z;

    Point3D() {
        System.out.println("Point3D 디폴트생성자 호출");
    }

    @Override
    public String toString() {
        return "Point3D [z=" + z + ", x=" + x + ", y=" + y + "]";
    }
}

Point3D ob = new Point3D();
ob.x = 10;  ob.y = 20;  ob.z = 30;
System.out.println(ob);
// Point2D 디폴트생성자 호출   ← 부모 생성자 먼저 실행
// Point3D 디폴트생성자 호출
// Point3D [z=30, x=10, y=20]
```

---

### C02 — 상속 + super() 생성자 호출

`super()` / `super(args)` 로 부모 생성자를 명시적으로 호출한다.  
생성자 첫 줄에 없으면 컴파일러가 `super()` 를 자동 삽입.

```java
class Point3D extends Point2D {
    int z;

    Point3D() {
        super();             // Point2D() 호출
        System.out.println("Point3D 디폴트생성자 호출");
    }

    Point3D(int x) {
        // super.x = x;  // 이렇게도 가능하지만
        // this.x = x;   // 이것도 가능하나
        super(x);          // 부모 생성자에게 위임하는 것이 올바른 방법
        System.out.println("Point3D(int x) 생성자 호출");
    }

    Point3D(int x, int y) {
        super(x, y);
        System.out.println("Point3D(int x, int y) 생성자 호출");
    }

    Point3D(int x, int y, int z) {
        super(x, y);
        this.z = z;
        System.out.println("Point3D(int x, int y, int z) 생성자 호출");
    }

    @Override
    public String toString() {
        return "Point3D [z=" + z + ", x=" + x + ", y=" + y + "]";
    }
}

Point3D ob = new Point3D(10, 20, 30);
System.out.println(ob);
// Point2D(int x, int y) 생성자 호출   ← super(x,y) 로 부모 먼저
// Point3D(int x, int y, int z) 생성자 호출
// Point3D [z=30, x=10, y=20]
```

---

### C03 — 메서드 오버라이딩 (Method Overriding)

상속 관계를 전제로 **상위 클래스의 메서드를 하위 클래스가 재정의** — 헤더는 동일, 본문(`{}`)만 수정.  
다형성의 근거가 되는 문법.

#### 오버로딩 vs 오버라이딩 비교

| 구분 | 오버로딩 | 오버라이딩 |
|---|---|---|
| 상속 전제 | X | O |
| 함수 헤더 변경 | O (파라미터 변동, 함수명 고정) | X (헤더 동일) |
| 함수 본문 변경 | 무관 | O |
| 목적 | 개발 편의성 (함수명 고정) | 다형성 |

```java
class Animal {
    void sound() { System.out.println("소리낸다"); }
}

class Dog extends Animal {
    void sound() { System.out.println("dog"); }  // 오버라이딩
}

class Cat extends Animal {
    @Override
    void sound() { System.out.println("cat"); }  // 오버라이딩
}

Dog d = new Dog();
d.sound();   // dog

Animal d2 = new Dog();  // 업캐스팅 — 부모 타입 참조변수에 자식 객체
d2.sound();  // dog ← 오버라이딩된 메서드 호출 (다형성)

Cat c = new Cat();
c.sound();   // cat
```

---

### C04 — 오버로딩 + 오버라이딩 혼합

```java
class Super {
    int sum(int x, int y)           { return x + y; }
    int sum(int x, int y, int z)    { return x + y + z; }  // 오버로딩
}

class Sub extends Super {
    int sum(int x, int y)               { return x + y + 1; }          // 오버라이딩
    int sum(int x, int y, int z)        { return x+x + y+y + z+z; }   // 오버라이딩
    int sum(int x, int y, int z, int h) { return x + y + z + h; }     // 오버로딩
    int sum(int x, double y)            { return (int)(x + y); }       // 오버로딩
    double sum(int x, double y, double z) { return x + y + z; }       // 오버로딩
}
```

---

### C05 — 연습 문제

#### 이것이자바다 확인 문제

**1. 자바 상속에 대한 설명 중 틀린 것은?**
```
① 자바는 다중 상속을 허용한다.
② 부모의 메소드를 자식 클래스에서 재정의(오버라이딩)할 수 있다.
③ 부모의 private 접근 제한을 갖는 필드와 메소드는 상속의 대상이 아니다.
④ final 클래스는 상속할 수 없고, final 메소드는 오버라이딩할 수 없다.
```
- **답 : ①** — 자바는 다중 상속을 허용하지 않는다.

---

**2. 클래스 타입 변환에 대한 설명 중 틀린 것은?**
```
① 자식 객체는 부모 타입으로 자동 타입 변환된다.
② 부모 객체는 어떤 자식 타입으로도 강제 타입 변환된다.
③ 자동 타입 변환을 이용해서 필드와 매개변수의 다형성을 구현한다.
④ 강제 타입 변환 전에 instanceof 연산자로 변환 가능한지 검사하는 것이 좋다.
```
- **답 : ②** — 강제 타입 변환은 자식 객체가 부모 타입으로 자동 변환된 후 다시 자식 타입으로 변환할 때만 사용할 수 있다.
- ④ `instanceof` 연산자는 변수가 참조하는 객체의 타입을 확인할 때 사용.

---

**3. final 키워드에 대한 설명으로 틀린 것은?**
```
① final 클래스는 부모 클래스로 사용할 수 있다.
② final 필드는 초기화된 후에는 변경할 수 없다.
③ final 메소드는 재정의(오버라이딩)할 수 없다.
④ static final 필드는 상수를 말한다.
```
- **답 : ①** — `final` 클래스는 최종 클래스로 상속 불가. 부모 클래스가 될 수 없다.

---

**4. 오버라이딩에 대한 설명으로 틀린 것은?**
```
① 부모 메소드의 시그니처(리턴 타입, 메소드명, 매개변수)와 동일해야 한다.
② 부모 메소드보다 좁은 접근 제한자를 붙일 수 없다.
③ @Override 어노테이션을 사용하면 재정의가 확실한지 컴파일러가 검증한다.
④ protected 접근 제한을 갖는 메소드는 다른 패키지의 자식 클래스에서 재정의할 수 없다.
```
- **답 : ④** — `protected`는 같은 패키지 또는 **다른 패키지의 자식 클래스**에서도 접근 가능하다.

---

**5. 추상 클래스에 대한 설명으로 틀린 것은?**
```
① 직접 객체를 생성할 수 없고, 상속만 할 수 있다.
② 추상 메소드를 반드시 가져야 한다.
③ 추상 메소드는 자식 클래스에서 재정의(오버라이딩)할 수 있다.
④ 추상 메소드를 재정의하지 않으면 자식 클래스도 추상 클래스가 되어야 한다.
```
- **답 : ②** — 추상 클래스에 추상 메소드가 없어도 된다. 단, 생성자는 반드시 있어야 한다.

---

**6. Child 생성자에서 컴파일 에러가 발생한 이유와 해결 방법**
```java
public class Parent {
    public String name;
    public Parent(String name) { this.name = name; }
}
public class Child extends Parent {
    public int studentNo;
    public Child(String name, int studentNo) {
        this.name = name;       // 오류 — 부모 생성자를 올바르게 호출하지 않음
        this.studentNo = studentNo;
    }
}
```
- **답 : `this.name = name;` → `super(name);` 으로 교체**
- 부모 생성자는 자식 생성자 첫 줄의 `super()` 로 반드시 호출해야 한다.

---

**7. 다음 코드의 출력 결과는?**
```java
class Parent {
    public Parent()           { this("대한민국"); System.out.println("Parent() call"); }
    public Parent(String nation) { this.nation = nation; System.out.println("Parent(String nation) call"); }
}
class Child extends Parent {
    public Child()            { this("홍길동"); System.out.println("Child() call"); }
    public Child(String name) { this.name = name; System.out.println("Child(String name) call"); }
}
// Child child = new Child();
```
```
Parent(String nation) call   ← this("대한민국") 로 먼저
Parent() call
Child(String name) call      ← this("홍길동") 로 먼저
Child() call
```
- **호출 순서** : Child() → super() 자동삽입 → Parent() → this("대한민국") → Parent(String) → 역순으로 복귀

---

**8. SnowTire 예제 출력 결과**
```java
class Tire { public void run() { System.out.println("일반 타이어가 굴러갑니다."); } }
class SnowTire extends Tire {
    @Override public void run() { System.out.println("스노우 타이어가 굴러갑니다."); }
}
SnowTire snowTire = new SnowTire();
Tire tire = snowTire;   // 업캐스팅

snowTire.run();  // 스노우 타이어가 굴러갑니다.
tire.run();      // 스노우 타이어가 굴러갑니다.
```
- 부모 타입으로 자동 변환 후에도 **오버라이딩된 메서드가 우선 호출** → 다형성

---

**9. 다음 빈칸에 들어올 수 없는 코드 (A←B←D, A←B←E, A←C←F 상속)**
```java
B b = (     );       void method(B b) {...}   method(     )
① new B()   ② (B) new A()   ③ new D()   ④ new E()
```
- **답 : ②** — `(B) new A()` 는 부모→자식 강제 변환이지만, 애초에 자식 타입으로 업캐스팅된 적이 없으므로 불가.

---

**10. Computer 클래스 컴파일 에러 이유**
```java
abstract class Machine {
    public abstract void work();
}
public class Computer extends Machine {
    // work() 오버라이딩 없음 → 에러
}
```
- **답** : `work()` 추상 메서드를 오버라이딩하지 않아서 오류. `abstract class Computer` 로 선언하거나 `work()` 를 재정의해야 한다.

---

**11. super 를 이용해 부모 메서드 호출**
```java
class Activity { public void onCreate() { System.out.println("기본적인 실행 내용"); } }
class MainActivity extends Activity {
    @Override
    public void onCreate() {
        super.onCreate();   // 부모의 onCreate() 호출
        System.out.println("추가적인 실행 내용");
    }
}
```

---

**12. instanceof 로 타입 확인 후 메서드 호출**
```java
public static void action(A a) {
    a.method1();
    if (a instanceof C c) {  // Java 16+ 패턴 매칭
        c.method2();
    }
}
```
- `instanceof` : 좌항 객체가 우항 타입이면 `true`. Java 16부터 패턴 변수 사용 가능.

---

#### 명품자바 5장 문제

**[5장 2번] 자바의 모든 클래스가 반드시 상속받는 클래스는?**
- **답 : Object**

---

**[5장 3번] 상속을 이용해 중복 제거**
```java
// 변경 전 : SharpPencil, Ballpen, FountainPen 각각 amount 중복
// 변경 후 :
class Pen {
    private int amount;
    public int getAmount()             { return amount; }
    public void setAmount(int amount)  { this.amount = amount; }
}
class SharpPen extends Pen    { private int width; }
class BallPen extends Pen     { private String color;
    public String getColor()           { return color; }
    public void setColor(String color) { this.color = color; }
}
class FountainPen extends BallPen {
    public void refill(int n) { setAmount(n); }
}
```

---

**[5장 4번] 빈칸 채우기**
```
자바에서 상속받는 클래스를 서브 클래스(sub class)라 하며, extends 키워드를 이용하여
상속을 선언한다. 상속받은 클래스에서 부모 멤버 접근 시 super 키워드를 이용한다.
객체 타입 확인은 instanceof 연산자, 인터페이스 선언은 interface 키워드를 이용한다.
```

---

**[5장 5번] 접근 지정자 설명 중 틀린 것은?**
```
1. 슈퍼 클래스의 private 멤버는 서브 클래스에서 접근할 수 없다.
2. 슈퍼 클래스의 protected 멤버는 같은 패키지에 있는 서브 클래스에서만 접근할 수 있다.
3. 슈퍼 클래스의 public 멤버는 모든 다른 클래스에서 접근할 수 있다.
4. 슈퍼 클래스의 디폴트 멤버는 같은 패키지에 있는 모든 다른 클래스에서 접근 가능하다.
```
- **답 : 2번** — `protected` 는 같은 패키지 + **다른 패키지의 서브 클래스**에서도 접근 가능.

---

**[5장 6번] ColorTV 생성자 빈칸**
```java
class TV { private int size; public TV(int n) { size = n; } }
class ColorTV extends TV {
    private int colors;
    public ColorTV(int colors, int size) {
        super(size);        // ← 빈칸
        this.colors = colors;
    }
}
```

---

**[5장 7번] 생성자 호출 순서 출력 결과**
```java
class A { public A() { System.out.println("A"); }
          public A(int x) { System.out.println("A: " + x); } }
class B extends A { public B()      { super(100); }
                    public B(int x) { System.out.println("B: " + x); } }
B b = new B(11);
```
```
A        ← B(int x) 진입 → 암묵적 super() → A() 출력
B: 11
```

---

**[5장 8번] 생성자 오류 찾기**
```java
class A { private int a; protected A(int i) { a = i; } }  // 기본 생성자 없음
class B extends A { private int b; public B() { b = 0; } } // super() 호출 → A()없음 → 에러
```
- **답** : `A`에 기본 생성자가 없으므로 오류. `public A(){}` 추가하거나 `B(){ super(1); b=0; }` 으로 수정.

---

**[5장 9번] 추상 클래스 선언/사용 오류**
```
(1) abstract class A { void f(); }
    → 오류 : void f() {} 이거나 abstract void f(); 로 수정

(2) abstract class A { void f() { System.out.println("~"); } }
    → 오류 없음 — 추상 클래스에 추상 메소드 없어도 됨

(3) abstract class B { abstract void f(); }  class C extends B {}
    → 오류 : f() 재정의 안 함 → abstract class C extends B 로 수정

(4) abstract class B { abstract int f(); }  class C extends B { void f(){...} }
    → 오류 : 리턴 타입 불일치 → int f() { ...; return 0; } 으로 수정
```

---

**[5장 10번] OddDetector 추상 클래스 구현**
```java
abstract class OddDetector {
    protected int n;
    public OddDetector(int n) { this.n = n; }
    public abstract boolean isOdd();
}
public class B extends OddDetector {
    public B(int n) { super(n); }

    @Override
    public boolean isOdd() {
        return n % 2 != 0;   // 홀수이면 true
    }

    public static void main(String[] args) {
        B b = new B(10);
        System.out.println(b.isOdd()); // false
    }
}
```

---

**[5장 11번] 업캐스팅 / instanceof**

계층 구조 : A ← B ← C/D, A ← (별도)

```
(1) 업캐스팅 골라라
    A a = new A()  → X (같은 타입)
    B b = new C()  → O (업캐스팅)
    A a = new D()  → O (업캐스팅)
    D d = new D()  → X (같은 타입)

(2) A x = new D();  System.out.println(x instanceof B); → true
                    System.out.println(x instanceof C); → false  (D는 B의 자식, C와 무관)

(3) System.out.println(new D() instanceof Object); → true  (모든 클래스는 Object 상속)
    System.out.println("Java" instanceof Object);  → true
```

---

**[5장 12번] 동적 바인딩**
```java
class Shape  { public void draw() { System.out.println("Shape"); } }
class Circle extends Shape {
    public void paint() { draw(); }         // (2) "Circle" 출력 — 오버라이딩된 draw() 호출
    // public void paint() { super.draw(); } // (3) "Shape" 출력 — 부모 draw() 호출
    public void draw()  { System.out.println("Circle"); }
}
Shape s = new Circle();
s.draw();    // (1) Circle — 업캐스팅 상태에서도 오버라이딩 메서드 호출
```

---

**[5장 13번] 추상 클래스 + 동적 바인딩**
```java
abstract class Shape {
    public void paint() { draw(); }
    abstract public void draw();
}
class Circle extends Shape {
    private int radius;
    public Circle(int radius) { this.radius = radius; }
    double getArea() { return 3.14 * radius * radius; }
    // (2) 추가 :
    public void draw() { System.out.println("반지름=" + radius); }
}
// (1) Shape s = new Shape(); → 오류 — 추상 클래스는 객체 생성 불가
Circle p = new Circle(10);
p.paint(); // 반지름=10
```

---

**[5장 14번] 다형성 설명 중 틀린 것은?**
```
1. 추상 메소드를 두는 이유는 상속받는 클래스에서 다형성을 실현하도록 하기 위함이다.
2. 인터페이스도 구현하는 클래스에서 다형성을 실현하도록 하기 위함이다.
3. 다형성은 서브클래스들이 슈퍼 클래스의 동일한 메소드를 서로 다르게 오버라이딩하여 이루어진다.
4. 자바에서 다형성은 모호한(ambiguous) 문제를 일으키므로 사용하지 않는 것이 바람직하다.
```
- **답 : 4번** — 다형성은 자바의 핵심 특성이며 모호한 문제를 일으키지 않는다.

---

**[5장 15번] 인터페이스의 특징이 아닌 것은?**
```
1. 인터페이스의 객체는 생성할 수 없다.
2. 인터페이스는 클래스와 같이 멤버 변수(필드)의 선언이 가능하다.
3. 인터페이스의 추상 메소드는 자동으로 public이다.
4. implements 키워드 이용, 모든 추상 메소드를 작성해야 한다.
```
- **답 : 2번** — 인터페이스는 멤버 변수(인스턴스 필드) 선언 불가. 상수(`static final`)만 가능.

---

**[5장 16번] interface Device + TV 구현 및 TV/ColorTV 예제**
```java
interface Device {
    void on();
    void off();
}

class TV implements Device {
    public void on()    { System.out.println("켜졌습니다."); }
    public void off()   { System.out.println("종료합니다."); }
    public void watch() { System.out.println("방송중입니다."); }
}
// myTV.on() → myTV.watch() → myTV.off()
// 켜졌습니다. / 방송중입니다. / 종료합니다.
```

실제 코드 — TV → ColorTV 상속 예제:

```java
class TV {
    String brand;  int year;  int size;

    public TV(String brand, int year, int size) {
        this.brand = brand;  this.year = year;  this.size = size;
    }

    void show() {
        System.out.printf("%s에서 만든 %d년형 %d인치 TV", brand, year, size);
    }
}

class ColorTV extends TV {
    String color;

    public ColorTV(String brand, int year, int size, String color) {
        super(brand, year, size);  // 부모 생성자 위임
        this.color = color;
    }

    @Override
    void show() {
        System.out.printf("%s에서 만든 %d년형 %d인치 %sTV", brand, year, size, color);
    }
}

ColorTV myTV = new ColorTV("삼성", 2017, 32, "검정");
myTV.show(); // 삼성에서 만든 2017년형 32인치 검정TV
```

---

### C06 — 업캐스팅 / 다운캐스팅

```java
class Super { int n1; }
class Sub extends Super { int n2; }
```

#### NoCasting — 형변환 없음

```java
Super ob1 = new Super();  ob1.n1 = 10;
Sub   ob2 = new Sub();    ob2.n1 = 10;  ob2.n2 = 20;
```

#### UpCasting ★★★★★ — 상위클래스형 참조변수 = 하위클래스형 객체

**자동 형변환** (메모리 영역 침범 우려 없음).

이유:
1. 상속 관계의 모든 하위 객체를 하나의 타입으로 연결할 수 있다
2. UpCasting된 상태에서도 **재정의(오버라이딩)된 메서드**에는 접근 가능하다

```java
Super ob3 = new Sub();   // UpCasting — new Sub() 객체를 Super 타입으로 참조
ob3.n1 = 10;
// ob3.n2 = 20;  // 접근 불가 — 참조변수 타입이 Super 이므로 Sub 멤버 숨겨짐

Super ob4 = ob2;         // UpCasting — 기존 Sub 객체를 Super 타입으로 참조
ob4.n1 = 10;
// ob4.n2 = 20;  // 접근 불가
```

#### DownCasting ★★★★ — 하위클래스형 참조변수 = 상위클래스형 참조변수

**강제 형변환** — UpCasting이 전제되어야 안전하다.

```java
// 위험한 DownCasting (UpCasting 전제 없음 → 런타임 에러)
// Sub ob5 = (Sub) new Super();
// ob5.n2 = 200;  // 실제 공간이 없음 → ClassCastException

// 안전한 DownCasting (ob4 는 이미 Sub 객체를 업캐스팅한 것)
Sub down = (Sub) ob4;  // DownCasting
down.n1 = 10;
down.n2 = 20;          // 이제 Sub 멤버 접근 가능
```

| 구분 | 방향 | 변환 방식 | 안전성 |
|---|---|---|---|
| UpCasting | 자식 → 부모 타입 | 자동 | 항상 안전 |
| DownCasting | 부모 → 자식 타입 | 강제 `(SubType)` | UpCasting 전제 필요 |

---

### C07 — 다중 계층 instanceof + DownCasting

계층 구조: `A ← B ← D/E`, `A ← C ← F/G`

파라미터를 상위 타입 `A`로 받고, `instanceof`로 실제 타입을 확인한 후 다운캐스팅하여 각 하위 멤버에 값을 대입하는 패턴.

```java
class A { int a; }
class B extends A { int b; }
class C extends A { int c; }
class D extends B { int d; }
class E extends B { int e; }
class F extends C { int f; }
class G extends C { int g; }

public static void UpDownCastingTestFunc(A obj) {
    obj.a = 100;
    if (obj instanceof B) { B down = (B) obj; down.b = 200; }
    if (obj instanceof C) { C down = (C) obj; down.c = 300; }
    if (obj instanceof D) { D down = (D) obj; down.d = 400; }
    if (obj instanceof E) { E down = (E) obj; down.e = 500; }
    if (obj instanceof F) { F down = (F) obj; down.f = 600; }
    if (obj instanceof G) { G down = (G) obj; down.g = 700; }
    System.out.println(obj);
}
```

- `D`는 `B`의 자식이므로 `instanceof B`, `instanceof D` 둘 다 `true`
- `F`는 `C`의 자식이므로 `instanceof C`, `instanceof F` 둘 다 `true`

#### 퀴즈

| 번호 | 문제 요지 | 정답 |
|---|---|---|
| 1 | 업캐스팅 후 하위 고유 메서드 바로 호출 가능? | **4번 ✗** — 다운캐스팅 필요 |
| 2 | 컴파일 오류 코드는? `Dog d1 = (Dog) new Animal();` | 컴파일 오류 없음, **런타임** ClassCastException |
| 3 | `Animal[] arr = new Dog[2]; arr[0] = new Cat();` 예외 | **2번** ArrayStoreException |
| 4 | `Animal a = new Dog(); a.sound();` 출력 | **2번** `woof` — 동적 바인딩 |
| 5 | 안전한 다운캐스팅 패턴 | **2번** `if (a instanceof Dog) { Dog d = (Dog) a; d.bark(); }` |

---

### C08 — 업캐스팅 핵심 규칙

```java
class Parent {
    void func1() { System.out.println("Parent's func1() Call"); }
    void func2() { System.out.println("Parent's func2() Call"); }
}
class Son extends Parent {
    void func2() { System.out.println("Son's func2() Call"); }  // 재정의
    void func3() { System.out.println("Son's func3() Call"); }  // 추가(확장)
}

Parent p2 = new Son();  // UpCasting
p2.func1();  // Parent's func1() Call
p2.func2();  // Son's func2() Call  ← 재정의된 메서드는 동적 바인딩
// p2.func3();  // 컴파일 에러 — 추가 메서드는 DownCasting 후 접근
```

| 상황 | 재정의(오버라이딩)된 메서드 | 추가(확장)된 메서드 |
|---|---|---|
| UpCasting 후 상위 타입 참조변수로 | **접근 가능** (동적 바인딩) | **접근 불가** (DownCasting 필요) |

---

### C09 — 연습: Employee 상속 계층

`Employee ← Parttimer`, `Employee ← Regular`

```java
class Employee {
    public String name;
    int age;
    String addr;

    public Employee(String name, int age, String addr) {
        this.name = name;  this.age = age;  this.addr = addr;
    }
}

class Parttimer extends Employee {
    private int hour_pay;
    public Parttimer(String name, int age, String addr, int hour_pay) {
        super(name, age, addr);
        this.hour_pay = hour_pay;
    }
}

class Regular extends Employee {
    private int salary;
    public Regular(String name, int age, String addr, int salary) {
        super(name, age, addr);
        this.salary = salary;
    }
}

Parttimer emp1 = new Parttimer("홍길동", 25, "대구", 20000);
Regular   emp2 = new Regular("서길동", 45, "울산", 50000000);
```

---

### C09Ex01 — 연습문제 1: 기본 업캐스팅 (Animal / Dog)

```java
class Animal {
    void makeSound() { System.out.println("동물이 소리를 냅니다"); }
}
class Dog extends Animal {
    void makeSound() { System.out.println("멍멍!"); }
    void fetch()     { System.out.println("강아지가 공을 가져옵니다!"); }
}

Dog d       = new Dog();
Animal upA  = d;           // UpCasting
upA.makeSound();           // "멍멍!" — 동적 바인딩
// upA.fetch();            // 컴파일 에러 — Animal 타입에 fetch() 없음
```

- 업캐스팅 후 **오버라이딩 메서드는 실행**, 하위 전용 메서드는 **컴파일 에러**

---

### C10Ex02 — 연습문제 2: 메서드 접근 (Vehicle / Car)

```java
class Vehicle {
    void start() { System.out.println("탈것의 시동을 겁니다"); }
}
class Car extends Vehicle {
    void start()      { System.out.println("자동차의 시동을 겁니다"); }
    void turboBoost() { System.out.println("자동차가 터보로 가속합니다!"); }
}

Car     c       = new Car();
Vehicle upV     = c;            // UpCasting
upV.start();                    // "자동차의 시동을 겁니다" — 오버라이딩
// upV.turboBoost();            // 컴파일 에러

Car downC = (Car) upV;          // DownCasting
downC.turboBoost();             // "자동차가 터보로 가속합니다!"
```

---

### C11Ex03 — 연습문제 3: 다중 레벨 캐스팅 (Shape / Circle / ColoredCircle)

계층 구조: `Shape ← Circle ← ColoredCircle`

```java
class Shape         { void draw()          { System.out.println("도형을 그립니다"); } }
class Circle extends Shape {
    void draw()         { System.out.println("원을 그립니다"); }
    void calculateArea(){ System.out.println("원의 넓이를 계산합니다"); }
}
class ColoredCircle extends Circle {
    void draw()      { System.out.println("색칠된 원을 그립니다"); }
    void applyColor(){ System.out.println("원에 색을 칠합니다"); }
}

ColoredCircle cc     = new ColoredCircle();
Shape         upS    = cc;              // UpCasting (Shape 타입)
upS.draw();                             // "색칠된 원을 그립니다" — 동적 바인딩

Circle  downC  = (Circle) upS;          // DownCasting → Circle 타입
downC.calculateArea();                  // "원의 넓이를 계산합니다"

ColoredCircle downCC = (ColoredCircle) downC;  // DownCasting → ColoredCircle 타입
downCC.applyColor();                    // "원에 색을 칠합니다"
```

| 참조변수 타입 | 호출 가능한 메서드 | 실제 실행 객체 |
|---|---|---|
| `Shape upS` | `draw()` | ColoredCircle |
| `Circle downC` | `draw()`, `calculateArea()` | ColoredCircle |
| `ColoredCircle downCC` | `draw()`, `calculateArea()`, `applyColor()` | ColoredCircle |

- 어느 타입으로 참조하든 실제 객체는 `ColoredCircle` — `draw()`는 항상 "색칠된 원을 그립니다" 출력

---

## Ch07 — 추상 클래스 & 인터페이스 & final

---

### C01 — 추상 클래스 (Abstract Class)

> 일반 클래스와의 핵심 차이: **추상 클래스는 직접 객체 생성 불가**, 반드시 하위 클래스가 추상 메서드를 재정의해야 함

```java
// 일반 클래스 상속 — 상위 클래스도 객체 생성 가능
class Parent1 {
    void func() {}                          // 빈 구현이지만 존재함
}
class Son1 extends Parent1 {
    void func() { System.out.println("Son1 재정의"); }
}

// 추상 클래스 상속 — 상위 클래스는 객체 생성 불가
abstract class Parent2 {
    abstract void func();                   // 구현 없음, 하위 클래스가 반드시 구현
}
class Son2 extends Parent2 {
    @Override void func() { System.out.println("Son2 재정의"); }
}
class Son3 extends Parent2 {
    @Override void func() { System.out.println("Son3 재정의"); }
}
```

```java
// main
Parent1 ob1 = new Parent1();    // 일반 클래스: 상위 객체 생성 O
Son1    ob2 = new Son1();
Parent1 ob3 = new Son1();       // UpCasting O
ob3.func();                     // "Son1 재정의" (동적 바인딩)

// Parent2 ob4 = new Parent2(); // 추상 클래스는 new 불가 — 컴파일 에러
Son2    ob5 = new Son2();
Parent2 ob6 = new Son2();       // UpCasting O
ob6.func();                     // "Son2 재정의"

ob6 = new Son3();               // 같은 참조변수에 다른 하위 객체 대입
ob6.func();                     // "Son3 재정의"
```

| 구분 | 일반 클래스 | 추상 클래스 |
|---|---|---|
| 직접 객체 생성 | O | X |
| 추상 메서드 | 없음 | 있음 (하위 클래스 강제 구현) |
| UpCasting | O | O |
| 용도 | 일반 상속 | 설계 강제 / 공통 뼈대 제공 |

---

### C02 — 추상 클래스 활용 (Converter 패턴)

> 변환 로직(`convert`)과 UI 로직(`run`)을 분리하는 **템플릿 메서드 패턴**의 전형적인 예

```java
abstract class Converter {
    abstract protected double convert(double src);   // 하위 클래스가 구현
    abstract protected String getSrcString();
    abstract protected String getDestString();

    protected double ratio;

    public Converter() {}
    public Converter(int ratio) { this.ratio = ratio; }

    // 공통 UI 흐름 — 하위 클래스가 건드릴 필요 없음
    public void run() {
        Scanner scanner = new Scanner(System.in);
        System.out.println(getSrcString() + "을 " + getDestString() + "로 바꿉니다.");
        System.out.print(getSrcString() + "을 입력하세요>> ");
        double val = scanner.nextDouble();
        double res = convert(val);
        System.out.println("변환 결과: " + res + getDestString() + "입니다");
        scanner.close();
    }
}
```

```java
// 원화 → 달러: ratio를 생성자로 주입
class Won2Dollar extends Converter {
    public Won2Dollar(int ratio) { this.ratio = ratio; }

    protected double convert(double src) { return src / ratio; }
    protected String getSrcString()      { return "원"; }
    protected String getDestString()     { return "달러"; }
}

// Won2Dollar toDollar = new Won2Dollar(1399);
// toDollar.run();
// → 원을 입력하세요>> 24000
// → 변환 결과: 20.0달러입니다
```

```java
// 섭씨 → 화씨: ratio 불필요, 공식으로 직접 계산
// 클래스명에 한글 사용도 자바 문법상 허용됨 (권장하지 않음)
class 섭씨to화씨 extends Converter {
    public 섭씨to화씨() { super(); }   // 기본 생성자 명시적 호출

    protected double convert(double src) { return (src * 1.8) + 32; }
    protected String getSrcString()      { return "섭씨"; }
    protected String getDestString()     { return "화씨"; }
}

// 섭씨to화씨 test = new 섭씨to화씨();
// test.run();
```

> **두 하위 클래스 비교**
> - `Won2Dollar`: ratio를 생성자 인자로 받아 `this.ratio`에 저장 → 환율 변경 가능
> - `섭씨to화씨`: ratio 미사용, convert() 안에 고정 공식 — `super()`로 기본 생성자만 호출

---

### C03 — 인터페이스 (Interface)

> 인터페이스는 **다중 구현(implements)**이 가능 — 클래스는 단일 상속만 가능한 것과 대조됨

```java
interface Remocon {
    void powerOn();             // public abstract 자동 적용
    void powerOff();
    void setVolumn(int vol);

    int MAX_VOL = 100;          // public static final 자동 적용 (상수)
    int MIN_VOL = 0;
}

interface Browser {
    void searchURL(String url);
}
```

```java
class Tv implements Remocon {
    private int volumn;

    @Override public void powerOn()  { System.out.println("TV on"); }
    @Override public void powerOff() { System.out.println("TV off"); }

    @Override
    public void setVolumn(int vol) {
        // 인터페이스 상수(MAX_VOL, MIN_VOL)를 바로 사용 가능
        if      (MAX_VOL < vol) this.volumn = MAX_VOL;
        else if (MIN_VOL > vol) this.volumn = MIN_VOL;
        else                    this.volumn = vol;
        System.out.println("TV 현재 볼륨 : " + this.volumn);
    }
}

// 클래스 상속 + 인터페이스 구현 동시 사용
// extends 가 implements 보다 반드시 앞에 위치
class SmartTv extends Tv implements Browser {
    @Override
    public void searchURL(String url) { System.out.println(url + "로 이동합니다."); }
}
```

```java
// 인터페이스 타입 파라미터로 다형성 활용
public static void TurnOn(Remocon remocon)              { remocon.powerOn(); }
public static void TurnOff(Remocon remocon)             { remocon.powerOff(); }
public static void ChangeVolumn(Remocon remocon, int vol){ remocon.setVolumn(vol); }
public static void WebBrowser(Browser browser, String url){ browser.searchURL(url); }

// main
SmartTv smartTv = new SmartTv();
TurnOn(smartTv);                            // SmartTv → Remocon으로 UpCasting
ChangeVolumn(smartTv, -5);                  // -5 → MIN_VOL(0)으로 보정
WebBrowser(smartTv, "https://www.naver.com");
TurnOff(smartTv);
```

---

### C04 — 인터페이스 다형성 (부품 교체 패턴)

> 인터페이스 타입으로 필드를 선언하면, **구현 클래스(부품)를 런타임에 자유롭게 교체** 가능

```java
interface Tire {
    void run();
}

class 한국타이어 implements Tire {
    public void run() { System.out.println("한국타이어가 굴러갑니다"); }
}
class 금호타이어 implements Tire {
    public void run() { System.out.println("금호타이어가 굴러갑니다"); }
}

class Car {
    Tire FL, FR, BL, BR;        // 인터페이스 타입으로 선언 → 어떤 Tire 구현체든 대입 가능

    Car() {
        FL = FR = BL = BR = new 한국타이어();   // 초기 장착
    }
    void start() { FL.run(); FR.run(); BL.run(); BR.run(); }
}
```

```java
Car car = new Car();
car.start();                    // 전체 한국타이어

car.FR = new 금호타이어();       // 특정 바퀴만 교체 — Car 코드 수정 없이 가능
car.BL = new 금호타이어();
car.start();                    // FL·BR = 한국, FR·BL = 금호
```

> Car 클래스는 Tire 인터페이스에만 의존 → 새 타이어 브랜드 추가 시 Car 수정 불필요 (**OCP 원칙**)

---

### C05 — 클래스 + 인터페이스 다중 상속 규칙

```java
interface A {}
interface B {}
class C   {}
class D   {}

// 클래스 단일 상속 + 인터페이스 다중 구현
// extends 하나만 가능, implements 는 여러 개 가능
class E extends C implements A, B {}

// class E extends C, D implements A, B {}  // 컴파일 에러 — 클래스 다중 상속 불가
```

| 구분 | 클래스(extends) | 인터페이스(implements) |
|---|---|---|
| 다중 가능 여부 | X (하나만) | O (여러 개) |
| 순서 | extends 먼저 | implements 나중 |

---

### C06 — 인터페이스 교체 예제 (Printer)

```java
interface Printer {
    void print();
}

class Inkjet implements Printer {
    public void print() { System.out.println("Inkjet 프린터 출력"); }
}
class Laser implements Printer {
    public void print() { System.out.println("Laser 프린터 출력"); }
}
```

```java
// 인터페이스 타입 참조변수 하나로 구현체를 교체
Printer p = new Inkjet();
p.print();          // "Inkjet 프린터 출력"

p = new Laser();    // 같은 변수에 다른 구현체 대입 — C04의 타이어 교체와 동일한 원리
p.print();          // "Laser 프린터 출력"
```

---

### C07 — final 키워드

> `final`은 **변경·상속·재정의를 막는** 키워드 — 적용 대상에 따라 의미가 달라짐

```java
class Parent {
    int n1 = 100;
    final int n2 = 200;         // 심볼릭 상수 — 값 변경 불가

    void setN1(int n1) { this.n1 = n1; }
    void setN2(int n2) {
        // this.n2 = n2;        // 컴파일 에러 — final 변수는 재할당 불가
    }

    final void func1() {        // final 메서드 — 하위 클래스에서 재정의 불가
        System.out.println("Parent's final void func1 !");
    }
}

final class Son extends Parent {
    // final void func1() { ... }  // 컴파일 에러 — 상위의 final 메서드 재정의 불가
}

// class endPoint extends Son { }  // 컴파일 에러 — final 클래스는 상속 불가
```

| 적용 대상 | 의미 |
|---|---|
| `final` 변수 | 선언 후 값 변경 불가 (상수) |
| `final` 메서드 | 하위 클래스에서 재정의(Override) 불가 |
| `final` 클래스 | 상속 불가 (예: `String`, `Integer`) |

---

### Ch07 핵심 정리

| 개념 | 키워드 | 특징 |
|---|---|---|
| 추상 클래스 | `abstract class` | 객체 생성 불가, 추상 메서드 강제 구현, 단일 상속 |
| 인터페이스 | `interface` | 다중 구현 가능, 모든 메서드 `public abstract`, 상수 `public static final` |
| 클래스+인터페이스 | `extends` + `implements` | extends 먼저, implements 나중, 인터페이스는 여러 개 가능 |
| final 변수 | `final int x` | 값 변경 불가 (심볼릭 상수) |
| final 메서드 | `final void f()` | 하위 클래스 재정의 불가 |
| final 클래스 | `final class` | 상속 불가 |

> **추상 클래스 vs 인터페이스 선택 기준**
> - 공통 상태(필드)나 구현 코드를 공유해야 할 때 → **추상 클래스**
> - 타입만 통일하고 구현은 각자 자유롭게, 다중 구현이 필요할 때 → **인터페이스**

---

## Ch08 — 인터페이스 기반 역할 분담 실습

> **핵심 개념**: 인터페이스를 먼저 설계하면, 구현이 끝나지 않아도 팀원이 **각자 다른 파트를 독립적으로** 작업할 수 있다.
> 이번 실습은 모두가 같은 Sum을 구현한 비교 실험이었지만, 실제 의도는 아래처럼 **파트를 나눠 맡는 것**이다.

---

### 실제 의도 — 파트 분담 구조

```
팀장
 ├── Common/Information.java      ← 공통 메타정보 인터페이스 설계
 ├── Interfaces/SumInterface.java ← 덧셈 담당자에게 줄 계약서
 ├── Interfaces/SubInterface.java ← 뺄셈 담당자에게 줄 계약서
 ├── Interfaces/MulInterface.java ← 곱셈 담당자에게 줄 계약서
 ├── Interfaces/DivInterface.java ← 나눗셈 담당자에게 줄 계약서
 └── Main.java                    ← 완성된 구현체를 모아서 테스트

팀원 A → SumImpl 구현
팀원 B → SubImpl 구현
팀원 C → MulImpl 구현
팀원 D → DivImpl 구현
```

> 팀원은 자기 인터페이스 파일만 받으면 된다. 나머지가 완성되지 않아도 자기 파트는 바로 시작 가능.
> Main도 인터페이스 타입으로만 선언해두면, 구현체가 나중에 붙어도 코드 변경 없음.

---

### Step 1. 팀장 — 공통 인터페이스 설계

```java
// Common/Information.java
// 모든 구현체가 팀명·이름을 반환하도록 강제 → Main에서 누구 구현인지 식별 가능
public interface Information {
    String getTeamName();
    String getUsername();
}
```

```java
// Interfaces/SumInterface.java — 팀원 A에게 전달할 계약서
public interface SumInterface {
    void sum(int a, int b);           // 오버로딩: 2개 int
    void sum(int a, int b, int c);    // 오버로딩: 3개 int
    void sum(int... arg);             // 오버로딩: 가변인자 int
    void sum(String... arg);          // 오버로딩: 가변인자 String
}
// SubInterface / MulInterface / DivInterface 도 같은 구조로 작성
```

> 인터페이스에 선언된 메서드는 자동으로 `public abstract` 적용
> 같은 이름 `sum`에 매개변수만 다른 것 → **메서드 오버로딩** (컴파일 타임에 구분)

---

### Step 2. 팀원 — 자기 파트만 구현

> 받은 인터페이스 파일을 보고 메서드 시그니처를 그대로 구현한다.
> `SumInterface`와 `Information`을 **동시에 implements** 해야 Main에서 이름 조회가 가능하다.

```java
public class SumImpl implements SumInterface, Information {

    // ① 2개 int 합산
    @Override
    public void sum(int a, int b) {
        System.out.println("a + b = " + (a + b));
    }

    // ② 3개 int 합산
    @Override
    public void sum(int a, int b, int c) {
        System.out.println("a + b + c = " + (a + b + c));
    }

    // ③ 가변인자 int — enhanced for로 순회
    @Override
    public void sum(int... arg) {
        int s = 0;
        for (int numb : arg) s += numb;
        System.out.println("총 합 : " + s);
    }

    // ④ 가변인자 String — Integer.parseInt로 변환 후 합산
    //    (처음에 문자열 이어붙이기로 할 수도 있지만, 숫자 합산이 의도이므로 parseInt 사용)
    @Override
    public void sum(String... arg) {
        // String s = "";
        // for (String sentence : arg) s += sentence;  // 이어붙이기 방식 — 주석으로 남겨둠
        int s = 0;
        for (String numb : arg) s += Integer.parseInt(numb);
        System.out.println(s);
    }

    @Override public String getTeamName() { return "2조"; }
    @Override public String getUsername()  { return "김정희"; }
}
```

> `sum(String... arg)` 주석 처리된 코드:
> 처음엔 문자열 이어붙이기(`+=`)로 구현을 고려했다가,
> 숫자 합산이 의도임을 파악하고 `parseInt` 방식으로 변경한 흔적

---

### Step 3. 팀장 — Main에서 구현체 조립 및 테스트

```java
public class Main {

    // 인터페이스 타입으로 선언 — 구현체가 누구 것이든 교체 가능
    static SumInterface 김정희_sum;
    // static SubInterface 팀원B_sub;
    // static MulInterface 팀원C_mul;
    // static DivInterface 팀원D_div;

    static void init() {
        // 패키지 경로로 각 팀원 구현체를 연결
        김정희_sum = (SumInterface) new Ch08.Team0.Impl.김정희.SumImpl();
    }

    static void test_sum(SumInterface sumImpl) {
        // SumImpl은 SumInterface이면서 동시에 Information이기도 함
        // → 같은 객체를 Information으로 캐스팅해 이름 조회 가능
        Information info = (Information) sumImpl;
        System.out.printf("======= %s ========\n", info.getTeamName());
        System.out.printf("======= %s ========\n", info.getUsername());

        sumImpl.sum(10, 20);
        sumImpl.sum(10, 20, 30, 40);
        sumImpl.sum(10, 20, 30, 40, 50);
        sumImpl.sum("11", "22", "33", "44");
    }

    public static void main(String[] args) {
        init();

        // 인터페이스 배열로 담으면 구현체가 몇 개든 동일한 코드로 순회
        SumInterface[] impls = { 김정희_sum /*, 다른팀원_sum, ... */ };
        for (SumInterface impl : impls) {
            test_sum(impl);
        }
    }
}
```

**`(Information) sumImpl` 캐스팅이 가능한 이유**

```
SumImpl 객체
  └── implements SumInterface  → SumInterface 타입으로 참조 가능
  └── implements Information   → Information 타입으로도 캐스팅 가능
```

하나의 객체가 두 인터페이스를 모두 구현했기 때문에, 어느 타입으로든 참조 가능하다.

---

### Ch08 핵심 정리

| 개념 | 설명 |
|---|---|
| 인터페이스 = 계약서 | 팀장이 먼저 설계 → 팀원은 계약서대로 구현만 하면 됨 |
| 파트 분담 | Sum·Sub·Mul·Div를 각자 맡으면 서로 기다리지 않고 병렬 작업 가능 |
| 다중 implements | `implements SumInterface, Information` — 두 계약을 동시에 이행 |
| 메서드 오버로딩 | 같은 이름, 다른 파라미터 → 컴파일 타임에 구분 |
| 가변인자 `...` | `int... arg` — 호출 시 개수 자유, 내부에서 배열처럼 처리 |
| 인터페이스 타입 배열 | `SumInterface[]`로 선언하면 어떤 구현체든 담아서 일괄 테스트 |
| 다중 캐스팅 | 같은 객체를 `SumInterface`로도, `Information`으로도 참조 가능 |

---

# JAVA03 - Advanced

## Ch01 — Object 클래스 & Wrapper & 날짜

---

### C01 — Object 클래스 toString()

> `java.lang.Object`는 자바의 모든 클래스가 자동으로 상속받는 최상위 부모 클래스
> `toString()`, `equals()`, `hashCode()` 등 공통 메서드를 제공

```java
class A {
    int x, y;

    @Override
    public String toString() {
        return "A [x=" + x + ", y=" + y + "]";
    }
}
```

```java
A ob1 = new A();
System.out.println(ob1.toString()); // "A [x=0, y=0]"
System.out.println(ob1);            // println은 내부적으로 toString() 자동 호출 — 결과 동일

Object ob2 = new Object();
System.out.println(ob2);            // 기본 toString() → "패키지.클래스명@해시코드" 형태
```

> `toString()`을 오버라이드하지 않으면 `Object`의 기본 구현이 실행되어 주소값처럼 보이는 문자열 출력

---

### C02 — Object 클래스 equals()

> 기본 `equals()`는 **참조(주소) 비교** — 내용(값) 비교가 필요하면 반드시 오버라이드해야 한다

```java
class C02Simple {
    int n;
    public C02Simple(int n) { this.n = n; }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof C02Simple) {
            C02Simple down = (C02Simple) obj;  // 다운캐스팅 후 필드 비교
            return down.n == this.n;
        }
        return false;
    }
}
```

```java
C02Simple ob1 = new C02Simple(10);
C02Simple ob2 = new C02Simple(20);
C02Simple ob3 = new C02Simple(10);

System.out.println(ob1.equals(ob2)); // false — n 값이 다름
System.out.println(ob1.equals(ob3)); // true  — n 값이 같음
System.out.println(ob2.equals(ob3)); // false
```

> `instanceof`로 타입 먼저 확인 → 다운캐스팅 → 필드 비교가 안전한 `equals()` 오버라이드 패턴

---

### C03 — Object 클래스 equals() + hashCode()

> `equals()`를 오버라이드하면 **`hashCode()`도 함께 오버라이드해야 한다**
> `equals()`가 true인 두 객체는 반드시 같은 hashCode를 반환해야 하는 규약 때문 (컬렉션 사용 시 필수)

```java
class C03Simple {
    int n;
    public C03Simple(int n) { this.n = n; }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof C03Simple)
            return ((C03Simple) obj).n == this.n;
        return false;
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.n);  // java.util.Objects — 필드값 기반 해시 생성
    }
}
```

```java
C03Simple ob1 = new C03Simple(10);
C03Simple ob2 = new C03Simple(20);
C03Simple ob3 = new C03Simple(10);

System.out.printf("%x\n", ob1.hashCode()); // ob1·ob3은 n이 같으므로 해시코드 동일
System.out.printf("%x\n", ob2.hashCode()); // ob2는 다른 해시코드
System.out.printf("%x\n", ob3.hashCode()); // ob1과 동일
```

| 메서드 | 기본 동작 | 오버라이드 이유 |
|---|---|---|
| `toString()` | 클래스명@해시코드 | 객체 내용을 읽기 좋게 출력 |
| `equals()` | 참조(주소) 비교 | 필드값 기준으로 동등성 판단 |
| `hashCode()` | 객체 주소 기반 해시 | equals 규약 유지 (컬렉션에서 필수) |

---

### C04 — Wrapper 클래스

> 기본 자료형을 객체로 다뤄야 할 때 사용 — `int → Integer`, `double → Double` 등

```java
// Boxing — 기본 자료형 → Wrapper 객체
Integer ob1 = new Integer(100);       // 생성자 boxing (deprecated)
Integer ob2 = new Integer("100");     // 문자열로도 가능
Integer ob3 = Integer.valueOf("300"); // valueOf() 권장 방식

System.out.println(ob1 + ob2 + ob3); // 500 — 연산 시 자동 unboxing

// UnBoxing — Wrapper 객체 → 기본 자료형
int n1 = ob1.intValue();
int n2 = ob2.intValue();
int n3 = ob3.intValue();
System.out.println(n1 + n2 + n3);    // 500

// Auto Boxing / Auto UnBoxing (Java 5+) — 자동 변환
Integer ob4 = 100;               // AutoBoxing: int → Integer 자동
int n4 = ob1 + ob2 + ob3 + ob4; // AutoUnBoxing: Integer → int 자동
System.out.println(n4);          // 600
```

| 구분 | 방향 | 예시 |
|---|---|---|
| Boxing | `int` → `Integer` | `Integer.valueOf(100)` |
| UnBoxing | `Integer` → `int` | `ob.intValue()` |
| AutoBoxing | 자동 변환 | `Integer ob = 100;` |
| AutoUnBoxing | 자동 변환 | `int n = ob1 + ob2;` |

---

### C05 — 날짜·시간 API 비교

> 자바의 날짜 API는 세대별로 나뉜다 — 신규 코드는 `LocalDateTime` 사용 권장

```java
// ① Date (구버전 — 대부분 deprecated)
Date d1 = new Date();
d1.getYear() + 1900   // 연도 (내부적으로 1900 기준이라 +1900 필요)
d1.getMonth() + 1     // 월 (0~11이라 +1 필요)
d1.getDay()           // 요일 0~6 (일~토)
d1.getTime()          // 타임스탬프 (밀리초)

// ② Calendar (구버전 — getInstance()로 생성)
Calendar cal = Calendar.getInstance();
cal.get(Calendar.YEAR)
cal.get(Calendar.MONTH) + 1      // 0~11이라 +1 필요
cal.get(Calendar.DAY_OF_MONTH)
cal.get(Calendar.DAY_OF_WEEK)    // 1~7 (일~토)
cal.get(Calendar.HOUR_OF_DAY)    // 24시간제

// ③ LocalDateTime (Java 8+ — 권장)
LocalDateTime now = LocalDateTime.now();
now.getYear()
now.getMonthValue()  // 1~12 (보정 불필요)
now.getDayOfMonth()
now.getHour()
now.getMinute()
now.getSecond()
now.getDayOfWeek()   // DayOfWeek 열거형 (MONDAY, TUESDAY ...)
```

| API | 월 보정 | 요일 범위 | 권장 |
|---|---|---|---|
| `Date` | +1 필요 | 0~6 (일~토) | X |
| `Calendar` | +1 필요 | 1~7 (일~토) | △ |
| `LocalDateTime` | 불필요 (1~12) | DayOfWeek 열거형 | O |

---

### C06 — SimpleDateFormat

> `parse()` → 문자열을 `Date`로, `format()` → `Date`를 문자열로

```java
String ymd = "2025/05/06";

// 입력 포맷 정의 → 문자열을 Date 객체로 파싱
SimpleDateFormat fmtin = new SimpleDateFormat("yyyy/MM/dd");
Date date = fmtin.parse(ymd);            // "2025/05/06" → Date 객체
System.out.println(date);               // Tue May 06 00:00:00 KST 2025

// 출력 포맷 정의 → Date 객체를 다른 형식 문자열로 변환
SimpleDateFormat fmtout = new SimpleDateFormat("yyyy~MM~dd");
System.out.println(fmtout.format(date)); // "2025~05~06"
```

> `parse()`는 `ParseException`을 던지므로 메서드 선언에 `throws ParseException` 필요

---

### C07 — DateTimeFormatter

> `SimpleDateFormat`의 Java 8+ 대체 — thread-safe, 불변 객체

```java
// LocalDate (날짜만)
DateTimeFormatter fmtin  = DateTimeFormatter.ofPattern("yyyy/MM/dd");
LocalDate date = LocalDate.parse("2025/05/06", fmtin);  // parse 시 포맷터를 두 번째 인자로 전달

DateTimeFormatter fmtout = DateTimeFormatter.ofPattern("yyyy*MM*dd");
System.out.println(fmtout.format(date));  // "2025*05*06"
```

```java
// LocalDateTime (날짜 + 시간)
String ymd = "2025/05/06 14:30:00";

DateTimeFormatter fmtin  = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
LocalDateTime date = LocalDateTime.parse(ymd, fmtin);
System.out.println(date);                 // 2025-05-06T14:30

DateTimeFormatter fmtout = DateTimeFormatter.ofPattern("yyyy-MM-dd HH-mm-ss");
System.out.println(fmtout.format(date));  // "2025-05-06 14-30-00"
```

| 구분 | `SimpleDateFormat` | `DateTimeFormatter` |
|---|---|---|
| 대상 타입 | `Date` | `LocalDate` / `LocalDateTime` |
| Thread-safe | X | O |
| 파싱 방법 | `fmtin.parse(str)` | `LocalDate.parse(str, fmtin)` |
| 포맷 방법 | `fmtout.format(date)` | `fmtout.format(date)` |

---

### Ch01 핵심 정리

| 클래스 | 주요 메서드 | 비고 |
|---|---|---|
| `Object` | `toString()`, `equals()`, `hashCode()` | 최상위 부모, 필요 시 함께 오버라이드 |
| Wrapper (`Integer` 등) | `valueOf()`, `intValue()` | AutoBoxing/UnBoxing으로 대부분 자동 처리 |
| `Date` | `getYear()+1900`, `getMonth()+1` | deprecated, 신규 코드 사용 지양 |
| `Calendar` | `getInstance()`, `cal.get(...)` | 월·요일 보정 필요 |
| `LocalDateTime` | `now()`, `getMonthValue()` | Java 8+, 권장 |
| `SimpleDateFormat` | `parse()`, `format()` | 구버전 Date용, thread-unsafe |
| `DateTimeFormatter` | `ofPattern()`, `LocalDate.parse()` | Java 8+, thread-safe |

---

## Ch02 — 예외 처리 (Exception Handling)

---

### C01 — try-catch 기본 구조

> 예외가 발생해도 프로그램이 종료되지 않고 이후 코드가 계속 실행된다

```java
try {
    String str = null;
    System.out.println(str.toString()); // null 객체에 메서드 호출 → 예외 발생
} catch (NullPointerException e) {
    e.printStackTrace();  // 예외 발생 위치와 원인을 콘솔에 출력
}
System.out.println("반드시 실행되어야 할 코드1"); // try-catch 이후 정상 실행
System.out.println("반드시 실행되어야 할 코드2");
```

**예외 객체에서 꺼낼 수 있는 정보**

```java
e.getMessage()       // 예외 메시지 문자열
e.getCause()         // 예외를 유발한 원인 객체
e.getStackTrace()    // StackTraceElement 배열
e.printStackTrace()  // 스택 트레이스 전체를 콘솔에 출력 (가장 많이 사용)

// 스택 트레이스 직접 순회
for (StackTraceElement el : e.getStackTrace()) System.out.println(el);
```

---

### C02 — finally 블록

> `finally`는 예외 발생 여부와 **무관하게 항상 실행** — 주로 자원 해제에 사용

```java
try {
    int[] arr = {10, 20, 30};
    System.out.println(arr[3]); // 인덱스 3은 없음 → 예외 발생
} catch (ArrayIndexOutOfBoundsException e) {
    System.out.println("예외 처리");
    e.printStackTrace();
} finally {
    System.out.println("예외 발생과 무관하게 실행"); // 항상 실행
}
System.out.println("반드시 실행되어야 할 코드1");   // 이후 코드도 정상 실행
```

| 블록 | 실행 조건 |
|---|---|
| `try` | 예외 없으면 끝까지 실행 |
| `catch` | 해당 예외가 발생했을 때만 실행 |
| `finally` | 예외 발생 여부와 무관하게 항상 실행 |

---

### C03 — 중첩 try-catch & 다중 catch

> try-catch 안에 try-catch를 중첩할 수 있고, catch는 여러 개 나열 가능

```java
Scanner sc = new Scanner(System.in);
try {
    int n1 = sc.nextInt();
    int n2 = sc.nextInt();

    try {
        System.out.println("결과: " + n1 / n2); // n2가 0이면 ArithmeticException
    } catch (NullPointerException e) {
        System.out.println(e.getCause());
    } catch (ArithmeticException e) {           // 나눗셈 예외를 안쪽 catch에서 처리
        System.out.println("연산오류");
        if (n2 == 0) System.out.println("n2가 0");
    }

} catch (InputMismatchException e) {            // 정수가 아닌 값 입력 시
    System.out.println("int가 아닌 잘못된 값");
} finally {
    sc.close();
}
```

> 안쪽 try에서 처리하지 못한 예외는 바깥 catch로 전달됨
> catch 순서는 **구체적인 예외 → 상위 예외** 순으로 작성

---

### C04 — ClassCastException

> UpCasting 없이 강제 다운캐스팅 시 발생 — `instanceof`로 사전 확인 필요

```java
class Animal {}
class Dog extends Animal {}
class Cat extends Animal {}

try {
    Animal poppi = new Dog();
    Animal tori  = new Cat();

    Dog down1 = (Dog) poppi;   // OK — poppi는 실제로 Dog 객체
    Dog down2 = (Dog) tori;    // ClassCastException — tori는 Cat 객체
} catch (ClassCastException e) {
    e.printStackTrace();
}
```

> 안전한 다운캐스팅: `if (tori instanceof Dog) { Dog d = (Dog) tori; }`

---

### C05 — Exception 상위 클래스로 일괄 처리

> 모든 예외의 최상위는 `Exception` — 하나의 catch로 모든 예외를 잡을 수 있다

```java
try {
    // String str = null;
    // str.toString();            // NullPointerException
    // int[] arr = {10,20,30};
    // arr[4] = 10;               // ArrayIndexOutOfBoundsException
    Animal tori = new Dog();
    Cat down = (Cat) tori;        // ClassCastException
} catch (Exception e) {           // 세 가지 예외를 모두 잡음
    e.printStackTrace();
}
```

**개별 처리 방식과 비교**

```java
// 예외 종류별로 다른 처리가 필요할 때
} catch (NullPointerException e1) {
    System.out.println("NullPointerException 처리");
} catch (ArrayIndexOutOfBoundsException e2) {
    System.out.println("ArrayIndexOutOfBoundsException 처리");
} catch (ClassCastException e3) {
    System.out.println("ClassCastException 처리");
}
```

| 방식 | 특징 |
|---|---|
| `catch (Exception e)` | 모든 예외 일괄 처리 — 간결하지만 예외 종류 구분 불가 |
| 개별 catch 나열 | 예외별 다른 처리 가능 — 구체적인 예외를 상위 예외보다 먼저 작성 |

---

### C06 — throw & throws

> `throw` — 예외를 직접 발생시킴
> `throws` — 예외 처리를 호출한 쪽으로 전가 (메서드 선언부에 명시)

```java
class A {
    // throws: 이 메서드에서 예외가 발생할 수 있음을 호출자에게 알림
    void func() throws NullPointerException {
        String str = null;
        str.toString();  // 실제로 예외가 발생하는 지점
    }
}

class B {
    // throw: 예외 객체를 직접 생성해서 던짐
    void func() throws Exception {
        throw new ArithmeticException(); // 명시적으로 예외 발생
    }
}
```

```java
A ob1 = new A();
B ob2 = new B();

try {
    ob2.func();                      // B.func()가 던진 예외를 여기서 처리
} catch (NullPointerException e1) { // 구체적인 예외 먼저
    e1.printStackTrace();
} catch (Exception e2) {            // 상위 예외 나중 — NullPointerException 외 모든 예외
    e2.printStackTrace();
}
```

| 키워드 | 위치 | 역할 |
|---|---|---|
| `throw` | 메서드 본문 | 예외 객체를 직접 생성해 발생시킴 |
| `throws` | 메서드 선언부 | 예외 처리를 호출자에게 위임 |

---

### Ch02 핵심 정리

```
예외 클래스 계층 구조
Throwable
 ├── Error          (시스템 오류 — 처리 불가)
 └── Exception      (처리 가능)
      ├── RuntimeException  (Unchecked — 컴파일러가 강제하지 않음)
      │    ├── NullPointerException
      │    ├── ArrayIndexOutOfBoundsException
      │    ├── ClassCastException
      │    ├── ArithmeticException
      │    └── InputMismatchException
      └── 그 외       (Checked — 반드시 처리해야 컴파일 가능)
           └── ParseException 등
```

| 개념 | 설명 |
|---|---|
| `try-catch` | 예외 발생 시 프로그램 종료 방지, 이후 코드 정상 실행 |
| `finally` | 예외 여부 무관하게 항상 실행 (자원 해제) |
| 다중 catch | 구체적 예외 → 상위 예외 순으로 작성 |
| `catch (Exception e)` | 모든 예외 일괄 처리 |
| `throw` | 예외 객체 직접 발생 |
| `throws` | 예외 처리를 호출자에게 전가 |

---

## Ch03 — 제네릭 (Generics)

---

### C01 — 제네릭 클래스 기본 (bounded type)

> `<T extends 상위클래스>` — T에 들어올 수 있는 타입을 **상위 클래스의 하위 타입으로 제한**

```java
class 호빵재료 {}
class 팥   extends 호빵재료 { public String toString() { return "팥";  } }
class 야채  extends 호빵재료 { public String toString() { return "야채"; } }
class 피자  extends 호빵재료 { public String toString() { return "피자"; } }
class 민트초코 {}  // 호빵재료를 상속받지 않음

class 호빵<T extends 호빵재료> {  // T는 반드시 호빵재료의 하위 타입이어야 함
    private T 재료;
    호빵(T 재료) { this.재료 = 재료; }

    @Override
    public String toString() { return "호빵 [재료=" + 재료 + "]"; }
}
```

```java
호빵<팥>  ob1 = new 호빵<팥>(new 팥());    // OK
호빵<피자> ob2 = new 호빵<피자>(new 피자()); // OK
// 호빵<민트초코> ob4 = new 호빵<민트초코>(...); // 컴파일 에러 — 호빵재료 하위 타입이 아님
```

> `<T>` 만 쓰면 모든 타입 허용, `<T extends X>` 로 범위를 제한

---

### C03 — 다중 타입 파라미터

> 타입 파라미터를 여러 개 선언할 수 있다 — `<M, W>`, `<K, V>` 등

```java
class Couple<M extends Person, W extends Person> {
    private M role_man;
    private W role_woman;

    Couple(M role_man, W role_woman) {
        this.role_man  = role_man;
        this.role_woman = role_woman;
    }

    @Override
    public String toString() {
        return "Couple [" + role_man + ", " + role_woman + "] 은 커플입니다.";
    }
}
```

```java
// M과 W 자리에 Person의 하위 타입이면 무엇이든 가능
Couple<Man, Woman> couple1 = new Couple<>(new Man("철수", 20), new Woman("영희", 20));
Couple<Man, Man>   couple2 = new Couple<>(new Man("A", 55),   new Man("B", 40));
```

---

### C04 — 제네릭 메서드

> 메서드 단위로 타입 파라미터를 선언 — 반환 타입 앞에 `<T>` 위치

```java
// 제네릭 메서드 — Animal 하위 타입 배열만 받을 수 있음
public static <T extends Animal> void PrintGeneric(T[] arr) {
    for (T el : arr) System.out.println(el);
}

// Object 배열 버전 — 어떤 배열이든 받지만 타입 안전성 없음
public static void PrintByObject(Object[] arr) {
    for (Object el : arr) System.out.println(el);
}
```

```java
Tiger[] arr1 = { new Tiger("시베리안호랑이"), new Tiger("타이거JK") };
PrintGeneric(arr1);   // OK — Tiger는 Animal 하위 타입

Panda[] arr2 = { new Panda("쿵푸팬더"), new Panda("래서팬더") };
PrintGeneric(arr2);   // OK — Panda는 Animal 하위 타입

Object[] arr3 = { new Panda("쿵푸팬더3"), new Tiger("아프리카"), new Person("홍길동", 30) };
// PrintGeneric(arr3); // 컴파일 에러 — Object[]는 Animal[]이 아님
PrintByObject(arr3);   // OK — Object[] 버전은 가능
```

| 방식 | 타입 안전성 | 사용 제한 |
|---|---|---|
| `<T extends Animal> void f(T[] arr)` | O — 컴파일 타임 검사 | Animal 하위 타입 배열만 |
| `void f(Object[] arr)` | X — 런타임 ClassCastException 가능 | 모든 배열 |

---

### C06 — 와일드카드 & 불공변성

> 제네릭은 **불공변(invariant)** — `Box<Object>`와 `Box<String>`은 서로 상하 관계가 없다

```java
// 기본 와일드카드 — Box<?> = 어떤 타입의 Box든 받겠다
Box<?> b1 = new Box<Object>();  // OK
Box<?> b2 = new Box<String>();  // OK
Box<?> b3 = new Box<>();        // OK (다이아몬드 연산자)

// 불공변 — Box<Object>와 Box<Fruit>은 관계 없음
// Box<Object> b = new Box<Fruit>(); // 컴파일 에러

// 상한 와일드카드 — Fruit 하위 타입의 Box만 받음
Box<? extends Fruit> b4 = new Box<Apple>(); // OK — Apple은 Fruit 하위

// new 에는 와일드카드 사용 불가 — 생성 시엔 구체 타입 필요
// new Box<? extends Fruit>(); // 컴파일 에러
```

**와일드카드 vs 제네릭 메서드 비교 — merge 예시**

```java
// 와일드카드 버전 — 읽기만 가능, add/addAll 불가 (PECS 규칙)
public static ArrayList<? extends Product> merge(
        ArrayList<? extends Product> list,
        ArrayList<? extends Product> list2) {
    ArrayList<? extends Product> newList = new ArrayList<>(list);
    // newList.addAll(list2); // 컴파일 에러 — ? extends 에는 쓰기 불가
    return newList;
}

// 제네릭 메서드 버전 — T로 통일하면 읽기·쓰기 모두 가능
public static <T extends Product> ArrayList<T> merge(
        ArrayList<T> list,
        ArrayList<T> list2) {
    ArrayList<T> newList = new ArrayList<>(list);
    newList.addAll(list2); // OK
    return newList;
}
```

| 문장 | 결과 | 이유 |
|---|---|---|
| `Box<Object> b = new Box<Fruit>()` | 컴파일 에러 | 불공변 — 제네릭은 상속 관계 무시 |
| `Box<?> b = new Box<Object>()` | OK | `?`는 모든 타입 수용 |
| `Box<? extends Fruit> b = new Box<Apple>()` | OK | 상한 와일드카드 |
| `new Box<? extends Fruit>()` | 컴파일 에러 | new에 와일드카드 불가 |

---

### C05 — 실용 예제 (Generic + Reflection + JDBC)

> 제네릭, Reflection, JDBC를 조합해 **JPA Repository 패턴을 직접 구현**한 예제
> Entity 클래스를 받아서 자동으로 CREATE TABLE 쿼리를 생성하고 실행

**전체 흐름**

```
Entity 클래스 (Member, Board, Product)
    ↓ 생성자 인자로 전달
C05JPARepository<E, D>
    ↓ Reflection으로 필드 목록 추출
    ↓ 필드 타입에 따라 SQL 자료형 결정
    ↓ JDBC로 CREATE TABLE 실행
```

**Reflection — 클래스 정보를 런타임에 읽기 (C05ReflectionTests)**

```java
// Class.forName()으로 클래스 정보를 런타임에 가져옴
Class<?> clazz = Class.forName("Ch03.A");
System.out.println(clazz.getSimpleName()); // "A"

Field[] fields = clazz.getDeclaredFields(); // 필드 목록
for (Field field : fields) {
    System.out.println(field.getType().toString()); // 필드 타입
    System.out.println(field.getName());            // 필드명
}
```

**제네릭 Repository 클래스 구조**

```java
// E = Entity 타입, D = PrimaryKey 자료형
public class C05JPARepository<E, D> {
    E entity;
    Class<?> dataType;  // PK 타입 (String.class, Integer.class 등)

    public C05JPARepository(E entity, Class<?> dataType) {
        this.entity   = entity;
        this.dataType = dataType;

        // Reflection으로 Entity 클래스명 → 테이블명
        Class<?> clazz = Class.forName(entity.getClass().getName());
        Field[] fields = clazz.getDeclaredFields();

        String sql = "CREATE TABLE IF NOT EXISTS tmpdb." + clazz.getSimpleName() + "(";
        for (Field field : fields) {
            if (field.getType().toString().contains("String"))
                sql += field.getName() + " varchar(45) not null,";
            else if (field.getType().toString().contains("int"))
                sql += field.getName() + " int not null,";
        }
        sql = sql.substring(0, sql.lastIndexOf(",")) + ")";

        // JDBC로 실행
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.executeUpdate();
    }
}
```

**Entity별 Repository 선언 (C05ImplementMain)**

```java
class MemberRepository  extends C05JPARepository<Member,  String>  { ... }
class BoardRepository   extends C05JPARepository<Board,   String>  { ... }
class ProductRepository extends C05JPARepository<Product, Integer> { ... }

// 인스턴스 생성 시 생성자에서 자동으로 테이블 생성
public static MemberRepository  memberRepository  = new MemberRepository(new Member(),  String.class);
public static BoardRepository   boardRepository   = new BoardRepository(new Board(),   Long.class);
public static ProductRepository productRepository = new ProductRepository(new Product(), int.class);
```

> `<E, D>` 두 타입 파라미터로 Entity 타입과 PK 타입을 분리 → 타입 안전성 확보
> Reflection(`getDeclaredFields()`)으로 Entity 필드를 읽어 SQL을 동적 생성 — 실제 JPA가 내부적으로 하는 방식과 유사

---

### Ch03 핵심 정리

| 문법 | 예시 | 설명 |
|---|---|---|
| 제네릭 클래스 | `class Box<T>` | 타입을 파라미터로 받는 클래스 |
| 상한 제한 | `<T extends Animal>` | T는 Animal의 하위 타입만 허용 |
| 다중 타입 파라미터 | `<M, W>` | 타입 파라미터 여러 개 선언 |
| 제네릭 메서드 | `<T> void f(T[] arr)` | 반환 타입 앞에 `<T>` 선언 |
| 와일드카드 | `Box<?>` | 모든 타입의 Box 수용 (읽기 전용) |
| 상한 와일드카드 | `Box<? extends Fruit>` | Fruit 하위 타입의 Box만 수용 |
| 불공변 | `Box<Object> ≠ Box<String>` | 제네릭은 상속 관계 무시 |
| Reflection | `Class.forName()`, `getDeclaredFields()` | 런타임에 클래스 구조 탐색 |

---

## Ch04 — 컬렉션 프레임워크 (Collection Framework)

---

> 배열의 단점(고정 크기, 타입 고정)을 보완하기 위해 만들어진 자료구조 모음
> `java.util` 패키지에 포함되며 `List`, `Set`, `Map` 세 가지 계열로 나뉜다

---

### C01 — ArrayList

> 순서 있음, 중복 허용, 인덱스 기반 조회 가능

```java
List<String> list = new ArrayList();

// 추가
list.add("HTML/CSS/JS");
list.add("NODEJS");
list.add("REACT");
list.add("JAVA");

// 조회
list.size();                  // 개수
list.get(2);                  // 인덱스로 조회
list.indexOf("JAVA");         // 값으로 인덱스 확인

// 순회 — 람다식
list.forEach(el -> System.out.println(el));
// 순회 — 메서드 참조
list.forEach(System.out::println);

// 삭제
list.remove(0);               // 인덱스로 삭제
list.remove("REACT");         // 값으로 삭제

// 전체 삭제
list.clear();
```

---

### C02 — List 구현체 비교 (ArrayList / LinkedList / Vector)

> 세 클래스 모두 `List` 인터페이스를 구현하므로 사용법은 동일, 내부 동작 방식만 다르다

| 구현체 | 특징 | 권장 상황 |
|---|---|---|
| `ArrayList` | 배열 기반 — 삽입/삭제 시 뒤 요소를 밀어야 함 | 조회 중심 |
| `LinkedList` | 노드 연결 구조 — 삽입/삭제 연산이 더 빠름 | 삽입/삭제 중심 |
| `Vector` | ArrayList와 동일하나 **멀티스레드 환경에서 임계영역 설정** — 동시 접근 시 잠금(Lock) 적용 | 멀티스레드 환경 |

```java
// 구현체만 바꾸면 나머지 코드는 동일
List<String> list = new ArrayList();
// List<String> list = new LinkedList();
// List<String> list = new Vector();   // 멀티스레드 안전

list.add("JAVA");
list.get(0);
list.remove(0);
```

---

### C03 — HashSet

> 순서 없음, **중복 불허** — 같은 값을 add해도 한 번만 저장됨

```java
Set<String> set = new HashSet();

set.add("JAVA");
set.add("JAVA");          // 중복 → 무시됨
set.add("SPRING BOOT");
set.add("SPRING BOOT");   // 중복 → 무시됨

set.size();               // 중복 제거된 개수

set.remove("REACT");

// 탐색 — Iterator (구형)
Iterator<String> iter = set.iterator();
while (iter.hasNext()) System.out.println(iter.next());

// 탐색 — 향상된 for (최신)
for (String el : set) System.out.println(el);

set.clear();
```

---

### C04 — 로또 번호 생성 + 정렬

> Set의 중복 불허 특성을 활용해 랜덤 고유 번호 6개를 뽑고, Stream으로 정렬

```java
// 1~45 사이 숫자 6개를 중복 없이 Set에 저장
Random rand = new Random();
Set<Integer> set = new HashSet();
while (set.size() < 6) set.add(rand.nextInt(45) + 1);  // 중복이면 자동 제거

for (Integer n : set) System.out.print(n + " ");

// 오름차순 정렬 — 스트림 + Collectors
List<Integer> list = set.stream().sorted().collect(Collectors.toList());
list.forEach(el -> System.out.print(el + " "));

// 내림차순은 sorted(Comparator.reverseOrder())
// 또는 List로 변환 후 Collections.sort(list) 사용
```

---

### C05 — HashSet + equals() & hashCode() 오버라이드

> HashSet이 중복을 판별하는 방식: `hashCode()` 먼저 비교 → 같으면 `equals()` 비교
> 커스텀 객체를 Set에 넣을 때 **두 메서드를 반드시 함께 오버라이드해야** 중복 처리가 제대로 동작한다

```java
class Person {
    String name;
    int age;

    public Person(String name, int age) { this.name = name; this.age = age; }

    @Override
    public String toString() {
        return "Person [name=" + name + ", age=" + age + "]";
    }

    // name + age 가 같으면 동일 객체로 판단
    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Person) {
            Person down = (Person) obj;
            return this.name.equals(down.name) && this.age == down.age;
        }
        return false;
    }

    // equals가 true인 두 객체는 반드시 같은 hashCode를 반환해야 함
    @Override
    public int hashCode() {
        return Objects.hash(this.name, this.age);
    }
}
```

```java
Set<Person> set = new HashSet();
Person ob1 = new Person("홍길동", 55);
Person ob2 = new Person("남길동", 35);
Person ob3 = new Person("홍길동", 55); // ob1과 내용 동일

System.out.println(ob1.equals(ob2)); // false
System.out.println(ob1.equals(ob3)); // true

set.add(ob1);
set.add(ob2);
set.add(ob3); // ob1과 중복 → 추가되지 않음

System.out.println("SIZE : " + set.size()); // 2
set.forEach(System.out::println);
```

---

### C06 — HashMap

> Key-Value 쌍으로 저장, **Key 중복 불허** — 같은 Key로 put 하면 나중 값으로 덮어씀

```java
Map<String, Integer> map = new HashMap();

// 추가
map.put("aaa", 1111);
map.put("bbb", 2222);
map.put("ddd", 4444); // 먼저 저장
map.put("ddd", 5555); // 같은 Key → 덮어씀 (5555 적용)

// 조회 — keySet()으로 Key 순회
for (String key : map.keySet()) {
    System.out.println("KEY : " + key + " VALUE : " + map.get(key));
}

// 단건 조회
map.get("bbb");     // 2222

// 삭제
map.remove("aaa");

// 개수
map.size();
```

---

### C07 — Map\<String, Object\> 활용

> `Object` 타입으로 선언하면 String, int, 배열, List 등 모든 타입을 하나의 Map에 저장 가능
> 꺼낼 때는 `instanceof`로 타입을 확인한 후 다운캐스팅

```java
static Map<String, Object> map = new HashMap();

// setter — 파라미터 Map의 내용을 내부 Map에 저장
static void setMap(Map<String, Object> param) {
    for (String key : param.keySet()) map.put(key, param.get(key));
}

static Map<String, Object> getMap() { return map; }

public static void main(String[] args) {
    Map<String, Object> params = new HashMap();

    // 배열 저장
    String[] values1 = {"정보처리기사", "웹디자인기능사", "SQLD", "네트워크관리사"};
    params.put("자격증", values1);

    // List 저장
    List<String> values2 = new ArrayList();
    values2.add("등산"); values2.add("게임"); values2.add("영화감상");
    params.put("취미", values2);

    // 기본 타입 저장
    params.put("이름", "홍길동");
    params.put("나이", 20);
    params.put("주소", "대구광역시 남구");

    setMap(params);

    // 꺼낼 때 instanceof로 타입 구분 후 캐스팅
    Map<String, Object> response = getMap();
    for (String key : response.keySet()) {
        Object value = response.get(key);

        if (value instanceof String[]) {
            String[] arr = (String[]) value;
            Arrays.stream(arr).forEach(el -> System.out.println("배열 : " + el));
        } else if (value instanceof List) {
            List list = (List) value;
            list.forEach(el -> System.out.println("리스트 : " + el));
        } else {
            System.out.println("KEY : " + key + " VALUE : " + value);
        }
    }
}
```

---

### C08 — Properties 파일 로드

> `.properties` 파일에서 key=value 형태의 설정값을 읽어오는 방법
> DB 접속 정보 등 외부 설정값을 코드에서 분리할 때 사용

**application.properties**
```properties
url=jdbc:mysql://localhost:3306/opendatadb
username=root
password=1234
```

```java
// 경로 조합 — 프로젝트 루트/src/패키지명/application.properties
String dirPath     = System.getProperty("user.dir");
String packagePath = C08PropertiesMain.class.getPackageName();
String filePath    = dirPath + File.separator + "src"
                   + File.separator + packagePath
                   + File.separator + "application.properties";

FileInputStream fin = new FileInputStream(filePath);
Properties properties = new Properties();
properties.load(fin);

String url      = properties.getProperty("url");
String username = properties.getProperty("username");
String password = properties.getProperty("password");

System.out.printf("%s %s %s\n", url, username, password);
// 출력: jdbc:mysql://localhost:3306/opendatadb root 1234
```

| 메서드 | 설명 |
|---|---|
| `System.getProperty("user.dir")` | 현재 프로젝트 루트 경로 |
| `System.getProperty("java.class.path")` | 클래스패스 |
| `getClass().getPackageName()` | 현재 클래스의 패키지명 |
| `properties.load(InputStream)` | 스트림에서 properties 파일 읽기 |
| `properties.getProperty("key")` | 키에 해당하는 값 반환 |

---

### Ch04 핵심 정리

| 컬렉션 | 클래스 | 순서 | 중복 | 특징 |
|---|---|---|---|---|
| **List** | `ArrayList` | O | O | 배열 기반, 조회 빠름 |
| **List** | `LinkedList` | O | O | 노드 연결, 삽입·삭제 빠름 |
| **List** | `Vector` | O | O | 멀티스레드 안전 (synchronized) |
| **Set** | `HashSet` | X | X | 중복 자동 제거, equals+hashCode 의존 |
| **Map** | `HashMap` | X | Key X | Key-Value, Key 중복 시 덮어씀 |

**컬렉션 공통 메서드**

| 동작 | List | Set | Map |
|---|---|---|---|
| 추가 | `add(값)` | `add(값)` | `put(키, 값)` |
| 조회 | `get(idx)` | (인덱스 없음) | `get(키)` |
| 삭제 | `remove(idx/값)` | `remove(값)` | `remove(키)` |
| 개수 | `size()` | `size()` | `size()` |
| 전체 삭제 | `clear()` | `clear()` | `clear()` |
| 순회 | `forEach` / `for-each` | `Iterator` / `for-each` | `keySet()` 순회 |

> **커스텀 객체를 HashSet/HashMap에 넣을 때**: `equals()` + `hashCode()` 반드시 오버라이드
> **Map\<String, Object\>**: 여러 타입 혼합 저장 시 꺼낼 때 `instanceof` + 다운캐스팅 필수

---

## Ch05 — Swing GUI & 이벤트 처리

---

> Java Swing은 `javax.swing` 패키지의 GUI 라이브러리
> **Frame → Panel → Component** 순서로 구성하며, `setVisible(true)` 호출 전에 모든 컴포넌트를 추가해야 한다

---

### C01 — JFrame 기본 생성

> 가장 단순한 형태 — main에서 직접 JFrame 객체를 생성

```java
JFrame frame = new JFrame("첫번째 프레임입니다.");
frame.setBounds(100, 100, 500, 500); // x, y, width, height
frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); // 창 닫으면 프로세스 종료
frame.setVisible(true);
```

| 메서드 | 설명 |
|---|---|
| `setBounds(x, y, w, h)` | 창 위치(x,y)와 크기(width,height) 설정 |
| `setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)` | X 버튼으로 닫으면 프로그램 종료 |
| `setVisible(true)` | 창을 화면에 표시 |

---

### C02 — JFrame 상속으로 클래스 구조화

> GUI 설정 코드를 별도 클래스로 분리 — `JFrame`을 상속받아 생성자에서 초기화

```java
class C02GUI extends JFrame {
    C02GUI(String title) {
        super(title);                               // JFrame 생성자에 타이틀 전달
        setBounds(100, 100, 500, 500);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setVisible(true);
    }
}

// main
new C02GUI("두번째 프레임 창입니다.");
```

> `super(title)` 로 부모(JFrame) 생성자를 호출해 타이틀 설정

---

### C03 — JPanel 추가

> Frame 자체에 직접 컴포넌트를 올리기보다 **Panel을 중간 레이어로 사용**하는 것이 일반적

```java
// Frame에 Panel 추가
JPanel panel = new JPanel();
// panel.setBackground(new Color(255, 255, 0)); // 배경색 설정 (주석 처리 예시)
add(panel); // JFrame.add() — Frame에 Panel 부착
```

> `Color(r, g, b)` 로 RGB 색상 지정 가능

---

### C04 — 컴포넌트 배치 (절대 좌표)

> `panel.setLayout(null)` 로 레이아웃 매니저를 해제하면 `setBounds()`로 절대 위치에 컴포넌트를 배치할 수 있다

```java
JPanel panel = new JPanel();
panel.setLayout(null); // 레이아웃 매니저 해제 → setBounds로 절대 배치

// 버튼
JButton btn1 = new JButton("BTN01");
btn1.setBounds(10, 10, 100, 30);   // x, y, width, height
JButton btn2 = new JButton("BTN02");
btn2.setBounds(120, 10, 100, 30);

// 한 줄 텍스트 입력
JTextField txt1 = new JTextField();
txt1.setBounds(10, 50, 210, 30);

// 여러 줄 텍스트 — 스크롤과 함께 사용
JTextArea area1 = new JTextArea();
JScrollPane scroll = new JScrollPane(area1); // JTextArea를 JScrollPane으로 감쌈
scroll.setBounds(10, 90, 210, 300);

// Panel에 추가 (JTextArea 직접 추가 X — scroll로 감싸서 추가)
panel.add(btn1);
panel.add(btn2);
panel.add(txt1);
panel.add(scroll); // area1이 아닌 scroll을 추가

add(panel);
setVisible(true); // 컴포넌트 추가 후 마지막에 호출
```

| 컴포넌트 | 클래스 | 용도 |
|---|---|---|
| 버튼 | `JButton` | 클릭 이벤트 처리 |
| 한 줄 입력 | `JTextField` | 짧은 텍스트 입력 |
| 여러 줄 입력/출력 | `JTextArea` | 채팅 로그 등 다중 라인 |
| 스크롤 패널 | `JScrollPane` | JTextArea를 감싸 스크롤 제공 |

---

### C05 — 채팅 UI 예제

> C04 구조를 바탕으로 채팅 창 레이아웃 직접 설계

```
[채팅 로그 + 스크롤] [파일로저장]
                      [1:1 요청 ]
                      [대화기록 ]
[입력창(TextField)] [입력 버튼]
```

```java
// 좌측: 채팅 로그 (스크롤)
JTextArea area1 = new JTextArea();
JScrollPane scroll = new JScrollPane(area1);
scroll.setBounds(10, 10, 200, 280);

// 우측: 기능 버튼들
JButton btn1 = new JButton("파일로저장");  btn1.setBounds(230, 10, 120, 30);
JButton btn2 = new JButton("1:1 요청");    btn2.setBounds(230, 50, 120, 30);
JButton btn3 = new JButton("대화기록보기"); btn3.setBounds(230, 90, 120, 30);

// 하단: 입력창 + 전송 버튼
JTextField txt1 = new JTextField();       txt1.setBounds(10, 300, 200, 30);
JButton btn4 = new JButton("입력");        btn4.setBounds(230, 300, 120, 30);
```

---

### C06 — ActionListener (버튼 클릭 이벤트)

> 이벤트를 처리하려면 **리스너 인터페이스를 implements** 하고, 컴포넌트에 **addXxxListener(this)** 로 등록

```java
// 1) 클래스가 ActionListener를 implements
class C06GUI extends JFrame implements ActionListener {
    JButton btn1, btn2, btn3, btn4; // 필드로 선언해야 actionPerformed에서 참조 가능

    C06GUI(String title) {
        // ... 컴포넌트 생성 및 배치 ...

        // 2) 각 버튼에 리스너 등록
        btn1.addActionListener(this);
        btn2.addActionListener(this);
        btn3.addActionListener(this);
        btn4.addActionListener(this);
    }

    // 3) 인터페이스 메서드 구현 — 어느 버튼인지 e.getSource()로 구분
    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == btn1) {
            System.out.println("파일로 저장 버튼 클릭");
        } else if (e.getSource() == btn2) {
            System.out.println("1:1 요청 버튼 클릭");
        } else if (e.getSource() == btn3) {
            System.out.println("대화기록보기 버튼 클릭");
        } else if (e.getSource() == btn4) {
            System.out.println("입력 버튼 클릭");
        }
    }
}
```

> `e.getSource()` — 이벤트를 발생시킨 컴포넌트 객체 반환 → `==` 로 어느 버튼인지 비교

---

### C07 — KeyListener (키보드 이벤트)

> `KeyListener`를 함께 implements하면 키 입력 감지 가능
> Enter(keyChar == 10)로 메시지 전송 구현

```java
class C07GUI extends JFrame implements ActionListener, KeyListener {
    JTextField txt1;
    JTextArea area1;

    C07GUI(String title) {
        // ...
        txt1.addKeyListener(this); // TextField에 키 리스너 등록
    }

    // 버튼 클릭 — "입력" 버튼 누르면 TextField 내용을 TextArea에 추가
    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == btn4) {
            String message = txt1.getText();   // TextField 내용 가져오기
            area1.append(message + "\n");      // TextArea에 줄 추가
            txt1.setText("");                  // TextField 초기화
        }
    }

    @Override
    public void keyTyped(KeyEvent e) { }    // 문자 입력 시 (문자키만)

    @Override
    public void keyPressed(KeyEvent e) { }  // 키를 누르는 동안

    @Override
    public void keyReleased(KeyEvent e) {   // 키를 뗐을 때
        if (e.getSource() == txt1) {
            if (e.getKeyChar() == 10) {      // Enter키 = keyChar 10
                String message = txt1.getText();
                area1.append(message + "\n");
                txt1.setText("");
            }
        }
    }
}
```

| KeyListener 메서드 | 호출 시점 |
|---|---|
| `keyTyped(e)` | 문자 키(char)가 입력됐을 때 |
| `keyPressed(e)` | 키를 누르는 동안 |
| `keyReleased(e)` | 키에서 손을 뗐을 때 |

| 메서드 | 설명 |
|---|---|
| `e.getKeyChar()` | 입력된 문자 (char) — Enter는 `10` |
| `e.getKeyCode()` | 입력된 키코드 (int) |
| `txt1.getText()` | TextField/TextArea 텍스트 가져오기 |
| `area1.append(str)` | TextArea 끝에 텍스트 추가 |
| `txt1.setText("")` | TextField/TextArea 내용 초기화 |

---

### C08 — MouseListener (마우스 이벤트)

> `MouseListener`를 추가하면 클릭, 누르기, 뗌, 진입, 나감 이벤트 처리 가능
> JTextArea 클릭 시 해당 줄의 텍스트를 추출하는 패턴

```java
class C08GUI extends JFrame implements ActionListener, KeyListener, MouseListener {

    C08GUI(String title) {
        // ...
        area1.addMouseListener(this); // TextArea에 마우스 리스너 등록
    }

    // 마우스 클릭 — 클릭한 위치의 줄 텍스트 추출
    @Override
    public void mouseClicked(MouseEvent e) {
        try {
            Point point = e.getPoint();                       // 클릭 좌표
            int offset = area1.viewToModel(point);            // 좌표 → 문자 오프셋(인덱스)
            int row = area1.getLineOfOffset(offset);          // 오프셋 → 줄 번호
            int startOffset = area1.getLineStartOffset(row);  // 줄 시작 오프셋
            int endOffset   = area1.getLineEndOffset(row);    // 줄 끝 오프셋
            String str = area1.getText(startOffset, endOffset - startOffset); // 줄 텍스트 추출
            System.out.println(str);
        } catch (Exception e1) {
            e1.printStackTrace();
        }
    }

    // 나머지 MouseListener 필수 구현 메서드 (미사용 시 빈 구현)
    @Override public void mousePressed(MouseEvent e)  { }
    @Override public void mouseReleased(MouseEvent e) { }
    @Override public void mouseEntered(MouseEvent e)  { }
    @Override public void mouseExited(MouseEvent e)   { }
}
```

| MouseListener 메서드 | 호출 시점 |
|---|---|
| `mouseClicked(e)` | 클릭(누르고 뗌) |
| `mousePressed(e)` | 마우스 버튼을 누를 때 |
| `mouseReleased(e)` | 마우스 버튼을 뗄 때 |
| `mouseEntered(e)` | 컴포넌트 영역 안으로 진입 |
| `mouseExited(e)` | 컴포넌트 영역 밖으로 나감 |

| JTextArea 줄 관련 메서드 | 설명 |
|---|---|
| `viewToModel(Point)` | 화면 좌표 → 텍스트 오프셋(인덱스) |
| `getLineOfOffset(offset)` | 오프셋이 속한 줄 번호 반환 |
| `getLineStartOffset(row)` | 해당 줄의 시작 오프셋 |
| `getLineEndOffset(row)` | 해당 줄의 끝 오프셋 |
| `getText(start, len)` | 오프셋 start부터 len 길이 텍스트 추출 |

---

### Ch05 핵심 정리

**Swing 구성 계층**

```
JFrame (창)
 └── JPanel (컨테이너, setLayout(null) → 절대 배치)
      ├── JButton
      ├── JTextField
      └── JScrollPane → JTextArea
```

**이벤트 처리 3단계**

```
1. 클래스에 implements XxxListener 추가
2. 컴포넌트에 addXxxListener(this) 등록
3. 인터페이스 메서드 오버라이드 (actionPerformed 등)
```

**리스너 종류 비교**

| 리스너 | 인터페이스 | 등록 메서드 | 주요 이벤트 메서드 |
|---|---|---|---|
| 버튼 클릭 | `ActionListener` | `addActionListener(this)` | `actionPerformed(e)` |
| 키보드 | `KeyListener` | `addKeyListener(this)` | `keyReleased(e)` 등 3개 |
| 마우스 | `MouseListener` | `addMouseListener(this)` | `mouseClicked(e)` 등 5개 |

> **주의**: `JButton`, `JTextField` 등 이벤트를 처리할 컴포넌트는 **생성자 파라미터가 아닌 필드로 선언**해야 `actionPerformed()` 안에서 `e.getSource() ==` 비교 가능

---

## Ch06 — 입출력 (I/O)

### 스트림 종류 비교

| 구분 | 문자 스트림 | 바이트 스트림 |
|---|---|---|
| 입력 | `Reader` / `FileReader` | `InputStream` / `FileInputStream` |
| 출력 | `Writer` / `FileWriter` | `OutputStream` / `FileOutputStream` |
| 단위 | `char` (2byte) | `byte` (1byte) |
| 적합 | 텍스트 파일 | 이미지·PDF 등 바이너리 |

---

### C01~C03 — 문자 스트림 (Reader / Writer)

**FileWriter — 파일 쓰기**

```java
// false: 덮어쓰기(기본값), true: 이어쓰기(append)
Writer fout = new FileWriter("경로/test1.txt", true);
fout.write("HELLOWORLD\n");
fout.flush();   // 버퍼 강제 출력 (중요)
fout.close();
```

**FileReader — 파일 읽기**

```java
Reader fin = new FileReader("경로/test1.txt");
int data;
while ((data = fin.read()) != -1) {
    System.out.print((char) data);  // int → char 변환
}
fin.close();
```

**Reader/Writer로 텍스트 파일 복사**

```java
Reader fin  = new FileReader(PATH + args[0]);   // 소스 파일
Writer fout = new FileWriter(PATH + args[1]);   // 대상 파일
int data;
while ((data = fin.read()) != -1) {
    fout.write((char) data);
    fout.flush();
}
fin.close();
fout.close();
```

> 실행 시 VM arguments로 `args[0]`, `args[1]` 전달

---

### C04 — 버퍼를 이용한 성능 개선

한 글자씩 읽으면 느림 → `char[]` 배열로 한 번에 여러 글자 읽기

```java
Reader fin = new FileReader("경로/origin.txt");
StringBuffer strBuffer = new StringBuffer();
char[] buff = new char[1024];
int data;

long startTime = System.currentTimeMillis();
while ((data = fin.read(buff)) != -1) {
    strBuffer.append(buff);
}
fin.close();
long endTime = System.currentTimeMillis();

System.out.println("총문자 길이 : " + strBuffer.length());
System.out.println("소요시간 : " + (endTime - startTime) + " ms");
```

| 방식 | 설명 |
|---|---|
| `fin.read()` | 1글자씩 반환 (`int`) |
| `fin.read(buff)` | 버퍼 크기만큼 읽고, 읽은 글자 수 반환 |

---

### C05~C07 — 바이트 스트림 (InputStream / OutputStream)

**FileInputStream — 바이너리 읽기 (PDF 등)**

```java
InputStream fin = new FileInputStream("경로/파일.pdf");
byte[] buffer = new byte[1024];
int data;
while ((data = fin.read(buffer)) != -1) {
    System.out.print(data);     // 읽은 바이트 수 출력
}
fin.close();
```

**FileOutputStream — 바이너리 쓰기**

```java
OutputStream fout = new FileOutputStream("경로/test2.txt");
fout.write("가나다".getBytes(StandardCharsets.UTF_8));  // 한글: UTF-8 명시
fout.write('a');
fout.write('b');
fout.flush();
fout.close();
```

**InputStream/OutputStream으로 바이너리 파일 복사**

```java
InputStream  fin  = new FileInputStream(PATH + args[0]);
OutputStream fout = new FileOutputStream(PATH + args[1]);
byte[] buff = new byte[4096];
int data;
while ((data = fin.read(buff)) != -1) {
    fout.write(buff, 0, data);  // 실제 읽은 길이(data)만큼만 씀
    fout.flush();
}
fin.close();
fout.close();
```

> `fout.write(buff, 0, data)` — 마지막 블록에서 버퍼가 꽉 차지 않을 때 불필요한 데이터를 쓰지 않으려면 `data`(실제 읽은 수)를 세 번째 인자로 전달

---

### C08 — URL 스트림 + 보조 스트림

네트워크 URL에서 HTML을 읽어 파일로 저장하는 예시

```java
URL url = (new URI("https://...")).toURL();

// 기본 스트림 (byte)
InputStream in = url.openStream();

// 보조 스트림 추가
BufferedInputStream buffIn = new BufferedInputStream(in);   // 버퍼 추가
Reader rin = new InputStreamReader(in);                     // byte → char 변환

// 출력 스트림
Writer fout = new FileWriter("경로/index.html");

int data;
while ((data = rin.read()) != -1) {
    fout.write((char) data);
    fout.flush();
}
fout.close();
rin.close();
buffIn.close();
in.close();
```

**보조 스트림 개념**

```
기본 스트림(byte) ──▶ BufferedInputStream (버퍼 추가)
                  ──▶ InputStreamReader   (byte → char 변환)
```

| 보조 스트림 | 역할 |
|---|---|
| `BufferedInputStream` | 버퍼를 추가해 읽기 성능 향상 |
| `InputStreamReader` | 바이트 스트림을 문자 스트림으로 변환 |

---

### 핵심 정리

| 항목 | 내용 |
|---|---|
| `flush()` | 버퍼에 남은 데이터를 강제로 출력 — 쓰기 후 반드시 호출 |
| `close()` | 스트림 자원 해제 — `flush()` 후 호출 |
| append 모드 | `new FileWriter(path, true)` — 기존 내용에 이어쓰기 |
| 한글 출력 | `getBytes(StandardCharsets.UTF_8)` 명시 |
| 읽기 종료 조건 | `read()` 반환값이 `-1`이면 EOF |
| 버퍼 크기 | 텍스트 `1024` char, 바이너리 `4096` byte 권장 |

---

### C09 — Jsoup (HTML 파싱 & 이미지 크롤링)

> 외부 라이브러리: `org.jsoup`

**기본 흐름**

```
Jsoup.connect(url) → Document → Elements → 각 요소 처리
```

**연결 설정**

```java
Connection conn = Jsoup.connect("https://...")
    .userAgent("Mozilla/5.0 ...")   // 봇 차단 우회
    .timeout(0)                     // 타임아웃 없음
    .ignoreHttpErrors(true)
    .followRedirects(true);

Document document = conn.get();     // DOM 파싱
```

**요소 추출 및 이미지 다운로드**

```java
Elements elements = document.getElementsByTag("img");

elements.forEach(el -> {
    String imgUrl = el.getElementsByAttribute("src").attr("src");

    // 상대경로 → 절대경로 변환
    if (!imgUrl.startsWith("http")) {
        imgUrl = "https://도메인" + imgUrl;
    }

    // URL 스트림으로 이미지 바이너리 다운로드
    InputStream in = (new URI(imgUrl)).toURL().openStream();
    BufferedInputStream bin = new BufferedInputStream(in);
    OutputStream out = new FileOutputStream("저장경로/" + UUID.randomUUID() + ".png");

    int data;
    while ((data = bin.read()) != -1) {
        out.write((byte) data);
        out.flush();
    }
    out.close(); bin.close(); in.close();
});
```

**주요 포인트**

| 항목 | 내용 |
|---|---|
| `conn.get()` | GET 요청 → `Document` 반환 |
| `getElementsByTag("img")` | 태그명으로 요소 선택 |
| `el.attr("src")` | 속성값 추출 |
| `UUID.randomUUID()` | 중복 없는 파일명 생성 |
| 확장자 분기 | `imgUrl.contains(".png")` 등으로 FileOutputStream 분기 |

---

### C10 — Selenium (브라우저 자동화)

> 외부 라이브러리: `org.openqa.selenium`

**드라이버 설정**

```java
// Selenium 3.x: chromedriver.exe 경로 직접 지정
System.setProperty("webdriver.chrome.driver", "src/Drivers/chromedriver.exe");
// Selenium 4.x: chromedriver.exe를 Windows PATH에 등록하면 경로 설정 불필요

ChromeOptions options = new ChromeOptions();
// options.addArguments("--headless");     // 백그라운드(창 없이) 실행
// options.addArguments("--no-sandbox");   // 리눅스 환경용

WebDriver driver = new ChromeDriver(options);
```

**요소 탐색 & 조작**

```java
driver.get("https://www.naver.com");

// id로 요소 찾기
WebElement searchEl = driver.findElement(By.id("query"));
searchEl.sendKeys("건조기");       // 텍스트 입력
searchEl.sendKeys(Keys.RETURN);    // 엔터 전송

Thread.sleep(500);  // 페이지 로딩 대기

// CSS 선택자로 요소 찾기
WebElement btn = driver.findElement(By.cssSelector(".wrap .tab:nth-child(1)"));

// JavaScript 실행 (속성 제거 등)
JavascriptExecutor js = (JavascriptExecutor) driver;
js.executeScript("arguments[0].removeAttribute('target')", btn);

btn.click();
```

**복수 요소 추출 → HTML 파일 저장**

```java
List<WebElement> items = driver.findElements(By.cssSelector(".list_item"));

StringBuilder html = new StringBuilder();
html.append("<!DOCTYPE html>\n<html><head>...");

// CSS 링크 추출
List<WebElement> cssLinks = driver.findElements(By.tagName("link"));
for (WebElement link : cssLinks) {
    if ("stylesheet".equals(link.getAttribute("rel"))) {
        html.append("<link rel=\"stylesheet\" href=\"")
            .append(link.getAttribute("href")).append("\">\n");
    }
}

// 본문 HTML 추출
for (WebElement el : items) {
    html.append(el.getAttribute("outerHTML")).append("\n");  // outerHTML: 태그 포함 전체 HTML
}

Writer out = new FileWriter("C:\\IOTEST\\" + UUID.randomUUID() + ".html");
out.write(html.toString());
out.flush();
out.close();
```

**주요 포인트**

| 항목 | 내용 |
|---|---|
| `By.id("id")` | id 속성으로 요소 탐색 |
| `By.cssSelector(".cls")` | CSS 선택자로 요소 탐색 |
| `sendKeys(Keys.RETURN)` | 엔터키 전달 |
| `JavascriptExecutor` | JS 직접 실행 (속성 제거·스크롤 등) |
| `outerHTML` | 해당 태그 포함 전체 HTML 문자열 |
| `Thread.sleep(ms)` | 동적 페이지 로딩 대기 |

---

### C11 — REST API (HttpClient & Jackson)

> Java 11+ 내장 `java.net.http` + 외부 라이브러리: `com.fasterxml.jackson`

**흐름**

```
URL 구성 → HttpRequest 빌드 → HttpClient.send() → HttpResponse → Jackson으로 JSON 파싱
```

**HTTP GET 요청**

```java
// 01 URL + 쿼리 파라미터 구성
String url = "https://api.example.com/data";
url += "?mode=json&addr=중구";

// 02 요청 객체 빌드
HttpRequest request = HttpRequest.newBuilder()
    .uri(URI.create(url))
    .GET()
    .build();

// 03 요청 전송 → 응답 수신
HttpClient httpClient = HttpClient.newHttpClient();
HttpResponse<String> response =
    httpClient.send(request, HttpResponse.BodyHandlers.ofString());

System.out.println(response.body());  // JSON 문자열
```

**Jackson으로 JSON 파싱**

```java
// 04 JSON 문자열 → JsonNode 트리
ObjectMapper mapper = new ObjectMapper();
JsonNode root = mapper.readTree(response.body());

// 단일 값
System.out.println(root.get("status"));
System.out.println(root.get("total"));

// 배열 순회
JsonNode data = root.get("data");
for (int i = 0; i < data.size(); i++) {
    JsonNode item = data.get(i);
    System.out.println(item.get("BZ_NM"));
}
```

**주요 포인트**

| 항목 | 내용 |
|---|---|
| `HttpRequest.newBuilder()` | 빌더 패턴으로 요청 구성 |
| `BodyHandlers.ofString()` | 응답 바디를 `String`으로 수신 |
| `response.body()` | 응답 본문(JSON 문자열) |
| `mapper.readTree()` | JSON → `JsonNode` 트리 파싱 |
| `jsonNode.get("key")` | 키로 값 접근 |
| `jsonNode.size()` | 배열 크기 |

---

### C12 — Swing 이벤트 통합 (채팅 UI + 파일 I/O)

> `JFrame`을 상속하고 `ActionListener`, `KeyListener`, `MouseListener`를 동시에 구현하는 패턴

**클래스 구조**

```java
class C12GUI extends JFrame implements ActionListener, KeyListener, MouseListener {
    JButton btn1, btn2, btn3, btn4;
    JTextField txt1;
    JTextArea area1;
}
```

**GUI 구성**

```java
// JTextArea를 JScrollPane으로 감싸서 스크롤 지원
JScrollPane scroll = new JScrollPane(area1);
scroll.setBounds(10, 10, 200, 280);

// 이벤트 리스너 등록
btn1.addActionListener(this);   // ActionListener
txt1.addKeyListener(this);      // KeyListener
area1.addMouseListener(this);   // MouseListener
```

**btn1 — 파일로 저장 (JFileChooser + FileWriter)**

```java
// 현재 시각 + textarea 내용을 파일로 저장
DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
String contents = LocalDateTime.now().format(fmt) + "\n" + area1.getText();

JFileChooser fileChooser = new JFileChooser();
fileChooser.setDialogTitle("파일 저장 위치를 선택하세요");
fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);

// 기본 디렉터리 설정
File defaultDir = new File("C:\\경로\\IOTEST\\");
if (defaultDir.exists()) fileChooser.setCurrentDirectory(defaultDir);

int selectedVal = fileChooser.showSaveDialog(null);
if (selectedVal == JFileChooser.APPROVE_OPTION) {
    String filePath = fileChooser.getSelectedFile().toString();
    if (!filePath.endsWith(".txt")) filePath += ".txt";  // 확장자 보장

    try (Writer out = new FileWriter(filePath)) {
        out.write(contents);
        out.flush();
    } catch (IOException e1) { e1.printStackTrace(); }
}
```

**btn3 — 대화기록 불러오기 (JFileChooser + FileReader)**

```java
JFileChooser fileChooser = new JFileChooser();
fileChooser.setApproveButtonText("불러오기");   // 승인 버튼 텍스트 변경
fileChooser.showOpenDialog(null);              // 열기 다이얼로그

if (selectedVal == JFileChooser.APPROVE_OPTION) {
    File selectedFile = fileChooser.getSelectedFile();
    StringBuffer buffer = new StringBuffer();
    try (Reader in = new FileReader(selectedFile)) {
        int data;
        while ((data = in.read()) != -1) buffer.append((char) data);
        area1.setText(buffer.toString());
    } catch (IOException e1) { e1.printStackTrace(); }
}
```

**btn4 / Enter 키 — 메시지 입력**

```java
// 버튼 클릭
area1.append(txt1.getText() + "\n");
txt1.setText("");

// Enter 키 (keyChar == 10)
@Override
public void keyReleased(KeyEvent e) {
    if (e.getSource() == txt1 && e.getKeyChar() == 10) {
        area1.append(txt1.getText() + "\n");
        txt1.setText("");
    }
}
```

**MouseListener — 클릭한 줄 텍스트 추출**

```java
@Override
public void mouseClicked(MouseEvent e) {
    Point point = e.getPoint();
    int offset = area1.viewToModel(point);          // 픽셀 좌표 → 문자 오프셋
    int row    = area1.getLineOfOffset(offset);     // 오프셋 → 행 번호
    int startOffset = area1.getLineStartOffset(row);
    int endOffset   = area1.getLineEndOffset(row);
    String str = area1.getText(startOffset, endOffset - startOffset);
    System.out.println(str);
}
```

**주요 포인트**

| 항목 | 내용 |
|---|---|
| `implements A, B, C` | 여러 리스너를 한 클래스에서 처리 |
| `e.getSource() == btn1` | 어느 컴포넌트에서 이벤트 발생했는지 구분 |
| `showSaveDialog` / `showOpenDialog` | 저장/열기 다이얼로그 구분 |
| `setApproveButtonText()` | 다이얼로그 승인 버튼 텍스트 커스텀 |
| `keyChar == 10` | Enter 키 감지 (`\n` 아스키 코드) |
| `viewToModel(point)` | 마우스 좌표 → 텍스트 오프셋 변환 |
| `getLineOfOffset(offset)` | 오프셋으로 행 번호 조회 |
| try-with-resources | `Reader`/`Writer` 자동 close |

---

## Ch07 — 보조 스트림 (Wrapper Stream)

> 보조 스트림은 단독으로 사용할 수 없고, 기본 스트림을 감싸서 기능을 추가한다.

**보조 스트림 체인 구조**

```
기본 스트림 → 변환 스트림 → 버퍼 스트림
FileOutputStream → OutputStreamWriter → BufferedWriter
FileInputStream  → InputStreamReader  → BufferedReader
```

---

### C01 — 변환 스트림 (InputStreamReader / OutputStreamWriter)

바이트 스트림 ↔ 문자 스트림 변환 브릿지

**쓰기 (바이트 → 문자 변환 후 버퍼 출력)**

```java
OutputStream out = new FileOutputStream("경로/test3.txt");
OutputStreamWriter wout = new OutputStreamWriter(out);   // 바이트 → 문자 변환
BufferedWriter bout = new BufferedWriter(wout);          // 버퍼 추가
bout.write("문자 변환 스트림테스트!");
bout.flush();
bout.close(); wout.close(); out.close();
```

**읽기 (바이트 → 문자 변환 후 버퍼 읽기)**

```java
InputStream in = new FileInputStream("경로/test3.txt");
InputStreamReader rin = new InputStreamReader(in);    // 바이트 → 문자 변환
BufferedReader bin = new BufferedReader(rin);         // 버퍼 추가
int data;
while ((data = bin.read()) != -1) System.out.println((char) data);
```

| 클래스 | 역할 |
|---|---|
| `InputStreamReader` | `InputStream` → `Reader` 변환 |
| `OutputStreamWriter` | `OutputStream` → `Writer` 변환 |
| `BufferedReader` | 문자 스트림에 버퍼 추가 |
| `BufferedWriter` | 문자 스트림에 버퍼 추가 |

---

### C02 — 줄 단위 읽기 (BufferedReader.readLine / PrintWriter)

**쓰기 (PrintWriter)**

```java
Writer out = new FileWriter("경로/test3.txt");
BufferedWriter bout = new BufferedWriter(out);
PrintWriter pout = new PrintWriter(bout);   // print/println 사용 가능
pout.print("HELLO WORLD");
pout.flush(); pout.close(); bout.close(); out.close();
```

**읽기 (readLine — 줄 단위)**

```java
Reader in = new FileReader("경로/test3.txt");
BufferedReader bin = new BufferedReader(in);
while (true) {
    String msg = bin.readLine();   // 줄 끝 개행문자 제거 후 반환, EOF면 null
    if (msg == null) break;
    System.out.println(msg);
}
in.close();
```

| 메서드 | 설명 |
|---|---|
| `readLine()` | 한 줄 읽기, EOF 도달 시 `null` 반환 |
| `PrintWriter.print()` | 개행 없이 출력 |
| `PrintWriter.println()` | 개행 포함 출력 |

---

### C03 — 타입별 읽기/쓰기 (DataInputStream / DataOutputStream)

> 기본 타입(`int`, `double`, `String`) 그대로 저장·복원. **쓴 순서와 동일한 순서로 읽어야 한다.**

**쓰기**

```java
FileOutputStream out = new FileOutputStream("경로/test3.txt");
DataOutputStream dout = new DataOutputStream(out);
dout.writeUTF("홍길동");    // String (UTF-8 인코딩)
dout.writeDouble(95.5);    // double (8 byte)
dout.writeInt(100);        // int (4 byte)
dout.flush(); dout.close();
```

**읽기 (쓴 순서 그대로)**

```java
FileInputStream in = new FileInputStream("경로/test3.txt");
DataInputStream din = new DataInputStream(in);
String name   = din.readUTF();      // "홍길동"
double weight = din.readDouble();   // 95.5
int data      = din.readInt();      // 100
```

| 메서드 쌍 | 타입 |
|---|---|
| `writeUTF` / `readUTF` | `String` |
| `writeDouble` / `readDouble` | `double` |
| `writeInt` / `readInt` | `int` |
| `writeBoolean` / `readBoolean` | `boolean` |

---

### C04 — 객체 직렬화 (ObjectInputStream / ObjectOutputStream)

> 객체를 바이트 스트림으로 변환(직렬화)하여 파일에 저장하고 복원(역직렬화)한다.

**Serializable 구현**

```java
class Board implements Serializable {
    private static final long serialVersionUID = 1L;  // 버전 관리용

    private int bno;
    private String title;
    private String content;
    private String writer;
    private Date date;
    // 생성자, getter/setter, toString 생략
}
```

**직렬화 — 객체 → 파일**

```java
FileOutputStream out = new FileOutputStream("경로/board.db");
ObjectOutputStream oout = new ObjectOutputStream(out);
oout.writeObject(board1);
oout.writeObject(board2);
oout.writeObject(board3);
oout.flush(); oout.close(); out.close();
```

**역직렬화 — 파일 → 객체**

```java
FileInputStream in = new FileInputStream("경로/board.db");
ObjectInputStream oin = new ObjectInputStream(in);

Board b1 = (Board) oin.readObject();   // Object → 타입 캐스팅 필수
Board b2 = (Board) oin.readObject();
Board b3 = (Board) oin.readObject();

// 데이터가 없는데 readObject() 호출 시 → EOFException 발생
oin.close(); in.close();
```

**주요 포인트**

| 항목 | 내용 |
|---|---|
| `implements Serializable` | 직렬화 대상 클래스에 필수 마커 인터페이스 |
| `serialVersionUID` | 클래스 버전 식별자, 불일치 시 역직렬화 실패 |
| `writeObject()` | 객체 → 바이트 스트림 |
| `readObject()` | 바이트 스트림 → `Object` (캐스팅 필요) |
| `EOFException` | 더 읽을 객체가 없을 때 발생 |
| `.db` 확장자 | 관례적 사용, 실제로는 바이트 파일 |

---

## Ch08 — JDBC (Java Database Connectivity)

---

### JDBC 기본 구조

JDBC는 Java에서 DBMS에 접속하여 SQL을 실행하는 표준 API.

**참조변수 3종**

| 변수 | 타입 | 역할 |
|---|---|---|
| `conn` | `Connection` | DBMS의 특정 DB에 연결되는 객체 |
| `pstmt` | `PreparedStatement` | SQL 쿼리 전송용 객체 |
| `rs` | `ResultSet` | SELECT 결과를 담는 객체 |

**JDBC 연결 순서**

```
1. Class.forName("com.mysql.cj.jdbc.Driver")  → 드라이버 로드
2. DriverManager.getConnection(url, id, pw)   → DB 연결 (Connection 반환)
3. conn.prepareStatement(sql)                 → SQL 준비
4. pstmt.executeUpdate() / pstmt.executeQuery() → SQL 실행
5. finally 블록에서 rs → pstmt → conn 순서로 close()
```

---

### C01 — DB 연결 (Connection)

```java
String id  = "root";
String pw  = "1234";
String url = "jdbc:mysql://localhost:3306/opendatadb";

Connection conn       = null;
PreparedStatement pstmt = null;
ResultSet rs          = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    System.out.println("Driver Loading Success...");
    conn = DriverManager.getConnection(url, id, pw);
    System.out.println("DB CONNECTED...");

} catch (Exception e) {
    e.printStackTrace();
} finally {
    try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
    try { conn.close();  } catch (Exception e) { e.printStackTrace(); }
}
```

---

### C02 — INSERT

`executeUpdate()` → 영향받은 행 수(int) 반환. 0이면 실패.

```java
pstmt = conn.prepareStatement("insert into tbl_a values(?,?)");
pstmt.setInt(1, Integer.parseInt(args[0]));  // ? 위치 바인딩 (1-based)
pstmt.setString(2, args[1]);

int result = pstmt.executeUpdate();
if (result > 0) System.out.println("INSERT 성공");
else            System.out.println("INSERT 실패");
```

---

### C03 — UPDATE

```java
pstmt = conn.prepareStatement("update tbl_a set name = ? where no = ?");
pstmt.setString(1, args[0]);
pstmt.setInt(2, Integer.parseInt(args[1]));

int result = pstmt.executeUpdate();
if (result > 0) System.out.println("UPDATE 성공");
else            System.out.println("UPDATE 실패");
```

---

### C04 — DELETE

```java
pstmt = conn.prepareStatement("delete from tbl_a where no = ?");
pstmt.setInt(1, Integer.parseInt(args[0]));

int result = pstmt.executeUpdate();
if (result > 0) System.out.println("DELETE 성공");
else            System.out.println("DELETE 실패");
```

---

### C05 — SELECT

`executeQuery()` → `ResultSet` 반환. `rs.next()`로 한 행씩 이동하며 `getXxx("컬럼명")`으로 값 추출.

```java
pstmt = conn.prepareStatement("select * from tbl_a");
rs = pstmt.executeQuery();

while (rs.next()) {
    System.out.print(rs.getInt("no") + ".");
    System.out.println(rs.getString("name"));
}
```

**finally에서 close 순서** — rs → pstmt → conn (열린 순서의 역순)

```java
finally {
    try { rs.close();    } catch (Exception e) { e.printStackTrace(); }
    try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
    try { conn.close();  } catch (Exception e) { e.printStackTrace(); }
}
```

| 메서드 | 용도 |
|---|---|
| `executeUpdate()` | INSERT / UPDATE / DELETE — 영향 행 수 반환 |
| `executeQuery()` | SELECT — `ResultSet` 반환 |
| `rs.next()` | 다음 행으로 이동 (없으면 `false`) |
| `rs.getInt("col")` | int 컬럼 값 추출 |
| `rs.getString("col")` | String 컬럼 값 추출 |

---

### C06 — DTO 패턴 + 오픈데이터 조회 (도시가스 충전소)

SELECT 결과를 DTO 객체에 담아 `List`로 관리하는 패턴.

**DTO 클래스 구조**

```java
class C06ChargeDto {
    private int    순번;
    private String 행정구역;
    private String 지사;
    private String 시설명;
    private int    우편번호;
    private String 주소;

    // 기본 생성자 + 모든인자 생성자 + getter/setter + toString 재정의
}
```

**SELECT → DTO 변환 → List 저장**

```java
pstmt = conn.prepareStatement("select * from tbl_charge");
rs = pstmt.executeQuery();

List<C06ChargeDto> list = new ArrayList();
C06ChargeDto dto = null;

while (rs.next()) {
    dto = new C06ChargeDto();
    dto.set순번(rs.getInt("순번"));
    dto.set행정구역(rs.getString("행정구역"));
    dto.set지사(rs.getString("지사"));
    dto.set시설명(rs.getString("시설명"));
    dto.set우편번호(rs.getInt("우편번호"));
    dto.set주소(rs.getString("주소"));
    list.add(dto);
}

list.forEach(System.out::println);
```

> DTO(Data Transfer Object): DB 컬럼을 필드로 매핑해 데이터를 이동시키는 객체. `toString()` 재정의로 출력 형식 고정.

---

### C07 — 오픈데이터 조회 (불법주정차 위반)

C06과 동일한 DTO 패턴, 다른 테이블·필드 구성.

```java
class C07ParkingDto {
    private String 위반구분;
    private String 위반일시;
    private String 위반장소;
    private String 과태료부과일자;
    private String 데이터기준일자;
    // 기본 생성자 + 모든인자 생성자 + getter/setter + toString
}

// 사용
pstmt = conn.prepareStatement("select * from tbl_parking");
rs = pstmt.executeQuery();

List<C07ParkingDto> list = new ArrayList();
while (rs.next()) {
    C07ParkingDto dto = new C07ParkingDto();
    dto.set위반구분(rs.getString("위반구분"));
    dto.set위반일시(rs.getString("위반일시"));
    dto.set위반장소(rs.getString("위반장소"));
    dto.set과태료부과일자(rs.getString("과태료부과일자"));
    dto.set데이터기준일자(rs.getString("데이터기준일자"));
    list.add(dto);
}
list.forEach(System.out::println);
```

---

### C08 — 트랜잭션 & Savepoint

JDBC에서 트랜잭션을 수동 제어. 기본은 `autoCommit=true`(각 SQL마다 자동 커밋).

```java
conn.setAutoCommit(false);  // TX 시작

pstmt = conn.prepareStatement("insert into tbl_a values(1,'a')");
pstmt.executeUpdate();

Savepoint sp1 = conn.setSavepoint("sp1");  // 저장점 설정

pstmt = conn.prepareStatement("insert into tbl_a values(2,'b')");
pstmt.executeUpdate();
pstmt = conn.prepareStatement("insert into tbl_a values(3,'c')");
pstmt.executeUpdate();
// ... 이후 중복 PK 등으로 예외 발생 시 catch 진입

conn.commit();  // 전체 성공 시 커밋
```

**예외 발생 시 롤백 처리**

```java
catch (Exception e) {
    e.printStackTrace();
    try {
        if (sp1 != null) conn.rollback(sp1);  // Savepoint까지 부분 롤백
        else             conn.rollback();      // 전체 롤백
        conn.commit();                         // 롤백 후 커밋
    } catch (Exception rollback) { rollback.printStackTrace(); }
}
```

**finally에서 autoCommit 복구**

```java
finally {
    try { conn.setAutoCommit(true); } catch (SQLException e) { e.printStackTrace(); }
    try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
    try { conn.close();  } catch (Exception e) { e.printStackTrace(); }
}
```

| 메서드 | 설명 |
|---|---|
| `conn.setAutoCommit(false)` | 수동 트랜잭션 모드 전환 |
| `conn.setSavepoint("이름")` | 현재 시점에 저장점 설정 |
| `conn.commit()` | 트랜잭션 확정 |
| `conn.rollback()` | 트랜잭션 전체 취소 |
| `conn.rollback(savepoint)` | 지정 저장점까지만 취소 |

> **주의**: `rollback()` 후 반드시 `commit()`을 호출해야 변경사항이 확정됨

---

## Ch09 — 소켓 통신 (Socket Communication)

### 개념

| 용어 | 설명 |
|------|------|
| `ServerSocket` | 서버 측 소켓. 특정 포트에서 클라이언트 접속을 대기 |
| `Socket` | 클라이언트 소켓. 서버에 연결 후 스트림으로 데이터 송수신 |
| `server.accept()` | 클라이언트 접속 대기 (블로킹). 연결되면 Socket 반환 |
| `DataOutputStream` | `writeUTF(String)` — 문자열 송신 |
| `DataInputStream` | `readUTF()` — 문자열 수신 |

---

### C01 — 단방향 통신 (서버 → 클라이언트)

서버가 클라이언트 접속 시 환영 메시지 1회 전송. `while(true)` 로 반복 접속 처리.

**Server**
```java
ServerSocket server = new ServerSocket(7000);
while(true) {
    Socket client = server.accept();                           // 접속 대기
    DataOutputStream dout = new DataOutputStream(client.getOutputStream());
    dout.writeUTF("[SERVER] WELCOME TO SERVER + " + new Date());
    dout.flush();
    dout.close(); client.close();
}
```

**Client**
```java
Socket server = new Socket("192.168.5.15", 7000);
DataInputStream din = new DataInputStream(server.getInputStream());
String recv = din.readUTF();
System.out.println("메시지 : " + recv);
din.close(); server.close();
```

---

### C02 — 양방향 채팅 (1:1 순차 방식)

서버가 먼저 전송 → 클라이언트 수신 후 응답. `"q"` 입력 시 종료.  
**단점**: 순차적 송수신 → 동시 송수신 불가 (Ch11에서 스레드로 해결)

**Server**
```java
Socket client = server.accept();
DataInputStream din  = new DataInputStream(client.getInputStream());
DataOutputStream dout = new DataOutputStream(client.getOutputStream());

while(true) {
    send = sc.nextLine();
    dout.writeUTF(send); dout.flush();        // 송신
    if(send.equals("q")) break;
    recv = din.readUTF();                     // 수신
    if(recv.equals("q")) break;
    System.out.println("[CLIENT] : " + recv);
}
```

**Client**
```java
Socket server = new Socket("192.168.5.15", 7000);

while(true) {
    recv = din.readUTF();                     // 수신
    if(recv.equals("q")) break;
    System.out.println("[SERVER] : " + recv);
    send = sc.nextLine();
    dout.writeUTF(send); dout.flush();        // 송신
    if(send.equals("q")) break;
}
```

| 메서드 | 설명 |
|--------|------|
| `dout.writeUTF(str)` | 문자열 송신 |
| `din.readUTF()` | 문자열 수신 (블로킹) |
| `EOFException` | 상대방이 연결을 끊었을 때 발생 |

---

## Ch10 — 스레드 (Thread)

### 개념

| 용어 | 설명 |
|------|------|
| **프로세스** | 실행 중인 프로그램 (독립 메모리) |
| **스레드** | 프로세스 내 실행 흐름 단위. 메모리 공유 |
| **멀티스레드** | 여러 작업을 동시에 실행 |
| `Thread.sleep(ms)` | 현재 스레드를 ms 밀리초 동안 대기 |
| `th.interrupt()` | 대기 중인 스레드를 깨워 `InterruptedException` 발생 |
| `th.join()` | 해당 스레드가 끝날 때까지 현재 스레드 대기 |

---

### C01 — 단일 스레드 순차 실행

```java
// TASK01 5회 완료 후 TASK02 5회 시작 (순차)
for(int i=0;i<5;i++) { System.out.println("TASK01"); Thread.sleep(500); }
for(int i=0;i<5;i++) { System.out.println("TASK02"); Thread.sleep(500); }
```

---

### C02 — 멀티스레드 생성 방법

**방법 1 — Runnable 인터페이스 구현**
```java
// Worker 클래스
public class C02Worker1 implements Runnable {
    @Override
    public void run() {
        for(int i=0;i<5;i++) {
            System.out.println("TASK01...");
            Thread.sleep(500);
        }
    }
}

// Main에서 실행
C02Worker1 w1 = new C02Worker1();
Thread th1 = new Thread(w1);
th1.start();
```

**방법 2 — Thread 클래스 익명 구현**
```java
new Thread() {
    @Override
    public void run() {
        for(int i=0;i<5;i++) {
            System.out.println("TASK03...");
            Thread.sleep(500);
        }
    }
}.start();
```

---

### C03 — Swing GUI + 스레드 (시작/중지 버튼)

GUI 이벤트 스레드(EDT)와 별도 Worker 스레드를 분리.  
버튼 클릭으로 스레드 시작/중단 제어.

```java
// 시작 버튼 → 스레드 생성 및 실행
if(th1 == null) {
    C03Worker1 w1 = new C03Worker1(this);  // GUI 참조 전달
    th1 = new Thread(w1);
    th1.start();
}

// 중지 버튼 → interrupt()로 스레드 종료
if(th1 != null) {
    th1.interrupt();
    th1 = null;
}
```

**Worker — InterruptedException 처리**
```java
public void run() {
    try {
        for(int i=0;;i++) {
            gui.area1.append("TASK01..." + i + "\n");  // JTextArea에 출력
            Thread.sleep(500);
        }
    } catch(InterruptedException e) {
        System.out.println("[EXCEPTION] WORKER01 THREAD INTERRUPTED..");
    }
}
```

| 구성요소 | 역할 |
|----------|------|
| `C03GUI` | JFrame 기반 GUI. 버튼 4개(시작×2, 중지×2), JTextArea×2 |
| `C03Worker1/2` | Runnable 구현. GUI 참조로 JTextArea에 직접 출력 |
| `th.interrupt()` | sleep 중인 스레드에 InterruptedException 발생시켜 종료 |

---

### C04 — 스레드 동기화 문제 (경쟁 조건)

여러 스레드가 공유 변수 `counter++` 을 동시 접근하면 결과가 불일치.

```java
// 문제 코드 (주석 처리됨 — 교육용)
private static int counter = 0;

// 4개 스레드가 counter++ 을 각각 100000번 수행
// → 예상값: 400000, 실제값: 불규칙 (Race Condition)
```

---

### C05 — synchronized + wait/notifyAll (동기화 해결)

```java
private static final Object Lock = new Object();

@Override
public void run() {
    for(int i = 0; i < 100000; i++) {
        synchronized(Lock) {           // Lock 획득 (다른 스레드 대기)
            counter++;
            Lock.notifyAll();          // 대기 중인 스레드에 알림
            Lock.wait(5);              // Lock 해제 후 5ms 대기
        }
    }
}
```

**`join()`으로 메인 스레드가 모든 작업 스레드 완료 대기**
```java
thread1.join();
thread2.join();
thread3.join();
thread4.join();
System.out.println("Final value: " + incrementThread1.getCounter());
```

| 메서드 | 설명 |
|--------|------|
| `synchronized(obj)` | 블록 진입 시 obj 락 획득, 나올 때 해제 |
| `obj.wait(ms)` | 락 해제 후 ms동안 대기. 0이면 무한 대기 |
| `obj.notifyAll()` | 해당 obj를 기다리는 모든 스레드 깨움 |
| `th.join()` | th 스레드 종료까지 현재 스레드 블로킹 |

---

## Ch11 — 멀티스레드 소켓 통신

### 개념

Ch09 C02의 순차적 1:1 채팅 한계를 스레드로 해결.  
**수신 스레드**와 **송신 스레드**를 분리하여 동시 송수신 구현.

```
ServerMain
├── ServerRecvThread  (클라이언트로부터 수신)
└── ServerSendThread  (클라이언트로 송신)

ClientMain
├── ClientRecvThread  (서버로부터 수신)
└── ClientSendThread  (서버로 송신)
```

---

### ServerMain / ClientMain — 스레드 분리 구조

```java
// ServerMain
ServerRecvThread recvThread = new ServerRecvThread(din, server);
ServerSendThread sendThread = new ServerSendThread(dout, server);
Thread th1 = new Thread(recvThread);
Thread th2 = new Thread(sendThread);
th1.start();
th2.start();
th1.join();
th2.join();
```

```java
// ClientMain (동일 구조)
ClientRecvThread recvThread = new ClientRecvThread(din, server);
ClientSendThread sendThread = new ClientSendThread(dout, server);
```

---

### RecvThread — 수신 전담

```java
// ServerRecvThread (ClientRecvThread도 동일 구조)
public void run() {
    while(true) {
        try {
            recv = din.readUTF();
        } catch(EOFException e) {
            System.out.println("[ERROR] 클라이언트가 연결을 끊었습니다."); break;
        } catch(Exception e) {
            System.out.println("[ERROR] 기타 예외발생 : " + e.getCause()); break;
        }
        if(recv.equals("q")) { server.close(); break; }
        System.out.println("\n[CLIENT] : " + recv);
    }
}
```

---

### SendThread — 송신 전담

```java
// ServerSendThread (ClientSendThread도 동일 구조)
public void run() {
    while(true) {
        send = sc.nextLine();
        if(send.equals("q")) {
            dout.writeUTF(send); dout.flush();
            server.close(); break;
        }
        dout.writeUTF(send); dout.flush();
    }
}
```

---

### Ch09 vs Ch11 비교

| 항목 | Ch09 C02 (단일 스레드) | Ch11 (멀티스레드) |
|------|----------------------|------------------|
| 송수신 방식 | 순차적 (번갈아가며) | 동시 (독립 스레드) |
| 먼저 보내는 쪽 | 서버 먼저 전송 | 누구든 먼저 전송 가능 |
| 구현 복잡도 | 단순 | Recv/Send 스레드 분리 |
| 실용성 | 교육용 | 실제 채팅과 유사 |

---

## Ch12 — Swing GUI 채팅 (1:1)

### 개념

Ch11(터미널 채팅)에 Swing GUI를 결합. 수신은 별도 스레드, 송신은 엔터키 이벤트로 처리.

```
ServerUI (Sgui)                   ClientUI (Cgui)
├── JTextArea (채팅 내용 표시)     ├── JTextArea
├── JTextField (메시지 입력)       ├── JTextField
└── ServerRecvThread              └── ClientRecvThread
    └── 수신 → area.append()          └── 수신 → area.append()
```

---

### ServerUI — 소켓 + GUI 초기화

```java
// 생성자 안에서 소켓 연결 처리
ServerSocket server = new ServerSocket(7000);
Socket client = server.accept();
din  = new DataInputStream(client.getInputStream());
dout = new DataOutputStream(client.getOutputStream());

// 수신 스레드만 분리
ServerRecvThread recvThread = new ServerRecvThread(din, this);
new Thread(recvThread).start();
```

---

### 엔터키 → 송신 (KeyListener)

```java
@Override
public void keyPressed(KeyEvent e) {
    if(e.getKeyCode() == 10) {                  // 엔터키
        area.append("[SERVER] : " + txt1.getText() + "\n");
        dout.writeUTF(txt1.getText());
        dout.flush();
        txt1.setText("");
    }
}
```

---

### ServerRecvThread — 수신 → GUI 갱신

```java
public void run() {
    while(true) {
        try {
            recv = din.readUTF();
        } catch(EOFException e) { break; }
         catch(Exception e)    { break; }
        if(recv.equals("q")) break;
        sgui.area.append("[CLIENT] : " + recv + "\n");
    }
    System.exit(-1);
}
```

| 항목 | Ch11 (터미널) | Ch12 (GUI) |
|------|-------------|-----------|
| 입력 방법 | `Scanner.nextLine()` | `JTextField` + 엔터키 이벤트 |
| 출력 방법 | `System.out.println()` | `JTextArea.append()` |
| 송신 스레드 | 별도 SendThread | EDT(이벤트 스레드)에서 직접 |

---

## Ch13 — 다중 클라이언트 채팅 서버 (N:N)

### 개념

1:1 → N:N 으로 확장. 서버가 모든 클라이언트 스트림을 Map으로 관리하고 broadCast로 전체 전달.

```
ServerUI
└── ServerBackground (서버 백그라운드 처리)
    ├── ServerSocket (포트 5555)
    ├── ClientList: Map<String닉네임, DataOutputStream>
    ├── addClient()    — 접속 등록 + 전체 알림
    ├── removeClient() — 퇴장 처리
    └── broadCast()    — 전체 or 자신 제외 전송

클라이언트 접속마다 ServerRecvThread 생성 (1스레드 per 클라이언트)
```

---

### ServerBackground — 핵심 로직

```java
// 클라이언트 목록 (동기화 처리)
Map<String, DataOutputStream> ClientList = new HashMap<>();
Collections.synchronizedMap(ClientList);

// 접속 루프
while(true) {
    client = server.accept();
    ServerRecvThread recv = new ServerRecvThread(client, this, gui);
    new Thread(recv).start();      // 클라이언트마다 스레드 1개
}

// 전체 브로드캐스트
public void broadCast(String msg) {
    for(String key : ClientList.keySet()) {
        ClientList.get(key).writeUTF(msg);
        ClientList.get(key).flush();
    }
}

// 자신 제외 브로드캐스트
public void broadCast(String nick, String msg) {
    for(String tmpnick : ClientList.keySet()) {
        if(!nick.equals(tmpnick)) {
            ClientList.get(tmpnick).writeUTF(msg);
        }
    }
}
```

---

### ServerRecvThread — 닉네임 등록 + 수신 처리

```java
public ServerRecvThread(Socket client, ServerBackground background, ServerUI gui) {
    Din  = new DataInputStream(client.getInputStream());
    Dout = new DataOutputStream(client.getOutputStream());
    nick = Din.readUTF();                       // 첫 메시지 = 닉네임
    background.addClient(nick, Dout);           // 클라이언트 목록 등록
}

public void run() {
    while(true) {
        recv = Din.readUTF();
        background.broadCast(nick, recv);       // 자신 제외 전파
        gui.area.append(recv + "\n");
        gui.area.setCaretPosition(gui.area.getDocument().getLength()); // 스크롤 하단
    }
    // 예외 발생 시
    background.removeClient(nick);              // 퇴장 처리
}
```

---

### ClientUI — 닉네임 입력 + 접속

```java
// main
String nick = sc.nextLine();
new ClientUI(nick);

// 생성자
client = new Socket("192.168.5.50", 5555);
new DataOutputStream(client.getOutputStream()).writeUTF(nick);  // 닉네임 먼저 전송
ClientRecvThread recv = new ClientRecvThread(client, this);
new Thread(recv).start();

// 엔터키 → 송신
Dout.writeUTF("[" + nick + "] : " + txt.getText());
```

| 항목 | Ch12 (1:1) | Ch13 (N:N) |
|------|-----------|-----------|
| 동시 접속 | 1명 | 무제한 |
| 클라이언트 관리 | 없음 | `Map<닉네임, OutputStream>` |
| 메시지 전달 | 상대방 1명 | broadCast (전체/자신 제외) |
| 스레드 수 | 서버 1개 | 클라이언트 수만큼 생성 |

---

## Ch14 — 리플렉션 (Reflection)

### 개념

실행 중(런타임)에 클래스 정보를 동적으로 조회·조작하는 API.  
`java.lang.reflect` 패키지 사용. 프레임워크·라이브러리 내부에서 주로 활용.

| 클래스 | 역할 |
|--------|------|
| `Class` | 클래스 메타데이터 (이름, 필드, 메서드, 생성자) |
| `Field` | 필드 정보 조회 및 값 읽기/수정 |
| `Method` | 메서드 정보 조회 및 호출 |
| `Constructor` | 생성자 정보 조회 및 객체 생성 |

---

### C01 — 클래스 정보 조회

```java
// 문자열로 클래스 로딩
Class<?> clazz = Class.forName("java.lang.String");

// 필드 목록
Field[] fields = clazz.getDeclaredFields();

// 생성자 목록
Constructor[] constructors = clazz.getDeclaredConstructors();

// 메서드 목록
Method[] methods = clazz.getDeclaredMethods();
for(Method m : methods) System.out.println(m);
```

---

### C02 — 생성자·메서드·필드 동적 호출

```java
Class<?> clazz = Class.forName("Ch14.Simple");

// 생성자 호출 (with reflect)
Constructor[] cons = clazz.getConstructors();
Object ob2 = cons[1].newInstance("홍길동", 30, "대구");

// 메서드 호출 (with reflect)
Method setName = clazz.getDeclaredMethod("setName", String.class);
Method getName = clazz.getDeclaredMethod("getName", null);
setName.invoke(ob1, "남길동");
getName.invoke(ob1, null);

// 필드 직접 접근 (private 아닌 필드)
Field addr = clazz.getDeclaredField("addr");
addr.set(ob2, "창원");

// 범용 객체 생성 유틸리티
public static Object genObject(Class<?> clazz) throws Exception {
    Constructor con = clazz.getDeclaredConstructor(null);
    return con.newInstance(null);   // 기본 생성자로 객체 생성
}
// 사용
genObject(Class.forName("Ch14.Simple"));
genObject(Class.forName("Ch11.ServerMain"));
```

| 메서드 | 설명 |
|--------|------|
| `Class.forName("패키지.클래스")` | 런타임에 클래스 로딩 |
| `clazz.getConstructors()` | public 생성자 목록 |
| `clazz.getDeclaredFields()` | 모든 필드 (private 포함) |
| `clazz.getDeclaredMethod(이름, 파라미터타입...)` | 메서드 탐색 |
| `method.invoke(obj, args...)` | 메서드 호출 |
| `field.set(obj, value)` | 필드 값 설정 |
| `constructor.newInstance(args...)` | 객체 생성 |

> **주의**: 리플렉션은 성능 오버헤드 + 컴파일 타임 타입 안전성 미보장. 가능하면 정적 방식 사용 권장.

---

## Ch15 — 디자인 패턴 (Design Pattern)

### 개요

| 분류 | 패턴 | 핵심 한 줄 |
|------|------|-----------|
| **생성** | 싱글톤 | 인스턴스 1개만 |
| **생성** | 빌더 | 체이닝으로 복잡한 객체 조립 |
| **생성** | 프로토타입 | clone()으로 복제 |
| **생성** | 팩토리 메서드 | 서브클래스가 객체 생성 결정 |
| **생성** | 추상 팩토리 | 관련 객체 세트를 한 번에 생성 |
| **구조** | 어댑터 | 호환 안 되는 인터페이스 연결 |
| **구조** | 데코레이터 | 기존 객체를 감싸서 기능 추가 |
| **구조** | 프록시 | 실제 객체 앞에 대리인 배치 |
| **행위** | 옵저버 | 상태 변화 → 구독자 자동 알림 |
| **행위** | 전략 | 알고리즘을 런타임에 교체 |
| **행위** | 커맨드 | 요청을 객체로 캡슐화 |

---

### C01 생성 패턴

#### 싱글톤 (Singleton)
> 비유: 회사 사장 — 조직에 단 한 명

```java
class Singleton {
    private static Singleton instance;
    private Singleton() {}          // 외부 생성 차단

    public static Singleton getInstance() {
        if(instance == null) instance = new Singleton();
        return instance;
    }
}

Singleton s1 = Singleton.getInstance();
Singleton s2 = Singleton.getInstance();
System.out.println(s1 == s2);   // true (동일 객체)
```

---

#### 빌더 (Builder)
> 비유: 햄버거 주문 — 옵션을 골라서 조립

```java
Car car = new Car.Builder("V6", 4)   // 필수 파라미터
        .color("red")                 // 선택 옵션
        .sunroof(true)
        .build();                     // 최종 객체 생성

// 내부 구조
public static class Builder {
    private final String engine;      // 필수
    private boolean sunroof = false;  // 선택 (기본값)

    public Builder sunroof(boolean v) { this.sunroof = v; return this; }  // 체이닝
    public Car build() { return new Car(this); }
}
```

---

#### 프로토타입 (Prototype)
> 비유: 문서 복사 — 원본 두고 사본 만들기

```java
class Computer implements Cloneable {
    String cpu;
    @Override
    protected Computer clone() throws CloneNotSupportedException {
        return (Computer) super.clone();   // 얕은 복사
    }
}

Computer original = new Computer("Intel i7");
Computer copy = original.clone();
copy.cpu = "AMD Ryzen";   // 복사본만 변경, 원본 유지
```

---

#### 팩토리 메서드 (Factory Method)
> 비유: 동물 공장 — 개공장→개, 고양이공장→고양이

```java
interface AnimalFactory { Animal createAnimal(); }

class DogFactory implements AnimalFactory {
    public Animal createAnimal() { return new Dog(); }
}
class CatFactory implements AnimalFactory {
    public Animal createAnimal() { return new Cat(); }
}

AnimalFactory factory = new DogFactory();
factory.createAnimal().sound();  // 멍멍
```

---

#### 추상 팩토리 (Abstract Factory)
> 비유: OS별 GUI 세트 — Windows 세트 / Mac 세트

```java
interface GUIFactory {
    Button   createButton();
    CheckBox createCheckBox();
}
class WinFactory implements GUIFactory { ... }
class MacFactory implements GUIFactory { ... }

// 공장 한 줄만 바꾸면 모든 UI가 일관되게 변경
GUIFactory factory = new WinFactory();  // ← MacFactory()로만 바꾸면 됨
factory.createButton().click();
factory.createCheckBox().check();
```

| 비교 | 팩토리 메서드 | 추상 팩토리 |
|------|-------------|-----------|
| 생성 단위 | 객체 1개 | 관련 객체 세트 |
| 확장 방향 | 서브클래스(공장) 추가 | 공장 인터페이스 확장 |

---

### C02 구조 패턴

#### 어댑터 (Adapter)
> 비유: 220V→110V 변환 어댑터

```java
interface Socket220V { void plug220(); }  // 우리 시스템 인터페이스
class Device110V { public void plug110() {...} }  // 수정 불가 외부 클래스

class VoltageAdapter implements Socket220V {
    private Device110V device;
    public void plug220() {
        device.plug110();   // 220V 요청 → 110V 호출로 변환
    }
}

Socket220V socket = new VoltageAdapter(new Device110V());
socket.plug220();   // 기존 인터페이스 그대로 사용
```

---

#### 데코레이터 (Decorator)
> 비유: 기본 커피 → 우유 추가 → 시럽 추가 (계속 감싸기)

```java
interface Coffee { String desc(); int cost(); }
class BasicCoffee implements Coffee { ... }           // 기본 구현

class MilkDecorator implements Coffee {
    private Coffee coffee;
    public MilkDecorator(Coffee c) { this.coffee = c; }
    public String desc() { return coffee.desc() + " + 우유"; }
    public int cost()    { return coffee.cost() + 500; }
}

// 중첩 감싸기 가능
Coffee c = new SyrupDecorator(new MilkDecorator(new BasicCoffee()));
// → "커피 + 우유 + 시럽 : 4200원"
```

---

#### 프록시 (Proxy)
> 비유: 비서 (실제 객체 앞단에서 접근 제어)

```java
class ProxyImage implements Image {
    private RealImage realImage;   // 처음엔 null (지연 로딩)
    private String fileName;

    public void show() {
        if(realImage == null) realImage = new RealImage(fileName);  // 첫 호출 시만 로딩
        realImage.show();
    }
}

Image img = new ProxyImage("photo.jpg");  // 아직 로딩 X
img.show();  // 이때 로딩 발생
img.show();  // 재로딩 없음 (캐시)
```

---

### C03 행위 패턴

#### 옵저버 (Observer)
> 비유: 유튜브 구독 — 영상 올리면 구독자 모두에게 알림

```java
class Subject {
    private List<Observer> observers = new ArrayList<>();
    private int state;

    public void setState(int state) {
        this.state = state;
        notifyObservers();              // 상태 변화 → 전체 알림
    }
    public void attach(Observer o) { observers.add(o); }
    private void notifyObservers() {
        for(Observer o : observers) o.update();
    }
}

// 옵저버들 (각자 다른 형식으로 출력)
new BinaryObserver(subject);   // 2진수 출력
new OctalObserver(subject);    // 8진수 출력
new HexaObserver(subject);     // 16진수 출력
subject.setState(10);          // → 세 옵저버 모두 update() 호출
```

---

#### 전략 (Strategy)
> 비유: 결제 방식 선택 — 카드/현금/카카오페이 동적 교체

```java
interface Strategy { int execute(int a, int b); }
class AddStrategy      implements Strategy { return a + b; }
class SubtractStrategy implements Strategy { return a - b; }
class MultiplyStrategy implements Strategy { return a * b; }

class Context {
    private Strategy strategy;
    public Context(Strategy s) { this.strategy = s; }
    public int executeStrategy(int a, int b) { return strategy.execute(a, b); }
}

Context ctx = new Context(new AddStrategy());
ctx.executeStrategy(10, 5);  // 15

ctx = new Context(new MultiplyStrategy());
ctx.executeStrategy(10, 5);  // 50
```

---

#### 커맨드 (Command)
> 비유: TV 리모컨 버튼 — 명령을 캡슐화해서 전달

```java
interface Command { void execute(); }

class TV { void turnOn(){...} void turnOff(){...} }   // Receiver

class TurnOnCommand implements Command {
    private TV tv;
    public void execute() { tv.turnOn(); }
}

class RemoteControl {           // Invoker (호출자)
    private Command command;
    public void setCommand(Command c) { this.command = c; }
    public void pressButton()         { command.execute(); }
}

RemoteControl remote = new RemoteControl();
remote.setCommand(new TurnOnCommand(tv));
remote.pressButton();   // TV가 켜졌습니다
```

| 역할 | 클래스 | 설명 |
|------|--------|------|
| Command | `Command` 인터페이스 | 실행 계약 |
| Receiver | `TV` | 실제 동작 수행 |
| ConcreteCommand | `TurnOnCommand` | 명령 캡슐화 |
| Invoker | `RemoteControl` | 명령 실행 요청 |

---

## Ch16 — 람다(Lambda) & 메서드 참조(Method Reference)

### 핵심 개념

| 개념 | 설명 |
|------|------|
| **람다식** | 익명 함수를 간결하게 표현 — `(매개변수) -> { 본문 }` |
| **함수형 인터페이스** | 추상 메서드가 1개뿐인 인터페이스 (`@FunctionalInterface`) |
| **메서드 참조** | 람다를 더 짧게 쓰는 문법 — `클래스::메서드` |

---

### C01 — 람다로 List 정렬 & 순회

```java
List<Person> list = new ArrayList<>();
list.add(new Person("홍길동", 55, "대구"));
list.add(new Person("남길동", 45, "창원"));
list.add(new Person("서길동", 35, "울산"));

// 나이 오름차순 정렬 (람다)
list.sort((a, b) -> { return a.getAge() - b.getAge(); });

// forEach 순회 — 4가지 동등한 표현
list.forEach((el) -> { System.out.println(el); }); // 완전형
list.forEach(el -> { System.out.println(el); });    // 매개변수 괄호 생략
list.forEach(el -> System.out.println(el));         // 중괄호 생략
list.forEach(System.out::println);                  // 메서드 참조
```

**람다 축약 규칙**

| 조건 | 생략 가능 항목 |
|------|----------------|
| 매개변수 1개 | `( )` 괄호 |
| 본문이 한 줄 | `{ }` 중괄호 + `return` |
| 본문이 기존 메서드 호출 1번 | `클래스::메서드` 메서드 참조로 대체 |

---

### C02 — 함수형 인터페이스 직접 정의

```java
// 추상 메서드 1개 → 함수형 인터페이스
interface Printer {
    void print(String name);
}

// 람다로 구현
Printer printer = (name) -> { System.out.println("01 " + name); };
printer.print("Hello World");

// 메서드 참조로 구현 (System.out::println)
Printer printer2 = System.out::println;
printer2.print("Hello World");
```

> 반환 타입이 있는 메서드도 동일한 패턴으로 구현 가능  
> (`String print(String name)` → `return "02 " + name;`)

---

### C03 — 함수형 인터페이스 활용 예제 (사칙연산)

```java
interface Calculator {
    int calculate(int num1, int num2);
}

Calculator add = (a, b) -> { return a + b; };
Calculator sub = (a, b) -> { return (a > b) ? a - b : b - a; };
Calculator mul = (a, b) -> { return a * b; };
Calculator div = (a, b) -> { return a / b; };

System.out.println(add.calculate(10, 20));  // 30
System.out.println(sub.calculate(30, 10));  // 20
System.out.println(mul.calculate(10, 20));  // 200
System.out.println(div.calculate(100, 5));  // 20
```

---

### C04 — 메서드 참조 4가지 유형

```java
// (1) 정적 메서드 참조 — 클래스::정적메서드
StrToInt t1 = s -> Integer.parseInt(s);   // 람다
StrToInt t2 = Integer::parseInt;          // 정적 메서드 참조
StrToInt t3 = C04MethodReferenceMain::toLength; // 직접 정의한 정적 메서드

// (2) 인스턴스 메서드 참조 (특정 인스턴스) — 인스턴스::메서드
StrConsumer t4 = s -> System.out.println(s);
StrConsumer t5 = System.out::println;     // System.out 인스턴스의 println

// (2) 인스턴스 메서드 참조 (임의 인스턴스) — 클래스::인스턴스메서드
StrConsumer t6 = C04Person::print;        // static void print(String s)

// (3) 인스턴스 메서드 참조 (임의 객체, 비정적) — 클래스::인스턴스메서드
StrToStr t7 = s -> { return s.toUpperCase(); };
StrToStr t8 = String::toUpperCase;        // 호출 대상 자체가 매개변수

// (4) 생성자 참조 — 클래스::new
PersonFactory  t9  = () -> { return new C04Person(); };
PersonFactory  t10 = C04Person::new;                   // 기본 생성자
PersonFactory2 t11 = C04Person::new;                   // 인자 있는 생성자

// 제네릭 컬렉션도 동일하게 적용
interface ListFactory { ArrayList<String> create(); }

ListFactory t12 = () -> { return new ArrayList<>(); }; // 람다
ListFactory t13 = ArrayList::new;                      // 생성자 참조
```

**메서드 참조 유형 정리**

| 유형 | 문법 | 예시 |
|------|------|------|
| 정적 메서드 참조 | `클래스::정적메서드` | `Integer::parseInt` |
| 특정 인스턴스 메서드 참조 | `인스턴스::메서드` | `System.out::println` |
| 임의 인스턴스 메서드 참조 | `클래스::인스턴스메서드` | `String::toUpperCase` |
| 생성자 참조 | `클래스::new` | `C04Person::new` |

---

### C05 — 클로저(Closure) 기본

> 람다가 자신이 선언된 **외부 스코프의 변수를 캡처(capture)** 하는 것

```java
// (1) 지역 변수 캡처 — effectively final
String str = "Hello?";
Greeter t1 = () -> { return str; };   // str 캡처
System.out.println(t1.say());         // Hello?

// (2) 기본형 변수 캡처 — 변경 시 컴파일 에러
int n = 100;
Greeter t2 = () -> { return "2." + n; };  // n → 암묵적 final
// n = 200;  ← 이 줄이 있으면 컴파일 에러
System.out.println(t2.say());

// (3) 메서드가 람다를 반환 → 클로저
private static Greeter makeGreeter(String name) {
    return () -> { return "Closure : " + name; };  // name 캡처
}

Greeter t3 = makeGreeter("hihi");
Greeter t4 = makeGreeter("hello hello");
System.out.println(t3.say());  // Closure : hihi
System.out.println(t4.say());  // Closure : hello hello
```

**핵심 규칙**

| 규칙 | 설명 |
|------|------|
| effectively final | 람다가 캡처한 지역 변수는 이후 값 변경 불가 |
| 각 람다는 독립 | `makeGreeter` 호출마다 `name`이 별도로 캡처됨 |

---

### C06 — 클로저 가변 상태 패턴

> 지역 변수는 final 제약이 있지만 **배열·인스턴스·static 변수**로 우회 가능

```java
// (1) 배열 트릭 — 참조(배열)는 final, 내용은 변경 가능
int[] n = {0};
Task addOne = () -> { n[0]++; };
addOne.run(); addOne.run(); addOne.run(); addOne.run();
System.out.println("n[0] : " + n[0]);  // 4

// (2) 인스턴스 변수 — final 제약 없음
Simple ob = new Simple();
Task addOne2 = () -> { ob.n++; };
addOne2.run(); // × 5
System.out.println(ob);  // Simple [n=5]

// (3) static 변수 — final 제약 없음
Task addOne3 = () -> { C06ClosureBasic.n++; };
addOne3.run(); // × 5
System.out.println(C06ClosureBasic.n);  // 5

// (4) 가변 클로저 — 호출마다 고유 상태 유지
private static TickBox makeTicker(int start) {
    int[] n = {start};        // 람다가 캡처할 개별 공간
    return () -> n[0]++;      // 현재값 반환 후 +1
}

TickBox ticker1 = makeTicker(10);
ticker1.tick(); // 10, 11, 12, 13, 14, 15

TickBox ticker2 = makeTicker(100);
ticker2.tick(); // 100, 101, 102 ... (ticker1과 독립)
```

**가변 상태 우회 방법 비교**

| 방법 | 특징 |
|------|------|
| `int[] n = {0}` 배열 트릭 | 지역 변수 final 제약 우회, 람다별 독립 공간 |
| 인스턴스 변수 (`ob.n`) | 객체 공유 — 여러 람다가 같은 값 참조 |
| `static` 변수 | 클래스 전역 공유 |

---

## Ch17 - 스트림 (Stream)

스트림은 Java 8에서 도입된 기능으로 컬렉션 데이터를 선언형으로 처리하는 파이프라인 방식의 API다.  
중간 연산은 지연(lazy) 평가되며, 최종 연산이 호출될 때 비로소 실행된다.

---

### 스트림 구조

```
컬렉션 → .stream() → [중간 연산...] → 최종 연산
```

---

### 중간 연산 (Intermediate Operations)

| 메서드 | 설명 |
|--------|------|
| `filter(Predicate)` | 조건에 맞는 요소만 통과 ★ |
| `map(Function)` | 요소를 다른 형태로 변환 ★ |
| `flatMap(Function)` | 각 요소를 스트림으로 변환 후 하나의 스트림으로 평면화 |
| `distinct()` | 중복 제거 (equals/hashCode 기준) |
| `sorted()` / `sorted(Comparator)` | 자연 순서 또는 사용자 지정 순서로 정렬 |
| `limit(n)` | 앞에서 n개만 통과 |
| `skip(n)` | 앞 n개 건너뛰기 |

---

### filter / map

```java
List<Integer> li1 = Arrays.asList(1, 2, 3, 4, 5);

// filter: 짝수만
List<Integer> li2 = li1.stream()
    .filter(n -> n % 2 == 0)
    .collect(Collectors.toList());   // [2, 4]

// filter + map: 홀수를 제곱으로
List<Integer> li3 = li1.stream()
    .filter(n -> n % 2 == 1)        // 1, 3, 5
    .map(n -> n * n)                // 1, 9, 25
    .collect(Collectors.toList());

// 객체 필드 추출
List<Integer> ages = persons.stream()
    .map(Person::getAge)
    .collect(Collectors.toList());

// 객체 타입 변환 (Person → Employee)
List<Employee> employees = persons.stream()
    .map(Employee::new)
    .collect(Collectors.toList());
```

---

### flatMap - 중첩 컬렉션 평탄화

```
map     : 1:1 변환 (양파 → 양파)
flatMap : 1:N 변환 후 하나로 합침 (양파 → 조각들 → 한 바구니)
```

```java
// List<List<Integer>> → List<Integer>
List<List<Integer>> numbers = Arrays.asList(
    Arrays.asList(1, 2, 3),
    Arrays.asList(4, 5, 6)
);
List<Integer> flat = numbers.stream()
    .flatMap(List::stream)
    .collect(Collectors.toList());   // [1,2,3,4,5,6]

// 문장 → 단어 분리
List<String> sentences = Arrays.asList("Hello World", "Java is fun");
List<String> words = sentences.stream()
    .flatMap(s -> Arrays.stream(s.split(" ")))
    .collect(Collectors.toList());   // [Hello, World, Java, is, fun]
```

---

### distinct - 중복 제거

```java
List<Integer> nums = Arrays.asList(1, 2, 2, 3, 3, 3);
List<Integer> result = nums.stream()
    .distinct()
    .collect(Collectors.toList());   // [1, 2, 3]
```

> 객체에 `distinct()` 적용 시 `equals()` / `hashCode()` 가 반드시 정의되어 있어야 한다.

---

### sorted - 정렬

```java
// 오름차순 (자연 순서)
nums.stream().sorted()

// 내림차순
nums.stream().sorted(Comparator.reverseOrder())

// 람다 Comparator
nums.stream().sorted((a, b) -> b - a)

// 객체 필드 기준 정렬
products.stream()
    .sorted(Comparator.comparingInt((Product p) -> p.price))

// 다중 정렬 (가격 → 이름순)
products.stream()
    .sorted(Comparator
        .comparingInt((Product p) -> p.price)
        .thenComparing(p -> p.name))
```

---

### limit / skip

```java
// 앞에서 3개만
nums.stream().limit(3)

// 앞 2개 건너뛰기
nums.stream().skip(2)

// 페이지네이션 (page: 1부터, pageSize: 3)
list.stream()
    .skip((long)(page - 1) * pageSize)
    .limit(pageSize)
    .collect(Collectors.toList());

// 무한 스트림 종료
Stream.iterate(0, n -> n + 2)
    .limit(5)
    .collect(Collectors.toList());   // [0, 2, 4, 6, 8]
```

---

### 최종 연산 (Terminal Operations)

| 메서드 | 반환 | 설명 |
|--------|------|------|
| `forEach(Consumer)` | void | 각 요소 반복 처리 ★ |
| `collect(Collector)` | T | 컬렉션으로 수집 ★ |
| `reduce(BinaryOperator)` | `Optional<T>` | 누적해서 하나로 줄이기 ★ |
| `count()` | long | 개수 |
| `min(Comparator)` | `Optional<T>` | 최솟값 |
| `max(Comparator)` | `Optional<T>` | 최댓값 |
| `anyMatch(Predicate)` | boolean | 하나라도 조건 만족하면 true |
| `allMatch(Predicate)` | boolean | 모두 조건 만족하면 true |
| `noneMatch(Predicate)` | boolean | 모두 조건 불만족하면 true |
| `findFirst()` | `Optional<T>` | 첫 번째 요소 |
| `findAny()` | `Optional<T>` | 임의의 요소 |

```java
List<String> names = Arrays.asList("John", "Jane", "Mike", "Jane", "Tom");
List<Integer> nums = Arrays.asList(5, 2, 8, 1, 4);

// forEach
names.stream().forEach(System.out::println);

// collect - toList / toSet / joining / groupingBy
List<String> list      = names.stream().collect(Collectors.toList());
Set<String>  set       = names.stream().collect(Collectors.toSet());
String       joined    = names.stream().collect(Collectors.joining(", "));
Map<Integer, List<String>> byLen = names.stream()
    .collect(Collectors.groupingBy(String::length));

// reduce
Optional<Integer> sumOpt = nums.stream().reduce((a, b) -> a + b);
int sumWithSeed = nums.stream().reduce(0, (a, b) -> a + b);   // 시드 제공 시 Optional 아님

// count
long jCount = names.stream().filter(s -> s.startsWith("J")).count();

// min / max
Optional<Integer> minV = nums.stream().min(Comparator.naturalOrder());
Optional<String>  longest = names.stream().max(Comparator.comparingInt(String::length));

// anyMatch / allMatch / noneMatch
boolean hasEven     = nums.stream().anyMatch(n -> n % 2 == 0);
boolean allPositive = nums.stream().allMatch(n -> n > 0);
boolean noneNeg     = nums.stream().noneMatch(n -> n < 0);

// findFirst
Optional<String> first = names.stream().filter(s -> s.startsWith("J")).findFirst();
```

---

### 종합 예제 - 직원 데이터 처리

```java
// IT 부서 직원 이름순 정렬
List<String> itNames = emps.stream()
    .filter(p -> p.dept.equals("IT"))
    .map(p -> p.name)
    .sorted()
    .collect(Collectors.toList());

// 부서별 평균 연봉
Map<String, Double> deptAvg = emps.stream()
    .collect(Collectors.groupingBy(
        p -> p.dept,
        Collectors.averagingInt(p -> p.salary)
    ));

// 연봉 상위 3명
List<String> top3 = emps.stream()
    .sorted((a, b) -> b.salary - a.salary)
    .limit(3)
    .map(p -> p.name)
    .collect(Collectors.toList());

// 전체 연봉 합계
int totalSal = emps.stream().mapToInt(p -> p.salary).sum();

// 부서별 직원 수
Map<String, Long> deptCount = emps.stream()
    .collect(Collectors.groupingBy(p -> p.dept, Collectors.counting()));
```

---

## Ch18 - 함수형 인터페이스 (Functional Interface)

`@FunctionalInterface` 는 추상 메서드가 **정확히 1개**인 인터페이스다.  
람다 표현식은 이 인터페이스의 익명 구현체로 취급된다.

---

### 커스텀 함수형 인터페이스

```java
@FunctionalInterface
interface Func1 {
    void say(String message);           // 인자O / 반환X
}

@FunctionalInterface
interface Func2 {
    int sum(Integer ...args);           // 가변인자 / int 반환
}

@FunctionalInterface
interface Func3 {
    List<Integer> sum(Object ...args);  // 가변인자 / List 반환
}

// 사용
Func1 func1 = message -> System.out.println(message + "_!");
func1.say("Hello");

Func2 func2 = arr -> Arrays.stream(arr).reduce(0, (sum, item) -> sum + item);
System.out.println(func2.sum(10, 20, 30));   // 60

Func3 func3 = arr -> Arrays.stream(arr)
    .filter(el -> el instanceof Integer)
    .map(el -> (Integer) el)
    .collect(Collectors.toList());
```

---

### Function - 함수 합성 (andThen)

```java
Function<Integer, Integer> func1 = x -> x * x;   // 제곱
Function<Integer, Integer> func2 = x -> x + x;   // 2배

// andThen: func1 먼저, 그 결과를 func2에 전달
Function<Integer, Integer> func5 = func1.andThen(func2);
// 10 → 100 → 200

// 체인
Function<List<Integer>, Integer> func6 = func3.andThen(func2).andThen(func1);
// [10,20,30] → 60 → 120 → 14400
```

---

### 커링 (Currying) - 함수를 반환하는 함수

```java
// 명시적 버전
Function<Integer, Function<Integer, Integer>> func7 = (x) -> {
    return (n) -> n + x;
};

// 간결한 버전
Function<Integer, Function<Integer, Integer>> func8 = x -> n -> n + x;

func7.apply(10).apply(20);   // 30
func8.apply(10).apply(20);   // 30
```

---

### 표준 함수형 인터페이스 (java.util.function.*)

| 인터페이스 | 시그니처 | 메서드 | 설명 |
|-----------|---------|--------|------|
| `Function<T, R>` | T → R | `apply` | 변환 |
| `Consumer<T>` | T → void | `accept` | 부수효과 (출력/저장) |
| `Supplier<T>` | () → T | `get` | 팩토리 (인자 없이 생성) |
| `Predicate<T>` | T → boolean | `test` | 조건 검사 |
| `BiFunction<T,U,R>` | T, U → R | `apply` | 인자 2개 변환 |

```java
// Function<T, R>
Function<String, Integer> toInt = Integer::parseInt;
toInt.apply("123");   // 123

Function<String, Integer> toIntThenTwice = toInt.andThen(n -> n * 2);
toIntThenTwice.apply("50");   // 100

// Consumer<T>
Consumer<String> printer = System.out::println;
printer.accept("출력");

printer.andThen(s -> System.out.println(s.toUpperCase()))
       .accept("hello");   // 연결

// Supplier<T>
Supplier<ArrayList<String>> listFactory = ArrayList::new;
ArrayList<String> list = listFactory.get();

// Predicate<T>
Predicate<String> isEmpty = String::isEmpty;
Predicate<String> isShort = s -> s.length() < 3;

// 조합 메서드
Predicate<String> notEmptyAndShort = isEmpty.negate().and(isShort);
words.stream().filter(isEmpty.negate()).filter(isShort).forEach(printer);

// BiFunction<T, U, R>
BiFunction<String, String, Integer> cmp = String::compareTo;
BiFunction<Integer, Integer, Integer> add = (a, b) -> a + b;
```

---

### Predicate 조합 메서드

| 메서드 | 설명 |
|--------|------|
| `and(Predicate)` | 논리 AND |
| `or(Predicate)` | 논리 OR |
| `negate()` | 논리 NOT |

```java
Predicate<Integer> isPositive = n -> n > 0;
Predicate<Integer> isEven     = n -> n % 2 == 0;
Predicate<Integer> lessThan10 = n -> n < 10;

nums.stream().filter(isPositive.and(isEven))                      // 양수 AND 짝수
nums.stream().filter(isPositive.or(isEven))                       // 양수 OR 짝수
nums.stream().filter(isPositive.negate())                         // NOT 양수
nums.stream().filter(isPositive.and(isEven).and(lessThan10))      // 세 조건 AND
```

---

## Ch19 - 어노테이션 (Annotation)

어노테이션(`@`)은 코드에 메타데이터를 붙이는 기능이다. 주석과 비슷하지만 컴파일러·빌드 도구·런타임이 읽고 활용할 수 있다.

---

### 어노테이션의 역할

- **컴파일러**: 문법 오류 체크 정보 제공 (`@Override`)
- **빌드 시**: 코드 자동 생성 (Lombok 등)
- **런타임**: 리플렉션을 통해 특정 동작 실행

---

### 표준 어노테이션

| 어노테이션 | 설명 |
|-----------|------|
| `@Override` | 메서드 오버라이딩임을 컴파일러에 알림 |
| `@Deprecated` | 더 이상 사용하지 않을 대상 표시 |
| `@FunctionalInterface` | 함수형 인터페이스임을 명시 |
| `@SuppressWarnings` | 컴파일 경고 무시 |
| `@SafeVarargs` | 제네릭 가변인자 경고 무시 |

---

### 메타 어노테이션

어노테이션을 정의할 때 사용하는 어노테이션이다.

| 어노테이션 | 설명 |
|-----------|------|
| `@Target` | 어노테이션 적용 대상 지정 |
| `@Retention` | 어노테이션 유지 기간 지정 |
| `@Documented` | javadoc 문서에 포함 |
| `@Inherited` | 하위 클래스에 상속 |
| `@Repeatable` | 동일 대상에 반복 적용 허용 |

---

### 사용자 정의 어노테이션 - 선언

```java
@Retention(RetentionPolicy.RUNTIME)              // 런타임까지 유지
@Target({ElementType.TYPE, ElementType.METHOD})  // 클래스 & 메서드에 적용 가능
public @interface C01CustomAnnotation {
    String  value()  default "HELLO WORLD";
    int     number() default 1;
    boolean isOpen() default false;
}
```

**`@Target` 주요 값**

| 값 | 적용 대상 |
|----|---------|
| `ElementType.TYPE` | 클래스, 인터페이스, enum |
| `ElementType.FIELD` | 멤버 변수 |
| `ElementType.METHOD` | 메서드 |

**`@Retention` 주요 값**

| 값 | 유지 시점 |
|----|---------|
| `RetentionPolicy.SOURCE` | 소스 코드에만 (컴파일 시 제거) |
| `RetentionPolicy.CLASS` | 클래스 파일까지 (기본값) |
| `RetentionPolicy.RUNTIME` | 런타임까지 (리플렉션으로 읽기 가능) |

---

### 사용자 정의 어노테이션 - 사용 & 리플렉션 읽기

```java
@C01CustomAnnotation(value = "홍길동", number = 10000, isOpen = true)
class Simple {
    String  value;
    int     number;
    boolean isOpen;

    Simple() {
        // 리플렉션으로 어노테이션 값 읽기
        C01CustomAnnotation ref = this.getClass().getAnnotation(C01CustomAnnotation.class);
        System.out.println("VALUE  : " + ref.value());    // 홍길동
        System.out.println("NUMBER : " + ref.number());   // 10000
        System.out.println("ISOPEN : " + ref.isOpen());   // true

        this.value  = ref.value();
        this.number = ref.number();
        this.isOpen = ref.isOpen();
    }
}

public class C01Main {
    public static void main(String[] args) {
        Simple ob = new Simple();
    }
}
```

---

## Ch20 — StarCraft OOP 설계 (추상클래스 · 인터페이스 · 리플렉션 · 스레드)

---

> 스타크래프트 유닛/건물을 모델링하는 종합 OOP 실습
> **추상 클래스 상속 → 인터페이스 구현 → 팩토리 패턴 → 리플렉션으로 동적 생성 → 멀티스레드 전투 시뮬레이션** 순서로 구성

---

### 패키지 구조

```
Ch20/
├── Main_01.java          # 전투 시뮬레이션 (멀티스레드)
├── Main_02.java          # Barrack으로 유닛 생성 + 리플렉션
├── unit/
│   ├── Unit.java         # 추상 클래스 — 공통 상태(hp, amor, type, isDead)
│   ├── Marine.java       # Unit 상속 — 총기 공격, 기본 공격
│   └── Medic.java        # Unit 상속 — 힐링
├── weapon/
│   ├── Gun.java          # 추상 클래스 — fire / reload
│   ├── Pistol.java       # Gun 상속 — power 10, 탄창 10
│   └── Rifle.java        # Gun 상속 — power 50, 탄창 100
└── building/
    ├── Building.java         # 추상 클래스 — 건물 공통
    ├── ICanFly.java          # 인터페이스 — Move / Land / Fly
    ├── UnitGenerator.java    # 인터페이스 — Gen()
    ├── MarineGenerator.java  # UnitGenerator 구현
    ├── MedicGenerator.java   # UnitGenerator 구현
    └── Barrack.java          # Building + ICanFly 구현, HashMap 팩토리 + 리플렉션
```

---

### unit/Unit.java — 추상 클래스

```java
package Ch20.unit;

public abstract class Unit {
    int hp;
    int amor;
    String type;
    public boolean isDead;

    abstract public void move();
    abstract public void underAttack(int damage);

    public int getHp()          { return hp; }
    public int getAmor()        { return amor; }
    public String getType()     { return type; }
    public boolean isDead()     { return isDead; }
    public void setHp(int hp)           { this.hp = hp; }
    public void setAmor(int amor)       { this.amor = amor; }
    public void setType(String type)    { this.type = type; }
    public void setDead(boolean isDead) { this.isDead = isDead; }
}
```

---

### unit/Marine.java — Unit 상속

```java
package Ch20.unit;

import Ch20.weapon.Gun;

public class Marine extends Unit {

    int base_damage;
    Gun myGun;
    int attackMethod;

    public final static int 총기사용 = 1;
    public final static int 기본공격 = 2;

    public Marine() {
        this.hp = 100;
        this.amor = 100;
        this.type = "해병";
        this.base_damage = 10;
    }

    public void attackMethod(int 공격방식) { this.attackMethod = 공격방식; }

    public void attack(Unit unit) {
        if (!unit.isDead) {
            if (this.attackMethod == this.총기사용)
                myGun.fire(unit);
            else
                unit.underAttack(this.base_damage);
        }
    }

    @Override
    public void move() { System.out.println(this.type + " 이 이동합니다"); }

    @Override
    public void underAttack(int damage) {
        // amor → hp → dead 순서로 피해 적용
        if (amor - damage > 0)
            amor -= damage;
        else if (hp - (amor - damage) > 0) {
            hp = hp - (damage - amor);
            amor = 0;
        } else {
            hp = 0; amor = 0;
            isDead = true;
            System.out.println("[경고] " + this.type + "전사했습니다");
        }
    }

    public Gun getMyGun()           { return myGun; }
    public void setMyGun(Gun myGun) { this.myGun = myGun; }
}
```

---

### unit/Medic.java — Unit 상속

```java
package Ch20.unit;

public class Medic extends Unit {

    private int HealingPoint;

    public Medic() {
        this.hp = 100;
        this.amor = 100;
        this.HealingPoint = 20;
        this.type = "의무병";
    }

    public void setHealingPoint(Unit unit) {
        unit.hp += this.HealingPoint;
        System.out.println("대상 " + unit.type + " HP 를 회복시킵니다. 현재 HP : " + unit.hp);
    }

    @Override
    public void move() { System.out.println(this.type + " 이 이동합니다"); }

    @Override
    public void underAttack(int damage) {
        if (amor - damage > 0)
            amor -= damage;
        else if (hp - (amor - damage) > 0)
            hp = hp - (amor - damage);
        else {
            hp = 0; amor = 0;
            isDead = true;
            System.out.println("[경고] " + this.type + "전사했습니다");
        }
    }
}
```

---

### weapon/Gun.java — 추상 클래스

```java
package Ch20.weapon;

import Ch20.unit.Unit;

public abstract class Gun {
    int maxBuillitCnt;
    int curBuillitCnt;
    int power;

    abstract public void fire(Unit unit);
    abstract public void reload(int bullit);
}
```

---

### weapon/Pistol.java & Rifle.java

```java
// Pistol — power 10, 탄창 10
public class Pistol extends Gun {
    public Pistol() { this.power = 10; this.curBuillitCnt = 0; this.maxBuillitCnt = 10; }

    @Override
    public void fire(Unit unit) {
        if (curBuillitCnt == 0) { System.out.println("[경고] 재장전이 필요합니다"); return; }
        unit.underAttack(this.power);
        curBuillitCnt--;
        System.out.println("[정보] " + unit.getType() + " 에게 " + this.power
            + " 만큼 피해를 입혔습니다. hp : " + unit.getHp() + " amor : " + unit.getAmor());
    }

    @Override
    public void reload(int bullit) {
        if (this.maxBuillitCnt > (bullit + this.curBuillitCnt))
            this.curBuillitCnt = maxBuillitCnt;
        else
            this.curBuillitCnt += bullit;
        System.out.println("[정보] 재장전 완료");
    }
}

// Rifle — power 50, 탄창 100 (구조 동일, 수치만 다름)
public class Rifle extends Gun {
    public Rifle() { this.power = 50; this.curBuillitCnt = 0; this.maxBuillitCnt = 100; }
    // fire / reload 구현 동일 구조
}
```

---

### building/Building.java · ICanFly.java · UnitGenerator.java

```java
// Building — 건물 추상 클래스
public abstract class Building {
    public int hp, sheld, ammor;
    public boolean isDestroyed;
    public abstract void BuildStructure();
    public abstract void UnderAttack(int damage);
}

// ICanFly — 이동 가능 건물 인터페이스
public interface ICanFly {
    public void Move();
    public void Land();
    public void Fly();
}

// UnitGenerator — 유닛 생성 인터페이스 (팩토리 패턴)
public interface UnitGenerator {
    public Unit Gen();
}

// MarineGenerator / MedicGenerator — UnitGenerator 구현체
public class MarineGenerator implements UnitGenerator {
    @Override public Unit Gen() { return new Marine(); }
}
public class MedicGenerator implements UnitGenerator {
    @Override public Unit Gen() { return new Medic(); }
}
```

---

### building/Barrack.java — HashMap 팩토리 + 리플렉션

```java
package Ch20.building;

import java.lang.reflect.Constructor;
import java.util.*;
import Ch20.unit.*;

public class Barrack extends Building implements ICanFly {

    // Key: 유닛 이름, Value: 생성 인터페이스 구현체
    public Map<String, UnitGenerator> generator;

    public Barrack() {
        generator = new HashMap();
        generator.put("marine", new MarineGenerator());
        generator.put("medic",  new MedicGenerator());
    }

    public Marine genMarine() {
        return (Marine) ((MarineGenerator) generator.get("marine")).Gen();
    }
    public Medic genMedic() {
        return (Medic) ((MedicGenerator) generator.get("medic")).Gen();
    }

    // 리플렉션으로 Class<?> 타입과 개수(n)를 받아 동적으로 유닛 생성
    public <T extends Unit> List<Unit> genUnit(Class<?> clazz, int n) {
        List<Unit> list = new ArrayList<>();
        try {
            Constructor con = clazz.getConstructor(null); // 기본 생성자 획득
            for (int i = 0; i < n; i++) {
                Object obj = con.newInstance(null);        // 인스턴스 생성
                list.add((Unit) obj);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override public void BuildStructure() { System.err.println("Barrack 건물 건설"); }
    @Override public void UnderAttack(int damage) { System.err.println("Barrack 공격 받음"); }
    @Override public void Move() {}
    @Override public void Land() {}
    @Override public void Fly() {}
}
```

---

### Main_01.java — 멀티스레드 전투 시뮬레이션

```java
package Ch20;

public class Main_01 {
    public static void main(String[] args) {
        Marine marine1 = new Marine();
        marine1.setMyGun(new Pistol());
        marine1.getMyGun().reload(100);
        marine1.attackMethod(Marine.총기사용);
        marine1.setType("marine1");

        Medic medic1 = new Medic();
        medic1.setType("medic1");

        Marine marine2 = new Marine();
        marine2.setMyGun(new Rifle());
        marine2.getMyGun().reload(100);
        marine2.setType("marine2");
        marine2.attackMethod(Marine.총기사용);

        // medic → marine1 힐링 (1.5초 간격)
        new Thread() {
            @Override public void run() {
                while (true) {
                    medic1.setHealingPoint(marine1);
                    try { Thread.sleep(1500); } catch (InterruptedException e) { e.printStackTrace(); }
                }
            }
        }.start();

        // marine1 → marine2 공격 (1초 간격)
        new Thread() {
            @Override public void run() {
                while (true) {
                    marine1.attack(marine2);
                    try { Thread.sleep(1000); } catch (InterruptedException e) { e.printStackTrace(); }
                }
            }
        }.start();

        // marine2 → marine1 공격 (1초 간격)
        new Thread() {
            @Override public void run() {
                while (true) {
                    marine2.attack(marine1);
                    try { Thread.sleep(1000); } catch (InterruptedException e) { e.printStackTrace(); }
                }
            }
        }.start();
    }
}
```

---

### Main_02.java — Barrack 유닛 생성 + 리플렉션

```java
package Ch20;

import java.util.List;
import Ch20.building.Barrack;
import Ch20.unit.*;

public class Main_02 {
    public static void main(String[] args) throws ClassNotFoundException {
        Barrack barrack = new Barrack();

        // 일반 생성
        Marine m1 = barrack.genMarine();
        Medic  m2 = barrack.genMedic();
        System.out.println(m1);
        System.out.println(m2);

        System.out.println("---------------");

        // 리플렉션으로 Marine 5개 생성
        List<Unit> li1 = barrack.genUnit(Class.forName("Ch20.unit.Marine"), 5);
        li1.forEach(el -> System.out.println((Marine) el));
    }
}
```

---

### Ch20 핵심 정리

| 개념 | 사용 위치 | 포인트 |
|---|---|---|
| **추상 클래스** | `Unit`, `Gun`, `Building` | 공통 상태 보유 + 일부 메서드 강제 구현 |
| **인터페이스** | `ICanFly`, `UnitGenerator` | 다중 구현 가능, 행동 규약 정의 |
| **다형성** | `Marine/Medic extends Unit` | `Unit` 타입으로 일괄 처리 |
| **팩토리 패턴** | `Barrack.generator` (HashMap) | Key로 생성기 조회 → 유닛 생성 |
| **리플렉션** | `Barrack.genUnit()` | `Class<?>` + `Constructor.newInstance()` 로 동적 생성 |
| **멀티스레드** | `Main_01` | `Thread` 익명 클래스로 동시 실행 |

> `underAttack` 피해 흐름: **amor 먼저 감소 → amor 0 이후 hp 감소 → hp 0 이면 isDead = true**
> `genUnit(Class.forName("Ch20.unit.Marine"), 5)` — 클래스명 문자열만으로 인스턴스 N개 동적 생성

---

