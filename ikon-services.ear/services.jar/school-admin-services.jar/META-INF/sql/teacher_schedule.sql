[list-all]
select p.objid, p.lastname,p.firstname,p.staffno,jp.orgunitid 
from jobposition jp 
inner join personnel p on jp.assigneeid = p.objid 
where jp.roleclass = 'FACULTY' 
and jp.orgunitid = $P{orgunitid} 

[list-teacher-availability]
select p.objid, p.lastname,p.firstname,p.staffno,jp.orgunitid 
from jobposition jp 
inner join personnel p on jp.assigneeid = p.objid 
where jp.roleclass = 'FACULTY' 
and jp.orgunitid = $P{orgunitid} 
and not exists (
	select * from class_schedule cs 
	inner join class cc on cs.classid=cc.objid 
	where cc.schooltermid=$P{schooltermid}  
	and cc.teacherid = p.objid 
   and (cs.days_of_week & $P{days_of_week} ) > 0   
   and ( 
		(cs.fromtime>=$P{fromtime} and cs.fromtime<$P{totime}) 
	 or	(cs.fromtime<=$P{fromtime} and cs.totime>=$P{totime}) 
	 or (cs.totime>$P{fromtime} and cs.totime<=$P{totime}) 
	 or (cs.fromtime>=$P{fromtime} and cs.totime<=$P{totime} ) 
   ) 
) 

[list-teacher-schedule]
select cs.*, cc.code as classcode, cc.colorcode, (select roomno from room where objid=cs.roomid) as roomno  
from class_schedule cs 
inner join class cc on cs.classid=cc.objid 
inner join course c on cc.courseid = c.objid 
where cc.schooltermid=$P{schooltermid}  
and cc.teacherid = $P{teacherid} 

[list-available-teacher-schedules]
select cs.*, cc.code as classcode, (select roomno from room where objid=cs.roomid) as roomno    
from class_schedule cs 
inner join class cc on cc.objid=cs.classid  
inner join course c on cc.courseid=c.objid 
where cc.schooltermid = $P{schooltermid} 
and cc.teacherid is null 
and c.orgunitid in (select orgunitid from jobposition jp where assigneeid = $P{teacherid})  
and not exists ( 
   select * 
   from class_schedule cs1 
   inner join class cc1 on cs1.classid = cc1.objid
   where cc1.teacherid = $P{teacherid} 
	and ((cs.days_of_week & cs1.days_of_week ) > 0)  
	and (
		(cs.fromtime>=cs1.fromtime and cs.fromtime<cs1.totime) 
	 or	(cs.fromtime<=cs1.fromtime and cs.totime>=cs1.totime) 
	 or (cs.totime>cs1.fromtime and cs.totime<=cs1.totime) 
	 or (cs.fromtime>=cs1.fromtime and cs.totime<=cs1.totime ) 
   ) 
) 

[remove-teacher-conflict] 
delete from teacher_schedule_conflict where teacherid=$P{teacherid} and ( sked1=$P{scheduleid} OR sked2=$P{scheduleid} )

[flag-teacher-conflict]
insert ignore into teacher_schedule_conflict 
select $P{scheduleid}, cs.objid, cc.teacherid  
from class_schedule cs 
inner join class cc on cs.classid=cc.objid 
where cc.schooltermid=$P{schooltermid}  
and not( cs.objid = $P{scheduleid} ) 
and cc.teacherid = $P{teacherid}  
and (cs.days_of_week & $P{days_of_week} ) > 0   
and ( 
	(cs.fromtime>=$P{fromtime} and cs.fromtime<$P{totime}) 
 or	(cs.fromtime<=$P{fromtime} and cs.totime>=$P{totime}) 
 or (cs.totime>$P{fromtime} and cs.totime<=$P{totime}) 
 or (cs.fromtime>=$P{fromtime} and cs.totime<=$P{totime} ) 
) 
 
[find-teacher-conflict]
select cc.code as classcode, cs.days, cs.fromtime, cs.totime 
from class_schedule cs 
inner join class cc on cc.objid=cs.classid 
inner join teacher_schedule_conflict rs on cs.objid=rs.sked1 
where rs.sked2 = $P{scheduleid} and rs.teacherid=$P{teacherid} 
union 
select cc.code as classcode, cs.days, cs.fromtime, cs.totime 
from class_schedule cs 
inner join class cc on cc.objid=cs.classid 
inner join teacher_schedule_conflict rs on cs.objid=rs.sked2 
where rs.sked1 = $P{scheduleid} and rs.teacherid=$P{teacherid} 
 
 