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
 
[check-teacher-conflict] 
select count(*) as flag from teacher_schedule_conflict tc where tc.teacherid=$P{teacherid} 
and (tc.sked1 = $P{scheduleid} or tc.sked2 = $P{scheduleid})
 
[teacher-conflict-list] 
select o.* from 
(select p.lastname, p.firstname, p.objid as teacherid,  
 c1.code as classcode1, cs1.days as days1, cs1.fromtime as fromtime1, cs1.totime as totime1, bc1.blockid as blockid1, 
 c2.code as classcode2, cs2.days as days2, cs2.fromtime as fromtime2, cs2.totime as totime2, bc2.blockid as blockid2  
from teacher_schedule_conflict tc  
inner join personnel p on p.objid=tc.teacherid  
inner join class_schedule cs1 on tc.sked1=cs1.objid 
inner join class c1 on cs1.classid=c1.objid 
left join block_class bc1 on bc1.classid=c1.objid 
inner join class_schedule cs2 on tc.sked2=cs2.objid 
inner join class c2 on cs2.classid=c2.objid 
left join block_class bc2 on bc2.classid=c2.objid 
) o ${filter} 
