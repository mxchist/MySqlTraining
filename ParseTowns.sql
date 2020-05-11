with countries_xml as (
select
cast(b as xml) as b
from openrowset(bulk 'c:\Users\Max\Desktop\Towns.xml', single_clob) as d (b)
)
select 
	N'Russian Federation'
	, N', (N'''

	+ replace(	t.unit.value('(td[position() = 2]/a)[1]', 'nvarchar(1000)'), ', Republic of', '') + ''', N'''
	+ t.unit.value('(td[position() = 3]/a)[1]', 'nvarchar(1000)') + N''')'
from countries_xml as x
cross apply x.b.nodes('table/tbody/tr[position() > 1]') as t(unit)
--where t.unit.exist('th') = 0



