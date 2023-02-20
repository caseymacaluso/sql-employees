select
	e.gender,
    round(avg(s.salary), 2) as avg_salary,
    d.dept_name,
    year(s.from_date) as calendar_year
from t_employees e
join t_salaries s on e.emp_no = s.emp_no
join t_dept_emp de on de.emp_no = e.emp_no
join t_departments d on de.dept_no = d.dept_no
group by d.dept_no, e.gender, calendar_year
having calendar_year <= 2002
order by d.dept_no;