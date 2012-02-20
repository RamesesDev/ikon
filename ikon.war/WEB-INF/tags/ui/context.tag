<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ tag import="java.util.*" %>

<%@ tag dynamic-attributes="params" %>
<%@ attribute name="name" %>
<%@ attribute name="object" %>

<c:set var="context" scope="request" value="${name}"/>
<c:if test="${!empty object}"><c:set var="object" scope="request" value="${object}"/></c:if>
<c:set var="objPrefix" scope="request"><%=(object!=null)?object+".":""%></c:set>
<jsp:doBody/>
<%
	request.removeAttribute("context");
	request.removeAttribute("object");
	request.removeAttribute("objPrefix");
%>

