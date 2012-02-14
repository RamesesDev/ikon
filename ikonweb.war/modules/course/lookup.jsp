<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	
	$put( "courselookup", 
		new function() {
			var svc = ProxyService.lookup( "CourseService" );
			
			var self = this;
			
			this.selectHandler;
			this.selectedItem;
			
			this.listModel = {
				rows: 10,
				fetchList: function(o) {
					return svc.getList( o );	
				}
			}
			
			this.select = function() {
				if(this.selectedItem && this.selectHandler) {
					this.selectHandler(this.selectedItem);
					return "_close";
				}	
			}
		}
	);
</script>


<input type="button" value="Add" r:context="courselookup" r:name="add" />
<table r:context="courselookup" r:model="listModel" r:varName="item" r:name="selectedItem" border="1" width="80%">
	<thead>
		<td>Code</td>
		<td>Title</td>
		<td>&nbsp;</td>
	</thead>
	<tbody>
		<td>#{item.code}</td>
		<td>#{item.title}</td>
		<td><a r:context="courselookup" r:name="select">Select</a></td>
	</tbody>
</table>
			
		