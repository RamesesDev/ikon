<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	
	$put( "jobpositionlist", 
		new function() {
			var svc = ProxyService.lookup( "OrgunitService" );
			var jobpossvc = ProxyService.lookup( "JobpositionService" );
			
			var self = this;
			
			this.selectedItem;
			this.orgUnits;
			this.orgUnit;
			
			this.onload = function() {
				this.orgUnits = svc.getUserOrgunits({});
				if(this.orgUnits && this.orgUnits.length > 0 ) {
					this.orgUnit = this.orgUnits[0];
				}
			}
			
			this.listModel = {
				rows: 10,
				fetchList: function(o) {
					if(self.orgUnit) o.orgunitid = self.orgUnit.objid;
					return jobpossvc.getList( o );	
				}
			}
			
			var refreshList = function() {
				self.listModel.refresh(true);	
			}
			
			this.add = function() {
				return new PopupOpener( "jobposition:info", {saveHandler:refreshList, 
					jobposition : {orgunitid: this.orgUnit.objid, orgunitcode: this.orgUnit.code, jobstatus: "R" } } );
			}

			this.edit = function() {
				return new PopupOpener( "jobposition:info", {saveHandler:refreshList, jobposition:this.selectedItem, mode:"edit" } );
			}
			
			this.propertyChangeListener = {
				orgUnit : function(o) { self.listModel.refresh(true); }
			}
			
			this.selectAssignee = function() {
				var h = function(x) {
					jobpossvc.assign( {objid: self.selectedItem.objid, assigneeid: x.objid } );
					refreshList();
				}
				return new DropdownOpener( "personnel:lookup" , {selectHandler: h});
			}
			
			this.removeAssignee = function() {
				if( confirm( "You are about to remove this assigned position. Continue?") ) {
					jobpossvc.unassign( {objid: self.selectedItem.objid  } );
					refreshList();
				}
			}
		}
	);
</script>


Org Unit: <select r:context="jobpositionlist" r:items="orgUnits" r:name="orgUnit" r:itemLabel="code"></select>

<input type="button" value="Add" r:context="jobpositionlist" r:name="add" />
<table r:context="jobpositionlist" r:model="listModel" r:varName="item" r:name="selectedItem" border="1" width="80%">
	<thead>
		<tr>
			<td>Code</td>
			<td>Title</td>
			<td>Assignee</td>
			<td>Role</td>
			<td>&nbsp;</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>#{item.code}</td>
			<td>#{item.title}</td>
			<td>
				<div r:context="jobpositionlist" r:visibleWhen="#{item.assignee == null}">
					<i>Vacant</i>
					<a r:context="jobpositionlist" r:name="selectAssignee">[Assign]</a>
				</div>
				<div r:context="jobpositionlist" r:visibleWhen="#{item.assignee != null}">
					<b>#{item.assignee}</b>
					<a r:context="jobpositionlist" r:name="removeAssignee"> [Unassign]</a>
				</div>
			</td>
			<td>#{item.role}</td>
			<td>
				<a r:context="jobpositionlist" r:name="edit">View</a>&nbsp;
			</td>
		</tr>	
	</tbody>
</table>

		