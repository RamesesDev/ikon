<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<script src="${pageContext.servletContext.contextPath}/js/ext/datetime.js"></script>
<script>
	$put( "personnel_create", 
		new function() {
			var svc = ProxyService.lookup( "PersonnelService");
			
			this.info =  {primaryaddress: {type:'HOME'}, contactinfo: [] };
			this.saveHandler;
			
			this.save = function() {
				svc.create( this.info );	
				this.saveHandler();
				return "_close";
			}
			
			this.selectedContact;
			this.contactTypes = ["HOME_PHONE", "WORK_PHONE", "MOBILE"];
			this.addContact = function() {
				this.info.contactinfo.push({});
			}
			this.removeContact = function() {
				this.info.contactinfo.remove( this.selectedContact );
			}
		}
	);
</script>

Staff No : <input r:context="personnel_create" r:name="info.staffno" r:required="true" r:caption="Staff No" />
<br>

Last Name : <input r:context="personnel_create" r:name="info.lastname" r:required="true" r:caption="Last Name" />
<br>
First Name : <input r:context="personnel_create" r:name="info.firstname" r:required="true" r:caption="First Name" />
<br>
Middle Name : <input r:context="personnel_create" r:name="info.middlename" r:caption="Middle Name" />
<br>
Birth date : <span r:context="personnel_create" r:type="datetime" r:name="info.birthdate" r:options="{mode:'date'}"></span>
<br>
Gender : <input type="radio" r:context="personnel_create" r:name="info.gender" value="M" r:required="true" r:caption="Gender" />Male &nbsp;
		 <input type="radio" r:context="personnel_create" r:name="info.gender" value="F"/>Female &nbsp;
<br>		 
Email : <input r:context="personnel_create" r:name="info.email" r:required="true" r:caption="Email"  style="width:200px"/>	

<h2>Primary Address</h2>
Address 
<br>
<input r:context="personnel_create" r:name="info.primaryaddress.address1" r:required="true" r:caption="Address" style="width:200px"/>	
<br>
<input r:context="personnel_create" r:name="info.primaryaddress.address2"  style="width:200px"/>	
<br>
City/Town <input r:context="personnel_create" r:name="info.primaryaddress.city" />	
<br>
Province <input r:context="personnel_create" r:name="info.primaryaddress.province" />	
<br>
Zip Code <input r:context="personnel_create" r:name="info.primaryaddress.zipcode" />	
<h2>Contact Info</h2>
<table r:context="personnel_create" r:items="info.contactinfo" r:varName="item" r:varStatus="stat" r:name="selectedContact"> 
	<tr>
		<td><select r:context="personnel_create" r:items="contactTypes" r:name="info.contactinfo[#{stat.index}].type"></select></td>	
		<td><input type="text" r:context="personnel_create" r:name="info.contactinfo[#{stat.index}].value"/></td>	
		<td><a r:context="personnel_create" r:name="removeContact" title="Remove"  r:immediate="true">Remove</a></td>
	</tr>
</table>
<br>
<a r:context="personnel_create" r:name="addContact" r:immediate="true">Add</a>

<br>
<br>
<br>
<input type="button" r:context="personnel_create" r:name="save" value="Save" />


