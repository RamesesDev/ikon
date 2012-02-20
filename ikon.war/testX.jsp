<%@ taglib tagdir="/WEB-INF/tags/app" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/uix" prefix="uix" %>

<%@ page import="java.util.*" %>

<c:set var="APP_VERSION" value="1"/>
<html>
		<head>
			<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/js/lib/css/jquery-ui/jquery.css?v=${APP_VERSION}" type="text/css"/>
			<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/js/lib/css/rameses-lib.css?v=${APP_VERSION}" type="text/css" />
			<script src="${pageContext.servletContext.contextPath}/js/lib/jquery-all.js?v=${APP_VERSION}"></script>
			<script src="${pageContext.servletContext.contextPath}/js/lib/rameses-ext-lib.js?v=${APP_VERSION}"></script>
			<script src="${pageContext.servletContext.contextPath}/js/lib/rameses-ui.js?v=${APP_VERSION}"></script>
		</head>		
		<body>
			<script>
				$put( "customer_info",
					new function() {
						this.entity = { contacts: [] }
						this.save = function() {
							alert( 'saving ' + $.toJSON(this.entity) );
						}
					}
				);	
			</script>
			<ui:form context="customer_info" object="entity" title="Personal Info">
				<ui:text caption="First Name" required="true" name="firstname"/>
				<ui:text caption="Last Name" required="true" name="lastname"/>
				<ui:label>
					<uix:contactinfo name="entity.contacts"/>
				</ui:label>
				<ui:label>
					<ui:button action="save" caption="Save"/>
				</ui:label>
			</ui:form>
		</body>
</html>




