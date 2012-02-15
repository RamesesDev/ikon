[check-block-schedule-conflict]
select count(*) as conflict_count  
from courseclass_schedule cs 
inner join courseclass c on c.objid=cs.classid 
where c.blockid = $P{blockid} 
and not( c.courseid = $P{courseid} ) 
and   (cs.days_of_week & $P{days_of_week} ) > 0   
and ( 
	(cs.fromtime>=$P{fromtime} and cs.fromtime<$P{totime}) 
or	(cs.fromtime<=$P{fromtime} and cs.totime>=$P{totime}) 
or (cs.totime>$P{fromtime} and cs.totime<=$P{totime}) 
or (cs.fromtime>=$P{fromtime} and cs.totime<=$P{totime} ) 
)