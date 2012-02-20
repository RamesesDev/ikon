<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	
	$put( "courselist", 
		new function() {
			var acadSvc = ProxyService.lookup( "AcademicOrgunitService" );
			var svc = ProxyService.lookup( "CourseService" );
			
			var self = this;
			
			this.selectedItem;
			this.orgUnits;
			this.orgUnit;
			
			this.onload = function() {
				this.orgUnits = acadSvc.getList({});
				if(this.orgUnits && this.orgUnits.length > 0 ) {
					this.orgUnit = this.orgUnits[0];
				}
			}
			
			this.listModel = {
				rows: 10,
				fetchList: function(o) {
					if( !self.orgUnit ) return [];
					o.orgunitid = self.orgUnit.objid;
					return svc.getList( o );	
				}
			}
			
			var reloadList = function(o) {
				self.listModel.refresh(true);	
			}
			
			this.add = function() {
				return new PopupOpener( "course:create", { saveHandler: reloadList, orgunit: this.orgUnit});
			}

			this.edit = function() {
				return new PopupOpener( "course:info", {saveHandler:reloadList, course:this.selectedItem } );
			}
			
			this.propertyChangeListener = {
				orgUnit : function(o) { self.listModel.refresh(true); }
			}
		}
	);
</script>

Academic Unit: <select r:context="courselist" r:items="orgUnits" r:name="orgUnit" r:itemLabel="code"></select>
<input type="button" value="Add" r:context="courselist" r:name="add" r:visibleWhen="#{orgUnit!=null}"/>
<table r:context="courselist" r:model="listModel" r:varName="item" r:name="selectedItem" border="1" width="80%">
	<thead>
		<td>Code</td>
		<td>Title</td>
		<td>Classification</td>
		<td>&nbsp;</td>
	</thead>
	<tbody>
		<td>#{item.code}</td>
		<td>#{item.title}</td>
		<td>#{item.classification}</td>
		<td><a r:context="courselist" r:name="edit">View</a></td>
	</tbody>
</table>
			
		