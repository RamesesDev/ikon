[list]
select * from schoolterm order by fromdate desc

[list-entries]
select se.*, p.description as phase   
from schoolterm_entry se  
inner join schoolterm_phase p on se.phaseid = p.objid 
where schooltermid = $P{schooltermid} 


[list-phases]
select * from schoolterm_phase