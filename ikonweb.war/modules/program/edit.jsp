<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>
	$put( "program_edit", 
		new function() {
		
			var svc = ProxyService.lookup( "ProgramService" );
		
			this.mode = 'create';
			this.orgunit;
			this.saveHandler;
			this.program = {}
			
			this.save = function() {
				if( this.mode == 'create' ) {
					this.program.orgunitid = this.orgunit.objid;
					this.program = svc.create(this.program);
				}
				else {
					this.program = svc.update(this.program);
				}
				
				this.saveHandler(this.program);
				return "_close";
			}
			
			this.yearLevels = [1,2,3,4,5];
		}
	);
</script>

<label r:context="program_edit">
Academic Org. Unit <b>#{orgunit.code} - #{orgunit.title}</b>
</label>
<br>
Code : <input type="text" r:context="program_edit" r:name="program.code" r:required="true" r:caption="Code" />
<br>
Title : <input type="text" r:context="program_edit" r:name="program.title" r:required="true" r:caption="Title" />
<br>
Rev Year : <input type="text" r:context="program_edit" r:name="program.revyear" r:required="true" r:caption="Revision Year" />
<br>
Year Levels : <select r:context="program_edit" r:name="program.yearlevels" r:required="true" r:caption="Year Levels" r:items="yearLevels" r:allowNull="true" ></select>
<br>

<input type="button" r:context="program_edit" r:name="save" value="Save"/>

