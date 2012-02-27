<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/common" prefix="com" %>
<%@ taglib tagdir="/WEB-INF/tags/app" prefix="app" %>

<com:load-session-info/>
<s:invoke service="JobPermissionService" method="getPermissions" params="${param}" var="PERMISSIONS" debug="true"/>
<s:invoke service="WorkflowService" method="getUserTasks" var="INFO"/>

<t:content title="News Feed">
	<jsp:attribute name="head">
		<script>
			$put( "news", 
			new function() {
					this.info;
				}
			);
		</script>
		
		<style>
			div.notification {
				padding: 10px;
				border: solid 1px #B7B7FF;
				background: #F4F4FF;
			}
			div.notification .hr {
				border-top: solid 1px #ddd;
				border-bottom: solid 1px #fff;
			}
		</style>
	</jsp:attribute>

	<jsp:body>
		<c:forEach items="${INFO}" var="item">
			<com:check-permission key="${item.permission}">
				${item.message}
				<div class="hr"></div>
			</com:check-permission>
		</c:forEach>
		
	</jsp:body>
</t:content>