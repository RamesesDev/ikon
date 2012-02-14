<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	
	$put( "personnellist", 
		new function() {
			var svc = ProxyService.lookup( "PersonnelService" );
			
			var self = this;
			
			this.selectedItem;
			
			this.listModel = {
				rows: 10,
				fetchList: function(o) {
					return svc.getList( o );	
				}
			}
			
			var reloadList = function() {
				self.listModel.refresh(true);	
			}
			
			this.add = function() {
				return new PopupOpener( "personnel:info", {mode:"create", saveHandler: reloadList });
			}

			this.edit = function() {
				return new PopupOpener( "personnel:info", {saveHandler:reloadList, personnel:this.selectedItem, mode:"edit" } );
			}
			
			this.propertyChangeListener = {
				orgUnit : function(o) { self.listModel.refresh(true); }
			}
		}
	);
</script>

<input type="button" value="Add" r:context="personnellist" r:name="add" />
<table r:context="personnellist" r:model="listModel" r:varName="item" r:name="selectedItem" border="1" width="80%">
	<thead>
		<td>Staff No</td>
		<td>Last Name</td>
		<td>First Name</td>
		<td>&nbsp;</td>
	</thead>
	<tbody>
		<td>#{item.staffno}</td>
		<td>#{item.lastname}</td>
		<td>#{item.firstname}</td>
		<td><a href="#personnel:info?objid=#{item.objid}">View</a></td>
	</tbody>
</table>
			
		