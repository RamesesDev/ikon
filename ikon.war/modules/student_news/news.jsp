<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/app" prefix="app" %>

<t:content title="News Feed">
	<jsp:attribute name="head">
		<script>
			$put( "news", 
				new function() {
					this.info =  <s:invoke service="StudentService" method="read" params="${pageContext.request}" json="true" />;
				}
			);
		</script>
	</jsp:attribute>

	<jsp:body>
		<c:if>
			<button>Enroll Now!</button>
		</c:if>
	</jsp:body>
</t:content>