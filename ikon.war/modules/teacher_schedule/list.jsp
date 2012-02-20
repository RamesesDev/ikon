<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<style>
	.teacher_search_results td {
		padding-left:5px;
	}
	.teacher_search_results tr.selected {
		background-color:orange;
	}
</style>

<script>
	$put( "teacher_schedule_list", 
	
		new function() {
			var svc = ProxyService.lookup("TeacherScheduleService");
			this.schedule;
			var self = this;
			
			this.schooltermid = "${param['schooltermid']}";	
			
			this.selectedSchedule;
			this.academicOrgUnits;
			this.orgunit;
			
			this.onload = function() {
				var asvc = ProxyService.lookup("AcademicOrgunitService");
				this.academicOrgUnits = asvc.getList({});
				if( this.academicOrgUnits && this.academicOrgUnits.length>0) {
					this.orgunit = this.academicOrgUnits[0];
				}
			}
			
			this.listModel = {
				fetchList: function(o) {
					if( !self.schedule ) return [];
					self.schedule.schooltermid = self.schooltermid;
					self.schedule.orgunitid = (self.orgunit.objid)? self.orgunit.objid : null;
					return svc.getTeacherAvailability(self.schedule);	
				}
			}	
			this.defineSchedule = function() {
				var f = function(x) {
					self.schedule = x;
					refreshScreen();
				}
				return new DropdownOpener( "scheduling:dow_schedule", {saveHandler: f} );
			}

			var refreshScreen = function() {
				self.listModel.refresh(true);
			}

			this.resetSchedule = function() {
				this.schedule = null;
				refreshScreen();
			}
		}
	);
</script>

<b>Teacher Schedules</b><br>
<input type="button" r:context="teacher_schedule_list" r:name="defineSchedule" value="Search"/><br>
<label r:context="teacher_schedule_list" r:visibleWhen="#{schedule}">
	<b>Schedule: #{schedule.days} #{schedule.fromtime}-#{schedule.totime}</b> 
	<br>
	<a r:context="teacher_schedule_list" r:name="resetSchedule">Reset</a>
</label>
<br>
Academic Unit : <select r:context="teacher_schedule_list" r:name="orgunit" r:items="academicOrgUnits" r:itemLabel="code"></select> 
<br>
<b><u>Teachers</u></b>
<br>
<table r:context="teacher_schedule_list" r:model="listModel" r:varName="item" r:varStatus="stat" width="80%" class="teacher_search_results">
	<tr>
		<td>#{item.lastname}, #{item.firstname}</td>
		<td><a href="#teacher_schedule:info?objid=#{item.objid}">View</a></td>
	</tr>
</table>