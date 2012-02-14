<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	
	$put( "orgunitlist", 
		new function() {
			var svc = ProxyService.lookup( "OrgunitService" );
			
			var self = this;
			
			this.selectedItem;
			this.orgTypes;
			this.orgType;
			
			this.onload = function() {
				this.orgTypes = svc.getOrgtypes();
				if(this.orgTypes && this.orgTypes.length > 0 ) {
					this.orgType = this.orgTypes[0];
				}
			}
			
			this.listModel = {
				rows: 10,
				fetchList: function(o) {
					o.orgtype = self.orgType;
					return svc.getList( o );	
				}
			}
			
			var refreshList = function() {
				self.listModel.refresh(true);	
			}
			
			this.add = function() {
				return new PopupOpener( "orgunit:info", {saveHandler:refreshList, orgunit : {orgtype: this.orgType } } );
			}

			this.edit = function() {
				return new PopupOpener( "orgunit:info", {saveHandler:refreshList, orgunit:this.selectedItem, mode:"edit" } );
			}
			
			this.propertyChangeListener = {
				orgType : function(o) { self.listModel.refresh(true); }
			}
		}
	);
</script>


<select r:context="orgunitlist" r:items="orgTypes" r:name="orgType" r:itemKey="name" r:itemLabel="name"></select>
<input type="button" value="Add" r:context="orgunitlist" r:name="add" />
<table r:context="orgunitlist" r:model="listModel" r:varName="item" r:name="selectedItem" border="1" width="80%">
	<thead>
		<td>Code</td>
		<td>Title</td>
		<td>&nbsp;</td>
	</thead>
	<tbody>
		<td>#{item.code}</td>
		<td>#{item.title}</td>
		<td><a r:context="orgunitlist" r:name="edit">View</a></td>
	</tbody>
</table>
			
		