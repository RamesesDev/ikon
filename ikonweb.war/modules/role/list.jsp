<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

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


Role Classes <select r:context="rolelist" r:items="roleClasses" r:name="roleClass" r:itemLabel="name"
	r:allowNull="true" r:emptyText="All"></select><br>
<input type="button" value="Add" r:context="rolelist" r:name="add" />
<table r:context="rolelist" r:model="listModel" r:varName="item" r:name="selectedItem" border="1" width="80%">
	<thead>
		<td>Role</td>
		<td>Description</td>
		<td>Role Class</td>
		<td>&nbsp;</td>
	</thead>
	<tbody>
		<td>#{item.name}</td>
		<td>#{item.description}</td>
		<td>#{item.roleclass}</td>
		<td align="center">
			<a r:context="rolelist" r:name="edit">View</a>
			<span class="vr"></span>
			<a r:context="rolelist" r:name="viewPermissions">Permissions</a>
		</td>
	</tbody>
</table>
			
		