-- 1-1
use ssgdb;
-- select * from customer;
select bookname
from Book
where bookid = 1;

-- 1-2
select bookname
from book
where price >= 20000;

-- 1-3
select sum(saleprice)
from orders
where custid = 1;

-- 1-4
select count(orderid)
from orders
where custid = 1;

-- 2-1
select * from Book;
select count(bookid)
from book;
-- 2-2
SELECT COUNT(DISTINCT publisher) 
FROM book;

-- 2-3
select * from customer;
select name, address
from customer;

-- 2-4
desc orders;
SELECT orderid
FROM orders
WHERE orderdate BETWEEN '2014-07-04' AND '2014-07-07';


-- 2-5
SELECT orderid
FROM orders
WHERE orderdate NOT BETWEEN '2014-07-04' AND '2014-07-07';
-- 2-6
select * from customer;
select name, address
from customer
where name like '김%';

-- 2-7
select name, address
from customer
where name like '김%아';

