-- 3-8 가장 비싼 도서의 이름을 찾으시
select max(price) from book;
select bookname name from book where price = 35000;
-- 두개의 질의를 하나의 질의로 만들 수는 없을까?
select bookname
from book
where price =(select max(price) from book);

-- 도서를 구매한 적이 있는 고객의 이름을 출력하세요
select custid from orders;
select name from customer where custid in (1,2,3,4);

select name
from customer
where custid in (select custid from orders);

-- 대한 미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오
select name
from customer 
where custid in (select custid from orders where bookid in (select bookid from book where publisher = '대한미디어') );

-- 부속질의 간에는 상하관계가 있다. 먼저 하위 부속질의를 실행하고 그 결과를 이용하여 상위 부속질의를 실행한다.

-- 상관 부속질의 (correlated subquery) 상위 부속질의와 하위 부속질의가 독립적이지 않고 서로 관련을 맺고 있다.

-- 3-31 출판사별로 춢판사의 평균 도서 가격보다 비싼 도서를 구하시오
select avg(price)
from book;
where 

