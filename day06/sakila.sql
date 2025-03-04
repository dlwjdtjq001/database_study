show databases;
use sakila;

desc customer;
-- customer_id 고객을 유일하게 식별하는 식별자
-- store_id store테이블에서 고객의 '홈스토어' 를 식별하는 외래키
-- first_name: 이름 last_name: 성
-- email : 고객의 이메일
-- address_id : address 테이블에서 고객의 주소를 식별하는 외래키
-- active : 고객이 활성화된 고객인지 여부가 저장
-- create_date : 고객이 시스템에 가입된 날
-- last_update: 행이 수정되었거나 가장 최근 업데이트 된 시간이 저장

-- select * from custom 자제요망

-- ex) 50 byte 데이터를 저장할 수 있는 열이 50 개 행이 1만개
-- 쿼리 한줄이 50byte * 50 * 10000 row => 25mb
-- Show columns from sakila.customer;

-- payment 테이블에서 customer_id, amount 열을 조회하는데 
-- customer_id 그룹화(고객별), 그룹별로 amount 의 값을 합한 결과를 내립차순 정렬한 결과에 따라 row_nember 함수로 순위를 부여

select customer_id, count(customer_id) from payment group by customer_id;

-- 순위함수 row_number() : 모든 행에 유일한 값으로 순위를 부여(함수를 실행한 결과에 같은 순위가 없다. 만역 같은 순위가 있다면 정렬 순서에 따라 순서를 다르게 부여함)
-- 순위를 부여하기 위해서 over(order by 열)
-- row_number() over ([partition by 열] order by 열)

select row_number() over(order by amount desc, customer_id desc) as num, customer_id, amount
from(
select customer_id , sum(amount) as amount from payment group by customer_id
) as x;

select staff_id, row_number() over(partition by staff_id order by amount desc, customer_id asc) as num, customer_id, anount
from(
select customer_id, staff_id, sum(amount) as amount from payment group by customer_id , staff_id
);

-- rank() 우선순위 고려하지 않고 순위를 부여하는 함수
-- Rank() over(partition by 열] order by 열)

select rank() over(order by amount desc) as num, customer_id, amount
from (
select customer_id, sum(amount) as amount from payment group by customer_id 
) as x;


