drop procedure if exists avg_gendered_salary_per_department;
delimiter $$
create procedure avg_gendered_salary_per_department(in p_low_salary float, in p_high_salary float)
begin
	select
		e.gender,
		round(avg(s.salary), 2) as avg_salary,
		d.dept_name
	from
		t_employees e
	join t_salaries s on s.emp_no = e.emp_no
	join t_dept_emp de on de.emp_no = e.emp_no
	join t_departments d on d.dept_no = de.dept_no
    where s.salary between p_low_salary and p_high_salary
	group by d.dept_name, e.gender
	order by d.dept_name;
end$$
delimiter ;

call avg_gendered_salary_per_department(50000, 90000);