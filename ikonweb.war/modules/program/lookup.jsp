<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<style>
	tr.selected {
		background-color: orange;
		color: white;
	}
	thead td {
		background-color: lightgrey;
		font-weight: bolder;
	}
</style>

<script>
	$put( "program_lookup", 
		new function() {
			var svc = ProxyService.lookup( "ProgramAdminService" );
			
			var self = this;
			
			this.query = {}
			this.selectedItem;
			this.selectHandler;
			
			this.listModel = {
				rows: 5,
				fetchList: function(o) {
					o.code = ( self.query.code ) ? self.query.code+"%" : null;
					return svc.getList( o );
				}
			}
			
			this.select = function() {
				this.selectHandler( this.selectedItem );
				return "_close";
			}
			
			this.search = function() {
				this.listModel.refresh(true);
			}
		}
	);
</script>

Code <input type="text" r:context="program_lookup" r:name="query.code" />
<input type="button" r:context="program_lookup" r:name="search" value="Go"/> 
<br>
<table r:context="program_lookup" r:model="listModel" r:varName="item" r:name="selectedItem" width="100%">
	<thead>
		<td width="100">Program Code</td>
		<td>Program Title</td>
	</thead>
	<tbody>
		<td>#{item.code}</td>
		<td>#{item.title}</td>
	</tbody>
</table>

<br>
<input type="button" r:context="program_lookup" r:name="select" value="OK"/> 
