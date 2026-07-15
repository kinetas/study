use testdb;
-- --------------------
-- JOIN
-- --------------------
-- 두 개 이상의 테이블을 연결하여 하나의 결과셋으로 출력

-- --------------------
-- JOIN 종류
-- --------------------
-- INNER JOIN: ON 조건에 맞는 데이터만 조인
-- OUTER JOIN:
--   LEFT OUTER JOIN: 왼쪽 테이블 전체 + 오른쪽 조건 일치 행
--   RIGHT OUTER JOIN: 오른쪽 테이블 전체 + 왼쪽 조건 일치 행
--   FULL OUTER JOIN: 양쪽 테이블 전체 (MySQL은 직접 지원하지 않음 → UNION으로 구현)
-- CROSS JOIN: 모든 행끼리 조인 (조건 없음)
-- SELF JOIN: 자기 자신 테이블을 조인

-- INNER JOIN 실습
use shopdb;
select * from usertbl;
desc usertbl;
select * from buytbl;
desc buytbl;

-- INNER JOIN 구매한 고객에 대한 모든 정보(전체컬럼)
select * 
from usertbl 
inner join buytbl 
on usertbl.userid = buytbl.userID;

-- INNER JOIN 원하는 컬럼만 출력
select usertbl.userid,name,addr moblie1,mobile2, prodname,price,amount 
from usertbl 
inner join buytbl 
on usertbl.userid = buytbl.userID;

-- INNER JOIN 별칭지정
select U.userid,name,addr moblie1,mobile2, prodname,price,amount 
from usertbl U
inner join buytbl B 
on U.userid = B.userID;

-- INNER JOIN + WHERE
select U.userid,name,addr moblie1,mobile2, prodname,price,amount 
from usertbl U
inner join buytbl B 
on U.userid = B.userID
where amount >= 5;

-- +group by(지역별 구매총량)
select addr, sum(amount)'구매총량' 
from usertbl U
inner join buytbl B 
on U.userid = B.userID
group by addr
having 구매총량 >= 5
order by 구매총량 desc;

-- 문제 1: 바비킴의 userID, birthYear, prodName, groupName 출력
select U.userid,birthyear,prodname,groupname
from usertbl U
inner join buytbl B
on U.userid = B.userID
where U.name = '바비킴';
-- 문제 2: amount * price ≥ 100 인 경우 행의 name,addr,prodname,mobile1- mobile2를 (concat()함수사용)출력
select name,addr,prodname,concat(mobile1,'-',mobile2)
from buytbl b
inner join usertbl u
on b.userID = u.userid
where (amount * price) >=100;
-- 문제 3: groupname이 '전자'인 행의 userid,name,birthyear, prodname 출력
select b.userid,name,birthYear,prodname
from buytbl b
inner join usertbl u
on b.userID = u.userid
where groupName in ('전자');

-- OUTER JOIN 실습

-- LEFT OUTER JOIN(on 조건절을 만족하지 않는 left 테이블의 행도 출력)
select *
from usertbl U -- LEFT
left outer join buytbl B -- RIGHT
on U.userID = B.userID;

-- RIGHT OUTER JOIN(on 조건절을 만족하지 않는 right 테이블의 행도 출력)
select *
from buytbl B -- LEFT
right outer join usertbl U -- RIGHT
on U.userID = B.userID;

-- FULL OUTER JOIN (on 조건절을 만족하지 않는 left, right 테이블의 행도 출력alter
-- mysql에서는 full outer join을 지원하지 않는다.
-- 대신 union을 사용해서 left, right outer join을 연결
select * from usertbl U left outer join buytbl B on U.userID = B.userID
union
select * from buytbl B right outer join usertbl U on U.userid = B.userID;


use employees;
desc employees;
desc salaries;
desc dept_emp;
desc departments;

select E.emp_no,concat(first_name,' ',last_name) as 'name',salary,hire_date,S.from_date,S.to_date, DE.dept_no,dept_name
from salaries S
inner join employees E
on E.emp_no = S.emp_no
inner join dept_emp DE
on E.emp_no = DE.emp_no
inner join departments D
on DE.dept_no = D.dept_no;

-- WORLD DB에서 진행 countryCode를 만족하는 
-- country'name ,
-- city's name, 
-- region ,
-- population,
-- Capital,
-- Language 
-- 를 출력하세요

use world;

select c.name,ct.name,region,c.population,capital,l.language
from country c
inner join city ct
on c.code = ct.CountryCode
inner join countrylanguage l
on c.code = l.CountryCode
order by c.population;