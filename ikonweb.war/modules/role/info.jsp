<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


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


Role Class : <select r:context="roleinfo" r:items="roleClasses" r:name="role.roleclass" 
	r:itemKey="name" r:itemLabel="description" r:visibleWhen="#{mode=='create'}"></select>
	<label r:context="roleinfo" r:visibleWhen="#{mode!='create'}">#{role.roleclass}</label>
	
<br>

Name : <input type="text" r:context="roleinfo" r:name="role.name" r:required="true" r:caption="Name" r:visibleWhen="#{mode=='create'}"/>
<label r:context="roleinfo" r:visibleWhen="#{mode!='create'}">#{role.name}</label>
<br>
Description <input type="text" r:context="roleinfo" r:name="role.description" r:required="true" r:caption="Role" />
<br>

<input type="button" r:context="roleinfo" r:name="save" value="Save" r:visibleWhen="#{mode=='create'}"/>

<input type="button" r:context="roleinfo" r:name="viewPermissions" value="Permissions" r:visibleWhen="#{mode!='create'}"/>