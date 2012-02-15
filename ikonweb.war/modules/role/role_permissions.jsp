<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<s:invoke service="RoleService" method="getAllPermissions" params="${param['role']}" var="INFO" debug="true"/>

<script>
	$put("role_permission",
		new function() {
			
			var svc = ProxyService.lookup( "RoleService" );
			
			this.rolename = "${param['role']}";
			this.included = <ui:tojson value="${INFO.included}"/>;
			
			this.savePermissions = function() {
				svc.updatePermissions( {name:this.rolename, included: this.included} );
				return "_close";	
			}
		}
	);
</script>

Role: <b>${param['role']}</b>
<c:forEach items="${INFO.modules}" var="m">
	<h2>${m.moduletitle}</h2>
	<table width="80%" border="1">
		<tr>
			<td width="80">Entity Name</td>
			<c:forEach items="${m.cols}" var="col">
				<td align="center">${col}</td>	
			</c:forEach>
		</tr>
		<c:forEach items="${m.rows}" var="row">
			<tr>
				<td>${row}</td>
				<c:forEach items="${m.cols}" var="col">
					<c:set var="id">${m.modulename}:${row}.${col}</c:set>
					<td align="center">
						<c:if test="${! empty m.index[id]}">
							<input type="checkbox" r:context="role_permission" r:name="included" r:mode="set" r:checkedValue="${id}" />
						</c:if>
					</td>	
				</c:forEach>
			</tr>
		</c:forEach>
	</table>
</c:forEach>
	
<br>
<input type="button" r:context="role_permission" r:name="savePermissions" value="Save"/>
