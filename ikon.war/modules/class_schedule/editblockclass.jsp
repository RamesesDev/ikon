<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>
	$put( "class_schedule_edit_block_class", 
	
		new function() {
			var svc = ProxyService.lookup("ClassScheduleService"); 
			
			this.class;
			this.selectedSchedule;
			this.saveHandler;
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
				this.class.schedules.remove( this.selectedSchedule );
				if( !this.class.removedSchedules ) this.class.removedSchedules = [];
				this.class.removedSchedules.push( this.selectedSchedule );
				refreshSchedule();
			}
			
			this.save = function() {
				svc.changeSchedule( this.class );
				this.saveHandler();
				return "_close";
			}
		}	
	);
</script>

<label r:context="class_schedule_edit_block_class">
	Class Code:  <b>#{class.code}</b><br>
	Course:  <b>#{class.coursecode} - #{class.coursetitle}</b><br>
</label>
<br>

<b>Schedules</b>
<br>
<table r:context="class_schedule_edit_block_class" r:model="scheduleList" r:varName="item" width="80%" r:name="selectedSchedule" border="1">
	<thead>
		<tr>
			<td>Days</td>
			<td>Time</td>
			<td>&nbsp;</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>#{item.days}</td>
			<td>#{item.fromtime} - #{item.totime}</td>
			<td>
				<a r:context="class_schedule_edit_block_class" r:name="editSchedule" r:immediate="true">Edit</a>
				&nbsp;&nbsp;&nbsp;
				<a r:context="class_schedule_edit_block_class" r:name="removeSchedule" r:immediate="true">Remove</a>
			</td>
		</tr>
	</tbody>	
</table>
<input type="button" r:context="class_schedule_edit_block_class" r:name="addSchedule" value="+" r:immediate="true" title="Add Schedule"/>
<br>
<br>
<input type="button" r:context="class_schedule_edit_block_class" r:name="save" value="Save"/>

	
	