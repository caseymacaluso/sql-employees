# INSERT
select * from titles order by emp_no desc limit 25;

-- Inserting records into the employees table
insert into employees values (999901, '1986-04-01', 'John', 'Smith', 'M', '2011-01-01');
insert into employees values (999902, '1973-03-26', 'Patricia', 'Lawrence', 'F', '2005-01-01');
insert into employees values (999903, '1977-09-14','Johnathan','Creek','M','1999-01-01');

-- Inserting records into the titles table
insert into titles (emp_no, title, from_date) values (999903, 'Senior Engineer', '1997-10-01');
select * from titles order by emp_no desc limit 25;

select * from dept_emp;

-- Insert record into the dept_emp table
insert into dept_emp values (999903, 'd005', '1997-10-01', '9999-01-01');
select * from dept_emp order by emp_no desc limit 10;

# Create a duplicate table of departments
create table departments_dup (
	dept_no char(4) not null,
    dept_name varchar(40) not null
);
# Insert from another table
insert into departments_dup select * from departments;
select * from departments_dup;

-- Insert a record into the departments table
insert into departments (dept_no, dept_name) values ('d010', 'Business Analysis');