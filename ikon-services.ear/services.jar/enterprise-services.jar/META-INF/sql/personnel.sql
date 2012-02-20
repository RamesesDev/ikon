[list]
select objid,staffno,lastname,firstname 
from personnel  
${condition} 
order by lastname, firstname, staffno 
