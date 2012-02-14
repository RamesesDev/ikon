<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	
	$put( "programcourse", 
		new function() {
			var svc = ProxyService.lookup( "ProgramService" );
			this.program;
			this.mode;
			this.course;
			this.saveHandler;
			this.courseid;
			var self = this;
			this.yearlevels = [];
			
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
					this.course.courseid = this.selectedCourse.objid;
					svc.addProgramCourse( this.course );
					if(this.saveHandler) this.saveHandler();
					return "_close";
				}
			}
			
			this.selectedCourse;
			
			this.courseLookup = function(searchText) {
				var courseSvc = ProxyService.lookup( "CourseService" );
				return courseSvc.getList( {code: searchText + '%' } );
			}
			
			this.addCourse = function() {
				return new PopupOpener( "course:create" );
			}
			
			this.termList = [
				{key:"1", label: "1st Semester"},
				{key:"2", label: "2nd Semester"},
				{key:"5", label: "Summer"}
			];
			
			this.propertyChangeListener = {
				"selectedCourse" : function(x) {
					self.course.units = x.units; 
				}
			}
		}
	);
</script>

Course <input type="text" r:context="programcourse" r:name="courseid" r:suggest="courseLookup" r:suggestName="selectedCourse" r:suggestExpression="#{code} - #{title}" />
<label r:context="programcourse" r:visibleWhen="#{selectedCourse!=null}" r:depends="selectedCourse">#{selectedCourse.title}</label>
<br> 
Year Level 
<select r:context="programcourse" r:name="course.yearlevel" r:allowNull="true" r:required="true"
	r:caption="Year Level" r:items="yearlevels"></select>
<br>
Term / Semester
<select r:context="programcourse" r:name="course.term" r:allowNull="true" r:required="true"
	r:caption="Term / Semester" r:itemKey="key" r:itemLabel="label" r:items="termList"></select>
<br>
Units  <input type="text" r:context="programcourse" r:name="course.units" r:depends="selectedCourse"/>
<br>
Lab Hrs <input type="text" r:context="programcourse" r:name="course.lab_hrs"/><br>
Lec Hrs <input type="text" r:context="programcourse" r:name="course.lec_hrs"/><br>
Remarks <input type="text" r:context="programcourse" r:name="course.remarks"/>
<br>
Other Rules for enrollment:<br>
Min. number units taken <input type="text" r:context="programcourse" r:name="course.min_units_taken" size="5"/><br>
Min. year level <input type="text" r:context="programcourse" r:name="course.min_yearlevel" size="5"/><br>

<br>
<input type="button" r:context="programcourse" r:name="save" value="Save"/>
 

			
		
		