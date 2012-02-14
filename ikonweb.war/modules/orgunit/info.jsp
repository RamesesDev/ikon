<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>
	$put( "orgunitinfo", 
		new function() {
			var svc = ProxyService.lookup("OrgunitService");
			this.saveHandler;
			this.orgunit;
			this.mode = "create";
			
			this.save = function() {
				if(this.mode == "create") {
					svc.create( this.orgunit );
				}
				else {
					svc.update(this.orgunit);
				}
				this.saveHandler();
				return "_close";
			}
			
		}
	);
</script>

Type :
<label r:context="orgunitinfo">#{orgunit.orgtype}</label>
<br>

Code : <input type="text" r:context="orgunitinfo" r:name="orgunit.code" r:required="true" r:caption="Code" />
<br>
Title <input type="text" r:context="orgunitinfo" r:name="orgunit.title" r:required="true" r:caption="Name" />
<br>

<input type="button" r:context="orgunitinfo" r:name="save" value="Save"/>

