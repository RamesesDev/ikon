<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	
	$put( "roomlist", 
		new function() {
			var svc = ProxyService.lookup( "RoomAdminService" );
			
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
				return new PopupOpener( "room:info", {saveHandler:f } );
			}

			this.edit = function() {
				var f = function(o) {
					svc.update(o);
					self.listModel.refresh(true);	
				}
				return new PopupOpener( "room:info", {saveHandler:f, room:this.selectedItem, mode:"edit" } );
			}
			
		}
	);
</script>


<input type="button" value="Add" r:context="roomlist" r:name="add" />
<table r:context="roomlist" r:model="listModel" r:varName="item" r:name="selectedItem" border="1" width="80%">
	<thead>
		<td>Code</td>
		<td>Room Number</td>
		<td>&nbsp;</td>
	</thead>
	<tbody>
		<td>#{item.code}</td>
		<td>#{item.roomno}</td>
		<td><a r:context="roomlist" r:name="edit">View</a></td>
	</tbody>
</table>
			
		