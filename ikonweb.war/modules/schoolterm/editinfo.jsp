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
		}
	);
</script>

Year <input type="text" r:context="schoolterm" r:name="schoolterm.year" r:required="true" r:caption="Year" />
<br>
Term <input type="text" r:context="schoolterm" r:name="schoolterm.term" r:required="true" r:caption="Semester" />
<br>
From date <input type="text" r:context="schoolterm" r:name="schoolterm.fromdate" r:required="true" r:caption="From date" r:datatype="date" />
<br>
To date <input type="text" r:context="schoolterm" r:name="schoolterm.todate" r:required="true" r:caption="To date" r:datatype="date" />
<br>

<input type="button" r:context="schoolterm" r:name="save" value="Save"/>

