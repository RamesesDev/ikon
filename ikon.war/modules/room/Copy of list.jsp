<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<style>
	.list-column {
		background-color:gray;
		padding: 4px;
	}
	.list-row {
		padding:4px;
		border-bottom: 1px solid lightgrey;
	}
	.list tr {
		background-color: lightyellow;
	}
	.list tr.selected {
		background-color: yellow;
	}
</style>

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

<ui:context name="roomlist">
	<ui:button caption="Add" action="add"/>
	<ui:list model="listModel" width="100%">
		<ui:col caption="Code" name="code"/>
		<ui:col caption="Room No" name="roomno"/>
		<ui:col><a r:context="roomlist" r:name="edit">View</a></ui:col>
	</ui:list> 
</ui:context>

	
		