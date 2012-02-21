<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ attribute name="context" %>
<%@ attribute name="caption" %>
<%@ attribute name="rtexpression" %>
<%@ attribute name="depends" %>
<%@ attribute name="visibleWhen" %>
<%@ attribute name="required" %>

<tr>
	<td class="form-caption" valign="top">
		${! empty caption ? caption : ''}
		<c:if test="${required == 'true'}">&nbsp;<font color=red>*</font></c:if>
	</td> 
	<td>
		<c:if test="${rtexpression == 'true'}">
			<label r:context="${context}"
			       <c:if test="${!empty depends}"> r:depends="${depends}"</c:if>
			       <c:if test="${!empty visibleWhen}"> r:visibleWhen="${visibleWhen}"</c:if> >
				<jsp:doBody/>
			</label>
		</c:if>
		<c:if test="${rtexpression != 'true'}">
			<jsp:doBody/>
		</c:if>
	</td> 
</tr>

