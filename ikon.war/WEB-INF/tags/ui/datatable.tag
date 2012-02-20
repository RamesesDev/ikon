<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ tag import="java.util.*" %>
<%@ tag dynamic-attributes="params" %>
<%@ attribute name="context" %>

<%@ variable name-given="_processing" %>

<%
	Map m = (Map)jspContext.getAttribute("params");
	m.put( "style", "background-color:lightyellow;" );
	m.put( "r:items", "items" );
%>

<table r:context="${context}" <c:forEach items="${params}" var="p"> ${p.key}="${p.value}" </c:forEach> border="1" cellpadding="0" cellspacing="0">
	<c:set var="_processing" scope="request" value="cols"/>
	<thead>
		<tr><jsp:doBody/></tr>
	</thead>
	<c:set var="_processing" scope="request" value="rows"/>
	<tbody>
		<tr><jsp:doBody/></tr>
	</tbody>
</table>


