-- View(뷰)는 복잡한 쿼리를 재사용하거나,
-- 보안 상 사용자에게 제한된 열만 제공할 때 사용하는 가상 테이블

use shopdb;
select * from usertbl;
select * from buytbl;

create or replace view view_01
as
select userid,name,addr,concat(mobile1,'-',mobile2)'phone' from usertbl;

select * from view_01;
-- 확인
show create view view_01;
select * from information_schema.views where table_schema='shopdb';
desc view_01;

create or replace view view_02
as
select userid,name,addr,concat(mobile1,'-',mobile2)'phone' 
from usertbl 
where addr in ('서울','경기');

select * from view_02;

create or replace view view_03
as
select U.userID,name,addr,concat(mobile1,'-',mobile2)'phone',prodname,price,amount
from usertbl U
inner join buytbl B
on U.userID = B.userID;

select * from view_03;

use world;

create or replace view view_04
as
select c.name'country',ct.name'city',region,c.population,capital,l.language
from world.country c
inner join world.city ct
on c.code = ct.CountryCode
inner join countrylanguage l
on c.code = l.CountryCode
order by c.population;

select * from view_04;

use testdb;

drop table tbl_a;
drop table tbl_b;
drop view view_a_b;
create table tbl_a(
	col1 int  primary key,
    col2 int 
);
create table tbl_b(
	col3 int  primary key,
    col4 int 
);

create or replace view view_a_b
as
select *  
from tbl_a
inner join tbl_b;

desc tbl_a;
desc tbl_b;
select * from tbl_a;
select * from tbl_b;
select * from view_a_b;

insert into tbl_a values(1,10);
insert into tbl_b values(2,20);
-- JOIN 된 view table에 insert 불가(단일 table view는 제약조건을 만족하면 가능)
insert into view_a_b(col1,col2,col3,col4) values(3,30,4,40);
insert into view_a_b(col1) values(3);
insert into view_a_b(col3) values(4);
