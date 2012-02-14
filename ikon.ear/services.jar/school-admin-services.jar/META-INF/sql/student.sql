[list-applicants]
select s.objid, s.lastname, s.firstname, s.yearlevel, p.code as programcode,  p.title as programtitle 
from student_applicant s 
left join program p on p.objid = s.programid

[list-students]
select s.objid, s.studentno, s.lastname, s.firstname, s.yearlevel, p.code as programcode, p.title as programtitle 
from student s 
inner join program p on p.objid = s.programid
