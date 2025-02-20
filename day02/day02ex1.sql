show databases;
create database shopdb;
use shopdb;

create table memberTBL(
memberID VARCHAR(8) not null,
memberName varchar(10) not null,
memberAddress varchar(20),
primary key(memberID)
);
create table productTBL(
productID int auto_increment,
productName varchar(4) not null,
cost int not null,
makeDate date,
primary key(productID)
);
show tables;

-- 테이블 수정
alter table productTBL add column productID int not null unique;
-- 테이블 수정(컬럼 삭제)
alter table pruductTBL drop column productID;
alter table productTBL change column cost price int;
select * from productTBL;
-- name 컬럼 앞에 productid 컬럼 추가
alter table productTBL add column productID int not null first;
-- 테이블에 지정 컬럼 뒤에 추가
alter table productTBL add column descript varchar(100) not null after price; 
-- 컬럼 타입 변경
alter table productTBL MODIFY COLUMN price smallint;
desc productTBL;
 