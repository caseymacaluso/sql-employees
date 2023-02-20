use employees;
commit;
select * from employees where emp_no = 999903;

-- Delete a specific record
delete from employees where emp_no = 999903;

rollback;

delete from departments where dept_no = 'd010';
commit;
