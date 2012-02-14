[list]
select * from course where orgunitid=$P{orgunitid} order by code

[lookup-list]
select * from course where code LIKE $P{code} order by code

[lookup-list-byprogram]
select c.* from course c 
inner join programcourse p on p.courseid = c.objid 
where p.programid=$P{programid} and c.code LIKE $P{code} order by c.code  
