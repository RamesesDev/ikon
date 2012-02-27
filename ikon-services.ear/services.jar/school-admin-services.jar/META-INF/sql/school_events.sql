[get-current-list]
 select 
  se.*, 
  sp.objid as phaseid, sp.description as phasedesc,
  st.objid as schooltermid, st.year, st.term,
  se.title 
 from schoolterm_entry se, schoolterm_phase sp, schoolterm st
 where 
  se.phaseid = sp.objid and
  se.schooltermid = st.objid and 
  $P{date} between se.fromdate and se.todate
 order by se.phaseid
 
 
[get-phase-events]
 select 
  se.*, 
  sp.description as phasedesc,
  st.year as schoolyear, st.term as schoolterm
 from schoolterm_entry se, schoolterm_phase sp, schoolterm st
 where 
  se.phaseid = $P{phaseid} and
  se.phaseid = sp.objid and
  se.schooltermid = st.objid 
 order by se.schooltermid, se.phaseid