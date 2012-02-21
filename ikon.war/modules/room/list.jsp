<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/controller" prefix="ctl" %>


<t:content title="Rooms">
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
		<ui:grid model="listModel" width="100%">
			<ui:col caption="Room No" name="roomno" width="120"/>
			<ui:col caption="Description" name="description"/>
			<ui:col><a r:context="${context}" r:name="view">View</a></ui:col>
		</ui:grid> 
	</ui:context>
</t:content>
	
		