<%@ taglib tagdir="/WEB-INF/tags/app" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*" %>


<%
	List list = new ArrayList();
	list.add( "one" );
	list.add( "two" );
	list.add( "three" );
	request.setAttribute( "mylist", list );
%>

This is a test
<t:sample list="${mylist}">
	<c:if test="${x == 'one'}">
		OOPS ONE... <b>${x}</b>...
	</c:if>
	<c:if test="${x != 'one'}">
		This is the body... <b>${x}</b>...
	</c:if>
</t:sample>

