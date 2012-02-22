<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:popup>
	<jsp:attribute name="head">
		<script>

			$put( "roleinfo", 
				new function() {
					var svc = ProxyService.lookup("RoleclassService");
					var roleSvc = ProxyService.lookup("RoleService");
			
					this.saveHandler;
					this.role = { excluded: [] }
					this.mode = "create";
					this.roleClasses;
			
					this.onload = function() {
						this.roleClasses = svc.getList( {} );
					}
			
					this.save = function() {
						if( this.mode == "create" ) {
							this.role = roleSvc.create( this.role );
							this.mode = "edit";
						}
						else {
							this.role = roleSvc.update( this.role );
						}
						this.saveHandler();
					}
			
					this.viewPermissions = function() {
						return new PopupOpener("role:permission", {role:this.role.name});
					}
				}
			);
		</script>
	</jsp:attribute>

	<jsp:attribute name="rightactions">
		<ui:button context="roleinfo" action="save" caption="Save" visibleWhen="#{mode=='create'}"/>
		<ui:button context="roleinfo" action="viewPermissions" caption="Permissions" visibleWhen="#{mode!='create'}"/>
	</jsp:attribute>
	
	<jsp:body>
		<ui:form context="roleinfo">
			<ui:combo name="roleclass" items="roleClasses" itemKey="name" itemLabel="description" caption="Role Class : " visibleWhen="#{mode=='create'}"/>
			<ui:label visibleWhen="#{mode!='create'}" caption="Role Class : " rtexpression="true">
				#{role.roleclass}
			</ui:label>
			<ui:text name="name" required="true" caption="Name" visibleWhen="#{mode=='create'}"/>
			<ui:label visibleWhen="#{mode!='create'}" caption="Name : " rtexpression="true">
				#{role.name}
			</ui:label>
			<ui:text name="description" required="true" caption="Description" visibleWhen="#{mode=='create'}"/>
			<ui:label visibleWhen="#{mode!='create'}" caption="Description : " rtexpression="true">
				#{role.description}
			</ui:label>
		</ui:form>
	</jsp:body>
</t:popup>
