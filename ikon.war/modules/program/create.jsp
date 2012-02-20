<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>
	$put( "program_create", 
		new function() {
		
			var svc = ProxyService.lookup( "ProgramService" );
		
			this.orgunit;
			this.saveHandler;
			this.program = {}
			
			this.save = function() {
				this.program.orgunitid = this.orgunit.objid;
				this.program = svc.create(this.program);
				this.saveHandler(this.program);
				return "_close";
			}
			
		}
	);
</script>

<label r:context="program_create">
Academic Org. Unit <b>#{orgunit.code} - #{orgunit.title}</b>
</label>
<br>
Code : <input type="text" r:context="program_create" r:name="program.code" r:required="true" r:caption="Code" />
<br>
Title : <input type="text" r:context="program_create" r:name="program.title" r:required="true" r:caption="Title" />
<br>
Rev Year : <input type="text" r:context="program_create" r:name="program.revyear" r:required="true" r:caption="Revision Year" />
<br>
Year Levels : <input type="text" r:context="program_create" r:name="program.yearlevels" r:required="true" r:caption="Year Levels" size="2"/>
<br>

<input type="button" r:context="program_create" r:name="save" value="Save"/>

