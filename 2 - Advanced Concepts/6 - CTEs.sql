# Common Table Expressions (CTEs)
with cte as (
	select avg(salary) as avg_salary from salaries
)
select
	sum(
		case
			when s.salary > c.avg_salary then 1 else 0
		end
	) as num_salaries_above_avg,
    count(s.salary) as num_salary_contracts
from salaries s
join employees e on s.emp_no = e.emp_no and e.gender = 'F'
cross join cte c;

with cte as (
	select avg(salary) as avg_salary from salaries
)
select
	sum(
		case
			when s.salary < c.avg_salary then 1 else 0
		end
	) as num_salaries_below_avg,
    count(s.salary) as num_salary_contracts
from salaries s
join employees e on s.emp_no = e.emp_no and e.gender = 'M'
cross join cte c;

with cte as (
	select avg(salary) as avg_salary from salaries
)
select
	count(
		case
			when s.salary < c.avg_salary then s.salary else null
		end
	) as num_salaries_below_avg,
    count(s.salary) as num_salary_contracts
from salaries s
join employees e on s.emp_no = e.emp_no and e.gender = 'M'
cross join cte c;

select
	count(
		case
			when s.salary < c.avg_salary then s.salary else null
		end
	) as num_salaries_below_avg,
    count(s.salary) as num_salary_contracts
from salaries s
join employees e on s.emp_no = e.emp_no and e.gender = 'M'
cross join (select avg(salary) as avg_salary from salaries) c;

# Multiple Subclauses
with cte as (
	select avg(salary) as avg_salary from salaries
),
cte2 as (
	select s.emp_no, max(s.salary) as highest_salary
    from salaries s
    join employees e on e.emp_no = s.emp_no and e.gender = 'F'
    group by s.emp_no
)
select
	sum(case when c2.highest_salary > c1.avg_salary then 1 else 0 end) as count_highest_salaries,
    count(e.emp_no) as total_num_female_contracts
from employees e
join cte2 c2 on c2.emp_no = e.emp_no
cross join cte c1;

with cte_avg_salary as (
	select avg(salary) as avg_salary from salaries
),
cte_highest_male_contracts as (
	select s.emp_no, max(s.salary) as highest_salary
    from salaries s
    join employees e on e.emp_no = s.emp_no and e.gender = 'M'
    group by s.emp_no
)
select
	sum(case when c2.highest_salary < c1.avg_salary then 1 else 0 end) as count_male_salaries_below_avg,
    count(e.emp_no) as total_num_male_contracts
from employees e
join cte_highest_male_contracts c2 on c2.emp_no = e.emp_no
cross join cte_avg_salary c1;

with cte_avg_salary as (
	select avg(salary) as avg_salary from salaries
),
cte_highest_male_contracts as (
	select s.emp_no, max(s.salary) as highest_salary
    from salaries s
    join employees e on e.emp_no = s.emp_no and e.gender = 'M'
    group by s.emp_no
)
select
	count(case when c2.highest_salary < c1.avg_salary then c2.highest_salary else null end) as count_male_salaries_below_avg,
    count(e.emp_no) as total_num_male_contracts
from employees e
join cte_highest_male_contracts c2 on c2.emp_no = e.emp_no
cross join cte_avg_salary c1;

with cte_avg_salary as (
	select avg(salary) as avg_salary from salaries
)
select
	sum(case when c2.highest_salary < c1.avg_salary then 1 else 0 end) as count_male_salaries_below_avg,
    count(e.emp_no) as total_num_male_contracts
from (
	select s.emp_no, max(s.salary) as highest_salary
    from salaries s
    join employees e on e.emp_no = s.emp_no and e.gender = 'M'
    group by s.emp_no
) c2
join employees e on e.emp_no = c2.emp_no
cross join cte_avg_salary c1;