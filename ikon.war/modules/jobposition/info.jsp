<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


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
Code : <input type="text" r:context="jobpositioninfo" r:name="jobposition.code"/>
<br/>
Title : <input type="text" r:context="jobpositioninfo" r:name="jobposition.title"/>
<br/>
Job Status 
<input type="radio" r:context="jobpositioninfo" r:name="jobposition.jobstatus" value="R"/>Regular
<input type="radio" r:context="jobpositioninfo" r:name="jobposition.jobstatus" value="D"/>Delegated
<br/>
Role Class : <select r:context="jobpositioninfo" r:allowNull="true" r:items="getRoleClasses()" 
	r:name="jobposition.roleclass" r:itemKey="name" r:itemLabel="name"></select>
<br/>
Role : <select r:context="jobpositioninfo" r:allowNull="true" r:items="getRoles()" 
	r:name="jobposition.role" r:itemKey="name" r:itemLabel="name" r:depends="jobposition.roleclass"></select>
<br/>


<input type="button" r:context="jobpositioninfo" r:name="save" value="Save" />

<input type="button" r:context="jobpositioninfo" r:name="viewPermissions" value="View Permissions" r:visibleWhen="#{mode!='create'}"/>

