[list]
select * from role order by name

[list-by-roleclass]
select * from role where roleclass=$P{roleclass} order by name
