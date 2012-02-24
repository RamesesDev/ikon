<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ tag import="java.util.*" %>
<%@ tag dynamic-attributes="params" %>

<%@ attribute name="caption" %>
<%@ attribute name="name" %>
<%@ attribute name="required" %>
<%@ attribute name="visibleWhen" %>
<%@ attribute name="depends" %>
<%@ attribute name="textcase" %>
<%@ attribute name="width" %>

<tr>
	<td class="form-caption" valign="top"
		<c:if test="${!empty visibleWhen}"> r:context="${context}" r:visibleWhen="${visibleWhen}"</c:if> >
		${caption} <c:if test="${required == 'true'}">&nbsp;<font color=red>*</font></c:if>
	</td> 
	<td <c:if test="${!empty visibleWhen}"> r:context="${context}" r:visibleWhen="${visibleWhen}"</c:if> >
		<input class="form-input" type="text" r:context="${context}" r:name="${objPrefix}${name}" r:caption="${caption}"
			r:textcase="${empty textcase? 'upper' : textcase}"
			<c:forEach items="${params}" var="p"> ${p.key}="${p.value}" </c:forEach> 
			<c:if test="${! empty depends}"> r:depends="${depends}" </c:if>
			<c:if test="${! empty required}"> r:required="${required}" </c:if>
			<c:if test="${! empty visibleWhen}"> r:visibleWhen="${visibleWhen}" </c:if>
			<c:if test="${! empty width}"> style="width:${width};" </c:if>
		/>
	</td> 
</tr>


