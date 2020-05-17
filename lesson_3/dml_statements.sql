select
*
from geodata._regions;

select
*
from geodata._cities;

select
*
from geodata._countries;


-- 1
select
ct.title, r.title, cntr.title
from geodata._cities as ct
inner join geodata._regions as r on r.id = ct.region_id
inner join geodata._countries as cntr on cntr.id = r.country_id;

-- 2
select
ct.title, r.title
from geodata._cities as ct
inner join geodata._regions as r on r.id = ct.region_id
where r.title = 'Московская область';

