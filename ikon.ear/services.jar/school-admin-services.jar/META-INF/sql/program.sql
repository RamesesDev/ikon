[list]
select * from program ${condition} order by code

[list-courses]
select p.*, c.code as coursecode, c.title as coursetitle 
from programcourse p 
inner join course c on c.objid = p.courseid 
where programid = $P{objid} order by yearlevel, term, c.code 

[list-requisites]
select p.*, c.code as coursecode, c.title as coursetitle 
from programcourse_req p 
inner join course c on c.objid = p.reqcourseid 
where programid = $P{programid} and courseid = $P{courseid}  and reqtype = $P{reqtype}

[lookup-course-prerequisites]
select p.*, c.code as coursecode, c.title as coursetitle 
from programcourse p 
inner join course c  
on p.courseid = c.objid  
where p.programid = $P{programid} 
and c.code LIKE $P{code}  
and ( yearlevel < $P{yearlevel} OR ( yearlevel = $P{yearlevel} and term < $P{term} ) )  

[lookup-course-corequisites]
select p.*, c.code as coursecode, c.title as coursetitle 
from programcourse p 
inner join course c  
on p.courseid = c.objid  
where p.programid = $P{programid} 
and c.code LIKE $P{code} 
and p.courseid != $P{courseid} 
and ( yearlevel <= $P{yearlevel} OR ( yearlevel = $P{yearlevel} and term <= $P{term} ) )  

[lookup-program-course-regular]
select p.*, c.code as coursecode, c.title as coursetitle 
from programcourse p 
inner join course c on c.objid = p.courseid 
where p.programid = $P{programid} 
and p.yearlevel=$P{yearlevel} and p.term=$P{term} 

[lookup-program-course-nonregular]
select p.*, c.code as coursecode, c.title as coursetitle 
from programcourse p 
inner join course c on c.objid = p.courseid 
where p.programid = $P{programid} 
and not(p.yearlevel=$P{yearlevel} and p.term=$P{term}) 
