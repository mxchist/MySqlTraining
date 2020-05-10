drop schema if exists lesson1_db;

create schema if not exists lesson1_db;

drop table if exists lesson1_db.coun_unit;
drop table if exists lesson1_db.administrative_unit;
drop table if exists lesson1_db.country;

create table if not exists lesson1_db.country (
country_id int2 auto_increment
, country_name nvarchar(100)
, constraint PK_Country primary key (country_id)
, constraint UQ_Country_CountryName unique (country_name)
);


-- Административные единицы наподобие областей в России
create table if not exists lesson1_db.administrative_unit (
unit_id int8 auto_increment
, unit_name nvarchar(500) not null
, country_id int2 not null
, constraint PK_AdministrativeUnit primary key (unit_id)
, constraint UQ_AdministrativeUnit unique (unit_name, country_id)
, constraint FK_AdministrativeUnit_Country_CountryId foreign key (country_id) references lesson1_db.country(country_id)
on update cascade on delete cascade
);

-- попробуем на эту вьюху навесить внешний ключ
create or replace view lesson1_db.VW_administrative_unit
as
select unit_id, unit_name , country_id from lesson1_db.administrative_unit
union all
select max(unit_id) + 1, null, null
from lesson1_db.administrative_unit
;

create table lesson1_db.city (
	city_id int8 auto_increment
    , country_id int2 not null
    , city_name nvarchar(100) not null
    , constraint PK_City primary key (city_id)
    , constraint UQ_CountryId_CityName unique (country_id, city_name)
    , constraint FK_City_Country_CountryId foreign key (country_id) references country(country_id)
		on update cascade on delete cascade
)

