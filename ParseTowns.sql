with countries_xml as (
select
cast(b as xml) as b
from openrowset(bulk 'c:\Users\Max\Desktop\Towns.xml', single_clob) as d (b)
)
select 
	N'Russian Federation'

	, t.unit.value('(td[position() = 2]/a)[1]', 'nvarchar(1000)')
	, t.unit.value('(td[position() = 3]/a)[1]', 'nvarchar(1000)')
from countries_xml as x
cross apply x.b.nodes('table/tbody/tr[position() > 1]') as t(unit)
--where t.unit.exist('th') = 0
