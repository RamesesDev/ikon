<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>
	$put( "schoolterm", 
		new function() {
		
			this.saveHandler;
			this.schoolterm = {}
			
			this.save = function() {
				this.saveHandler(this.schoolterm);
				return "_close";
			}
			
			this.termList = [
				{key:"1", label: "1st Semester"},
				{key:"2", label: "2nd Semester"},
				{key:"5", label: "Summer"}
			];
			
		}
	);
</script>

Year <input type="text" r:context="schoolterm" r:name="schoolterm.year" r:required="true" r:caption="Year" />
<br>
Term <select r:context="schoolterm" r:name="schoolterm.term" 
	r:required="true" r:caption="Semester" r:items="termList" r:itemKey="key" r:itemLabel="label"></select>
<br>
From date <input type="text" r:context="schoolterm" r:name="schoolterm.fromdate" r:required="true" r:caption="From date" r:datatype="date" />
<br>
To date <input type="text" r:context="schoolterm" r:name="schoolterm.todate" r:required="true" r:caption="To date" r:datatype="date" />
<br>

<input type="button" r:context="schoolterm" r:name="save" value="Save"/>

