# Subqueries

-- Find all department managers hired between Jan 1, 1990 and Jan 1, 1995
select * 
from dept_manager dm
where dm.emp_no in (
	select e.emp_no
    from employees e
    where hire_date between '1990-01-01' and '1995-01-01'
);

-- Find all information for employees with the title 'Assistant Engineer'
select * 
from employees e
where exists (
	select t.emp_no
    from titles t
    where t.emp_no = e.emp_no
    and t.title = "Assistant Engineer"
)
order by e.emp_no;

-- Find all employees managed by specific managers (110022 and 110039) who have employee numbers in a specified range
select A.*
from
(
	select 
		e.emp_no, 
        min(d.dept_no),
		(
			select emp_no
			from dept_manager
			where emp_no = 110022
		) as manager_id
	from employees e
	join dept_emp d on e.emp_no = d.emp_no
	where e.emp_no <= 10020
	group by e.emp_no
	order by e.emp_no
) as A
UNION
select B.*
from
(
	select 
		e.emp_no, 
        min(d.dept_no),
		(
			select emp_no
			from dept_manager
			where emp_no = 110039
		) as manager_id
	from employees e
	join dept_emp d on e.emp_no = d.emp_no
	where e.emp_no between 10021 and 10040
	group by e.emp_no
	order by e.emp_no
) as B;

-- Create a new emp_manager table
drop table if exists emp_manager;
create table emp_manager (
	emp_no int(11) not null,
    dept_no char(4) null,
    manager_no int(11) not null
);

-- Insert data into the emp_manager table:
-- emp_no 10001 through 10020 should have the manager 110022
-- emp_no 10021 through 10040 should have the manager 110039
-- emp_no 110022 and 110039 should manage each other
insert into emp_manager
select U.* from 
(
	select A.*
	from
	(
		select 
			e.emp_no, 
			min(d.dept_no),
			(
				select emp_no
				from dept_manager
				where emp_no = 110022
			) as manager_id
		from employees e
		join dept_emp d on e.emp_no = d.emp_no
		where e.emp_no <= 10020
		group by e.emp_no
		order by e.emp_no
	) as A
	UNION
	select B.*
	from
	(
		select 
			e.emp_no, 
			min(d.dept_no),
			(
				select emp_no
				from dept_manager
				where emp_no = 110039
			) as manager_id
		from employees e
		join dept_emp d on e.emp_no = d.emp_no
		where e.emp_no between 10021 and 10040
		group by e.emp_no
		order by e.emp_no
	) as B
	UNION
	select C.*
	from
	(
		select 
			e.emp_no, 
			min(d.dept_no),
			(
				select emp_no
				from dept_manager
				where emp_no = 110039
			) as manager_id
		from employees e
		join dept_emp d on e.emp_no = d.emp_no
		where e.emp_no = 110022
		group by e.emp_no
		order by e.emp_no
	) as C
    UNION
    select D.*
	from
	(
		select 
			e.emp_no, 
			min(d.dept_no),
			(
				select emp_no
				from dept_manager
				where emp_no = 110022
			) as manager_id
		from employees e
		join dept_emp d on e.emp_no = d.emp_no
		where e.emp_no = 110039
		group by e.emp_no
		order by e.emp_no
	) as D
) as U;

select * from emp_manager;


