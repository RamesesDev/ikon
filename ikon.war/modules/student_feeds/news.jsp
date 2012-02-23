<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/common" prefix="com" %>
<%@ taglib tagdir="/WEB-INF/tags/app" prefix="app" %>


<s:invoke service="SchoolEventService" method="getCurrentEvents" var="events"/>
<app:load-notification-handlers type="student:notification" events="${events}" var="handlers"/>

<t:content title="News Feed">
	<jsp:attribute name="head">
		<script>
			$put( "news", 
				new function() {
					this.info =  <s:invoke service="StudentService" method="read" params="${pageContext.request}" json="true" />;
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
		<c:if test="${!empty handlers}">
			<div class="notification">
				<c:forEach items="${handlers}" var="handler" varStatus="stat">
					<div class="section">
						<c:set var="_phase_events" value="${events[handler.phase]}" scope="request"/>
						<jsp:include page="${fn:toLowerCase(handler.relativepage)}"/>
					</div>
					<c:if test="${!stat.last}">
						<div class="hr"></div>
					</c:if>
				</c:forEach>
			</div>
		</c:if>
	</jsp:body>
</t:content>