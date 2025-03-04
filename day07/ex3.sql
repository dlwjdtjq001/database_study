
use shopdb;

create table pivotTest(
userName Char(10),
season Char(2),
amount int
);

insert into pivotTest values
('김범수','겨울',10),
('유노윤호','여름',15),
('김범수','가을',10),
('김범수','겨울',10),
('김범수','겨울',10),
('김범수','겨울',10),
('김범수','겨울',10),
('김범수','겨울',10),
('김범수','겨울',10),
('김범수','겨울',60);
commit;
select count(*) from pivotTest;

select username, 
sum(if(season = '봄', amount,0)) as 봄,
sum(if(season = '여름', amount,0)) as 여름,
sum(if(season = '가을', amount,0)) as 가을,
sum(if(season = '겨울', amount,0)) as 겨울,
sum((amount)) as 합계
from pivotTest 
group by username;


-- json 데이터 ()
-- 속성 : 값
-- {
-- "아이디" : "winter",
-- "이름" : "ssg"
-- }


-- mysql json 관련된 다양한 내장 함수 제
select * from membertbl;
select json_object('memberID',memberid,'memberName',memberName) as 'json값' from membertbl;

SET @json = '{
    "membertbl": [
        {"memberID": 2, "membername": "신세계1"},
        {"memberID": 3, "membername": "신세계2"},
        {"memberID": 4, "membername": "신세계1"}
    ]
}';

SELECT JSON_VALID(@json) AS json_valid;  -- 1 (유효한 JSON) 

select json_search(@json,'one','신세계1') as json_search;
select json_search(@json,'all','신세계1') as json_search;

select * from usertbl where name = '김범수';
-- 김범수 회원이 구매한 물품리스트를 출력 => 김범수 회원이 여러명 있을 수 있으므로 김범수 뢰원의 아이디를 확인 후 쿼리문을 작성하는게 정확하다.

select prodName
from buytbl b, usertbl u
where b.userID = u.userID 
and u.name = '김범수';

-- 구매한 기록이 있는 회원들의 정보만 출력하세요

-- 우리 쇼핑몰에서 한번이라도 구매한 기록이 있는 회원들에게 쿠폰지금, 안내문 발송
select distinct u.name
from usertbl u
where exists(
select * from buytbl b where u.userid = b.userid
);

-- 전체회원의 구매 기록을 출력(단 구매 기록이 없는 회원도 출력)
select u.userid, u.name, b.prodname
from buytbl b
	right outer join usertbl u
		on u.userid = b.userid
	order by u.userid;
    
-- 구매이력이 아예 없는 회원 출력
create table ghostmember as
select u.userid, u.name, b.prodname
from buytbl b
	right outer join usertbl u
		on u.userid = b.userid
        where b.prodname is null
	order by u.userid;
    
    select * from ghostmember;
 
 
 -- 서브쿼리 : 쿼리안에 또 다른 쿼리 (중첩된 쿼리)
 
 -- 조건 : 1. 반드시 소괄호() 감싸 사용한다. 2. 서브쿼리는 주 쿼리를 실행하기 전에 1 번만 실행한다. 3. 비교연산자와 함꼐 사용하면 서브쿼리를 반드시 오른쪽에 둬야한다.
 -- 4, 서브쿼리 내부에서는 order by 문을 사용할 수 없다.
 -- 다중행 현산자 : in : 서브쿼리의 결과에 존재하는 임의의 값과 동일한 조건 검색
 -- 2) any : 서브 쿼리의 결과에 존재하는 어느 하나의 값이라도 만족하는 조건 검색
 -- 3) all : 서브 쿼리의 결과에 존재하는 모든 값을 만족하는 조건 검색
 -- 4) exists : 서브 쿼리의 결과를 만족하는 값이 존재하는지 여부 확인
 
 
 use sakila;
 -- customer 테이블 참조하여 이름이 (first_name) 'rosa' 고객의 정보를 출력하시오
 
 select *
 from customer
 where customer_id = (select customer_id from customer where first_name = 'ROSA' );
 
  -- customer 테이블 참조하여 이름이 (first_name) 'rosa','ANA' 고객의 정보를 출력하시오
 
 select *
 from customer
 where customer_id in (select customer_id from customer where first_name in ('ROSA','ANA') );
 -- 서브쿼리에서 다중행 리턴
 
 -- film film_category category
 desc category;
 select * from category limit 10;
 desc film_category;
 select * from film_category limit 10;
 desc film;
 select * from film;
 
 
 select f.film_id, f.title
 from film f, film_category fc, category c
 where f.film_id = fc.film_id and fc.category_id = c.category_id
 and c.name = 'Action';

select film.film_id, film.title
from film
where film.film_id in (select film_category.film_id from film_category where film_category.category_id = (
select category.category_id from category where name = 'action'
));

 
 
 