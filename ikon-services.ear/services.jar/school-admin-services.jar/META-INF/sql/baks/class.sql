[list]
  select cls.objid,cls.code, p.code as programcode, p.title as programtitle, bc.blockid, 
  c.code as coursecode, c.title as coursetitle, b.code as blockcode, 
  (select concat(p.lastname, ', ', p.firstname) from personnel p where p.objid=cls.teacherid ) as teacher    
  from class cls 
  inner join program p on cls.programid = p.objid 
  inner join course c on cls.courseid = c.objid 
  inner join block_class bc on bc.classid=cls.objid  
  inner join block_schedule b on b.objid = bc.blockid 
  where cls.schooltermid = $P{schooltermid} 
  order by b.code 

[list-pending-blocks]
  select b.*, p.code as programcode, p.title as programtitle, b.objid as blockid  
  from block_schedule b 
  inner join program p on b.programid = p.objid 
  where b.schooltermid = $P{schooltermid} 
  and not exists ( select * from block_class bc where bc.blockid=b.objid ) 
    
[list-all]
  select z.objid, z.code, 
     z.programcode, z.programtitle,
     z.coursecode, z.coursetitle,
     z.blockid, z.blockcode, 
     z.teacher 
  from 
  (select null as objid,null as code, 
  p.code as programcode, p.title as programtitle, 
  null as coursecode, null as coursetitle, 
  b.objid as blockid, b.code as blockcode,  
  null as teacher, 
  1 as idx 
  from block_schedule b 
  inner join program p on p.objid=b.programid 
  where b.schooltermid = $P{schooltermid} 
  and not exists (select * from block_class bc where bc.blockid=b.objid) 
  union 
   select cls.objid, cls.code, 
	p.code as programcode, p.title as programtitle, 
   c.code as coursecode, c.title as coursetitle, 
   b.objid as blockid, b.code as blockcode,  
   (select concat(p.lastname, ', ', p.firstname) from personnel p where p.objid=cls.teacherid ) as teacher, 
   2 as idx 
  from class cls 
  inner join program p on cls.programid = p.objid 
  inner join course c on cls.courseid = c.objid 
  left join block_class bc on bc.classid=cls.objid   
  left join block_schedule b on b.objid = bc.blockid 
  where cls.schooltermid = $P{schooltermid} ) z 
  order by z.idx 

	
	
[class-schedules]
  select s.*, (select roomno from room where objid = s.roomid ) as roomno 
  from class_schedule s  
  where s.classid = $P{classid} 
  order by s.fromtime, s.days  

[list-block-classes]
  select cls.*, c.code as coursecode, c.title as coursetitle, 
  (select concat(p.lastname,', ',p.firstname) from personnel p where p.objid=cls.teacherid ) as teacher 
  from class cls 
  inner join course c on cls.courseid = c.objid 
  inner join block_class bc on bc.classid = cls.objid 
  where bc.blockid = $P{blockid} 

[list-teacher-possible-classes]
  SELECT clz.*, c.code as coursecode, c.title as coursetitle 
  FROM class clz 
  INNER JOIN course c ON clz.courseid=c.objid
  WHERE clz.schooltermid = $P{schooltermid}
  AND EXISTS (
  	SELECT * 
  	FROM course_skill_tag cst 
  	INNER JOIN teacher_skill_tag tst ON cst.skill_tag=tst.skill_tag
      WHERE cst.courseid = c.objid AND tst.teacherid = $P{teacherid}
  )

[list-block-schedules]
  select * from block_schedule where schooltermid = $P{schooltermid} and programid = $P{programid}

[remove-class-schedules]
delete from class_schedule where classid = $P{classid} 