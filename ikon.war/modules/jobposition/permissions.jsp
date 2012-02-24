<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="cui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:popup>
	<jsp:attribute name="head">
		<s:invoke service="JobpositionService" method="getPermissions" params="${pageContext.request}" var="INFO"/>
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
		<style>
			.role_permission .row-header {
				padding-left: 0;
			}
	
			.role_permission td { border-right: solid 1px #ccc; }
		</style>
	</jsp:attribute>

	<jsp:attribute name="rightactions">
		<ui:button context="jobposition_permission" name="savePermissions" caption="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		<c:forEach items="${INFO.modules}" var="m" varStatus="stat">
			<c:if test="${stat.index > 0}">
				<br/>
			</c:if>
			<h2>${m.moduletitle}</h2>
			<table class="grid role_permission" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="100px">Entity Name</td>
					<c:set var="count" value="${0}"/>
					<c:forEach items="${m.cols}" var="col">
						<c:set var="count" value="${count+1}"/>
						<td align="center" width="50px">
							${col}
						</td>	
					</c:forEach>
					<c:if test="${count < 10}">
						<c:forEach begin="${count}" end="${10-1}">
							<td align="center" width="50px">
								&nbsp;
							</td>
						</c:forEach>
					</c:if>
				</tr>
				<c:forEach items="${m.rows}" var="row">
					<tr>
						<td>${row}</td>
						<c:set var="count" value="${0}"/>
						<c:forEach items="${m.cols}" var="col">
							<c:set var="count" value="${count+1}"/>
							<c:set var="id">${m.modulename}:${row}.${col}</c:set>
							<td align="center">
								<c:if test="${! empty m.index[id]}">
									<input type="checkbox" r:context="jobposition_permission" r:name="excluded" r:mode="set" r:uncheckedValue="${id}" />
								</c:if>
							</td>	
						</c:forEach>
						<c:if test="${count < 10}">
							<c:forEach begin="${count}" end="${10-1}">
								<td align="center">
									&nbsp;
								</td>
							</c:forEach>
						</c:if>
					</tr>
				</c:forEach>
			</table>
		</c:forEach>
	</jsp:body>
</t:popup>
