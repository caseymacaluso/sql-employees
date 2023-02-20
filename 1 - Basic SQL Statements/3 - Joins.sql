-- Table cleanup before we practice joins
alter table departments_dup
drop column dept_manager;

alter table departments_dup
change column dept_no dept_no char(4) null;

alter table departments_dup
change column dept_name dept_name varchar(40) null;

insert into departments_dup (dept_name) values ('Public Relations');
delete from departments_dup where dept_no = 'd002';
insert into departments_dup(dept_no) values ('d010'), ('d011');

-- Create a duplicate of the department_manager table
DROP TABLE IF EXISTS dept_manager_dup;
CREATE TABLE dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
);

INSERT INTO dept_manager_dup
	select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES 
	(999904, '2017-01-01'),
	(999905, '2017-01-01'),
	(999906, '2017-01-01'),
	(999907, '2017-01-01');

-- Remove department managers who manage the 'd001' department
DELETE FROM dept_manager_dup
WHERE
    dept_no = 'd001';
    
select * from dept_manager_dup order by dept_no;
select * from departments_dup order by dept_no;

# Inner Join
select m.dept_no, m.emp_no, d.dept_name
from dept_manager_dup m
inner join departments_dup d on m.dept_no = d.dept_no
order by m.dept_no;

select m.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
from dept_manager_dup m
inner join employees e on m.emp_no = e.emp_no
order by m.emp_no;

# Left Join
select m.dept_no, m.emp_no, d.dept_name
from dept_manager_dup m
left join departments_dup d on m.dept_no = d.dept_no
order by m.dept_no;

select e.emp_no, e.first_name, e.last_name, m.dept_no, m.from_date
from employees e
left join dept_manager_dup m on e.emp_no = m.emp_no
where last_name = 'Markovitch'
order by m.dept_no desc, e.emp_no;

# Old Syntax
select e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
from employees e, dept_manager_dup m
where e.emp_no = m.emp_no;

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

# Join and Where
select e.first_name, e.last_name, e.hire_date, t.title
from employees e
join titles t on e.emp_no = t.emp_no
where e.first_name = 'Margareta'
and e.last_name = 'Markovitch';

# Cross Join
select dm.*, d.*
from dept_manager_dup dm
cross join departments_dup d
where d.dept_no = 'd009';

select e.*, d.*
from employees e
cross join departments_dup d
where e.emp_no <= 10010
order by e.emp_no, d.dept_no;

# Multi Join
select e.first_name, e.last_name, e.hire_date, t.title, t.from_date, d.dept_name
from employees e
join dept_manager_dup dm on e.emp_no = dm.emp_no
join departments_dup d on dm.dept_no = d.dept_no
join titles t on e.emp_no = t.emp_no
where t.title = 'Manager'
order by e.emp_no;

# Additional Join Practice
select e.gender, count(m.emp_no) as 'Number of Managers'
from employees e
join dept_manager_dup m on e.emp_no = m.emp_no
join titles t on t.emp_no = e.emp_no
where t.title = 'Manager'
group by e.gender;

# Union
SELECT * FROM
    (SELECT e.emp_no, e.first_name, e.last_name, NULL AS dept_no, NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis'
        UNION SELECT NULL AS emp_no, NULL AS first_name, NULL AS last_name, dm.dept_no, dm.from_date
    FROM
        dept_manager dm) as a
ORDER BY -a.emp_no desc; 
# Minus sign in front allows the entries with employee numbers to be displayed first and sorted in ascending order, with null entries listed after







