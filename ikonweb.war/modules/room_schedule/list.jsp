<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	$put( "room_schedule_list", 
		this.listModel = function() {
			this.selectedItem;
			return [];
		}	
	);
</script>


<table r:context="room_schedule_list" r:model="listModel" r:varName="item" r:varStatus="stat" r:name="selectedItem" border="1" width="80%">
	<thead>
		<tr>
			<td>Room No.</td>
			<td>No of Classes</td>
			<td>Remarks</td>
			<td>&nbsp;</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>#{item.name}</td>
			<td>#{item.numclasses}</td>
			<td>#{item.remarks}</td>
			<td>&nbsp;</td>
		</tr>
	</tbody>
</table>
			
		