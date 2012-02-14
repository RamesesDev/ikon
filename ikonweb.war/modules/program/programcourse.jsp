<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	
	$put( "programcourse", 
		new function() {
			var svc = ProxyService.lookup( "ProgramAdminService" );
			this.programid;
			this.mode;
			this.course;
			this.saveHandler;
			this.courseid;
			
			this.onload = function() {
				this.course = {programid:this.programid}
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
				return svc.findCourses( {code: searchText + '%' } );
			}
			
			this.addCourse = function() {
				return new PopupOpener( "" );
			}
		}
	);
</script>
<div id="courseTpl" style="display:none;">
	<a>#{code} - #{title}</a>
</div>

Course <input type="text" r:context="programcourse" r:name="courseid" r:suggest="courseLookup" r:suggestName="selectedCourse" r:suggestExpression="#{code}" r:suggestTemplate="courseTpl" />
<label r:context="programcourse" r:visibleWhen="#{selectedCourse!=null}" r:depends="selectedCourse">#{selectedCourse.title}</label>
<br> 
Year Level <input type="text" r:context="programcourse" r:name="course.yearlevel"/><br> 
Semester <input type="text" r:context="programcourse" r:name="course.term"/><br> 
Units <input type="text" r:context="programcourse" r:name="course.units"/><br> 
Lab Hrs <input type="text" r:context="programcourse" r:name="course.lab_hrs"/><br>
Lec Hrs <input type="text" r:context="programcourse" r:name="course.lec_hrs"/><br>
Remarks <input type="text" r:context="programcourse" r:name="course.remarks"/>
<br>
Other Rules for enrollment:<br>
Min. number units taken <input type="text" r:context="programcourse" r:name="course.min_units_taken" size="5"/><br>
Min. year level <input type="text" r:context="programcourse" r:name="course.min_yearlevel" size="5"/><br>

<br>
<input type="button" r:context="programcourse" r:name="save" value="Save"/>
 

			
		