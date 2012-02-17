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
	$put( "lookup_available_teacher_schedule", 
		new function() {
			this.schooltermid;
			this.teacherid;
			this.orgunitid;
			
			var svc = ProxyService.lookup("TeacherScheduleService");
			var self = this;
			this.selectedItem;
			this.selectHandler;
			
			this.listModel = {
				fetchList: function(o) {
					return svc.getUnassignedSchedules({schooltermid:self.schooltermid,teacherid:self.teacherid, orgunitid: self.orgunitid});	
				}
			}	
			this.select = function() {
				this.selectHandler(this.selectedItem);
				return "_close";
			}
		}
	);
</script>

<table r:context="lookup_available_teacher_schedule" r:model="listModel" r:varName="item" r:name="selectedItem" width="80%" class="lookup">
	<thead>
		<tr>
			<td>Class Code</td>
			<td>Days</td>
			<td>From Time</td>
			<td>To Time</td>
			<td>Room</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>#{item.classcode}</td>
			<td>#{item.days}</td>
			<td>#{item.fromtime}</td>
			<td>#{item.totime}</td>
			<td>#{item.roomno}</td>
		</tr>
	</tbody>
</table>
<input type="button" r:context="lookup_available_teacher_schedule" r:name="select" value="OK"/>
		