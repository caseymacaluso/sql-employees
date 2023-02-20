use employees_mod;

select
	year(de.from_date) as emp_year,
    e.gender,
    count(e.emp_no) as num_employees
from
	t_dept_emp de
join
	t_employees e on de.emp_no = e.emp_no
group by emp_year, e.gender
having emp_year >= 1990
order by emp_year;