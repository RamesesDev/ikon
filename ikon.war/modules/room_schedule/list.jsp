<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<style>
	.room_search_results tr.selected {
		background-color: orange;
	}

</style>

<script>
	$put( "room_schedule_list", 
		new function() {
			var svc = ProxyService.lookup("RoomScheduleService");
			this.schedule;
			var self = this;
			this.schooltermid = "${param['schooltermid']}";	
			
			this.selectedSchedule;
			
			this.listModel = {
				fetchList: function(o) {
					if( !self.schedule ) return [];
					self.schedule.schooltermid = self.schooltermid;
					return svc.getRoomAvailability(self.schedule);	
				}
			}	
			this.defineSchedule = function() {
				var f = function(x) {
					self.schedule = x;
					refreshList();
				}
				return new DropdownOpener( "scheduling:dow_schedule", {saveHandler: f} );
			}

			var refreshList = function() {
				self.listModel.refresh(true);
			}

			this.resetSchedule = function() {
				this.schedule = null;
				refreshList();
			}
		}
	);
</script>

<b>Room Schedules</b><br>
<input type="button" r:context="room_schedule_list" r:name="defineSchedule" value="Search"/><br>
<label r:context="room_schedule_list" r:visibleWhen="#{schedule}">
	<b>Schedule: #{schedule.days} #{schedule.fromtime}-#{schedule.totime}</b> 
	<br>
	<a r:context="room_schedule_list" r:name="resetSchedule">Reset</a>
</label>
	
<br>	
<b><u>Rooms</u></b>
<table r:context="room_schedule_list" r:model="listModel" r:varName="item" r:varStatus="stat" width="80%" class="room_search_results">
	<tr>
		<td>#{item.roomno}</td>
		<td><a href="#room_schedule:info?objid=#{item.objid}">View Schedule</a></td>
	</tr>
</table>
