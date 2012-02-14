<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>
	$put( "program", 
		new function() {
		
			var svc = ProxyService.lookup( "ProgramAdminService" );
		
			this.mode = 'create';
			this.orgunitid;
			this.saveHandler;
			this.program = {}
			
			this.save = function() {
				if( this.mode == 'create' ) {
					this.program.orgunitid = this.orgunitid;
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

Code <input type="text" r:context="program" r:name="program.code" r:required="true" r:caption="Code" />
<br>
Title <input type="text" r:context="program" r:name="program.title" r:required="true" r:caption="Title" />
<br>
Rev Year <input type="text" r:context="program" r:name="program.revyear" r:required="true" r:caption="Revision Year" />
<br>
Year Levels <select r:context="program" r:name="program.yearlevels" r:required="true" r:caption="Year Levels" r:items="yearLevels" r:allowNull="true" ></select>
<br>

<input type="button" r:context="program" r:name="save" value="Save"/>

