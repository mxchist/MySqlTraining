select
*
from geodata._regions;

select
*
from geodata._cities;

select
*
from geodata._countries;


-- 1 все данные о городе – регион, страна.
select
ct.title, r.title, cntr.title
from geodata._cities as ct
inner join geodata._regions as r on r.id = ct.region_id
inner join geodata._countries as cntr on cntr.id = r.country_id;

-- 2 все города из Московской области
select
ct.title, r.title
from geodata._cities as ct
inner join geodata._regions as r on r.id = ct.region_id
where r.title = 'Московская область';

-- 1 среднюю зарплату по отделам 

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
-- and sl.to_date > current_date()	
group by de.dept_no
-- для проверки
-- order by emp.emp_no
) as average_salaries
inner join lesson3_db.departments as d on d.dept_no = average_salaries.dept_no
;

-- 2 максимальную зарплату у сотрудника
select
	salaries_max.salary_sum
    , emp.first_name, emp.last_name
from (
	select
		max(sl.salary) as salary_max
		, emp.emp_no
	from lesson3_db.salaries as sl
	inner join lesson3_db.employees as emp on emp.emp_no = sl.emp_no
    group by emp.emp_no
) as salaries_max
inner join lesson3_db.employees as emp on emp.emp_no = salaries_max.emp_no;

select
*
from lesson3_db.departments;

select
*
from lesson3_db.salaries as sl
where sl.emp_no = 10001;
