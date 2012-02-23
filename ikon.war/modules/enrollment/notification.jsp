<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<%@page import="java.util.*" %>

<%
	List list = (List)request.getAttribute("_phase_events");
	if( list!=null )
	{
		StringBuffer sb = new StringBuffer();
		Iterator itr = list.iterator();
		while( itr.hasNext() ) {
			Map m = (Map)itr.next();
			sb.append(m.get("title") + "\n");
		}
		request.setAttribute("title", sb.toString());
	}
%>
<s:invoke service="EnrollmentService" method="checkEnrollment" var="result" debug="true"/>

<c:if test="${!result.pending and !result.active}">
	<span title="${title}">
		<b>Enrollment is now going on!</b>
	</span>
	<a class="button" href="#enrollment:init">Enroll Now!</a>
</c:if>
<c:if test="${result.pending}">
	<b>You have a pending enrollment waiting for approval.</b>
	<a href="#enrollment:pending">View Enrollment Form</a>
</c:if>