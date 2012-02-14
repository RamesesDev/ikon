<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	
	$put( "studentlist", 
		new function() {
			var svc = ProxyService.lookup( "StudentService" );
			var self = this;
			this.selectedItem;
			
			this.listModel = {
				rows: 10,
				fetchList: function(o) {
					return svc.getList( o );	
				}
			}
			var reloadList = function() {
				self.listModel.refresh(true);	
			}
		}
	);
</script>

<table r:context="studentlist" r:model="listModel" r:varName="item" r:name="selectedItem" border="1" width="80%">
	<thead>
		<tr>
			<td>Student No</td>
			<td>Last Name</td>
			<td>First Name</td>
			<td>Program</td>
			<td align="center">Year Level</td>
			<td>&nbsp;</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>#{item.studentno}</td>
			<td>#{item.lastname}</td>
			<td>#{item.firstname}</td>
			<td>#{item.programcode} (#{item.programtitle})</td>
			<td align="center">#{item.yearlevel}</td>
			<td><a href="#student:info?objid=#{item.objid}">View</a></td>
		</tr>
	</tbody>
</table>
			
		