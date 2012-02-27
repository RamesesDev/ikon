<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:popup>

	<jsp:attribute name="style">
		.grid tr.selected {
			background-color: orange;
		}
	</jsp:attribute>

	<jsp:attribute name="script">
		$put( "enrollment_customize_addclass", 
			new function() {
			
				var svc = ProxyService.lookup("EnrollmentService");
				this.studentid = "${SESSION_INFO.objid}";
				this.schooltermid = "${param['schooltermid']}";
				
				this.saveHandler;
				this.filterType = "regular";
				this.selectedCourse;
				this.selectedItem;
				var self = this;
				
				this.getCourses = function() {
					var v = {studentid: this.studentid, schooltermid: this.schooltermid, filtermode: this.filterType};
					return svc.getAvailableCourses(v);
				}	
				
				this.listModel = {
					fetchList : function(x) {
						if( !self.selectedCourse) return [];
						var p = {}
						p.studentid = self.studentid;
						p.schooltermid = self.schooltermid;
						p.courseid = self.selectedCourse.objid;
						return svc.getAvailableCourseSchedules( p );
					}
				}
				
				this.propertyChangeListener = {
					"selectedCourse": function(x) {
						self.listModel.refresh(true);
					}
				}
				
				this.save = function() {
				    if( !this.selectedItem ) alert( "Please select an item" );
					var p = {
						studentid: this.studentid,
						classid: this.selectedItem.classid 
					}
					this.saveHandler( p );	
					return "_close";
				}
			}
		);	
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<ui:button caption="Add Schedule" action="save" context="enrollment_customize_addclass"/>						
	</jsp:attribute>
	
	<jsp:body>
		<ui:context name="enrollment_customize_addclass">
			<ui:panel cols="2" width="100%" height="300">
				<ui:section width="150">
					<ui:form>
						<ui:combo caption="Filter" name="filterType" itemKey="id" itemLabel="title">
							<option value="regular">Regular</option>
							<option value="nonregular_ge">Non-regular (GE Courses)</option>
							<option value="nonregular_minor">Non-regular (Minor Courses)</option>
						</ui:combo>
					</ui:form>
					<select r:items="getCourses()" r:name="selectedCourse" r:context="${context}" 
						r:itemLabel="coursecode" style="width:100%;height:100%" size="15" r:depends="filterType"></select>
				</ui:section>
				<ui:section>
					<label r:context="${context}" r:depends="selectedCourse">
						<b>Course Code:</b> &nbsp;#{selectedCourse.coursecode}<br>
						<b>Course Title: </b> &nbsp;#{selectedCourse.coursetitle}<br>
					</label> 
					<ui:grid model="listModel">
						<ui:col caption="Class Code" name="classcode"/>
						<ui:col caption="Schedule / Room">#{item.fromtime} - #{item.totime} #{item.days}</ui:col>
						<ui:col caption="Seats Alloc." name="max_seats"/>
						<ui:col caption="Pending" name="pending"/>
						<ui:col caption="Enrolled" name="enrolled"/>
						<ui:col caption="Program">#{item.programcode}</ui:col>
					</ui:grid>
				</ui:section>
			</ui:panel>
		</ui:context>
	</jsp:body>
	
</t:popup>