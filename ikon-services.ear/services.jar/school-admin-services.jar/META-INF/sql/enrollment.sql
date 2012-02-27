[get-pending-classes]
 select 
   cls.*, c.code as coursecode, c.title as coursetitle, ce.state, ce.remarks
 from class_enrollee ce 
 inner join class cls on ce.classid = cls.objid
 inner join course c on cls.courseid = c.objid 
 where ce.studentid = $P{studentid}
 
[enrollment-status]
 select state from enrollment_status where studentid = $P{studentid}

[available-blocks]
 select bs.objid, bs.code as blockcode    
 from block_schedule bs, schoolterm st, student stud  
 where stud.objid=$P{studentid} 
 and bs.schooltermid=st.objid 
 and st.objid = $P{schooltermid}  
 and st.term = bs.term 
 and bs.programid = stud.programid 
 and bs.yearlevel = stud.yearlevel  

[available-courses-regular]
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
	 
[available-course-schedules]
 select cs.classid, cls.code as classcode, cls.max_seats, cs.days, cs.fromtime, cs.totime, 
 prog.code as programcode, prog.title as programtitle 
 from class_schedule cs 
 inner join class cls on cs.classid=cls.objid 
 inner join program prog on prog.objid=cls.programid 
 where cls.schooltermid=$P{schooltermid}  
 and cls.courseid = $P{courseid} 
 and not exists 
 (
	select *  
	from class_enrollee xce 
   inner join class_schedule xcs on xce.classid=xcs.classid 
	inner join class xcls on xcls.objid=xce.classid 
	where xce.studentid = $P{studentid} 
   and xcls.schooltermid = cls.schooltermid 
	and (xcs.days_of_week & cs.days_of_week ) > 0   
   and ( 
		 (xcs.fromtime>=cs.fromtime and xcs.fromtime<cs.totime) 
	 or (xcs.fromtime<=cs.fromtime and xcs.totime>=cs.totime) 
	 or (xcs.totime>cs.fromtime and xcs.totime<=cs.totime) 
	 or (xcs.fromtime>=cs.fromtime and xcs.totime<=cs.totime ) 
   )   
 )


[add-block-classes]
 insert into class_enrollee (classid, studentid)
 select bc.classid, $P{studentid}
 from block_class bc 
 inner join class cls on cls.objid=bc.classid 
 where bc.blockid=$P{blockid} 
 and not exists 
 ( select * from class_enrollee xce 
  inner join class xcls on xcls.objid = xce.classid 
  where xce.studentid=$P{studentid} 
  and xcls.courseid=cls.courseid 
 )
 

[approve-pending]
 insert into class_student(classid, studentid, finalgrade, partialgrade, state)
 select classid, studentid, 0.00, 0.00, 0 from class_enrollee where studentid = $P{studentid}


[remove-pending]
 delete from class_enrollee where studentid = $P{studentid}
 
[post-remarks]
 update class_enrollee set remarks = $P{remarks} where classid = $P{classid}
 
 

