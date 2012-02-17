<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	$put( "room_schedule_list", 
		new function() {
		
			var svc = ProxyService.lookup("RoomScheduleService");
			this.schedule;
			var self = this;

			this.schooltermid = "${param['schooltermid']}";	
			this.selectedItem;
			
			this.listModel = {
				fetchList: function(o) {
					if( !self.schedule ) return [];
					self.schedule.schooltermid = self.schooltermid;
					return svc.getAvailability(self.schedule);	
				}
			}	
			
			this.defineSchedule = function() {
				var f = function(x) {
					self.schedule = x;
					self.listModel.refresh(true);
				}
				return new DropdownOpener( "scheduling:dow_schedule", {saveHandler: f} );
			}
			
			this.resetSchedule = function() {
				this.schedule = null;
			}
		}
	
	);
</script>

Search available rooms: 
<input type="button" r:context="room_schedule_list" r:name="defineSchedule" value="Define Schedule"/>
<br>
<label r:context="room_schedule_list" r:visibleWhen="#{schedule}">
	<b>Schedule: #{schedule.days} #{schedule.fromtime}-#{schedule.totime}</b> 
	<a r:context="room_schedule_list" r:name="resetSchedule">Reset</a>
</label>
<br>
<br>
<br>
<table r:context="room_schedule_list" r:model="listModel" r:varName="item" r:varStatus="stat" r:name="selectedItem" width="80%">
	<thead>
		<tr>
			<td>Room</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>#{item.roomno}</td>
		</tr>
	</tbody>
</table>
			
		