[list-all]
select r.* from room r order by r.roomno 

[list-room-availability]
select r.* from room r 
where not exists (
	select * from class_schedule cs 
	inner join class cc on cs.classid=cc.objid 
	where cc.schooltermid=$P{schooltermid}  
	and cs.roomid = r.objid 
    and (cs.days_of_week & $P{days_of_week} ) > 0   
    and ( 
		(cs.fromtime>=$P{fromtime} and cs.fromtime<$P{totime}) 
	 or	(cs.fromtime<=$P{fromtime} and cs.totime>=$P{totime}) 
	 or (cs.totime>$P{fromtime} and cs.totime<=$P{totime}) 
	 or (cs.fromtime>=$P{fromtime} and cs.totime<=$P{totime} ) 
   ) 
) 
order by r.roomno

[list-room-schedule]
select cs.*, cc.code as classcode, cc.colorcode, (select concat(lastname,',',firstname) from personnel where objid=cc.teacherid) as teacher   
from class_schedule cs 
inner join class cc on cs.classid=cc.objid 
inner join course c on cc.courseid = c.objid 
where cc.schooltermid=$P{schooltermid}  
and cs.roomid = $P{roomid} 

[list-available-room-schedules]
select cs.*, cc.code as classcode   
from class_schedule cs 
inner join class cc on cc.objid=cs.classid 
inner join course c on cc.courseid=c.objid 
where cc.schooltermid = $P{schooltermid} 
and cs.roomid is null 
and not exists ( 
   select * from class_schedule xs 
   where xs.roomid = $P{roomid} 
	and ((cs.days_of_week & xs.days_of_week ) > 0)  
	and (
		(cs.fromtime>=xs.fromtime and cs.fromtime<xs.totime) 
	or	(cs.fromtime<=xs.fromtime and cs.totime>=xs.totime) 
	or (cs.totime>xs.fromtime and cs.totime<=xs.totime) 
	or (cs.fromtime>=xs.fromtime and cs.totime<=xs.totime ) 
   ) 
) 

[remove-room-conflict] 
delete from room_schedule_conflict where roomid=$P{roomid} and ( sked1=$P{scheduleid} OR sked2=$P{scheduleid} )

[flag-room-conflict]
insert ignore into room_schedule_conflict 
select $P{scheduleid}, cs.objid, cs.roomid 
from class_schedule cs 
inner join class cc on cs.classid=cc.objid 
where cc.schooltermid=$P{schooltermid}  
and not( cs.objid = $P{scheduleid} ) 
and cs.roomid = $P{roomid}  
and (cs.days_of_week & $P{days_of_week} ) > 0   
and ( 
	(cs.fromtime>=$P{fromtime} and cs.fromtime<$P{totime}) 
 or	(cs.fromtime<=$P{fromtime} and cs.totime>=$P{totime}) 
 or (cs.totime>$P{fromtime} and cs.totime<=$P{totime}) 
 or (cs.fromtime>=$P{fromtime} and cs.totime<=$P{totime} ) 
) 
 
[find-room-conflict]
select cc.code as classcode, cs.days, cs.fromtime, cs.totime 
from class_schedule cs 
inner join class cc on cc.objid=cs.classid 
inner join room_schedule_conflict rs on cs.objid=rs.sked1 
where rs.sked2 = $P{scheduleid} and rs.roomid=$P{roomid} 
union 
select cc.code as classcode, cs.days, cs.fromtime, cs.totime 
from class_schedule cs 
inner join class cc on cc.objid=cs.classid 
inner join room_schedule_conflict rs on cs.objid=rs.sked2 
where rs.sked1 = $P{scheduleid} and rs.roomid=$P{roomid} 
 
 