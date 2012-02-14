<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>
	$put( "editblock", 
		new function() {
			
			var svc = ProxyService.lookup( "ClassService" );
			
			this.saveHandler;
			this.editblock = { schooltermid: "${param['schooltermid']}"}
			
			this.programCourse = new ProgramCourse();
			
			var self = this;
			
			this.onload = function() {
				if(this.editblock.programcode) {
					this.programName = this.editblock.programcode + " - " + this.editblock.programtitle;
				}
			}
			
			this.propertyChangeListener = {
				"programCourse.selectedProgram" : function(o) {
					self.editblock.programid = o.objid;
					if(!self.editblock.yearlevel) self.editblock.yearlevel = 1;
					self.programCourse.buildYearLevels( o.yearlevels );
				}
			};
			
			this.save = function() {
				this.editblock = svc.saveBlock( this.editblock );
				this.saveHandler(this.editblock);
				return "_close";
			}
		}	
	);
</script>
<div id="programTpl" style="display:none;">
	<a>#{code} - #{title}</a>
</div>


Program <input type="text" r:context="editblock" r:name="programName" size="50"
	r:suggest="programCourse.programLookup" r:suggestName="programCourse.selectedProgram" 
	r:suggestExpression="#{code} - #{title}" r:suggestTemplate="programTpl" r:caption="Program"/>
<br>
Block Code <input type="text" r:context="editblock" r:name="editblock.code" r:required="true" r:caption="Block Code" />
<br>

<br>	
Year Level <select r:context="editblock" r:name="editblock.yearlevel" 
	r:depends="programCourse.selectedProgram"
	r:items="programCourse.yearLevels"></select>
<br/>


<br>
<input type="button" r:context="editblock" r:name="save" value="Save"/>

