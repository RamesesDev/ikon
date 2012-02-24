<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:popup>
	<jsp:attribute name="head">
		<script>		
		
			$put( "jobpositioninfo", 
				new function() {
					var svc = ProxyService.lookup("JobpositionService");
					this.saveHandler;
					this.jobposition;
					this.mode = "create";
			
					var roleClasses;
					var roleSvc;
			
					this.getRoleClasses = function() {
						if( !roleClasses ) {
							var roleClassSvc = ProxyService.lookup("RoleclassService");
							roleClasses = roleClassSvc.getList({});	
						}
						return roleClasses;
					}
			
					this.getRoles = function() {
						if( !this.jobposition.roleclass ) return [];
						if( !roleSvc ) roleSvc = ProxyService.lookup("RoleService");
						return roleSvc.getRolesByClass( {roleclass: this.jobposition.roleclass} );  
					}
			
					this.save = function() {
						if(this.mode == "create") {
							svc.create( this.jobposition );
							this.mode = "edit";
						}
						else {
							svc.update(this.jobposition);
						}
						this.saveHandler();
					}

					this.viewPermissions = function() {
						return new PopupOpener("jobposition:permission", {objid:this.jobposition.objid});
					}	
				}
			);
		</script>
	</jsp:attribute>

	<jsp:attribute name="rightactions">
		<ui:button context="jobpositioninfo" action="save" caption="Save"/>
		<ui:button context="jobpositioninfo" action="viewPermissions" caption="View Permissions" visibleWhen="#{mode!='create'}"/>
	</jsp:attribute>
	
	<jsp:body>
		<ui:form context="jobpositioninfo" object="jobposition">
			<ui:text name="code" caption="Code : "/>
			<ui:text name="title" caption="Title : " width="200px"/>		
			<ui:radio name="jobstatus" caption="Job Status : " options="{R:'Regular', D:'Delegated'}"/>
			<ui:combo name="roleclass" caption="Role Class : " items="getRoleClasses()" allowNull="true" itemKey="name" itemLabel="name"/>
			<ui:combo name="role" caption="Role : " items="getRoles()" allowNull="true" itemKey="name" itemLabel="name"/>
		</ui:form>
	</jsp:body>
</t:popup>
