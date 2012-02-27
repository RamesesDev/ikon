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
 
[check-room-conflict] 
select count(*) as flag from room_schedule_conflict rc where rc.roomid=$P{roomid} 
and (rc.sked1 = $P{scheduleid} or rc.sked2 = $P{scheduleid})


[room-conflict-list] 
select o.* from 
(select r.roomno, r.objid as roomid,  
 c1.code as classcode1, cs1.days as days1, cs1.fromtime as fromtime1, cs1.totime as totime1, bc1.blockid as blockid1, 
 c2.code as classcode2, cs2.days as days2, cs2.fromtime as fromtime2, cs2.totime as totime2, bc2.blockid as blockid2  
from room_schedule_conflict tc  
inner join room r on r.objid=tc.roomid  
inner join class_schedule cs1 on tc.sked1=cs1.objid 
inner join class c1 on cs1.classid=c1.objid 
left join block_class bc1 on bc1.classid=c1.objid 
inner join class_schedule cs2 on tc.sked2=cs2.objid 
inner join class c2 on cs2.classid=c2.objid 
left join block_class bc2 on bc2.classid=c2.objid 
) o ${filter} 
 
 
 