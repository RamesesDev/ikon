[check-enrolled-state]
 select 
  (select distinct(studentid) from class_enrollee where studentid = $P{studentid}) pending,
  (select distinct(studentid) from class_student where studentid = $P{studentid}) active;