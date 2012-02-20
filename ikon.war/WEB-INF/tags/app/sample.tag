<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ variable name-given="x" scope="NESTED" %>
<%@ attribute name="list"  rtexprvalue="true" type="java.lang.Object" %>

<br/>
<h1>listing</h1>
<c:forEach items="${list}" var="item">
	<c:set var="x" value="${item}"/>
	<jsp:doBody/>
	<br>
</c:forEach> 

