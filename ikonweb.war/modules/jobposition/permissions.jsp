<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="cui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<s:invoke service="JobpositionService" method="getPermissions" params="<%=request%>" var="INFO"/>

<script>
	$put("jobposition_permission",
		new function() {
			
			var svc = ProxyService.lookup( "JobpositionService" );
			
			this.objid;
			this.excluded = <cui:tojson value="${INFO.excluded}"/>;
			
			this.savePermissions = function() {
				svc.updatePermissions( {objid:this.objid, excluded: this.excluded} );
				return "_close";	
			}
		}
	);
</script>

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
							<input type="checkbox" r:context="jobposition_permission" r:name="excluded" r:mode="set" r:uncheckedValue="${id}" />
						</c:if>
					</td>	
				</c:forEach>
			</tr>
		</c:forEach>
	</table>
</c:forEach>
	
<br>
<input type="button" r:context="jobposition_permission" r:name="savePermissions" value="Save"/>
