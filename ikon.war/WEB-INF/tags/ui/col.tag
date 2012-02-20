<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ attribute name="name" %>
<%@ attribute name="caption"%>
<c:if test="${_processing == 'cols'}"><td>${caption}</td></c:if>
<c:if test="${_processing == 'rows'}"><td>#{item.${name}}</td></c:if>