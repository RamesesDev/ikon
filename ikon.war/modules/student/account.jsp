<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/app" prefix="app" %>

<t:content title="Student - Account">
	<jsp:attribute name="head">
		<script>
			$put( "studentaccount", 
				new function() {
					this.info =  <s:invoke service="StudentService" method="read" params="${pageContext.request}" json="true" />;
				}
			);
		</script>
	</jsp:attribute>

	<jsp:body>
		<app:studentinfo objid="${param['objid']}"/>

		Student Account
	</jsp:body>
</t:content>