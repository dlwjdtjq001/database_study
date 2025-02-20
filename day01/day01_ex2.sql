
create database ssg;
create table test(
id int auto_increment primary key,
name varchar(20) not null
);
use ssgdb;
SELECT user, host FROM mysql.user WHERE user = 'ssg';
drop user 'ssg'@'localhost';
create user ssg@localhost identified by 'ssg1234'; 
grant all privileges on ssgdb.* to 'ssg'@'localhost';

insert into test (name) values 
('aaaa'),
('bbbb'),
('cccc');
select * from test;
