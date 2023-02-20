# Ranking
select
	emp_no,
    salary,
    row_number() over (partition by emp_no order by salary desc) as row_num
from salaries;

select
	*,
    row_number() over (order by emp_no asc) as manager_num
from dept_manager;

select
	emp_no,
    first_name,
    last_name,
    row_number() over (partition by first_name order by last_name asc) as row_num
from employees;

# Several Window Functions
select
	dm.emp_no,
    s.salary,
    row_number() over () as row_num,
    row_number() over (partition by dm.emp_no order by salary desc) as salary_rank
from
	dept_manager dm
join
	salaries s on dm.emp_no = s.emp_no
order by
	row_num, s.salary asc;
    
select
	dm.emp_no,
    s.salary,
    row_number() over (partition by dm.emp_no order by salary desc) as salary_rank,
    row_number() over (partition by dm.emp_no order by salary asc) as salary_rank_2
from
	dept_manager dm
join
	salaries s on dm.emp_no = s.emp_no;
    
# Window Clause
select
	*,
    row_number() over w as row_num
from employees
window w as (partition by first_name order by emp_no asc);

# Partition vs Group By
select * from (
	select
		emp_no,
		salary,
		row_number() over w as lowest_salary
	from
		salaries
	window w as (partition by emp_no order by salary asc)) a
where a.lowest_salary = 1;

select * from (
	select
		emp_no,
		salary,
		row_number() over (partition by emp_no order by salary asc)  as lowest_salary
	from
		salaries
	) a
where a.lowest_salary = 1;

select * from (
	select 
		emp_no,
		min(salary) as lowest_salary
	from
		salaries
	group by
		emp_no
) a;

# Rank and Dense Rank
select emp_no, salary
from salaries
where emp_no = 10560
order by salary desc;

select dm.emp_no, count(s.salary) as '# Contracts'
from dept_manager dm
join salaries s on dm.emp_no = s.emp_no
group by dm.emp_no;

select emp_no, salary, rank() over (partition by emp_no order by salary desc) as salary_rank
from salaries
where emp_no = 10560;

select emp_no, salary, dense_rank() over (partition by emp_no order by salary desc) as salary_dense_rank
from salaries
where emp_no = 10560;

# Window Functions and Joins
select
	e.emp_no,
    e.first_name,
    e.last_name,
    s.salary,
    rank() over w as salary_rank
from employees e
join salaries s on e.emp_no = s.emp_no
where e.emp_no between 10500 and 10600
window w as (partition by e.emp_no order by salary);

select
	e.emp_no,
    e.first_name,
    e.last_name,
    s.salary,
    dense_rank() over w as salary_rank
from employees e
join salaries s on e.emp_no = s.emp_no
where e.emp_no between 10500 and 10600
	and year(s.from_date) - year(e.hire_date) >= 5
window w as (partition by e.emp_no order by salary);

# Lag and Lead Functions
select
	emp_no
	salary,
    lag(salary) over w as previous_salary,
    lead(salary) over w as next_salary,
    salary - lag(salary) over w as salary_current_prev_diff,
    lead(salary) over w - salary  as salary_next_current_diff
from
	salaries
where salary > 80000
	and emp_no between 10500 and 10600
window w as (partition by emp_no order by salary);

select
	emp_no,
    salary,
    lag(salary) over w as previous_salary,
    lag(salary, 2) over w as previous_salary_2,
    lead(salary) over w as next_salary,
    lead(salary, 2) over w as next_salary_2
from
	salaries
window w as (partition by emp_no order by salary)
limit 1000;

# Aggregate Functions in Window Functions
select
	s.emp_no,
    s.salary,
    s.from_date,
    s.to_date
from
	salaries s
join (
		select
			emp_no,
            min(from_date) as from_date
		from
			salaries
		group by emp_no
) s1 on s.emp_no = s1.emp_no
where s.from_date = s1.from_date;

select
	de2.emp_no,
    s2.salary,
    de2.dept_no,
    avg(s2.salary) over w as average_department_salary
from (
	select 
		de.emp_no, 
        de.dept_no, 
        de.from_date,
        de.to_date
    from 
		dept_emp de
    join (
		select 
			emp_no, 
            max(from_date) as from_date
        from 
			dept_emp
        group by 
			emp_no
	) de1 
		on de.emp_no = de1.emp_no
    where de.from_date = de1.from_date
		and de.from_date > '2000-01-01'
		and de.to_date < '2002-01-01'
) de2
join (
	select s.emp_no, s.salary, s.from_date, s.to_date
    from salaries s
	join (
		select emp_no, max(from_date) as from_date
        from salaries
        group by emp_no
    ) s1 on s1.emp_no = s.emp_no
    where s.from_date = s1.from_date
		and s.from_date > '2000-01-01'
		and s.to_date < '2002-01-01'
) s2 on s2.emp_no = de2.emp_no
group by de2.emp_no, de2.dept_no
window w as (partition by de2.dept_no)
order by de2.emp_no;

