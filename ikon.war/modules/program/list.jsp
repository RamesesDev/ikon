<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:content title="Programs">
	<jsp:attribute name="head">
		<script>
			
			$put( "programlist", 
				new function() {
					var acadSvc = ProxyService.lookup( "AcademicOrgunitService" );
					var svc = ProxyService.lookup( "ProgramService" );
					
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
							if( !self.orgUnit ) return [];
							o.orgunitid = self.orgUnit.objid;
							return svc.getList( o );	
						}
					}
					
					var refreshList = function() {
						self.listModel.refresh(true);	
					}
					
					this.add = function() {
						return new PopupOpener( "program:create", {saveHandler:refreshList,orgunit:this.orgUnit} );
					}
					
					this.propertyChangeListener = {
						orgUnit : function(o) { self.listModel.refresh(true); }
					}
				}
			);
		</script>
	</jsp:attribute>

	<jsp:body>
		<ui:context name="programlist">
			<ui:form>
				<ui:combo caption="Academic Unit:" items="orgUnits" itemLabel="code" name="orgUnit"/>
			</ui:form>
			<ui:button caption="Add" action="add" visibleWhen="#{orgUnit!=null}"/>
			<ui:grid model="listModel" width="100%">
				<ui:col caption="Code" name="code" width="80px"/>
				<ui:col caption="Title" name="title"/>
				<ui:col>
					<a href="#program:info?objid=#{item.objid}">View</a>
				</ui:col>
			</ui:grid>
		</ui:context>
	</jsp:body>
</t:content>


