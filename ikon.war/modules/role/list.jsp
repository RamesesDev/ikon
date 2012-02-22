<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:content title="Roles">
	<jsp:attribute name="head">
		<script>
	
			$put( "rolelist", 
				new function() {
					var roleClassSvc = ProxyService.lookup( "RoleclassService" );
					var svc = ProxyService.lookup( "RoleService" );
			
					var self = this;
			
					this.selectedItem;
					this.roleClasses; 
					this.roleClass;
			
					this.onload = function() {
						this.roleClasses = roleClassSvc.getList({});
					}
			
					this.listModel = {
						rows: 10,
						fetchList: function(o) {
							if( self.roleClass ) {
								o.roleclass = self.roleClass.name;
							}
							else {
								o.roleclass = null;
							}	
							return svc.getList( o );	
						}
					}
			
					var refreshList = function() {
						self.listModel.refresh(true);	
					}
			
					this.add = function() {
						return new PopupOpener( "role:info", {saveHandler:refreshList, mode:"create" } );
					}

					this.edit = function() {
						return new PopupOpener( "role:info", {saveHandler:refreshList, role:this.selectedItem, mode:"edit" } );
					}
			
					this.viewPermissions = function() {
						return new PopupOpener("role:permission", {role:this.selectedItem.name});
					}
			
					this.propertyChangeListener = {
						"roleClass" : function(o) {
							refreshList();
						}
					}
				}
			);
		</script>
	</jsp:attribute>

	<jsp:body>
		<ui:context name="rolelist">
			<ui:form>
				<ui:combo caption="Role Classes : " items="roleClasses" 
					name="roleClass" itemLabel="name" allowNull="true" emptyText="All"/>
			</ui:form>
			<ui:button action="add" caption="Add"/>
			<ui:grid model="listModel" name="selectedItem">
				<ui:col caption="Role" name="name"/>
				<ui:col caption="Description" name="description"/>
				<ui:col caption="Role Class" name="roleclass"/>
				<ui:col>
					<a r:context="rolelist" r:name="edit">View</a>
					<span class="vr"></span>
					<a r:context="rolelist" r:name="viewPermissions">Permissions</a>
				</ui:col>
			</ui:grid>
		</ui:context>
	</jsp:body>
</t:content>
		
