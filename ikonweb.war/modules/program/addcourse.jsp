<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	
	$put( "program_addcourse", 
		new function() {
			var svc = ProxyService.lookup( "ProgramService" );
			this.program;
			this.course;
			this.saveHandler;
			this.courseid;
			var self = this;
			this.yearlevels;
			this.selectedCourse;
			
			this.onload = function() {
				this.course = {programid:this.program.objid}
				this.yearlevels = [];
				for( var i=0; i<this.program.yearlevels; i++ ) {
					this.yearlevels.push(i+1);
				}	
			}	
			
			this.save = function() {
				if( !this.selectedCourse ) {
					alert("Please select a course" );
				}	
				else {	
					svc.addProgramCourse( this.course );
					if(this.saveHandler) this.saveHandler();
					return "_close";
				}
			}
			
			this.lookupCourse = function() {
				var h = function(x) {
					self.selectedCourse = x;
					self.course.courseid = x.objid;
					self.course.units = x.units;
				}
				return new PopupOpener( "course:lookup", {selectHandler: h,  orgunit:{objid: this.program.orgunitid} } );
			}
			
			this.termList = [
				{key:"1", label: "1st Semester"},
				{key:"2", label: "2nd Semester"},
				{key:"5", label: "Summer"}
			];
			
		}
	);
</script>

<br>
<input type="hidden" r:context="program_addcourse" r:name="course.courseid" r:caption="Course" r:required" />
<input type="button" r:context="program_addcourse" r:name="lookupCourse" value="Course" r:immediate="true" />
<label r:context="program_addcourse" r:visibleWhen="#{selectedCourse!=null}" r:depends="selectedCourse">
#{selectedCourse.code} - #{selectedCourse.title}
</label>

<br> 
Year Level 
<select r:context="program_addcourse" r:name="course.yearlevel" r:allowNull="true" r:required="true"
	r:caption="Year Level" r:items="yearlevels"></select>
<br>
Term / Semester
<select r:context="program_addcourse" r:name="course.term" r:allowNull="true" r:required="true"
	r:caption="Term / Semester" r:itemKey="key" r:itemLabel="label" r:items="termList"></select>
<br>
Units  <input type="text" r:context="program_addcourse" r:name="course.units" r:depends="selectedCourse"/>
<br>
Lab Hrs <input type="text" r:context="program_addcourse" r:name="course.lab_hrs"/><br>
Lec Hrs <input type="text" r:context="program_addcourse" r:name="course.lec_hrs"/><br>
Remarks <input type="text" r:context="program_addcourse" r:name="course.remarks"/>
<br>
<br>
<input type="button" r:context="program_addcourse" r:name="save" value="Save"/>
 

			
		
		