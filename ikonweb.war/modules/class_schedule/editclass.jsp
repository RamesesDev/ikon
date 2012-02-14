<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>
	$put( "editclass", 
		new function() {

			this.saveHandler;
			this.editclass = {}
		
			this.programCourse;
			
			var self = this;
			
			this.onload = function() {
				this.programCourse = new ProgramCourse();
				if(this.editclass.programcode) {
					this.programName = this.editclass.programcode + " - " + this.editclass.programtitle;
				}
			}
			
			this.propertyChangeListener = {
				"programCourse.selectedProgram" : function(o) {
					self.editclass.programid = o.objid;
					self.programCourse.programid = o.objid;
					self.programCourse.buildYearLevels( o.yearlevels );
					self.courseName = "";
					self.programCourse.selectedCourse = null;
				}
			};
			
			this.save = function() {
				//this.saveHandler(this.editclass);
				alert( $.toJSON(this.editclass) );
				return "_close";
			}
			
		}
	);
</script>

<div id="programTpl" style="display:none;">
	<a>#{code} - #{title}</a>
</div>

Block Code<input type="text" r:context="editclass" r:name="editclass.block" r:required="true" r:caption="Block" />
<br>
		
Program <input type="text" r:context="editclass" r:name="programName" size="50"
	r:suggest="programCourse.programLookup" r:suggestName="programCourse.selectedProgram" 
	r:suggestExpression="#{code} - #{title}" r:suggestTemplate="programTpl" r:caption="Program"/>
	
<br>	
Course 
<input type="text" r:context="editclass" r:name="courseName" size="50"
	r:suggest="programCourse.courseLookup" r:suggestName="programCourse.selectedCourse" 
	r:suggestExpression="#{code} - #{title}" r:suggestTemplate="programTpl" r:caption="Course"/>
<br>	
	
Year Level <select r:context="editclass" r:name="editblock.yearlevel" 
	r:depends="programCourse.selectedProgram"
	r:items="programCourse.yearLevels"></select>
<br/>

<br>
<input type="button" r:context="editclass" r:name="save" value="Save"/>

