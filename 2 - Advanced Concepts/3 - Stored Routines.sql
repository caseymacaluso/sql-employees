use employees;

#############################################
###############   PROCEDURES   ##############
#############################################

drop procedure if exists select_employees;
-- Set new delimiter as we define the procedure
delimiter $$
-- Procedure to select first 1000 employees from the employees table
create procedure select_employees()
begin
	select * from employees limit 1000;
end$$
-- Set the delimiter back to default ;
delimiter ;

-- Call the procedure
call employees.select_employees();
call select_employees();

drop procedure if exists calculate_average_salary;
delimiter $$
-- Procedure to calculate the average salary in the salaries table
create procedure calculate_average_salary()
begin
	select round(avg(salary), 2) from salaries;
end$$
delimiter ;

call calculate_average_salary();

drop procedure if exists emp_salary;
delimiter $$
-- Procedure to find the salary information on a specific employee
-- Uses an 'in' parameter, meaning that we call the procedure with a specific value
create procedure emp_salary(in p_emp_no integer)
begin
	select e.first_name, e.last_name, s.salary, s.from_date, s.to_date
    from employees e
    join salaries s on e.emp_no = s.emp_no
    where e.emp_no = p_emp_no;
end$$
delimiter ;

-- Call procedure with an emp_no value of 11300. Procedure will output the information for this employee
call emp_salary(11300);

drop procedure if exists emp_avg_salary_out;
delimiter $$
-- Procedure to calculate the average salary of an employee
-- Uses both an 'in' and 'out' parameter. The 'out' parameter acts as something we can use when we define a variable later on.
create procedure emp_avg_salary_out(in p_emp_no integer, out p_avg_salary decimal(10,2))
begin
	select avg(s.salary) into p_avg_salary
    from employees e
    join salaries s on e.emp_no = s.emp_no
    where e.emp_no = p_emp_no
    group by e.emp_no;
end$$
delimiter ;

-- Define a variable to store the average salary
set @v_avg_salary = 0;
-- Call procedure with an employee #, and outputs the value to the variable we defined
call emp_avg_salary_out(11300, @v_avg_salary);
-- Select the variable
select @v_avg_salary;

drop procedure if exists emp_info;
delimiter $$
-- Procedure to return employee info based on first and last name
-- Outputs an employee #
create procedure emp_info(in p_first_name varchar(14), in p_last_name varchar(16), out p_emp_no integer)
begin
	select max(e.emp_no) into p_emp_no
    from employees e
    where e.first_name = p_first_name and e.last_name = p_last_name;
end$$
delimiter ;

set @v_emp_no = 0;
call emp_info('Aruna', 'Journel', @v_emp_no);
select @v_emp_no;


############################################
###############   FUNCTIONS   ##############
############################################

delimiter $$
create function f_emp_avg_salary (p_emp_no integer) returns decimal(10,2)
deterministic
begin
	declare v_avg_salary decimal(10,2);
    
    select avg(s.salary)
    into v_avg_salary
    from employees e
    join salaries s on e.emp_no = s.emp_no
    where e.emp_no = p_emp_no;
    
    return v_avg_salary;
end$$
delimiter ;

select f_emp_avg_salary(11300);

drop function if exists f_emp_info;
delimiter $$
create function f_emp_info (p_first_name varchar(14), p_last_name varchar(16)) returns decimal(10,2)
deterministic
begin
	declare v_max_from_date date;
    declare v_salary decimal(10,2);
    
    select max(s.from_date)
	into v_max_from_date
    from salaries s
    join employees e on e.emp_no = s.emp_no
    where e.first_name = p_first_name and e.last_name = p_last_name;
    
    select s.salary
	into v_salary
    from salaries s
    join employees e on e.emp_no = s.emp_no
    where e.first_name = p_first_name and e.last_name = p_last_name and s.from_date = v_max_from_date;
    
    return v_salary;
end$$
delimiter ;

select f_emp_info('Georgi','Facello');


#############################################
##############   DIFFERENCES   ##############
#############################################

-------- Procedures --------
-- Does not return a value
-- you CALL a procedure
-- can have multiple OUT parameters
-- INSERT, UPDATE and DELETE work with procedures
-- cannot include a procedure inside a SELECT statement


-------- Functions --------
-- Returns a value
-- you SELECT a function
-- returns a single value only
-- INSERT, UPDATE and DELETE do not work with functions
-- can include as one of the columns inside a SELECT statement