<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	
	$put( "program_courserules", 
		new function() {
			var svc = ProxyService.lookup( "ProgramService" );
			
			this.course;
			this.selectedCourse;
			this.saveHandler;
			var self = this;
			
			this.prerequisites = [];
			this.corequisites = [];
			
			this.save = function() {
				if(this.saveHandler) this.saveHandler();
				return "_close";
			}
			
			
			
			var buildModel = function(x) {
				return {
					programid: self.course.programid, 
					courseid: self.course.courseid, 
					reqcourseid: x.courseid, 
					reqtype: self.reqtype,
					coursecode: x.coursecode,
					coursetitle: x.coursetitle						
				};
			}
			
			this.addPrerequisite = function() {
				var h = function(x) {
					self.prerequisites.push( buildModel(x) );
				}
				return new DropdownOpener( "program:coursereq_lookup", {selectHandler: h, reqtype: "0", course:this.course } );
			}
			
			this.addCorequisite = function() {
				var h = function(x) {
					self.corequisites.push( buildModel(x) );
				}
				return new DropdownOpener( "program:coursereq_lookup", {selectHandler: h, reqtype: "1", course:this.course } );
			}
			
			this.removePrerequisite = function() {
				self.prerequisites.push( this.selectedCourse );
			}
			
			this.removeCorequisite = function() {
				self.corequisites.push( this.selectedCourse );
			}
		}
	);
</script>

<br>
Other Rules for enrollment:<br>
Min. number units taken : <input type="text" r:context="program_courserules" r:name="course.min_units_taken" size="5"/>
<br>
Min. year level : <input type="text" r:context="program_courserules" r:name="course.min_yearlevel" size="5"/><br>
<br>
<br>
<b>Pre-requisite courses</b>
<input type="button" r:context="program_courserules" r:name="addPrerequisite" value="Add Course" r:immediate="true"/>
<table r:context="program_courserules" r:items="prerequisites" r:varName="item" r:name="selectedCourse" width="90%">
	<tr>
		<td>#{item.coursecode} - #{item.coursetitle}</td>
		<td><a r:context="program_courserules" r:name="removePrerequisite" title="Remove">x</a></td>
	</tr>
</table>
<br>
<b>Co-requisite courses</b>
<input type="button" r:context="program_courserules" r:name="addCorequisite" value="Add Course" r:immediate="true"/>
<table r:context="program_courserules" r:items="corequisites" r:varName="item" r:name="selectedCourse" width="90%">
	<tr>
		<td>#{item.coursecode} - #{item.coursetitle}</td>
		<td><a r:context="program_courserules" r:name="removeCorequisite" title="Remove">x</a></td>
	</tr>
</table>

<br>
<br>
<input type="button" r:context="program_courserules" r:name="save" value="Save"/>
 

			
		
		