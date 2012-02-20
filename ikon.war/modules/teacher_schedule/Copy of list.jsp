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
	$register( {id:"#context_menu", context: "teacher_schedule_list" });
	$put( "teacher_schedule_list", 
	
		new function() {
			var util = new SkedUtil();
			var svc = ProxyService.lookup("TeacherScheduleService");
			this.schedule;
			var self = this;
			
			this.schooltermid = "${param['schooltermid']}";	
			this.selectedItem;
			
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
				self.selectedItem = null;
				self._controller.notifyDependents("selectedItem");
			}

			this.resetSchedule = function() {
				this.schedule = null;
				refreshScreen();
			}
			
			this.weekSchedule = {
				minTime: 6,
				maxTime: 22,
				onclick: function(o,e) {
					self.selectedSchedule = o.item;
					self._controller.navigate(new DropdownOpener( "#context_menu"), e );
				},
				fetchList: function() {
					if( !self.selectedItem) return [];
					var list = svc.getTeacherSchedules({schooltermid:self.schooltermid,teacherid:self.selectedItem.objid});
					var arr = [];
					for( var i=0; i<list.length; i++ ) {
						var c = list[i];	
						var func = function(d) {
							var caption = c.classcode;
							caption += "\n" + "Rm:" + ((c.roomno)?c.roomno:'unassigned');
							arr.push( {day: d, from: c.fromtime, to: c.totime, caption: caption, item:c, color: c.colorcode });		
						}
						util.fetchDays( c.days_of_week, func );
					}
					return arr;
				}
			};
			
			this.lookupAvailable = function() {
				var f = function(x) {
					svc.assignTeacher( {objid: x.classid, teacherid: self.selectedItem.objid } );
					self.weekSchedule.load();
				}
				return new PopupOpener( "teacher_schedule:lookup_available_schedule", 
					{selectHandler:f, schooltermid:this.schooltermid, teacherid: this.selectedItem.objid, orgunitid: this.orgunit.objid } 
				);
			}
			
			this.unassignTeacher = function() {
				self._controller.navigate( "_close");
				if( confirm( "This will remove room assignement. Proceed?")) {
					svc.unassignTeacher( {objid: self.selectedSchedule.classid, teacherid: self.selectedSchedule.teacherid } );
					self.weekSchedule.load();
				}
			}
			
			this.propertyChangeListener = {
				"selectedItem": function(o) {
					self.weekSchedule.load();
				}
			}
		}
	);
</script>

<div id="context_menu" style="display:none;">
	<label r:context="teacher_schedule_list">
		<b>#{selectedSchedule.code}</b>
		<br>
	</label>
	<a r:context="teacher_schedule_list" r:name="unassignTeacher">Unassign Teacher</a>
</div>



<table width="100%" height="100%">
	<tr>
		<td colspan="2" height="40" valign="top" style="border-bottom:1px solid lightgrey;padding-bottom:10px;">
			<b>Teacher Schedules</b><br>
			<input type="button" r:context="teacher_schedule_list" r:name="defineSchedule" value="Search"/><br>
			<label r:context="teacher_schedule_list" r:visibleWhen="#{schedule}">
				<b>Schedule: #{schedule.days} #{schedule.fromtime}-#{schedule.totime}</b> 
				<br>
				<a r:context="teacher_schedule_list" r:name="resetSchedule">Reset</a>
			</label>
			<br>
			Academic Unit : <select r:context="teacher_schedule_list" r:name="orgunit" r:items="academicOrgUnits" r:itemLabel="code"></select> 
		</td>
	</tr>
	<tr>
		<td width="120" valign="top" style="border-right:1px solid lightgrey;">
			<b><u>Teachers</u></b>
			<table r:context="teacher_schedule_list" r:model="listModel" r:varName="item" r:varStatus="stat" r:name="selectedItem" width="80%" class="teacher_search_results">
				<tr><td>#{item.lastname}, #{item.firstname}</td></tr>
			</table>
		</td>
		
		<td valign="top">
			<label r:context="teacher_schedule_list" r:depends="selectedItem" r:visibleWhen="#{selectedItem!=null}">
				Teacher: <b>#{selectedItem.lastname}, #{selectedItem.firstname}</b>
				<input type="button" r:context="teacher_schedule_list" r:name="lookupAvailable" value="Assign Schedule"/>
				<br>
			</label>
			<div r:type="weekcalendar" r:context="teacher_schedule_list" r:model="weekSchedule"></div>
		</td>
	</tr>
</table>

		