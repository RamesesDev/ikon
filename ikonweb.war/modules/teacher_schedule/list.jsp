<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	$put( "teacher_schedule_list", 
		new function() {
			this.selectedItem;
			this.listModel = {
				fetchList: function(o) {
					return [ {objid:"USR-50fe299b:13505234eaf:-7ffc", firstname:"Nazareno", lastname: "Pat", numclasses: 0, numunits: 0 } ];
				}	
			}	
		}	
	);
</script>


<table r:context="teacher_schedule_list" r:model="listModel" r:varName="item" r:varStatus="stat" r:name="selectedItem" border="1" width="80%">
	<thead>
		<tr>
			<td>Teacher Name</td>
			<td>No of Classes</td>
			<td>No of Units</td>
			<td>&nbsp;</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>#{item.lastname}, #{item.firstname}</td>
			<td>#{item.numclasses}</td>
			<td>#{item.numunits}</td>
			<td><a href="#teacher_schedule?objid=#{item.objid}">View</a></td>
		</tr>
	</tbody>
</table>
			
			