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

-- 3 среднюю зарплату по отделам 

with average_salaries as (
select
*
from lesson3_db.salaries as sl
inner join lesson3_db.employees as emp on emp.emp_no = sl.emp_no
inner join lesson3_db.dept_emp as de on de.emp_no = emp.emp_no
inner join lesson3_db.departments as d on d.dept_no = de.dept_no
where de.from_date <= sl.from_date and de.to_date >= sl.to_date
-- если необходимо  увидеть среднюю зарплату в текущий момент
-- and sl.to_date > current_date()	
-- для проверки
-- order by emp.emp_no
);

select
*
from lesson3_db.departments;

select
*
from lesson3_db.salaries as sl
where sl.emp_no = 10001;
