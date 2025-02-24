use testdb;
create table test_create_table(col_1 int, col_2 varchar(50), col_3 datetime);

insert into test_create_table(col_1, col_2, col_3) values (1, 'testSQL', now());
insert into test_create_table values (1, 'testSQL', now());

rollback;
select * from test_create_table;

-- 여러 데이터를 한번에 삽입
insert into test_create_table values
(8, 'testSQL', now()),
(9, 'testSQL', now()),
(10, 'testSQL', now());

select * from test_create_table;
-- test_create_table 의 col1_1의 컬럼 속성을 변경 col1_1의 속성을 int -> smallint notnull 속성 추가
alter table test_create_table modify col_1 smallint not null;
desc test_create_table;

-- update 문으로 데이터 수정
update test_create_table set col_2 = 'testSQL_UPDATE' where col_1 = 5;

-- commit 시에는 반영된 데이터 값을 되돌릴 수 없다.
-- dml 작업시 특히 delete 작업시 commit 작업은 신중히, 최소시 rollback 하면 한단계 취소

-- delete from 테이블 이름 where 열 = 조건;
delete from test_create_table;

use testdb;
create table NewBook(
bookid integer,
bookname varchar(20),
publisher varchar(20),
price integer,
primary key(bookid)
);

desc NewBook;
alter table NewBook modify bookname varchar(20) not null;
alter table NewBook modify publisher varchar(20) unique;
alter table NewBook modify price Integer default 10000 check (price > 1000);
alter table NewBook 
drop primary key;
alter table NewBook 
add primary key(bookid);
desc NewBook;

insert into NewBook values 
(1,'쉽게풀어쓴자바','오나로',10000);



select * from NewBook;

create table NewCustomer(
custid integer primary key,
name varchar(40),
address varchar(40),
phone varchar(30)
);

create table NewOrders(
orderid INTEGER,
custid INTEGER not null,
bookid INTEGER not null,
saleprice INTEGER,
orderdate DATE,
primary key(orderid),
foreign key(custid) references NewCustomer(custid),
foreign key(bookid) references NewBook(bookid)
);

alter table NewBook add isbn varchar(13);
alter table NewBook modify isbn Integer;
alter table NewBook drop isbn;
alter table NewBook modify bookid integer not null;
desc NewBook;
desc NewOrders;
drop table NewBook;
drop table NewCustomer;
use testdb;

-- foreign key (관계 해제)  => 테이블을 기준, 데이터베이스 기준 외래키 확인 

select * from information_schema.table_constraints where table_name = 'neworders';

alter table neworders drop foreign key neworders_ibfk_2;
alter table neworders drop foreign key fk_custid;

alter table neworders add constraint fk_bookid foreign key(bookid) references newbook(bookid) on delete cascade; 
alter table neworders add constraint fk_custid foreign key(custid) references newcustomer(custid) on delete cascade; 

select * from NewCustomer;
insert into NewCustomer values(1,'sad','asd','asd');
insert into NewCustomer values(1,'sad','asd','asd');

update newcustomer set custid = 1 where custid =2;

delete from newcustomer where custid =2;

-- newBook 테이블 책 한권 저장
insert into NewBook values(4,'쉽게 배우는 디비','오광록',10000);

select * from newBook;
-- neworders 테이블에 custid 1인 고객이 북아이디 1 인 책을 주문goTek. 해당 데이터를 입력
desc neworders;
-- neworders 테이블에 orderid에 auto_increment 속성 추가
alter table NewOrders modify orderid int not null auto_increment;

insert into neworders values (null, 1,1,9000,now());
update neworders set bookid = 4 where custid =1;

delete from neworders where custid =1;



