-- Update a specific record (i.e. where the employee number = 999901)
update employees
set
	first_name = 'Stella',
    last_name = 'Parkinson',
    gender = 'F',
    birth_date = '1990-12-31'
where emp_no = 999901;

select * from employees order by emp_no desc limit 10;

# Updates ALL records in the departments_dup table to have these values
update departments_dup
set
	dept_no = 'd011',
    dept_name = 'QC';
    
select * from departments_dup;

# Return back one commit
rollback;

# Commit current state of the database
commit;

select * from departments;

# Update the department number d010 to have a name of 'Data Analysis'
update departments
set dept_name = "Data Analysis"
where dept_no = 'd010';
commit;