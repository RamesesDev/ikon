<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/app" prefix="app" %>

<script>
	$put( "studentrecord", 
		new function() {
			this.info =  <s:invoke service="StudentService" method="read" params="<%=request%>" json="true" />;
		}
	);
</script>

<app:studentinfo objid="${param['objid']}"/>

Student Record