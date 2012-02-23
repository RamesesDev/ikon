<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>


<t:popup>
	<jsp:attribute name="script">
		$put( "blockschedule_addclass", 
			new function() {
				var svc = ProxyService.lookup("BlockScheduleService"); 
				
				this.class;
				this.block;
				
				this.selectedSchedule;
				this.saveHandler;
				
				this.courseList;
				
				this.getCourseList = function() {
					var p = {}
					p.yearlevel = this.block.yearlevel;
					p.term = this.block.term;
					p.blockid = this.block.objid;
					p.programid = this.block.programid;
					return svc.lookupRegularProgramCourses( p );
				}
				
				this.onload = function() {
					this.class = {schedules: [] };
					this.class.blockid = this.block.objid;
					this.class.programid = this.block.programid;
					this.class.schooltermid = this.block.schooltermid;	
					this.class.min_seats = 1;
					this.class.max_seats = 50;
					this.class.colorcode = "lightgrey";
				}
				
				var self = this;
				
				this.scheduleList = {
					fetchList: function(o)  {
						return self.class.schedules;
					}
				}
				
				var refreshSchedule = function(o) {
					self.scheduleList.refresh();
				}
				
				this.addSchedule = function() {
					var f = function(o) {
						self.class.schedules.push(o);
						refreshSchedule();
					}
					return new PopupOpener("scheduling:dow_schedule", {saveHandler: f} );
				}
				
				this.editSchedule = function() {
					return new PopupOpener("scheduling:dow_schedule", {saveHandler: refreshSchedule, schedule: this.selectedSchedule} );
				}
				
				this.removeSchedule = function() {
					if( confirm("You are about to remove this item. Continue?")) {
						this.class.schedules.remove( this.selectedSchedule );
						refreshSchedule();
					}
				}
				
				this.save = function() {
					if(this.class.schedules.length == 0) {
						MsgBox.error("Please specify the schedule(s).");
						return;
					}
					svc.saveClass( this.class );
					this.saveHandler();
					return "_close";
				}
			}	
		);
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<ui:button context="blockschedule_addclass" action="save" caption="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		<ui:context name="blockschedule_addclass">
			<ui:panel cols="2" width="100%">	
				<ui:section width="180px">
					Select a course<br>
					<select r:context="${context}" r:items="getCourseList()" r:depends="scheduletype" r:name="class.courseid" 
						r:itemKey="courseid" r:itemLabel="coursecode" r:required="true" r:caption="Course" size="15"
						style="width:100%"/>
				</ui:section>
				<ui:section style="padding-left:20px">
					<ui:form object="class">
						<ui:text caption="Class Code" name="code" 	required="true"/>
						<ui:label caption="Color Code">
							<span r:type="colorpicker" r:context="blockschedule_addclass" r:name="class.colorcode"></span>			
						</ui:label>
					</ui:form>
					<br>
					<h2>Class Policy</h2>
					<ui:form object="class">
						<ui:text caption="Min No. of Seats" name="min_seats" required="true" size="4"/>
						<ui:text caption="Max No. of Seats" name="max_seats" required="true" size="4"/>
					</ui:form>
					<ui:grid model="scheduleList" width="100%" name="selectedSchedule">
						<ui:col caption="Days" name="days"/>
						<ui:col caption="Time">#{item.fromtime} - #{item.totime}</ui:col>
						<ui:col>
							<a r:context="${context}" r:name="editSchedule" r:immediate="true">Edit</a>
							&nbsp;&nbsp;&nbsp;
							<a r:context="${context}" r:name="removeSchedule" r:immediate="true">Remove</a>
						</ui:col>
					</ui:grid>
					<ui:button action="addSchedule" caption="Add Schedule" immediate="true" title="Add Schedule"/>

				</ui:section>
			</ui:panel>
		</ui:context>
		
	</jsp:body>
</t:popup>





	
	