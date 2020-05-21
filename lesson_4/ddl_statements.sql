use lesson3_db

-- 1. VIEW на основе запросов в ДЗ к уроку 3
create or replace view lesson3_db.vw_average_salary_by_departments
as
select
	average_salaries.salary_avg
    , d.dept_name
from  (
select
	avg(sl.salary) as salary_avg
    , sum(sl.salary) as salary_sum
    , count(sl.emp_no) as employer_qry
	, de.dept_no
from lesson3_db.salaries as sl
inner join lesson3_db.employees as emp on emp.emp_no = sl.emp_no
inner join lesson3_db.dept_emp as de on de.emp_no = emp.emp_no
-- проверка, что по каждому сотруднику учитывалась только зарплата во время работы его в отделе de.dept_no
where de.from_date <= sl.from_date and de.to_date >= sl.to_date
-- если необходимо  увидеть среднюю зарплату в текущий момент
-- and de.to_date > current_date()	
group by de.dept_no
-- для проверки
-- order by emp.emp_no
) as average_salaries
inner join lesson3_db.departments as d on d.dept_no = average_salaries.dept_no
;

-- 2. функция для поиска менеджера по имени и фамилии
drop function if exists lesson3_db.fn_get_manager_byfirstname_lastname;
delimiter //
create function lesson3_db.fn_get_manager_byfirstname_lastname  (firstname varchar(14), lastname varchar(16))
returns int
reads sql data
begin
	declare emp_no int;
    select
    e.emp_no
    into emp_no
    from  lesson3_db.employees as e;
    return emp_no;
end
//

