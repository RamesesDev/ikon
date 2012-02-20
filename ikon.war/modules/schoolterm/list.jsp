<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	
	$put( "schooltermlist", 
		new function() {
			var svc = ProxyService.lookup( "SchoolTermAdminService" );
			
			var self = this;
			
			this.selectedItem;
			this.listModel = {
				rows: 10,
				fetchList: function(o) {
					return svc.getList( o );	
				}
			}
			
			this.add = function() {
				var f = function(o) {
					svc.create(o);
					self.listModel.refresh(true);	
				}
				return new PopupOpener( "schoolterm:edit", {saveHandler:f} );
			}
		}
	);
</script>


<input type="button" value="Add" r:context="schooltermlist" r:name="add" />
<table r:context="schooltermlist" r:model="listModel" r:varName="item" r:name="selectedItem" border="1" width="80%">
	<thead>
		<td>Year</td>
		<td>Semester</td>
		<td>From date</td>
		<td>To date</td>
		<td>Status</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</thead>
	
	<tbody>
		<td>#{item.year}</td>
		<td>#{item.term}</td>
		<td>#{item.fromdate}</td>
		<td>#{item.todate}</td>
		<td>#{item.status}</td>
		<td><a href="#schoolterm:info?objid=#{item.objid}">View</a></td>
		<td><a href="${pageContext.request.contextPath}/schoolterm.jsp?schooltermid=#{item.objid}">Main Page</a></td>
	</tbody>
</table>
			
		