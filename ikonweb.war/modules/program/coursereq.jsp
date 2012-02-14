<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	
	$put( "coursereq", 
		new function() {
			var svc = ProxyService.lookup( "ProgramAdminService" );
		
			this.saveHandler;
			this.programCourse;
			this.reqtype = 0;
			
			this.selectedCourse;
			var self = this;
			
			this.courseList = [];
			this.removedItems = [];
			
			this.onload = function() {
				var p = {
					programid: self.programCourse.programid, 
					courseid: self.programCourse.courseid,
					reqtype: self.reqtype	
				};
				this.courseList = svc.getCourseRequisites( p );
			}
			
			this.courseLookup = function(o) {
				var p = {
					programid: self.programCourse.programid, 
					courseid: self.programCourse.courseid, 
					code: o + "%",
					yearlevel: self.programCourse.yearlevel,
					term: self.programCourse.term
				};
				
				if(self.reqtype == 0 ) {
					return svc.lookupCoursePrerequisites( p ); 
				}
				else {
					p.courseid = self.programCourse.courseid;
					return svc.lookupCourseCorequisites( p ); 
				}	
			}
			
			this.propertyChangeListener = {
				"selectedCourse" : function(o) {
					var n = {
						programid: self.programCourse.programid, 
						courseid: self.programCourse.courseid, 
						reqcourseid: o.courseid, 
						reqtype: self.reqtype,
						coursecode: o.coursecode,
						coursetitle: o.coursetitle						
					};
					self.courseList.push(n);
					self.courseName = "";
					self._controller.refresh();
				}	
			}
			
			this.selectedItem;
			
			this.removeCourse = function() {
				this.removedItems.push(this.selectedItem);
				this.courseList.remove( this.selectedItem );
			}
			
			this.save = function() {
				svc.saveCourseRequisites( this.courseList, this.removedItems );
				if(this.saveHandler) this.saveHandler();
				return "_close";
			}
		}
	);
</script>

<div id="courseTpl" style="display:none;">
	<a>#{coursecode} - #{coursetitle}</a>
</div>

Add course <input type="text" r:context="coursereq" r:name="courseName" r:suggest="courseLookup" 
	r:suggestName="selectedCourse" r:suggestExpression="#{coursecode} - #{coursetitle}" r:suggestTemplate="courseTpl" size="30"/>
<br>
<table r:context="coursereq" r:items="courseList" r:varName="item" r:depends="selectedCourse" r:name="selectedItem" width="90%">
	<tr>
		<td>#{item.coursecode} - #{item.coursetitle}</td>
		<td><a r:context="coursereq" r:name="removeCourse" title="Remove">x</a></td>
	</tr>
</table>
<br>
<input type="button" r:context="coursereq" r:name="save" value="Save" />
			
		