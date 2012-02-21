<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

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

<ui:context name="courselist">
	<ui:form>
		<ui:combo caption="Academic Unit" items="orgUnits" name="orgUnit" itemLabel="code"/>
	</ui:form>
	<ui:button caption="Add" action="add" visibleWhen="#{orgUnit!=null}"/>
	<ui:grid model="listModel">
		<ui:col caption="Code" name="code"/>
		<ui:col caption="Title" name="title"/>
		<ui:col caption="Classification" name="classification"/>
		<ui:col>
			<a r:context="courselist" r:name="edit">View</a>
		</ui:col>
	</ui:grid>
</ui:context>



