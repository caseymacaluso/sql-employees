# Session variables
SET @s_var1 = 3;
select @s_var1;

# Global variables
set global max_connections = 1000;
set @@global.max_connections = 1; # different syntax

# Triggers
delimiter $$
create trigger trig_update_hire_date
before insert on employees
for each row
begin
	if new.hire_date > date_format(sysdate(), '%y-%m-%d') then
		set new.hire_date = date_format(sysdate(), '%y-%m-%d');
	end if;
end$$
delimiter ;

INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');

SELECT  *  
FROM employees
ORDER BY emp_no DESC;

# Indexes
-- Indexes help to speed up processing time for specific operations
create index i_hire_date on employees(hire_date);
select * from employees where hire_date > '2000-01-01';

create index i_comp_index on employees(first_name, last_name);
select * from employees where first_name = 'Georgi' and last_name = 'Facello';

drop index i_hire_date on employees;

select * from salaries where salary > 89000;
create index i_salary on salaries(salary);
select * from salaries where salary > 89000; # Slower than before the index was created...

# CASE statement
-- Helps to display conditional content (think if...else... blocks)

-- Select all employees, + a column that shows if they are a 'Manager' or an 'Employee'
select
	e.emp_no,
    e.first_name,
    e.last_name,
    case
		when dm.emp_no is not null then 'Manager'
        else 'Employee'
	end as 'Designation'
from employees e
left join dept_manager dm on dm.emp_no = e.emp_no
where e.emp_no > 109990;

-- Find info on department managers + whether or not the difference between their highest and lowest contracts is higher than $30k
select
	e.emp_no,
    e.first_name,
    e.last_name,
    (
		select max(salary) - min(salary)
		from salaries s2
        where s2.emp_no = e.emp_no
	) as salary_diff,
    case
		when (
			select max(salary) - min(salary)
			from salaries s2
			where s2.emp_no = e.emp_no
		) > 30000 then 'Yes'
        else 'No'
	end as 'Higher than $30k?'
from employees e
join salaries s on e.emp_no = s.emp_no
join dept_manager dm on e.emp_no = dm.emp_no
group by e.emp_no;

-- Checks employees to see if they are still with the company
select
	e.emp_no,
    e.first_name,
    e.last_name,
    case
		when max(de.to_date) < sysdate() then 'No'
        else 'Yes'
	end as 'Currently Employed'
from employees e
join dept_emp de on e.emp_no = de.emp_no
group by de.emp_no
limit 100;


