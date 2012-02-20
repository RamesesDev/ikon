<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<%@ attribute name="selected" %>
<%@ attribute name="objid"  %>
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

<table width="100%" cellpadding="4">
	<tr>
		<td>
			<a class="headmenu" href="#student:info?objid=${objid}">Information</a>
		</td>
		<td>
			<a class="headmenu" href="#student:record?objid=${objid}">Records<a/>
		</td>
		<td>
			<a class="headmenu" href="#student:account?objid=${objid}">Account</a>
		</td>
		<td width="100%">&nbsp;</td>
	</tr>
</table>