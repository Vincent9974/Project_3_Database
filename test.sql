use test;
create table class_test(id int, name varchar(128) unique, teacher varchar(64), 
index idx_no(id desc));

show create table class_test;

insert into class_test values(1, '一班', 'Martin');
insert into class_test values(1, '二班', 'vc');

select * from class_test where id > 0;



CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    employee_number INT UNIQUE,
    salary DECIMAL(10, 2),
    unique index idx_id(employee_id)
);

INSERT INTO employees (employee_id, employee_name, employee_number, salary) VALUES
(1, 'John Doe', 101, 50000.00),
(2, 'Jane Smith', 102, 60000.00),
(3, 'Bob Johnson', 103, 55000.00);


alter table employees
add unique index idx_num(employee_number);


alter table employees
alter index idx_num invisible;

alter table employees
alter index idx_num visible;

show create table employees;


drop index idx_num on employees;

show index from employees;



CREATE TABLE documents (
    id INT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT,
    FULLTEXT (title, content)
);

INSERT INTO documents (id, title, content) VALUES
(1, 'Introduction to MySQL', 'MySQL is a popular relational database management system.'),
(2, 'Advanced SQL Techniques', 'Learn advanced SQL techniques for efficient data retrieval.'),
(3, 'Database Design Best Practices', 'Explore best practices for designing effective databases.');

INSERT INTO documents (id, title, content) VALUES
(4, 'Introduction to MySQL', '丁真 理塘 王.');


select * from documents;

select * from documents where match(title, content) against('丁真');

create table students(
id int primary key auto_increment,
name varchar(64),
age int,
grade char(1)
);

insert into students(name,age,grade) values
('John Doe', 20, 'A'),
('Jane Smith', 22, 'B'),
('Bob Johnson', 21, 'C');

select * from students;

truncate table students;

delete from students;


update students 
set grade = 'B';

delete from  students where id>0;


use test;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);


CREATE TABLE employees_1 (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50)
);

INSERT INTO employees_1 (employee_id, first_name, last_name, department)
VALUES
    (1, 'John', 'Doe', 'HR'),
    (2, 'Jane', 'Smith', 'IT'),
    (3, 'Bob', 'Johnson', 'HR'),
    (4, 'Alice', 'Brown', 'IT'),
    (5, 'Charlie', 'Williams', 'Finance'),
    (6, 'Diana', 'Miller', 'Finance');
    
select distinct (department), first_name from employees_1;


-- in 查询
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

INSERT INTO products (product_id, product_name, category, price)
VALUES
    (1, 'Laptop', 'Electronics', 1200.00),
    (2, 'Smartphone', 'Electronics', 800.00),
    (3, 'Coffee Maker', 'Appliances', 50.00),
    (4, 'Headphones', 'Electronics', 100.00),
    (5, 'Toaster', 'Appliances', 30.00),
    (6, 'Camera', 'Electronics', 500.00);
    
select * from products where category in('Electronics','Appliances');

select * from products;

-- in + 子查询
select * 
from products
where category  in(select distinct category from products where price>100);

-- not in
select * from products where category not in('Electronics');

-- between and 查询
CREATE TABLE employees_2 (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hire_date DATE
);

INSERT INTO employees_2 (employee_id, first_name, last_name, hire_date)
VALUES
    (1, 'John', 'Doe', '2022-01-15'),
    (2, 'Jane', 'Smith', '2021-08-22'),
    (3, 'Bob', 'Johnson', '2022-02-10'),
    (4, 'Alice', 'Brown', '2021-12-05'),
    (5, 'Charlie', 'Williams', '2022-03-01'),
    (6, 'Diana', 'Miller', '2022-01-30');

SELECT *
FROM employees_2
where hire_date between '2022-01-01' and '2022-02-28';

-- 取反
select * 
from employees_2
where hire_date not between '2022-01-01' and '2022-02-28';


-- like 模糊查找
CREATE TABLE products_1 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

INSERT INTO products_1 (product_id, product_name, category, price)
VALUES
    (1, 'Laptop', 'Electronics', 1200.00),
    (2, 'Smartphone', 'Electronics', 800.00),
    (3, 'Coffee Maker', 'Appliances', 50.00),
    (4, 'Headphones', 'Electronics', 100.00),
    (5, 'Toaster', 'Appliances', 30.00),
    (6, 'Camera', 'Electronics', 500.00);

select * 
from products_1
where product_name like '%%';

-- group by
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    sale_date DATE,
    quantity INT,
    price DECIMAL(10, 2)
);

INSERT INTO sales (sale_id, product_id, sale_date, quantity, price)
VALUES
    (1, 101, '2022-01-15', 5, 120.00),
    (2, 102, '2022-01-16', 3, 80.00),
    (3, 101, '2022-01-17', 2, 50.00),
    (4, 103, '2022-01-18', 4, 100.00),
    (5, 102, '2022-01-19', 1, 30.00),
    (6, 101, '2022-01-20', 3, 50.00);



select product_id, sum(quantity) as total_quantity, avg(price)
from sales
group by product_id;

-- GroupConcat
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    class_id INT,
    student_name VARCHAR(50)
);

INSERT INTO students (student_id, class_id, student_name)
VALUES
    (1, 101, 'John Doe'),
    (2, 102, 'Jane Smith'),
    (3, 101, 'Bob Johnson'),
    (4, 103, 'Alice Brown'),
    (5, 102, 'Charlie Williams'),
    (6, 101, 'Diana Miller');

select class_id, group_concat(student_name separator ',') 
as student_name 
from students
group by class_id;


-- 内连接
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(50)
);

INSERT INTO orders (order_id, customer_id, order_date, total_amount)
VALUES
    (1, 101, '2022-01-15', 120.00),
    (2, 102, '2022-01-16', 80.00),
    (3, 101, '2022-01-17', 50.00),
    (4, 103, '2022-01-18', 100.00),
    (5, 102, '2022-01-19', 30.00),
    (6, 101, '2022-01-20', 50.00);

INSERT INTO customers (customer_id, customer_name, email)
VALUES
    (101, 'John Doe', 'john@example.com'),
    (102, 'Jane Smith', 'jane@example.com'),
    (103, 'Bob Johnson', 'bob@example.com');

select orders.order_id, order_date, total_amount, customer_name, email
from orders
inner join customers 
on orders.customer_id = customers.customer_id;

-- 自连接
CREATE TABLE employees_3 (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    manager_id INT
);

INSERT INTO employees_3 (employee_id, employee_name, manager_id)
VALUES
    (1, 'John Doe', NULL),
    (2, 'Jane Smith', 1),
    (3, 'Bob Johnson', 1),
    (4, 'Alice Brown', 2),
    (5, 'Charlie Williams', 2),
    (6, 'Diana Miller', 3);
    
    
select e1.employee_name as employee, e2.employee_name as manager
from employees_3 e1
left join employees_3 e2 on e1.manager_id = e2.employee_id;


-- 等值连接
CREATE TABLE employees_4 (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT
);

CREATE TABLE departments_4 (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO employees_4 (employee_id, employee_name, department_id)
VALUES
    (1, 'John Doe', 101),
    (2, 'Jane Smith', 102),
    (3, 'Bob Johnson', 101),
    (4, 'Alice Brown', 103),
    (5, 'Charlie Williams', 102),
    (6, 'Diana Miller', 101);

INSERT INTO departments_4 (department_id, department_name)
VALUES
    (101, 'HR'),
    (102, 'IT'),
    (103, 'Finance');

select employees_4.employee_name, departments_4.department_name
from employees_4
join departments_4 on employees_4.department_id = departments_4.department_id;

-- 不等值连接
CREATE TABLE orders_2 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

CREATE TABLE customers_2 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    registration_date DATE
);

INSERT INTO orders_2 (order_id, customer_id, order_date, total_amount)
VALUES
    (1, 101, '2022-01-15', 120.00),
    (2, 102, '2022-01-16', 80.00),
    (3, 101, '2022-01-17', 50.00),
    (4, 103, '2022-01-18', 100.00),
    (5, 102, '2022-01-19', 30.00),
    (6, 101, '2022-01-20', 50.00);

INSERT INTO customers_2 (customer_id, customer_name, registration_date)
VALUES
    (101, 'John Doe', '2021-12-01'),
    (102, 'Jane Smith', '2022-01-01'),
    (103, 'Bob Johnson', '2021-11-15');

select orders_2.order_id, orders_2.total_amount,
customers_2.customer_name, customers_2.registration_date
from orders_2
JOIN customers_2 ON orders_2.customer_id = customers_2.customer_id 
AND orders_2.order_date > customers_2.registration_date;

-- 外连接
-- 左外链接
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO employees (employee_id, employee_name, department_id)
VALUES
    (1, 'John Doe', 101),
    (2, 'Jane Smith', 102),
    (3, 'Bob Johnson', 101),
    (4, 'Alice Brown', 103),
    (5, 'Charlie Williams', 102),
    (6, 'Diana Miller', 101);

INSERT INTO departments (department_id, department_name)
VALUES
    (101, 'HR'),
    (102, 'IT'),
    (103, 'Finance');

SELECT employees.employee_id, employee_name, department_name
FROM employees
LEFT JOIN departments ON employees.department_id = departments.department_id;

SELECT employees.employee_id, employee_name, department_name
FROM employees
RIGHT JOIN departments ON employees.department_id = departments.department_id;

-- union

CREATE TABLE students1 (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);

CREATE TABLE students2 (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);

INSERT INTO students1 (student_id, student_name) VALUES
    (1, 'John Doe'),
    (2, 'Jane Smith'),
    (3, 'Bob Johnson');

INSERT INTO students2 (student_id, student_name) VALUES
    (3, 'Alice Brown'),
    (4, 'Charlie Williams'),
    (5, 'Diana Miller');


INSERT INTO students1 (student_id, student_name) VALUES
(6, 'Alice Brown');
INSERT INTO students2 (student_id, student_name) VALUES
(6, 'Alice Brown');

-- union all 不消除重复
select student_id, student_name from students1
union all
select student_id, student_name from students2;

-- union 消除一样的,相当于union all 后 进行 distinct
select student_id, student_name from students1
union 
select student_id, student_name from students2;

-- 子查询

SELECT employee_id, employee_name
FROM employees e
WHERE EXISTS (SELECT 1 FROM departments d 
WHERE e.department_id = d.department_id AND d.department_name = 'HR');

SELECT employee_id, employee_name
FROM employees
WHERE department_id IN (SELECT department_id FROM departments 
WHERE department_name = 'HR');

SELECT department_id, department_name
FROM departments
WHERE department_id = ANY (SELECT department_id FROM employees 
WHERE employee_name = 'John Doe');

-- 返回属于 HR 或 IT 部门的员工信息
SELECT employee_id, employee_name, department_id
FROM employees
WHERE department_id = ANY (SELECT department_id FROM departments 
WHERE department_name IN ('HR', 'IT'));

-- 视图
CREATE TABLE employees_5 (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2)
);

INSERT INTO employees_5 VALUES
    (1, 'John Doe', 101, 50000),
    (2, 'Jane Smith', 102, 60000),
    (3, 'Bob Johnson', 101, 55000),
    (4, 'Alice Brown', 103, 70000);

create view hr_employees_ as 
select  employee_id,employee_name,salary
from employees_5
where department_id = 101;


SELECT * FROM hr_employees_;
show create view hr_employees_;

show tables;



-- 增加隐私列
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    encrypted_credit_card VARCHAR(256) -- 加密后的信用卡号
);

create or replace  view hr_employees_ as
select  employee_id,employee_name,salary
from employees_5
where department_id = 101 and salary > 5000;

drop view if exists hr_employees_;

-- 触发器,增改时更新班级表的人数
create table classes(
	class_id int primary key,
    class_name varchar(50),
    student_count int
);

create table students(
	student_id int primary key,
    student_name varchar(64),
    class_id int,
    foreign key(class_id) references classes(class_id)
);

-- 创建触发器，当在学生表中插入新学生时，更新班级表的学生人数
CREATE TRIGGER update_student_count_after_insert
AFTER INSERT
ON students
FOR EACH ROW

UPDATE classes
SET student_count = student_count + 1
WHERE class_id = NEW.class_id;

-- 创建触发器，当在学生表中删除学生时，更新班级表的学生人数
delimiter //
create trigger update_student_count_after_delete
after delete
on students
for each row
begin
	update classes
	set student_count = student_count - 1
	WHERE class_id = OLD.class_id;
end;
//
delimiter ;

-- 插入班级数据
INSERT INTO classes (class_id, class_name, student_count) VALUES
(1, '计算机科学', 0),
(2, '数学', 0);

select student_count from classes;

INSERT INTO students (student_id, student_name, class_id) VALUES
(1, '张三', 1),  -- 将计算机科学班级的学生人数更新为 1
(2, '李四', 1),  -- 将计算机科学班级的学生人数更新为 2
(3, '王五', 2);  -- 将数学班级的学生人数更新为 1

delete from  students where student_name = '张三';

-- 查看触发器
show triggers;

-- 查看系统表triggers查看触发器
use information_schema;
select * from triggers;
use test;

-- 创建存储过程
delimiter //
create procedure insert_student(
	in p_student_id int,
    in p_student_name varchar(64),
    in p_class_id int
)
begin
	insert into students(student_id, student_name, class_id)
    values (p_student_id, p_student_name, p_class_id);

end //
delimiter ;

-- 调用函数
call insert_student(4, 'John Doe', 1);
select * from students;


delimiter //
create procedure GetStudentInfo_1()
begin
	declare studentID int;
    declare studentName varchar(64);
    declare classID int;
    
    select student_id, student_name, class_id
    into studentID,studentName,classID
    from students
    where student_id =1;
	 SELECT 'Student ID:', studentID, 'Student Name:', studentName, 'Class ID:', classID;
end //
delimiter ;

CALL GetStudentInfo_1();

-- 光标
delimiter //
create procedure ShowStudentName()
begin
	-- 申明变量
	declare done int default 0;
    declare studentName varchar(64);
    
    -- 申明游标
	declare studentCursor cursor for
		select student_name from students;
	
    -- 申明异常处理
    declare continue handler for not found set done =1;
    
	open studentCursor;
    
    cursorLoop: LOOP
		fetch studentCursor into studentName;
        
        if done = 1 then
			leave cursorLoop;
		end if;
    
		select concat('Student Name: ', studentName) as result;
	end loop;
    
    close studentCursor;

end //
delimiter ;

call ShowStudentName();

-- if 
delimiter //
create procedure DisplayStudentInfoByAge(IN p_age int)
begin
	-- 申明变量
    declare studentName varchar(64);
    
    -- 获取学生姓名
    select student_name into studentName
    from students
    where age = p_age;

	if p_age < 18 then
		select concat('student ', studentName, '  is a minor.') as result;
	else
		select concat('student ', studentName, '  is a adult.') as result;
	end if;
end //
delimiter ;

alter table students
add column age int;

update students
set age = 18 ;

select* from students;

call DisplayStudentInfoByAge(18);

-- loop
DELIMITER //

CREATE PROCEDURE ExampleLoopProcedure()
BEGIN
    -- 声明变量
    DECLARE counter INT DEFAULT 0;

    -- 开始 LOOP
    simpleLoop: LOOP
        -- 在循环中执行的代码
        SET counter = counter + 1;

        -- 打印计数器的值
        SELECT counter;

        -- 检查是否达到退出条件
        IF counter = 5 THEN
            LEAVE simpleLoop;
        END IF;
    END LOOP simpleLoop;
END //

DELIMITER ;

call ExampleLoopProcedure();

-- iterate
delimiter //

create procedure ExampleIterateProcedure()
begin
    -- 声明变量
    DECLARE counter INT DEFAULT 0;

    -- 开始 LOOP
    simpleLoop: LOOP
        -- 在循环中执行的代码
        SET counter = counter + 1;

        -- 如果计数器的值为奇数，跳过本次迭代，执行下一次迭代
        IF counter % 2 <> 0 THEN
            ITERATE simpleLoop;
        END IF;

        -- 打印计数器的值（仅在偶数时执行）
        SELECT counter;

        -- 检查是否达到退出条件
        IF counter >= 5 THEN
            LEAVE simpleLoop;
        END IF;
    END LOOP simpleLoop;
end //
delimiter ;
 
 
 -- repeat do_while 至少执行一次
 DELIMITER //

CREATE PROCEDURE ExampleRepeatProcedure()
BEGIN
    -- 声明变量
    DECLARE counter INT DEFAULT 0;

    -- 开始 REPEAT
	simpleRepeat: repeat	
        -- 在循环中执行的代码
        SET counter = counter + 1;

        -- 打印计数器的值
        SELECT counter;

        -- 检查是否达到退出条件
        IF counter >= 5 THEN
            LEAVE simpleRepeat;
        END IF;
    until counter >= 5 end repeat;
END //

DELIMITER ;


-- while 与repeat 类似, 但每次循环检查条件
DELIMITER //

CREATE PROCEDURE ExampleWhileProcedure()
BEGIN
    -- 声明变量
    DECLARE counter INT DEFAULT 0;

    -- 开始 WHILE 循环
    while counter < 5 do
        -- 在循环中执行的代码
        SET counter = counter + 1;

        -- 打印计数器的值
        SELECT counter;
    end while;
END //

DELIMITER ;

 show procedure status like '%student%';

show create PROCEDURE ExampleWhileProcedure;

select * from information_schema.Routines where routine_name = 'ExampleWhileProcedure';

show engines;


