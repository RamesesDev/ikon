<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	
	$put( "programlist", 
		new function() {
			var acadSvc = ProxyService.lookup( "AcademicOrgunitService" );
			var svc = ProxyService.lookup( "ProgramAdminService" );
			
			var self = this;
			
			this.orgUnits;
			this.orgUnit;
			
			this.onload = function() {
				this.orgUnits = acadSvc.getList({});
				if(this.orgUnits && this.orgUnits.length > 0 ) {
					this.orgUnit = this.orgUnits[0];
				}
			}
			
			this.selectedItem;
			this.listModel = {
				rows: 10,
				fetchList: function(o) {
					o.orgunitid = self.orgUnit.objid;
					return svc.getList( o );	
				}
			}
			
			var refreshList = function() {
				self.listModel.refresh(true);	
			}
			
			this.add = function() {
				return new PopupOpener( "program:edit", {saveHandler:refreshList,orgunitid:this.orgUnit.objid} );
			}
			
			this.propertyChangeListener = {
				orgUnit : function(o) { self.listModel.refresh(true); }
			}
		}
	);
</script>

Academic Unit: <select r:context="programlist" r:items="orgUnits" r:name="orgUnit" r:itemLabel="code"></select>

<input type="button" value="Add" r:context="programlist" r:name="add" />
<table r:context="programlist" r:model="listModel" r:varName="item" r:name="selectedItem" border="1" width="80%">
	<thead>
		<td>Code</td>
		<td>Title</td>
		<td>&nbsp;</td>
	</thead>
	<tbody>
		<td>#{item.code}</td>
		<td>#{item.title}</td>
		<td><a href="#program:info?objid=#{item.objid}">View</a></td>
	</tbody>
</table>
			
		