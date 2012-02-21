<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/controller" prefix="ctl" %>

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

<ui:context name="roomlist">
	<ctl:crudlist service="RoomAdminService">
		this.add = function() {
			return new PopupOpener( "room:info", {saveHandler:self.refreshList} );
		}
		
		this.view = function() {
			return new PopupOpener( "room:info", {saveHandler:self.refreshList, room:this.selectedItem, mode:"edit" } );
		}
	</ctl:crudlist>	
	
	<ui:button caption="Add" action="add"/>
	<ui:list model="listModel" width="100%">
		<ui:col caption="Code" name="code"/>
		<ui:col caption="Room No" name="roomno"/>
		<ui:col><a r:context="${context}" r:name="view">View</a></ui:col>
	</ui:list> 
</ui:context>

	
		