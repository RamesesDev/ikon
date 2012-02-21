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
						this.listModel = {
							fetchList: function(o) {
								return [ 
									{lastname: "nazareno", firstname: "elmo"},
									{lastname: "vergara", firstname: "jay"},
								];
							}	
						}
					}
				);	
			</script>
			
			<ui:datatable context="customer_info" model="listModel">
				<ui:col caption="First Name"><a href="#sample?index=#{status.index+1}">#{item.firstname}</a></ui:col>
				<ui:col caption="Last Name" name="lastname"/>
			</ui:datatable>
			
			
		</body>
</html>




