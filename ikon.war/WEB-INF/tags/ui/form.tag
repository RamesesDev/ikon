<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>
<%@ tag import="java.util.*" %>

<%@ tag dynamic-attributes="params" %>
<%@ attribute name="title" %>
<%@ attribute name="orientation" %>

<%@ attribute name="context" %>
<%@ attribute name="object" %>

<c:if test="<%=request.getAttribute("context")==null%>">
	<ui:context name="${context}" object="${object}">
		<table <c:forEach items="${params}" var="p"> ${p.key}="${p.value}" </c:forEach>>
			<c:if test="${! empty title}">
				<tr>
					<td colspan="2" class="form-title" width="100%">${title}</td> 
				</tr>
			</c:if>
			<jsp:doBody/>
		</table>
	</ui:context>
</c:if>

<c:if test="<%=request.getAttribute("context")!=null%>">
	<table <c:forEach items="${params}" var="p"> ${p.key}="${p.value}" </c:forEach>>
		<c:if test="${! empty title}">
			<tr>
				<td colspan="2" class="form-title" width="100%">${title}</td> 
			</tr>
		</c:if>
		<jsp:doBody/>
	</table>
</c:if>	
