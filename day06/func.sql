use ssg;
use ssgdb;
-- abs() 숫자의 절대값 반환
-- -78 +78 의 절대값 select 의 의미는 출력하라라는 의미
select abs(-78), abs(78) from dual; -- 오라클일 경우 dual : 가상테이블
select abs(-78), abs(78); -- mysql 일 경우
-- 4,875 를 소수 첫쨰자리까지 반올림한 값을 구하시오
select round(4.875,1);

-- 10, 10.1, -10.1    10 10.1,-10

select ceil(10), ceil(10.1), ceil(-10.1);

select ceiling(3.14) as ceil_value;
select floor(3.14) as floor_value;
-- truncate() => 숫자를 지정한 소수점 자리수로 잘라낸다.
select truncate(3.141592,2) as truncate_ex;

select round(sum(saleprice)/count(*),-2), custid as 고객번호
from orders
group by custid;

-- trim
select trim('=' from '==asdf=sf==='); -- 앞 뒤만 걷어낸다.
select upper('asdasd');
select ascii('a');
select length('asfaf');
select char_length('asfaf');
-- 보통 한 문자가 차지하는 바이트의 기준은 데이터베이스 시스템에 따라 다르게 적용되는데
-- UTF-8 환경에서는 알파벳 'a' 1byte 한글'가' => 3byte 로 저장된다.
-- 그러므로 순수한 문자의 수를 알기위해서는 char_length(문자열) 사용한다.
-- 공백도 하나의 문자로 취급됩니다.
select length('sssssGGGGGG'); 
select char_length('신세계');
select length('신세계');


-- 도서제목에 야구가 포함된 도서를 농구로 변경한 후 도서목록을 보이시오
select bookid, replace(bookname,'야구','농구')
from book;

-- 굿스포트에서 출판한 도서의 제목과 제목의 글자수를 확인하세요
select bookname '제목', char_length(bookname), length(bookname)
from book
where publisher = '굿스포츠';

-- 같은 성을 가진 사람의 수
select substr(name, 1,1) 성, count(*)
from customer
group by substr(name,1,1);

-- 날짜함수
select sysdate();
select now();

select orderid,orderdate,adddate(orderdate, interval 10 DAY)
from orders;

select orderid 주문번호, date_format(orderdate,'%Y-%m-%d') 주문일
from orders
where orderdate = str_to_date('20240707', '%Y%m%d');


create table Bybook(
bookid int,
price int
);

desc ByBook;
alter table ByBook rename to Mybook;
desc myBook;

insert into mybook values
(1,10000),
(2,20000),
(3,null);

select price + 100 from mybook;
select sum(price), avg(price), count(*), count(price)
from mybook
where bookid >= 4;

-- null값 확인하는 방법 (is null, is not null) 아니다 => <>
select * from mybook where price is null;
select * from mybook where price = '';

-- ifnull 함수 => 널값을 치환하여 연산한다.
select name 이름, ifnull(phone , '연락처 없음') 전화번호
from customer;

select bookname, ifnull(price, 0) 가격
from book;

set @seq :=9;
select (@seq:=@seq+1) 순번 , custid, name,phone
from customer;
-- where @seq<2;
