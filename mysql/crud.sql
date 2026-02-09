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



-- 4 feb 2025 ---

show databases;

use employee_query;

show tables;

select * from employee;


-- 4 find the employee from table where employee salary is grater than 40000 --

select * from employee where emp_salary > 40000;

-- 5 find the employee from table where employee salary is less than 50000 and from IT department --

select * from employee where emp_salary < 50000 and dept_name = "IT";


-- 6 find the employee from table who is belong to IT or Sales Department --

select * from employee where dept_name = "IT" or dept_name = "Sales";

--          OR We can Use         --

select * from 
employee where dept_name in ('IT','Sales');



-- 7 finnd the employee who is not belong to IT department --


select * from employee where dept_name not in ('IT');


--             OR We Can Use          --

select * from employee where dept_name != 'IT';


--             OR We Can Use         ---

select * from employee where not dept_name = "IT";




-- 8 find the number of employees in each department here we will learn group by --

select count(emp_id) as no_of_emp,dept_name,sum(emp_salary)
from employee 
group by (dept_name);


-- 9 find the number of employees in each department and max salary in each dpet --

select dept_name,max(emp_salary)
from employee 
group by (dept_name);

-- 10 find the total salary in each department 

select dept_name,sum(emp_salary)
from employee 
group by (dept_name);

-- 11 find the top 3 rows from employee

select * from employee limit 3 ;


-- 12 sort the emp_salary in ASC order --

select * from employee order by emp_salary ASC;


-- 13 sort the emp_salary in DESC order --

select * from employee order by emp_salary DESC;

-- 14 find the details of employee who is getting max salary --

select 
emp_name, 
emp_salary
from employee
order by emp_salary DESC
limit 1;


-- now we will learn the sub query -- corrcet solution of 14 question 

select * from
employee where emp_salary = (select max(emp_salary) from employee);



-- 15 , 16 find the second highest salary form employee 

select * from 
employee where emp_salary 
= (select max(emp_salary)
from employee where emp_salary < (select max(emp_salary) from employee));


-- 17 , 18 find the details of employee where at least more than 2 employee in each department --

SELECT count(emp_id),dept_name
    FROM employee
    GROUP BY dept_name
    HAVING COUNT(emp_id) > 2;

SELECT *
FROM employee
WHERE dept_name IN (
    SELECT dept_name
    FROM employee
    GROUP BY dept_name
    HAVING COUNT(emp_id) > 2
);

-- 5 feb 2026 --


use employee_query;

show tables;


select * from employee;



-- find the details of the employee who is getting salary more than avg salary --

select avg(emp_salary) from employee;

select * from employee where emp_salary > (select avg(emp_salary) from employee);


-- find the details of the employee who's salary range is between 30k to 60k --

select * from 
employee where emp_salary between 30000 and 60000;


-- find the details of employees working in same department as Ram --

select dept_name from employee where emp_name = "Ram";

select * from employee where dept_name = ( select dept_name from employee where emp_name = "Ram");


-- find the dept name where avg salary > 40000 --


select dept_name from employee group by dept_name having avg(emp_salary) > 40000;


-- find department name where having total salary > 100000 --

select dept_name,sum(emp_salary) from employee group by dept_name having sum(emp_salary) > 100000;


-- pattern matching --
-- find the details of employee who's name start with A --

select *
from employee
where emp_name like "a%"; -- here a indicates start with a and % means all charchters after a

select *
from employee
where emp_name like "z%";

select * 
from employee 
where emp_name like "%a";


-- find employee name start with r and have at least 3 charchter --

select * 
from employee
where emp_name like "R___";


-- find the department name start with H --

select dept_name from employee where dept_name like "H%";


-- find the emp name which have exactly 4 letters --

select emp_name from employee where emp_name like "____";


-- insert the data of emp --

insert into employee values
(113,"Nancy","IT",NULL),
(114,"Abu","HR",NULL),
(115,"Sharwan","Fianence",Null);

-- find the em details who's salary is null --



select * from employee where emp_salary IS NULL;



select * from employee where emp_salary is not null;



SET SQL_SAFE_UPDATES = 0;

delete from employee where emp_salary is null;


-- new database for leanr joints and fk and pk --

create database join_fk_db;


use join_fk_db;



create table department 
(dept_id int auto_increment primary key,
dept_name varchar(30),
dept_head varchar(50));



create table employee 
(emp_id varchar(10) primary key,
emp_name varchar(30),
emp_salary int,
dept_id int ,
foreign key (dept_id) references department(dept_id));  -- here this line is for connecting department and employee using dept_id --


select * from department;
insert into department (dept_name,dept_head) values ("HR","Santosh");


-- 9th feb 2026 --

use join_fk_db;

show tables;


desc department;
desc employee;


select * from department;


insert into department(dept_name,dept_head) values ("Sales","Ajay");
insert into department(dept_name,dept_head) values ("IT","Diya"),
("Account","Fathima"),
("Admin","Archana");


select * from department;



insert into employee values 
("EMP001","AKSHATHA",65000,1),
("EMP002","BANU",35000,1),
("EMP003","JHON",45000,1),
("EMP004","TARUN",65000,NULL),
("EMP005","DIVYA",58000,2),
("EMP006","NAVANITH",95000,2),
("EMP007","SHRAVYA",85000,3),
("EMP008","RANI",75000,NULL),
("EMP009","GAGAN",42000,3),
("EMP010","RAJ",15000,NULL);

SELECT * FROM EMPLOYEE;

insert into employee values 
("EMP011","CHARAN",65000,9); -- THIS WILL THORW AN ERROR CAUSE DEPT ID 9 DOES NOT EXIST --


start transaction ;

delete from department where dept_id = 3; -- this will throw error cause it is connected with employee table so it will not delete

rollback;



-- find the dept head of the akshatha --


select dept_head from department where dept_id = (
select dept_id from employee where emp_name = "AKSHATHA");


-- METHOD 2 using joins 

select d.dept_head 
from department as d 
inner join 
employee as e 
on d.dept_id = e.dept_id
where e.emp_name = "AKSHATHA";



-- FIND THE DETAILS OF EMPLPOYEE WHERE DEPARTMENT IS IT

select * from employee as e 
inner join 
department as d 
on e.dept_id = d.dept_id 
where d.dept_name = "IT";



-- display all the employees along with thier dept_name -- 

SELECT e.emp_name,d.dept_name,d.dept_head FROM employee as e 
left join department as d 
on e.dept_id = d.dept_id;


-- display all department along with their employee name --
SELECT d.dept_name,e.emp_name FROM employee as e 
right join department as d 
on e.dept_id = d.dept_id;



-- find the numbers of employee in each department -- 


SELECT 
    d.dept_name,
    COUNT(e.emp_id) AS employee_count
FROM department d
JOIN employee e 
    ON e.dept_id = d.dept_id
GROUP BY d.dept_name;
