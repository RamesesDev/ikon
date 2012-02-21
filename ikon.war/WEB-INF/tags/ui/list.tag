<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ tag import="java.util.*" %>
<%@ tag dynamic-attributes="params" %>
<%@ attribute name="context" %>
<%@ attribute name="items" %>
<%@ attribute name="model" %>
<%@ attribute name="hideCols" %>
<%@ attribute name="name" %>

<%
	Map m = (Map)jspContext.getAttribute("params");
	if(items!=null) m.put( "r:items", items );
	if(model!=null) m.put( "r:model", model );
	m.put( "r:name", (name==null) ? "selectedItem" : name );
%>

<table class="list" r:context="${context}" <c:forEach items="${params}" var="p"> ${p.key}="${p.value}" </c:forEach> cellpadding="0" cellspacing="0" r:varName="item" r:varStatus="status">
	<c:if test="${hideCols != true}">
		<c:set var="_datatable_processing" scope="request" value="cols"/>
		<thead>
			<tr><jsp:doBody/></tr>
		</thead>
	</c:if>	
	<c:set var="_datatable_processing" scope="request" value="rows"/>
	<tbody>
		<tr><jsp:doBody/></tr>
	</tbody>
</table>

<%request.removeAttribute("_datatable_processing");%>

