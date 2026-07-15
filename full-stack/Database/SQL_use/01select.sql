use shopdb;

-- UserTbl 만들기
CREATE TABLE userTbl(  
userID VARCHAR(8) NOT NULL PRIMARY KEY,  
name VARCHAR(10) NOT NULL,  
birthYear INT NOT NULL,  
addr VARCHAR(2) NOT NULL,  
mobile1 VARCHAR(3), 
mobile2 VARCHAR(8),  
height SMALLINT, 
mDate DATE 
);
-- Buytbl 만들기
CREATE TABLE buyTbl(  
num INT NOT NULL PRIMARY KEY, 
userID VARCHAR(8) NOT NULL,  
prodName VARCHAR(15) NOT NULL, 
groupName VARCHAR(15),  
price INT NOT NULL,  
amount SMALLINT NOT NULL,  
FOREIGN KEY (userID) REFERENCES userTbl(userID)
);

-- Usertbl 값삽입
INSERT INTO userTbl VALUES('LSG','이승기',1987,'서울','011','1111111',182,'2008-8-8');
INSERT INTO userTbl VALUES('KBS','김범수',1979,'경남','011','2222222',173,'2012-4-4');
INSERT INTO userTbl VALUES('KKH','김경호',1971,'전남','019','3333333',177,'2007-7-7');
INSERT INTO userTbl VALUES('JYP','조용필',1950,'경기','011','4444444',166,'2009-4-4');
INSERT INTO userTbl VALUES('SSK','성시경',1979,'서울',NULL,NULL,186,'2013-12-12');
INSERT INTO userTbl VALUES('LJB','임재범',1963,'서울','016','6666666',182,'2009-9-9');
INSERT INTO userTbl VALUES('YJS','윤종신',1969,'경남',NULL,NULL,170,'2005-5-5');
INSERT INTO userTbl VALUES('EJW','은지원',1972,'경북','011','8888888',174,'2014-3-3');
INSERT INTO userTbl VALUES('JKW','조관우',1965,'경기','018','9999999',172,'2010-10-10');
INSERT INTO userTbl VALUES('BBK','바비킴',1973,'서울','010','0000000',176,'2013-5-5');

select * from usertbl;

-- Buytbl 값 삽입

INSERT INTO buyTbl VALUES(1,'KBS','운동화',NULL,30,2);
INSERT INTO buyTbl VALUES(2,'KBS','노트북','전자',1000,1);
INSERT INTO buyTbl VALUES(3,'JYP','모니터','전자',200,1);
INSERT INTO buyTbl VALUES(4,'BBK','모니터','전자',200,5);
INSERT INTO buyTbl VALUES(5,'KBS','청바지','의류',50,3);
INSERT INTO buyTbl VALUES(6,'BBK','메모리','전자',80,10);
INSERT INTO buyTbl VALUES(7,'SSK','책','서적',15,5);
INSERT INTO buyTbl VALUES(8,'EJW','책','서적',15,2);
INSERT INTO buyTbl VALUES(9,'EJW','청바지','의류',50,1);
INSERT INTO buyTbl VALUES(10,'BBK','운동화',NULL,30,2);
INSERT INTO buyTbl VALUES(11,'EJW','책','서적',15,1);
INSERT INTO buyTbl VALUES(12,'BBK','운동화',NULL,30,2);



use shopdb;
show tables;
desc usertbl;
desc buytbl;
select * from usertbl; 
select * from buytbl;

-- 01 SELECT
select userID, birthYear from usertbl;
select userID as '아이디', birthYear as '생년월일' from usertbl;
select userID as '아이디', birthYear as '생년월일', concat(mobile1,'-' ,mobile2) as '전화번호' from usertbl; 

-- 02 SELECT - where(조건절 - 비교연산자)
select * from usertbl where name = '김경호'; -- 동등비교연산자(=)
select * from usertbl where userId = 'LSG'; -- 동등비교연산자(=)
select * from usertbl where birthYear >= 1970; -- 대소비교연산자
select * from usertbl where height <= 170; -- 대소비교연산자

-- 03 SELECT - WHERE(조건절 - 논리연산자)
-- and 연산자
select * from usertbl where birthYear >= 1970 and height >=180;
-- or 연산자
select * from usertbl where birthYear >= 1970 or height >=180;
-- between and
select * from usertbl where height >= 170 and height<=180;
select * from usertbl where height between 170 and 180;

-- in(포함문자열) , like(포함문자열)
select * from usertbl where addr = '서울' or addr = '경기';
select * from usertbl where addr in ('서울', '경기');

select * from usertbl where name like '김%';
select * from usertbl where name like '%수';
select * from usertbl where name like '%경%';
select * from usertbl where name like '김__';

select * from buytbl;
select * from buytbl where amount >= 5;
select userID, prodName from buytbl where price between 50 and 500;
select * from buytbl where amount >= 10 or price >= 100;
select * from buytbl where userID like 'K%';
select * from buytbl where groupName in ('서적', '전자');
select * from buytbl where prodName = '책' and userID like '%W';
select * from buytbl where groupName != "";

-- 04 SELECT 조건절 - 서브쿼리
select * from usertbl where name = '김경호';
-- 김경호으 키보다 큰 행을 조회
select * from usertbl where height > (select height from usertbl where name = '김경호');
-- 성시경보다 나이가 많은 모든 행 조회
select * from usertbl where birthYear < (select birthYear from usertbl where name ='성시경');
-- 지역이 '경남'인 height보다 큰 모든 행 조회
select * from usertbl;
select *from usertbl where height >= all(select height from usertbl where addr ='경남'); 
select *from usertbl where height >= any(select height from usertbl where addr ='경남'); 

-- buytbl
select * from buytbl;
-- 1 amount가 10인 행의 price보다 큰 행을 출력하세요(서브쿼리)
select * from buytbl where price > (select price from buytbl where amount =10);
-- 2 userID 가 K로 시작하는 행의 amount 보다 큰 행을 출력하세요(서브쿼리 + ANY) 
select * from buytbl where amount > any(select amount from buytbl where userID like 'K%');
-- 3 amount 가 5인 행의 price보다 큰 행을 출력하세요(서브쿼리 + ALL)
select * from buytbl where price > all(select price from buytbl where amount = 5);
-- select * from buytbl where groupName is null;

-- 05 SELECT ORDER BY
select * from usertbl order by mDate asc;
select * from usertbl order by mDate desc;
select * from usertbl where birthYear >= 1970 order by mDate desc;
select * from usertbl order by height desc,mdate asc;

-- 06 distinct
select addr from usertbl;
select distinct addr from usertbl;

-- 07 limit
select * from usertbl;
select * from usertbl limit 3;
select * from usertbl limit 2,3;

-- 08 테이블 복사
-- 08-01  구조 + 값 복사(PK,FK 복사 x)
create table tbl_buy_copy(select * from buytbl);
select * from tbl_buy_copy;
desc tbl_buy_copy;
desc buytbl;
create table tbl_buy_copy2(select userID, prodName, amount from buytbl);
select * from tbl_buy_copy2;
-- 08-02  구조만 복사(값x, PK O, FK X, INDEX O)
create table tbl_buy_copy3 like buytbl;
desc tbl_buy_copy3;
-- 08-03  데이터만 복사
insert into tbl_buy_copy3 select * from buytbl where amount >=3;
select * from tbl_buy_copy3;

-- 1 userId 순으로 오름차순 정렬
select * from buytbl order by userID;
-- 2 price 순으로 내림차순 정렬
select * from buytbl order by price desc;
-- 3 amount 순으로 오름차순 prodName으로 내림차순정렬
select * from buytbl order by amount, prodName desc;
-- 4 prodName을 오름차순으로 정렬시 중복 제거
select distinct prodName from buytbl order by prodName;
-- 5 userID열의 검색시 중복된 아이디제거하고 select
select distinct userID from buytbl; 
-- 6 구매양(amount)가 3이상인 행을 prodName 내림차순으로 정렬
select * from buytbl where amount >= 3 order by prodName desc;
-- 7 usertbl의 addr 가 서울,경기인 값들을 CUsertbl에 복사
create table CUsertbl(select * from usertbl where addr in ('서울','경기'));
select * from cusertbl;