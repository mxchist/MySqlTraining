drop schema if exists lesson1_db;

create schema if not exists lesson1_db;

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

create table if not exists lesson1_db.city (
	city_id int8 auto_increment
    , country_id int2 not null
    , city_name nvarchar(100) not null
    , constraint PK_City primary key (city_id)
    , constraint UQ_CountryId_CityName unique (country_id, city_name)
    , constraint FK_City_Country_CountryId foreign key (country_id) references country(country_id)
		on update cascade on delete cascade
);

create table if not exists lesson1_db.local_administrative_unit_type (
	id int1 not null auto_increment
    , type_name nvarchar(100) not null
    , constraint PK_LocalAdministrativeUnitType primary key (id)

);

create table if not exists lesson1_db.local_administrative_unit (
	local_unit_id int8 auto_increment
    , unit_id int8 not null
    , local_unit_name nvarchar(100) not null
    , local_unit_type int1 not null
    , constraint PK_LocalAdministrativeUnit primary key (local_unit_id)
    , constraint UQ_UnitId_CityName unique (unit_id, local_unit_name)
    , constraint FK_LocalAdministrativeUnit_AdministrativeUnit_UnitId foreign key (unit_id) references administrative_unit(unit_id)
		on update cascade on delete cascade
    , constraint FK_LocalAdministrativeUnit_AdministrativeUnitType foreign key (local_unit_type) references local_administrative_unit_type(id)
		on update cascade on delete cascade
);

create table if not exists lesson1_db.local_country_type (
	id int2  auto_increment
	, type_name nvarchar(100)
    , constraint PK_LocalCountryType primary key (id)
);

create table if not exists lesson1_db.local_country (
	local_country_id int8 auto_increment
    , local_unit_id int8 not null
    , local_country_name nvarchar(100)
    , local_country_type int2
    , constraint PK_LocalCountry primary key (local_country_id)
    , constraint FK_LocalCountry_AdministrativeUnit foreign key (local_unit_id) references local_administrative_unit(local_unit_id)
    on update cascade on delete cascade
    , constraint FK_LocalCountry_СountryType foreign key (local_country_type) references local_country_type(id)
    on update cascade on delete cascade
)

