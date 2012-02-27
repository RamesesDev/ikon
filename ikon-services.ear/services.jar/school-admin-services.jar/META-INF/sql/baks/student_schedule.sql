[list-available-courses]
select c.objid, c.code as coursecode, c.title as coursetitle  
from schoolterm st, programcourse pc, student stud, course c  
where stud.objid = $P{studentid} 
and stud.programid=pc.programid 
and pc.courseid = c.objid 
and pc.yearlevel = stud.yearlevel 
and pc.term = st.term 
and st.objid = $P{schooltermid} 
and pc.courseid not in 
  ( select cls.courseid from class cls 
	 inner join class_enrollee ce on ce.classid=cls.objid 
	 where ce.studentid = stud.objid )
and pc.courseid not in
  ( select cls.courseid from class cls inner join class_student cs on cs.classid=cls.objid 
	 where cs.studentid = stud.objid ) 


	 
	 