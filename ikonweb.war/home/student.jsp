<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="common" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>


<t:secured>

	<jsp:attribute name="script">
		<common:loadmodules name="modules" permissions="${JOB.permissions}"/>
		
	</jsp:attribute>
	
	<jsp:attribute name="style">
		
	</jsp:attribute>
	
	<jsp:body>
		This is the page for student.
	</jsp:body>
</t:secured>