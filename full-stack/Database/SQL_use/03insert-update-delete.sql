-- use shopdb;
-- select * from buytbl;
-- create table tbl_buy_2(select num, userid, prodname, amount from buytbl);
-- select * from tbl_buy_2;
delete from tbl_buy_2;

-- INSERT 
-- 1) 여러 값 한번에 삽입
-- insert into tbl_buy_2 values
-- (1,'aaa','운동화',1),
-- (2,'bbb','운동화',1),
-- (3,'ccc','운동화',1),
-- (4,'ddd','운동화',1),
-- (5,'eee','운동화',1),
-- (6,'fff','운동화',1),
-- (7,'ggg','운동화',1);
-- select * from tbl_buy_2;
-- 2) PK 중복시 무시
-- insert ignore into tbl_buy_2 values
-- (1,'aaa','운동화',2),
-- (2,'bbb','냉장고',4),
-- (1,'ccc','노트북',3),
-- (4,'ddd','세탁기',1);
-- select * from tbl_buy_2;
-- 3) AUTO INCREMENT
-- insert ignore into tbl_buy_2 values
-- (null,'aaa','운동화',2),
-- (null,'bbb','냉장고',4),
-- (66,'ccc','노트북',3),
-- (null,'ddd','세탁기',1);
-- select * from tbl_buy_2;

-- AUTO INCREMENT 확인
-- select auto_increment from information_schema.tables where table_schema ='shopdb' and table_name='tbl_buy_2';
-- select last_insert id();
-- alter table tbl_buy_2 auto_increment=0;

-- DUPLICATE KEY
insert ignore into tbl_buy_2 values
(1,'aaa','운동화',2) on duplicate key update amount=amount+1;
select * from tbl_buy_2;

-- AUTO INCREMENT 초기화
-- delete from tbl_buy_2;
-- select * from tbl_buy_2;
-- insert ignore into tbl_buy_2 values(null,'aaa','운동화',2);
-- alter table tbl_buy_2 auto_increment=0;
-- insert ignore into tbl_buy_2 values(null,'aaa','운동화',2);

-- UPDATE