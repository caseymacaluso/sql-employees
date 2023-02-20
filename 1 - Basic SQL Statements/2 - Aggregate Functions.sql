-- Find the number of distinct departments from the dept_emp table
select count(distinct dept_no) from dept_emp;

-- Find the total salary amount paid out after Jan 1, 1997
select sum(salary) from salaries where from_date  > '1997-01-01';

-- Find lowest and highest employee #'s
select min(emp_no) from employees;
select max(emp_no) from employees;

-- Find average salary for contracts starting after Jan 1, 1997
select avg(salary) from salaries where from_date > '1997-01-01';

-- Round above amount to 2 decimals
select round(avg(salary), 2) from salaries where from_date > '1997-01-01';

----------------------------------

-- Add a null constraint to dept_name
alter table departments_dup
change column dept_name dept_name varchar(40) null;

-- Insert values for the dept_no into the departments duplicate table
select * from departments_dup order by dept_no ASC;

-- Add dept_manager column to departments_dup table
alter table departments_dup
add column dept_manager varchar(255) null after dept_name;

select * from departments_dup order by dept_no ASC;
commit;

-- select department information, and specify information to display if certain information is null
select ifnull(dept_no, 'N/A'), ifnull(dept_name, 'Department name not provided'), coalesce(dept_no, dept_name) as dept_info
from departments_dup;