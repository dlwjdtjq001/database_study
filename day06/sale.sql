show databases;
use sale;

create table Salesperson(
name varchar(20),
age int,
salary int
);

create table Customer(
name varchar(20),
custname varchar(20),
industrytype varchar(20)
);

alter table customer change custname city varchar(20);
desc customer;

create table Orders(
number int,
custname varchar(20),
salesperson varchar(20),
amount int
);


alter table orders
add constraint fk_orders_custname
foreign key (custname)
references customer (custname)
on delete cascade
on update cascade;



