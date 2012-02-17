<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<style>
	.lookup thead td {
		background-color: lightgrey;
	}
	.lookup td {
		padding-left:5px;
	}
	.lookup tr.selected {
		background-color:orange;
	}
</style>

<script>
	$put( "lookup_available_room_schedule", 
		new function() {
			this.schooltermid;
			this.roomid;
			var svc = ProxyService.lookup("RoomScheduleService");
			var self = this;
			this.selectedItem;
			this.selectHandler;
			
			this.listModel = {
				fetchList: function(o) {
					return svc.getUnassignedSchedules({schooltermid:self.schooltermid,roomid:self.roomid});	
				}
			}	
			this.select = function() {
				this.selectHandler(this.selectedItem);
				return "_close";
			}
		}
	);
</script>

<table r:context="lookup_available_room_schedule" r:model="listModel" r:varName="item" r:name="selectedItem" width="80%" class="lookup">
	<thead>
		<tr>
			<td>Class Code</td>
			<td>Days</td>
			<td>From Time</td>
			<td>To Time</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>#{item.classcode}</td>
			<td>#{item.days}</td>
			<td>#{item.fromtime}</td>
			<td>#{item.totime}</td>
		</tr>
	</tbody>
</table>
<input type="button" r:context="lookup_available_room_schedule" r:name="select" value="OK"/>
		