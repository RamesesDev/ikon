[list]
select cls.*, p.code as programcode, p.title as programtitle, 
c.code as coursecode, c.title as coursetitle, b.code as blockcode, 
(select concat(p.lastname, ', ', p.firstname) from personnel p where p.objid=cls.teacherid ) as teacher    
from courseclass cls 
inner join program p on cls.programid = p.objid 
inner join course c on cls.courseid = c.objid 
inner join block_schedule b on b.objid = cls.blockid 
where cls.schooltermid = $P{schooltermid} 
order by b.code 



[list-pending-blocks]
select b.*, p.code as programcode, p.title as programtitle 
from block_schedule b 
inner join program p on b.programid = p.objid 
where b.schooltermid = $P{schooltermid} 
and not exists (select c.* from courseclass c where c.blockid=b.objid) 

[class-schedules]
select s.*, (select roomno from room where objid = s.roomid ) as roomno 
from courseclass_schedule s  
where s.classid = $P{classid} 
order by s.fromtime, s.days  

[list-block-classes]
select cls.*, c.code as coursecode, c.title as coursetitle, 
(select concat(p.lastname,', ',p.firstname) from personnel p where p.objid=cls.teacherid ) as teacher 
from courseclass cls 
inner join course c on cls.courseid = c.objid 
where cls.blockid = $P{blockid}

[list-teacher-possible-classes]
SELECT clz.*, c.code as coursecode, c.title as coursetitle 
FROM courseclass clz 
INNER JOIN course c ON clz.courseid=c.objid
WHERE clz.schooltermid = $P{schooltermid}
AND EXISTS (
	SELECT * 
	FROM course_skill_tag cst 
	INNER JOIN teacher_skill_tag tst ON cst.skill_tag=tst.skill_tag
    WHERE cst.courseid = c.objid AND tst.teacherid = $P{teacherid}
)

