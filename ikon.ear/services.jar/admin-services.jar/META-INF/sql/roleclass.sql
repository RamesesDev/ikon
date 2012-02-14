[list]
select * from roleclass where rolelevel > $P{rolelevel} order by name

[module-list]
select * from roleclass_module where roleclass = $P{roleclass}

[module-permissions]
select sm.name as modulename, sm.title as moduletitle, sm.permissions 
from roleclass_module rcm  
inner join sys_module sm on sm.name = rcm.module 
where rcm.roleclass = $P{roleclass} 




