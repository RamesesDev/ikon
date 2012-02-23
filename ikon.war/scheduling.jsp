<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="common" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<t:secured-master>
	
	<jsp:attribute name="head">
		<script src="${pageContext.servletContext.contextPath}/js/apps/ProgramCourse.js"></script>
		<script src="${pageContext.servletContext.contextPath}/js/apps/SkedUtil.js"></script>

		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/js/ext/calendar/fullcalendar.css" type="text/css"/>
		<script src="${pageContext.servletContext.contextPath}/js/ext/calendar/fullcalendar.js"></script>
		<script src="${pageContext.servletContext.contextPath}/js/ext/calendar/calendar.js"></script>

		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/js/ext/colorpicker/colorpicker.css" type="text/css"/>
		<script src="${pageContext.servletContext.contextPath}/js/ext/colorpicker/colorpicker.js"></script>
	</jsp:attribute>

	<jsp:attribute name="script">
		<common:loadmodules name="modules"/>
		
		$put("apps", 
			new function() {
				this.items;
				this.onload = function() {
					this.items = Registry.lookup( "schoolterm:menu" );
				}
			}
		);
			
		
		$put(
			"home",
			new function(){
				this.onload = function() {
					if( !location.hash && $ctx('apps').items && $ctx('apps').items.length > 0 ) 
						location.hash = $ctx('apps').items[0].id;
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="style">
		
	</jsp:attribute>
	
	<jsp:body>
		<a href="index.jsp">Home</a>
		<div class="hr"></div>
		<table r:context="apps" r:items="items">
			<tr>
				<td><a href="##{id}">#{caption}</a></td>
			</tr>
		</table>
	</jsp:body>
</t:secured-master>