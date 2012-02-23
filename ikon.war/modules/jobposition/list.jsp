<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:content title="Job Positions">
	<jsp:attribute name="head">
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
			
					this.viewPermissions = function() {
						return new PopupOpener( "jobposition:permission", {objid:this.selectedItem.objid } );
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
	</jsp:attribute>

	<jsp:body>
		<ui:context name="jobpositionlist">
			<ui:form>
				<ui:combo items="orgUnits" name="orgUnit" itemLabel="title" caption="Org Unit : "/>
			</ui:form>
			<ui:button action="add" caption="Add"/>
			<ui:grid model="listModel" name="selectedItem" width="80%">
				<ui:col name="code" caption="Code"/>
				<ui:col name="title" caption="Title"/>
				<ui:col caption="Assignee">
					<div r:context="jobpositionlist" r:visibleWhen="#{item.assignee == null}">
						<i>Vacant</i>
						<a r:context="jobpositionlist" r:name="selectAssignee">[Assign]</a>
					</div>
					<div r:context="jobpositionlist" r:visibleWhen="#{item.assignee != null}">
						<b>#{item.assignee}</b>
						<a r:context="jobpositionlist" r:name="removeAssignee"> [Unassign]</a>
					</div>
				</ui:col>
				<ui:col>
					<a r:context="jobpositionlist" r:name="edit">View</a>
					<span class="vr"></span>
					<a r:context="jobpositionlist" r:name="viewPermissions">Permissions</a>
				</ui:col>
			</ui:grid>
		</ui:context>
	</jsp:body>
</t:content>
