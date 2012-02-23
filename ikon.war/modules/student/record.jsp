<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/app" prefix="app" %>


<t:content title="Student - Record">
	<jsp:attribute name="head">
		<script>
			$put( "studentrecord", 
				new function() {
					this.info =  <s:invoke service="StudentService" method="read" params="${pageContext.request}" json="true" />;
				}
			);
		</script>
	</jsp:attribute>

	<jsp:body>
		<app:studentinfo objid="${param['objid']}"/>

		Student Record
	</jsp:body>
</t:content>