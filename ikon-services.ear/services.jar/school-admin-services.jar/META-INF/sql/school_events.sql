[get-current-list]
 select 
  se.title, 
  sp.objid as phaseid, sp.description as phasedesc,
  st.year, st.term
 from schoolterm_entry se, schoolterm_phase sp, schoolterm st
 where 
  se.phaseid = sp.objid and
  se.schooltermid = st.objid and 
  $P{date} between se.fromdate and se.todate
 order by se.schooltermid, se.phaseid