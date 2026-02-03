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


-- update the gender who's customer id is 2 --

update customer 
set cust_gender = "Male"
where cust_id = 2;

-- update the age of cust_id 3 to 25 --
update customer 
set cust_age = 25
where cust_id = 3;

-- delete the data of cust_id = 1 --

delete from customer where cust_id = 1;


-- add 2 columns to table --
alter table customer 
add cust_status varchar(10),
add cust_remarks varchar(10);


-- verify --

desc customer_info;
select * from customer;


-- update the customer status active where cust id is 2,4--
-- here if we want to change in multiple rows like 2,3,4 so we need to use in operator --

update customer 
set cust_status = "Active"
where cust_id in (2,4);



-- disbale the safe mode for update --
set sql_safe_updates =0;


-- update the cust_remarks as 'none' where cust_name is nancy and she is from india

update customer
set cust_remarks = "None"
where cust_name = "Nancy" and cust_country = "India";


-- drop the column cust_status and cust_remarks --

alter table customer
drop column  cust_status,drop column cust_remarks;


-- chnange the column name cust_name to customer_name --

alter table customer 
change column cust_name customer_name varchar(50) not null;

-- rename the table name 

alter table customer rename to customer_info;

-- verify --

desc customer_info;



-- now we will see start transaction and roll back so what does it use for a when you run start transaction and then whatever query you will execute will be temp and when yoou write rollback and execute then all query which execute between start transaction and roll back will un done.


start transaction ;

update customer_info 
set cust_age = 45
where cust_id = 2;

select * from customer_info;
rollback;

select * from customer_info;



-- now we will write commit insted of rollback so it will store permenently --


start transaction ;

update customer_info 
set cust_age = 55
where cust_id = 4;

select * from customer_info;

commit;

select * from customer_info;


-- now if we start the transaction and and not write commit or rollback if we save file without this and close the app and when we came back it will auto rollback --


-- now we are working on new database

use employee_query;


select * from employee;

-- 1 find the department name and dept name unique --

select distinct(dept_name)
from employee;


-- 2 find the maximum salary 

select max(emp_salary)
from employee;


-- min,max,sum,avg,count -- aggregate function 


-- 3. find min salary 

select min(emp_salary)
from employee;


-- 4. find sum of all salary

select sum(emp_salary)
from employee;


-- 5. find the number of employees using count function 

select count(emp_id)
from employee;

