[list-by-program]
select p.objid, p.lastname, p.firstname  
from jobposition jp  
inner join personnel p on jp.assigneeid=p.objid 
where jp.roleclass='FACULTY' 
and exists 
( select * from program where orgunitid=jp.orgunitid and objid=$P{programid} )

[list-all]
select distinct p.objid, p.lastname, p.firstname 
from jobposition jp  
inner join personnel p on jp.assigneeid=p.objid    
inner join orgunit ou on ou.objid=jp.orgunitid 
where jp.roleclass='FACULTY' 