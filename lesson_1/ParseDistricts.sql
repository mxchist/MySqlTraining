with countries_xml as (
select
cast(b as xml) as b
from openrowset(bulk 'c:\Users\Max\Desktop\Administrative_districts.xml', single_clob) as d (b)
)
select 
N'Russian Federation'
, t.unit.value('(../../../h3/span)[1]', 'nvarchar(1000)')	as admin_unit
, t.unit.value('(td[1]/a[1])', 'nvarchar(1000)')			as district
, trim( coalesce(
	t.unit.value('(td[3]/i)[1]', 'nvarchar(1000)')
	, substring( t.unit.value('(td[3])[1]', 'nvarchar(1000)'), 1, charindex (' ', t.unit.value('(td[3])[1]', 'nvarchar(1000)') )	)
)	) as settlement_type
, t.unit.value('td[3]/a[1]', 'nvarchar(1000)')				as "settlement_name"


from countries_xml as x
cross apply x.b.nodes('/Administrative_units/Administrative_unit/table/tbody/tr') as t(unit)
where t.unit.exist('th') = 0
