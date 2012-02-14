<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>
	$put( "class_addblock", 
		new function() {
			
			var svc = ProxyService.lookup( "ClassScheduleService" );
			
			this.saveHandler;
			this.block = { schooltermid: "${param['schooltermid']}"}
			this.program;
			this.yearLevels;
			
			var self = this;

			this.lookupProgram = function() {
				var h = function(o) {
					self.program = o;
					self.block.programid = o.objid;
					self.yearLevels = [];
					for( var i=0; i<o.yearlevels; i++){
						self.yearLevels.push(i+1);
					}
				}
				return new DropdownOpener( "program:lookup", {selectHandler: h} );
			}
			
			this.save = function() {
				this.block = svc.saveBlock( this.block );
				this.saveHandler(this.block);
				return "_close";
			}
		}	
	);
</script>

Block Code <input type="text" r:context="class_addblock" r:name="block.code" r:required="true" r:caption="Block Code" />
<br>

<input type="button" r:context="class_addblock" r:name="lookupProgram" value="Program" r:immediate="true"/>
<label r:context="class_addblock" >#{program.code} - #{program.title}</label>


<br>	
Year Level <select r:context="class_addblock" r:name="block.yearlevel" r:items="yearLevels"></select>
<br/>

<br>
<br>
<br>
<input type="button" r:context="class_addblock" r:name="save" value="Save"/>

