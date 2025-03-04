use 극장db;

create table 고객(
고객번호 int,
이름 varchar(20),
주소 varchar(20),
primary key (고객번호)
);

create table 극장(
극장번호 int auto_increment,
극장이름 varchar(20),
위치 varchar(20),
primary key (극장번호)
);

create table 상영관(
극장번호 int,
상영관번호 int,
영화제목 varchar(20),
가격 int check (가격 < 20000),
좌석수 int,
primary key(극장번호)
);


create table 예약(
극장번호 int,
상영관번호 int check (상영관번호 between 1 and 10),
고객번호 int,
좌석번호 int,
날짜 date,
primary key(고객번호, 좌석번호) -- 같은사람이 같은좌석 두번 안하기 떄문
);

alter table 상영관 add constraint fk_상영관_극장 foreign key (극장번호) references 극장 (극장번호);
alter table 예약 add constraint fk_예약_극장 foreign key (극장번호) references 극장 (극장번호);
alter table 예약 add constraint fk_예약_상영관 foreign key (상영관번호) references 상영관 (상영관번호);
alter table 예약 add constraint fk_예약_고객 foreign key (고객번호) references 고객 (고객번호);

insert into 고객 values
(3,'홍길동','강남'),
(4,'김철수','잠실'),
(9,'박영희','강남');
select * from 고객;

insert into 극장 values
(null, '롯데', '위치'),
(null, '메가', '강남'),
(null, '대한', '잠실');
update 극장
set 위치 = '잠실'
where 극장번호 = 1;

alter table 상영관 drop primary key;
alter table 상영관 add primary key (상영관번호, 극장번호);
insert into 상영관 values
(1,1,'어려운 영화',15000,48),
(3,1,'멋진 영화',7500,120),
(3,2,'재밌는 영화',8000,110);

insert into 예약 values
(3,2,3,15,'2024-09-01'),
(3,1,4,16,'2024-09-01'),
(1,1,9,48,'2024-09-01');

 


-- 1-1
select 극장이름 , 위치
from 극장;

-- 1-2
select *
from 극장
where 위치 = '잠실';

-- 1-3
select 이름
from 고객
where 주소 = '잠실'
order by 이름;

-- 1-4
select 극장번호, 상영관번호, 영화제목
from 상영관
where 가격 <= 8000;

-- 1-5
select *
from 고객
where 고객번호 in (
    select 고객번호
    from 예약
    where 극장번호 in (
        select 극장번호
        from 극장
        where 위치 = (select 주소 from 고객 where 고객.고객번호 = 예약.고객번호))); -- 예약한 극장의 위치와 고객의 주소가 일치
        
-- 2-1
select count(극장번호)
from 극장;

-- 2-2
select *
from 극장
where 위치 = '잠실';

-- 2-3
select count(*)
from 예약
where 날짜 = '2024-09-01';

-- 3-1
select 영화제목
from 상영관
where 극장번호 in (select 극장번호 from 극장 where 극장이름 = '대한');

-- 3-2
select 이름
from 고객
where 고객번호 in (select 고객번호 from 예약 where 극장번호 in (select 극장번호 from 극장 where 극장이름 = '대한'));

-- 3-3
select sum(가격)
from 상영관
where 극장번호 = (select 극장번호 from 극장 where 극장이름 = '대한');

-- 4-1
select 극장번호, count(상영관번호)
from 상영관
group by 극장번호;

-- 4-2
select * 
from 상영관
where 극장번호 in (select 극장번호 from 극장 where 위치 = '잠실');

-- 4-3
select count(*) , 극장번호
from 예약
where 날짜 = '2024-09-01' 
group by 극장번호;

-- 4-4
-- 4-4
SELECT 영화제목
        FROM 상영관, 예약
        WHERE 상영관.극장번호=예약.극장번호 AND 상영관.상영관번호=예약.상영관번호
        AND 날짜 LIKE '2024-09-01'
        GROUP BY 예약.극장번호, 예약.상영관번호
        HAVING COUNT(*) = (SELECT MAX(*)
        FROM 상영관, 예약
        WHERE 상영관.극장번호=예약.극장번호
        AND 상영관.상영관번호=예약.상영관번호
        AND 날짜 LIKE '2024-09-01'
        GROUP BY 예약.극장번호, 예약.상영관번호);

-- 5-1
insert into 고객 values (10,'고길동','노원');
insert into 극장 values (null,'cgv','홍대');
insert into 상영관 values (2,1,'아리랑',4000,30);
insert into 예약 values (2,1,10,29,'2024-10-10');

-- 5-2
set SQL_SAFE_UPDATES = 0;
update 상영관 set 가격 = 가격 * 1.1;
select * from 상영관;

