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
						this.addContact = function() {
							MsgBox.alert( 'hello' );
						}
					}
				);	
			</script>
			<ui:panel>
				<ui:section>
					<ui:form title="Personal Information" context="customer_info" object="entity">
						<ui:text caption="First Name" required="true" name="firstname" style="width:100%"/>
						<ui:text caption="Last Name" required="true" name="lastname"/>
						<ui:text caption="Middle Initial" name="middlename" size="1" />
					</ui:form>
				</ui:section>
			</ui:panel>
			<ui:context name="customer_info" object="entity">
				<uix:contactinfo name="entity.contacts"/>
				<ui:button action="save" caption="Save"/>
			</ui:context>
		</body>
</html>



