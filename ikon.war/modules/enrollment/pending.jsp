<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>


<t:content title="Pending Enrollment Form">	
	<jsp:attribute name="head">
		<s:invoke service="StudentService" method="read" params="${SESSION_INFO}" var="STUDENT" debug="true"/>
		
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/js/ext/calendar/fullcalendar.css" type="text/css"/>
		<script src="${pageContext.servletContext.contextPath}/js/ext/calendar/fullcalendar.js"></script>
		<script src="${pageContext.servletContext.contextPath}/js/ext/calendar/calendar.js"></script>
		<script src="${pageContext.servletContext.contextPath}/js/apps/SkedUtil.js"></script>
		
		<script>
			$put(
				"pending", 
				new function() 
				{
					var self = this;
					var svc = ProxyService.lookup("BlockScheduleService");
					var util = new SkedUtil();

					
					
				}
			);
		</script>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div id="schedule_panel" style="display:none;">
			#{it.coursecode}<br>
			Rm: #{(it.roomno) ? it.roomno: 'unassigned'}<br>
			#{(it.teacher) ? it.teacher: 'unassigned'}
		</div>
	</jsp:attribute>

	<jsp:body>
		
	</jsp:body>
</t:content>