-- 1번
use testdb;
drop table NewBook;
drop table NewOrders;
drop table NewCustomer;
drop table test_create_table;

create table customer (
custid int,
name varchar(40),
address varchar(50),
phone varchar(20),
primary key(custid)
);
create table book(
bookid int,
bookname varchar(40),
publisher varchar(40),
price int,
primary key(bookid)
);
create table orders(
orderid int,
custid int,
bookid int,
saleprice int,
orderdate date,
primary key(orderid)
);

show databases;
show tables;
select * from information_schema.table_constraints where table_name = 'orders';
alter table orders add constraint fk_bookid foreign key(bookid) references book(bookid) on delete cascade; 
alter table orders add constraint fk_custid foreign key(custid) references customer(custid) on delete cascade; 

select * from orders;

-- 2
create table cust_addr(
addrid int auto_increment,
custid int,
address varchar(50),
phone varchar(20),
changedate Date,
primary key(addrid, custid)
);
select * from information_schema.table_constraints where table_name = 'cust_addr';
alter table cust_addr add constraint fk_cust_addrid foreign key(custid) references customer(custid) on delete cascade;

-- insert into
INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구 아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '배구 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);


INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001'); 
INSERT INTO Customer VALUES (3, '김연경', '대한민국 경기도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전',  NULL);

INSERT INTO Orders VALUES (1, 1, 1, 6000, STR_TO_DATE('2024-07-01','%Y-%m-%d'));
INSERT INTO Orders VALUES (2, 1, 3, 21000, STR_TO_DATE('2024-07-03','%Y-%m-%d'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, STR_TO_DATE('2024-07-03','%Y-%m-%d'));
INSERT INTO Orders VALUES (4, 3, 6, 6000, STR_TO_DATE('2024-07-04','%Y-%m-%d'));
INSERT INTO Orders VALUES (5, 4, 7, 20000, STR_TO_DATE('2024-07-05','%Y-%m-%d'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, STR_TO_DATE('2024-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, STR_TO_DATE( '2024-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, STR_TO_DATE('2024-07-08','%Y-%m-%d'));
INSERT INTO Orders VALUES (9, 2, 10, 7000, STR_TO_DATE('2024-07-09','%Y-%m-%d'));
INSERT INTO Orders VALUES (10, 3, 8, 13000, STR_TO_DATE('2024-07-10','%Y-%m-%d'));

INSERT INTO Cust_addr VALUES (null,1, '영국 에인트호번', '010-5000-0001', STR_TO_DATE('2003-07-01','%Y-%m-%d'));
INSERT INTO Cust_addr VALUES (null,1, '영국 맨체스터', '010-5000-0002', STR_TO_DATE('2005-07-01','%Y-%m-%d'));
INSERT INTO Cust_addr VALUES (null,1, '영국 에인트호번', '010-5000-0003', STR_TO_DATE('2013-07-01','%Y-%m-%d'));
INSERT INTO Cust_addr VALUES (null,1, '영국 퀸즈파크', '010-5000-0004', STR_TO_DATE('2021-07-01','%Y-%m-%d'));

select * from cust_addr;

-- 고객버호 1번의 주소변경 내역을 모두 나타내시오
select address
from cust_addr
where custid = 1;

-- 고객번호 1번의 전화번호 변경 내역
select phone
from cust_addr
where custid = 1;
-- 고객번호 1번의 가입당시 전화번호를 나타내시오
select * from cust_addr;
select phone
from cust_addr
where changedate = (select min(changedate) from cust_addr where custid = 1);
-- 고객번호 1번의 20240101 전화번호를 나타내시오 단 주소이력중 20240201 보다 오래된 첫번쨰 값을 찾는다.
select phone
from cust_addr
where changedate = (select max(changedate) from cust_addr where changedate > 2024-02-01);
-- 3

create table cart(
cartid int,
custid int,
bookid int,
cartdate date,
primary key(cartid)
);

INSERT INTO Cart VALUES (1, 1, 1, STR_TO_DATE('2024-07-01','%Y-%m-%d')); 
INSERT INTO Cart VALUES (2, 1, 3, STR_TO_DATE('2024-07-03','%Y-%m-%d'));
INSERT INTO Cart VALUES (3, 1, 5, STR_TO_DATE('2024-07-03','%Y-%m-%d')); 
INSERT INTO Cart VALUES (4, 1, 6, STR_TO_DATE('2024-07-04','%Y-%m-%d')); 
commit;

show databases;
use information_schema;
show tables;
select * from table_constraints where table_name = 'cart';
use testdb;
alter table cart add constraint fk_cart_custid foreign key(custid) references customer(custid) on delete cascade;
alter table cart add constraint fk_cart_bookid foreign key(bookid) references book(bookid) on delete cascade;

-- 고객번호 1번의 cart 에 저장된 두서중 주문한 도서를 구하시오
select bookname
from book
where bookid in (select bookid from cart where custid = 1) ;

-- 1번이 구입하지 않은 도서
select bookname
from book
where bookid not in (select bookid from cart where custid = 1) ;

-- 1번 구입한 도서의 정가 합

select sum(price)
from book
where bookid in (select bookid from cart where custid = 1);