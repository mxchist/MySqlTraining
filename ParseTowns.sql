with countries_xml as (
select
cast(b as xml) as b
from openrowset(bulk 'c:\Users\Max\Desktop\Towns.xml', single_clob) as d (b)
)
select 
N'Russian Federation'
--, t.unit.value('(td[2]/a)[1]', 'nvarchar(1000)')	as admin_unit
--, t.unit.value('(td[3]/a[1])', 'nvarchar(1000)')			as district
--, coalesce(
--	t.unit.value('(td[3]/i)[1]', 'nvarchar(1000)')
--	, substring( t.unit.value('(td[3])[1]', 'nvarchar(1000)'), 1, charindex (' ', t.unit.value('(td[3])[1]', 'nvarchar(1000)') ) -1	)
--) as settlement_type
--, t.unit.value('td[3]/a[1]', 'nvarchar(1000)')				as "settlement_name"
, x.b.query('
for $j in 
	for $i in table/tbody/tr[position() > 1]
	return $i
where position() = 2 or position() = 3
return $j
')

from countries_xml as x
--cross apply x.b.nodes('table/tbody/tr') as t(unit)
--where t.unit.exist('th') = 0
