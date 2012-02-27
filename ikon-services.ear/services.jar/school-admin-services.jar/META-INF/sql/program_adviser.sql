[list]
 select pa.*, a.lastname, a.firstname, p.code as programcode, p.title as programtitle, pa.yearlevel 
 from program_adviser pa 
 inner join personnel a on pa.adviserid=a.objid 
 inner join program p on pa.programid=p.objid  
 where pa.schooltermid = $P{schooltermid} 
   and pa.programid=$P{programid}
 
 
[get-adviser]
 select pa.*, a.lastname, a.firstname, p.code as programcode, p.title as programtitle, pa.yearlevel 
 from program_adviser pa 
 inner join personnel a on pa.adviserid=a.objid 
 inner join program p on pa.programid=p.objid  
 where 
   (pa.schooltermid is null or length(pa.schooltermid) = 0 or pa.schooltermid = $P{schooltermid})
   and pa.programid=$P{programid}
   and (pa.yearlevel = 0 or pa.yearlevel = $P{yearlevel})