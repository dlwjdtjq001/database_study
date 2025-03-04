-- geometry 타입 공간데이터 저장형식
-- json 8byte 타입 지원

-- set @변수이름 = 변수의 값;
-- select @변수이름;
set @myvar1 = 5;
set @myvar2 = 6;
set @myvar3 = 7;
set @myvar4 = 8;
set @myvarName = '이름 ==>';

select @myvar1 + @myvar2;
select @myvarName, memberName From membertbl where memberAddress like('서울');
select * from membertbl;
insert into membertbl values
(1,'ssg','서울');
commit;
