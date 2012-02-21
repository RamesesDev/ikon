<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<s:invoke service="LogoutService" method="logout" params="${SESSIONID}"/>
<%
	Cookie cookie = new Cookie( "sessionid", (String)request.getAttribute("SESSIONID") ) ;
	cookie.setMaxAge(0);
	response.addCookie( cookie );
	
	request.setAttribute("APP_TITLE", application.getInitParameter("app.title"));
%>

<t:index redirect_session="true">
	<h2>Thank you for using ${APP_TITLE}!</h2>
</t:index>
