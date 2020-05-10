with countries_xml as (
select
cast(b as xml) as b
from openrowset(bulk 'c:\Users\Max\Desktop\countries.xml', single_clob) as d (b)
)
, adm_units_xml as (
select
cast(b as xml) as b
from openrowset(bulk 'c:\Users\Max\Desktop\AdmUnits.xml', single_clob) as d (b)
)
, countries as (
select
	trim(	a.value('(self::option)[1]', 'nvarchar(1000)') ) as country_name
	, a.value('(self::option/@data-place-code)[1]', 'nchar(3)')	as country_code
from countries_xml
cross apply b.nodes('/root/form/select/option[@data-place-code != "xx"]') as t(a)
)
, adm_units as (
select
		value	as adm_unit_name
--, t.a.value('(parent::div/parent::td/parent::tr/td/a)[1]', 'nvarchar(1000)')
, t.a.value('parent::div/parent::td/parent::tr/@id', 'nchar(3)')	as country_code
from adm_units_xml
cross apply b.nodes('/tbody/tr/td/div/div') as t(a)
cross apply string_split (dbo.discard_before_delimiter( t.a.value('(self::div)', 'nvarchar(4000)'),N';' ),  ',') 
)
select 
countries.country_name
, adm_units.adm_unit_name

from countries
inner join adm_units on adm_units.country_code = countries.country_code
;
go

--create or alter  function dbo.discard_before_delimiter(@input_string nvarchar(4000), @delimiter nvarchar(3999)) 
--returns  nvarchar(4000)
--as
--begin
--	declare @ind int;
--	set @ind = CHARINDEX(@delimiter, @input_string, 0);
--	while (@ind > 0)
--	begin
--		set @input_string = SUBSTRING(@input_string, @ind +1, len(@input_string));
--		set @ind = CHARINDEX(@delimiter, @input_string, 0);
--	end
--	return @input_string;
--end
--go

