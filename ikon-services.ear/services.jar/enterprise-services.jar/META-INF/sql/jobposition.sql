[list]
select jp.*, concat(p.lastname, ',' , p.firstname) as assignee 
from jobposition jp 
left join personnel p on jp.assigneeid = p.objid  
where jp.orgunitid=$P{orgunitid} order by jp.code

