select
	d.dept_name,
    e2.gender,
    dm.emp_no,
    dm.from_date,
    dm.to_date,
	e.calendar_year,
    case
		when e.calendar_year between year(dm.from_date) and year(dm.to_date) then 1 else 0
	end as active
    from (
		select year(hire_date) as calendar_year
        from t_employees
        group by calendar_year
    ) e
    cross join t_dept_manager dm
    join t_departments d on dm.dept_no = d.dept_no
    join t_employees e2 on dm.emp_no = e2.emp_no
    order by dm.emp_no, calendar_year;