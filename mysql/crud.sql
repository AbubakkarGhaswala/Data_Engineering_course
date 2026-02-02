-- TO VIEW THE LIST OF DATABASES --
show databases;

-- CREATE A DATABASE NAME SMARTQUICK_DB --
Create database smartquick_db;

-- SELECT DATABASE --
Use smartquick_db;

-- create table for customer --
create table customer (
cust_id int primary key auto_increment,
cust_name varchar(50) not null,
cust_age int check(cust_age > 16) not null,
cust_country varchar(20) default "India",
cust_gender varchar(10));

-- verify table --

show tables;


-- insert data into table --

insert into customer values
(1,"Abu",19,"USA","Male");

-- display all data from customer --

select * from customer;

-- display specific data from table --

select cust_name,cust_age from customer;

insert into customer values
(2,"Nancy",20,"India","Female"),
(3,"Amit",23,"India","Male"),
(4,"Abhay",22,"UAE","Male");


insert into customer (cust_id,cust_age) values (5,20);





