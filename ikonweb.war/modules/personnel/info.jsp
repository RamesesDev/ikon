<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>


<style>
	.headmenu {
		background-color:red;
		padding:4px;
		padding-right:8px;
		padding-left:8px;
		color:white;
		font-size:11px;
	}
</style>

<script>
	$put( "personnelinfo", 
		new function() {
			this.info =  <s:invoke service="PersonnelService" method="read" params="<%=request%>" json="true" />;
			this.objid;
		}
	);
</script>

<table width="100%" cellpadding="4">
	<tr>
		<td>
			<a class="headmenu">Information</a>
		</td>
		<td>
			<a class="headmenu">Positions<a/>
		</td>
		<td width="100%">&nbsp;</td>
	</tr>
</table>


Staff No : <label r:context="personnelinfo">#{info.staffno}</label>
<br>

Last Name : <label r:context="personnelinfo">#{info.lastname}</label>
<br>
First Name : <label r:context="personnelinfo">#{info.firstname}</label>
<br>

