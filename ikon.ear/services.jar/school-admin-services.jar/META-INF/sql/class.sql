[list]
select cls.*, p.code as programcode, p.title as programtitle, c.code as coursecode, c.title as coursetitle,
(select code from block_section b where b.objid = cls.blockid ) as blockcode   
from courseclass cls 
inner join program p on cls.programid = p.objid 
inner join course c on cls.courseid = c.objid 
where cls.schooltermid = $P{schooltermid}


[list-pending-blocks]
select b.*, p.code as programcode, p.title as programtitle 
from block_section b 
inner join program p on b.programid = p.objid 
where b.schooltermid = $P{schooltermid} 
and not exists (select c.* from courseclass c where c.blockid=b.objid) 

[class-schedules]
select s.* from courseclass_schedule s  
where s.classid = $P{classid} 
order by s.fromtime, s.days  

[list-block-classes]
select cls.*, c.code as coursecode, c.title as coursetitle 
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

