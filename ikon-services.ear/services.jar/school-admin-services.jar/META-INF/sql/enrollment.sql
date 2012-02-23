[check-enrolled-state]
 select 
  (select distinct(studentid) from class_enrollee where studentid = $P{studentid}) pending,
  (select distinct(studentid) from class_student where studentid = $P{studentid}) active;


[get-pending-classes]
 select 
   cls.*, c.code as coursecode, c.title as coursetitle
 from class_enrollee ce 
 inner join class cls on ce.classid = cls.objid
 inner join course c on cls.courseid = c.objid 
 where ce.studentid = $P{studentid}