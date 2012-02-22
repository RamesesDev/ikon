<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
Class Info

<script>
	$put( "blockinfo", 
		new function() {
		
			this.saveHandler;
			this.blockinfo = {}
			
			this.programCourse = new ProgramCourse();
			
			var self = this;
			
			this.onload = function() {
				if(this.blockinfo.programcode) {
					this.programName = this.blockinfo.programcode + " - " + this.blockinfo.programtitle;
				}
			}
			
			this.propertyChangeListener = {
				"programCourse.selectedProgram" : function(o) {
					self.blockinfo.programid = o.objid;
					self.programCourse.buildYearLevels( o.yearlevels );
				}
			};
			
			this.save = function() {
				//this.saveHandler(this.blockinfo);
				alert( $.toJSON(this.blockinfo) );
				return "_close";
			}
		
			this.addBlock = function() {
				return "blockschedule";
			}
		
		},
		{
			"default" : "class/newblock.jsp",
			"blockschedule" : "class/blockschedule.jsp"
		}
	);	
</script>

<div r:controller="blockinfo"></div>