<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	
	$put( "studentapplicantlist", 
		new function() {
			var svc = ProxyService.lookup( "StudentApplicantService" );
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

<table r:context="studentapplicantlist" r:model="listModel" r:varName="item" r:name="selectedItem"
       class="grid" cellpadding="0" cellspacing="0" width="80%">
	<thead>
		<td>App. No</td>
		<td>Last Name</td>
		<td>First Name</td>
		<td>Program</td>
		<td>&nbsp;</td>
	</thead>
	<tbody>
		<td>#{item.objid}</td>
		<td>#{item.lastname}</td>
		<td>#{item.firstname}</td>
		<td></td>
		<td><a href="#student_applicant:info?objid=#{item.objid}">View</a></td>
	</tbody>
</table>
			
		