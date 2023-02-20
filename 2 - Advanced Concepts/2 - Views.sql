-- Create a view for the latest contract for each employee
create view v_dept_emp_latest_date as
select emp_no, max(from_date) as from_date, max(to_date) as to_date
from dept_emp
group by emp_no;

-- Extract the average salary of all department managers
create or replace view v_avg_manager_salary as
select round(avg(salary), 2)
from salaries s
join dept_manager d on s.emp_no = d.emp_no;