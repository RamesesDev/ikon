<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ attribute name="caption" %>

<tr>
	<td class="form-caption" valign="top">${! empty caption ? caption : ''}</td> 
	<td><jsp:doBody/></td> 
</tr>

