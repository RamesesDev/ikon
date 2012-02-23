[list]
	select objid,staffno,lastname,firstname 
	from personnel  
	${condition} 
	order by lastname, firstname, staffno 

[getPersonnelPositions]
	select code, title, role 
	from jobposition 
	where assigneeid=$P{objid}
