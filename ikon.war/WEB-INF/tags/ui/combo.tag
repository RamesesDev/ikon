<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ tag import="java.util.*" %>
<%@ tag dynamic-attributes="params" %>

<%@ attribute name="caption" %>
<%@ attribute name="name" %>
<%@ attribute name="required" %>
<%@ attribute name="visibleWhen" %>
<%@ attribute name="depends" %>
<%@ attribute name="items" %>
<%@ attribute name="allowNull"%>
<%@ attribute name="itemLabel"%>
<%@ attribute name="itemKey"%>
<%@ attribute name="emptyText"%>

<c:if test="${visibleWhen || visibleWhen == null}">
	<tr>
		<td class="form-caption" valign="top">${caption} <c:if test="${required == 'true'}">&nbsp;<font color=red>*</font></c:if></td> 
		<td>
			<select r:context="${context}" r:name="${name}" r:items="${items}" r:caption="${caption}"
				<c:forEach items="${params}" var="p"> ${p.key}="${p.value}" </c:forEach> 
				<c:if test="${! empty depends}"> r:depends="${depends}" </c:if>
				<c:if test="${! empty required}"> r:required="${required}" </c:if>
				<c:if test="${! empty visibleWhen}"> r:visibleWhen="${visibleWhen}" </c:if>
				<c:if test="${! empty itemKey}"> r:itemKey="${itemKey}" </c:if>
				<c:if test="${! empty itemLabel}"> r:itemLabel="${itemLabel}" </c:if>
				<c:if test="${! empty allowNull}"> r:allowNull="${allowNull}"</c:if> 
				<c:if test="${! empty emptyText}"> r:emptyText="${emptyText}"</c:if> >
				<jsp:doBody/>
			</select>
		</td>
</tr>
</c:if>
