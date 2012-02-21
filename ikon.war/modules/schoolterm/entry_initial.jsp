<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	
	$put( "schooltermentry", 
		new function() {
			var svc = ProxyService.lookup( "SchoolTermAdminService" );
			this.entry;	
			this.phaseList;
			this.schooltermid;
			this.saveHandler;
			
			this.onload = function() {
				this.entry = { schooltermid: this.schooltermid };	
				this.phaseList = svc.getPhaseList();
			}	
			
			this.save = function() {
				svc.addEntry( this.entry );
				if(this.saveHandler) this.saveHandler();
				return "_close";
			}
		}
	);
</script>

Phase <select r:context="schooltermentry" r:items="phaseList" r:allowNull="true" r:required="true" r:caption="Phase" r:name="entry.phaseid" r:itemKey="objid" r:itemLabel="description" ></select>
<br>
From Date <input type="text" r:context="schooltermentry" r:name="entry.fromdate" r:datatype="date"/><br>
To Date <input type="text" r:context="schooltermentry" r:name="entry.todate" r:datatype="date" /><br>
<br>
<input type="button" r:context="schooltermentry" r:name="save" value="Save"/>
