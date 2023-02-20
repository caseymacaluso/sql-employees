# Temporary Tables
# Tables that can be created during a session. Ending a session will remove the table.
create temporary table m_highest_salary
select s.emp_no, max(s.salary) as highest_salary
from salaries s
join employees e on e.emp_no = s.emp_no and e.gender = 'M'
group by s.emp_no;

select * from m_highest_salary;
select * from m_highest_salary where emp_no < 10010;

create temporary table dates
select
	now() as current_date_and_time,
    date_sub(now(), interval 2 month) as two_months_earlier,
    date_sub(now(), interval -2 year) as two_years_later;
    
select * from dates;

with cte as (
	select
		now() as current_date_and_time,
		date_sub(now(), interval 2 month) as two_months_earlier,
		date_sub(now(), interval -2 year) as two_years_later
)
select *
from dates d1
join cte c;

with cte as (
	select
		now() as current_date_and_time,
		date_sub(now(), interval 2 month) as two_months_earlier,
		date_sub(now(), interval -2 year) as two_years_later
)
select *
from dates d1
union select  * from cte c;

drop temporary table if exists m_highest_salary;
drop temporary table if exists dates;