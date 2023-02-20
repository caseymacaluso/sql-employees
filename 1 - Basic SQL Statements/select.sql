select dept_no from departments;
select * from departments;

# WHERE
select * from employees where first_name = 'Elvis';

# AND
select * from employees where gender = 'F' and first_name = 'Kellie';

# OR
select * from employees where first_name = 'Kellie' or first_name = 'Aruna';

# AND OR
select * from employees where gender = 'F' and (first_name = 'Kellie' or first_name = 'Aruna');

# IN ...  NOT IN
select * from employees where first_name in ('Denis', 'Elvis');
select * from employees where first_name not in ('John','Mark','Jacob');

# LIKE ... NOT LIKE
select * from employees where first_name like ("Mark%");
select * from employees where hire_date like ('2000%');
select * from employees where emp_no like ('1000_');
select * from employees where first_name like ('%Jack%');
select * from employees where first_name not like ('%Jack%');

# BETWEEN ... NOT BETWEEN
select * from salaries where salary between 66000 and 72000;
select * from employees where emp_no not between '10004' and '10012';
select * from departments where dept_no between 'd003' and 'd006';

# IS NOT NULL
# Find all departments that have a department number
select * from departments where dept_no is not null;

# Comparison Ops
-- Find all female employees hired from Jan 1, 2000 and later
select * from employees where gender = 'F' and hire_date >= '2000-01-01';
-- Find all employees who make more than $150k
select * from salaries where salary > 150000;

# DISTINCT
-- Find the unique hire dates for all employees
select distinct hire_date from employees;

# Aggregate functions
-- Find the # of salaries higher than $100k
select count(salary) from salaries where salary >= 100000;
-- Find the * of records in the dept_manager table
select count(*) from dept_manager;

# ORDER BY
select * from employees order by hire_date desc;

# GROUP BY
-- Find the # of employees contracted to a specific salary higher than $80k
select salary, count(emp_no) as emps_with_same_salary
from salaries
where salary > 80000
group by salary
order by salary;

# HAVING
-- select all employees who have an average salary higher than $120k
select emp_no, avg(salary)
from salaries
group by emp_no
having avg(salary) > 120000;

# GROUP BY and ORDER BY
SELECT *, AVG(salary)
FROM salaries
WHERE salary > 120000
GROUP BY emp_no
ORDER BY emp_no; # larger output because we include salaries higher than 120k

-- Select employee #s for everyone who's signed more than 1 contract after a certain date
select emp_no
from dept_emp
where from_date > '2000-01-01'
group by emp_no
having count(from_date) > 1;

# LIMIT
-- selects first 100 records
select * from dept_emp limit 100;