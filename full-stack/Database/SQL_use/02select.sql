use shopdb;

-- 01 select group by
select * from buytbl;
-- userid별 amount 총합(집계함수 : sum)
select userID, sum(amount) '구매총량' from buytbl group by userID;
-- userid별 amount*price 총합(sum)
select userID, sum(amount*price) '구매총액' from buytbl group by userID;
-- avg를 이용
select userID, truncate(avg(amount*price),2) '구매평균액' from buytbl group by userID;
-- min, max
select min(height) from usertbl;
select max(height) from usertbl;

-- 가장 큰키를 가지는 user 정보 확인
select * from usertbl where height = (select max(height) from usertbl);
-- 가장 작은키를 가지는 user 정보 확인
select * from usertbl where height = (select min(height) from usertbl);
-- 가장 큰키, 작은키를 가지는 user 정보 확인
select * from usertbl where height in((select max(height) from usertbl),(select min(height) from usertbl));

-- 1 buytbl에서 userid 별로 구매량(amount)의 합을 출력하세요
select userid, sum(amount)'구매량' from buytbl group by userID;
-- 2 usertbl에서 키의 평균값을 구하세요
select avg(height) from usertbl;
-- 3 buy테이블에서 최대구매량과 최소구매량을 userid와함께 출력하세요
select userID, max(amount)'최대구매량', min(amount)'최소구매량' from buytbl group by userID;
-- 4 buytbl의 groupname 의 개수를 출력하세요
select count(groupname) from buytbl;

use world;
-- 5 city 테이블에서 countrycode 별로 population의 총합을 구하세요(world DB에서 진행)
select countrycode, sum(population) from city group by countrycode; 
-- 6 country테이블에서 countinent 별로 lifeexpectancy의 평균을 구하세요(world DB에서 진행)
select continent, avg(lifeexpectancy) from country group by continent;

-- 7 select group by + having
use shopdb;
select * from buytbl;

select userid, sum(amount)'구매총량' from buytbl group by userid having sum(amount)>=5;
select userid, sum(amount)'구매총량' from buytbl group by userid having 구매총량>=5;