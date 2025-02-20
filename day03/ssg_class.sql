use madangdb;
show tables;
-- 1. 운영자적 관점 sql : 집계 (affregate) -> 집계함수(aggregate function) 제공
-- 집계함수란 테이블의 각 열에 대해 계산하는 함수

-- 고객(costumer) 이 주문한 도서의 총 판매액을 구하세요
select *
from orders;
select sum(saleprice)
from orders;

-- 3-15 고객이 주문한 도서의 총 판매액을 구해보자
select sum(saleprice) as '총매출'
from orders;

-- 3-16
select custid from customer where name = '김연아';
select * from customer;
select count(*)
from customer;


-- 3-17
select sum(saleprice) as 'total'
,avg(saleprice) as 'average'
,min(saleprice) as 'min',
max(saleprice) as 'max'
from orders;

-- 3-18 count : 행의 개수를 셈 count(*) 전체 튜플의 수 
select count(orderid) from orders;


