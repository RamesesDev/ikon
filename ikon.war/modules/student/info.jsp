<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/app" prefix="app" %>


	<script>
		$put( "studentinfo", 
			new function() {
				this.info =  <s:invoke service="StudentService" method="read" params="<%=request%>" json="true" />;
			}
		);
	</script>
	
	<app:studentinfo objid="${param['objid']}"/>

	Student No : <label r:context="studentinfo">#{info.studentno}</label>
	<br>

	Last Name : <label r:context="studentinfo">#{info.lastname}</label>
	<br>
	First Name : <label r:context="studentinfo">#{info.firstname}</label>
	<br>

