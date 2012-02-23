<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:content title="Teacher Schedules">
	<jsp:attribute name="style">
		.form-title {
			font-weight: bolder;
		}
	</jsp:attribute>

	<jsp:attribute name="script">
		$put( "teacher_schedule_list", 
			new function() {
				var svc = ProxyService.lookup("TeacherScheduleService");
				
				var self = this;
				
				this.schooltermid = "${param['schooltermid']}";	
				this.academicOrgUnits;
				this.orgunit;
				this.display_available = 0;
				this.schedule;
				this.filterText;
				
				this.onload = function() {
					var asvc = ProxyService.lookup("AcademicOrgunitService");
					this.academicOrgUnits = asvc.getList({});
					if( this.academicOrgUnits && this.academicOrgUnits.length>0) {
						this.orgunit = this.academicOrgUnits[0];
					}
				}
				
				this.listModel = {
					fetchList: function(o) {
						if(!o) o = {};
						o.display_available = self.display_available;
						if(self.schedule) {
							o.days_of_week = self.schedule.days_of_week;
							o.fromtime = self.schedule.fromtime;
							o.totime = self.schedule.totime;
						}
						o.schooltermid = self.schooltermid;
						o.orgunitid = (self.orgunit)? self.orgunit.objid : null;
						return svc.getTeachers(o);	
					}
				}	
				this.defineSchedule = function() {
					var f = function(x) {
						self.schedule = x;
						self._controller.notifyDependents("schedule");
					}
					return new DropdownOpener( "scheduling:dow_schedule", {saveHandler: f} );
				}

				this.search = function() {
					if( this.display_available == 1 ) {
						if( !this.schedule ) throw new Error('Please specify a schedule');
					}
					else {
						this.schedule = null;
					}
					
					this.filterText = "View Teachers for " + this.orgunit.title;
					if(this.schedule) {
						this.filterText += " available on " + this.schedule.days + " " + this.schedule.fromtime + "-" + this.schedule.totime;
					}
					self.listModel.refresh(true);
					self._controller.notifyDependents( "filterText" );
				}
				
			}
		);
	</jsp:attribute>	

	<jsp:body>
		<ui:context name="teacher_schedule_list">

			<ui:panel cols="2" width="100%">
				<ui:section width="70%">
					<label r:context="${context}" r:depends="filterText">#{filterText}</label>
					<br>
					<ui:grid model="listModel" width="100%">
						<ui:col caption="Teacher" width="80%">#{item.lastname}, #{item.firstname}</ui:col>
						<ui:col><a href="#teacher_schedule:info?objid=#{item.objid}">View Schedule</a></ui:col>
					</ui:grid>
				</ui:section>
				<ui:section style="padding-left:10px;padding-top:10px;">
					<ui:panel style="border:1px solid lightgrey;padding:4px;" width="100%">
						<ui:section><h2>Filters</h2></ui:section>
						<ui:section>Academic Org Unit</ui:section>
						<ui:section>
							<select r:context="${context}" r:name="orgunit" r:items="academicOrgUnits" r:itemLabel="code"></select>
						</ui:section>
						<ui:section style="padding-top:20px;">
							<input type="radio" r:context="${context}" r:name="display_available" value="0"/>Display All<br>
							<input type="radio" r:context="${context}" r:name="display_available" value="1"/>Available on ff. schedules<br>
							<div r:context="${context}" style="padding-left:10px" r:depends="display_available" r:visibleWhen="#{display_available==1}">
								<label r:context="${context}" r:visibleWhen="#{schedule!=null}" r:depends="schedule">
									Schedule: #{schedule.days} #{schedule.fromtime}-#{schedule.totime}
								</label>
								<br>
								<a r:context="${context}" r:name="defineSchedule">Specify Schedule</a>
							</div>
						</ui:section>
						
						<ui:section style="padding-top:10px;">
							<ui:button caption="Search" action="search"/> 
						</ui:section>
					</ui:panel>
				</ui:section>
			</ui:panel>
		</ui:context>
	</jsp:body>
	
</t:content>


