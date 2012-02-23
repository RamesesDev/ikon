<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/app" prefix="app" %>


<s:invoke service="SchoolEventService" method="getCurrentEvents" var="events"/>
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
		</style>
	</jsp:attribute>

	<jsp:body>
		<c:if test="${!empty events}">
			<div class="notification">
				<c:forEach items="${events}" var="evt" varStatus="stat">
					<div class="section">
						<c:set var="_event" value="${evt.value}" scope="request"/>
						<jsp:include page="handlers/${fn:toLowerCase(evt.key)}.jsp"/>
					</div>
					<c:if test="${!stat.last}">
						<div class="hr"></div>
					</c:if>
				</c:forEach>
			</div>
		</c:if>
	</jsp:body>
</t:content>