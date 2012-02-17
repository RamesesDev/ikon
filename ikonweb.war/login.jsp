<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<c:if test="${param.username!=null or param.password!=null}">
	<%    
		Map map = new HashMap();
		map.put( "username", request.getParameter( "username" ) );
		map.put( "password", request.getParameter( "password" ) );
		request.setAttribute( "data", map );	
	%>


	<s:invoke service="LoginService" method="login" params="${data}" var="result" debug="true"/>
	<c:if test="${empty error}">
		<c:set var="SESSIONID" value="${result.sessionid}" scope="request"/>
		<%
			Cookie cookie = new Cookie( "sessionid", (String)request.getAttribute("SESSIONID") ) ;
			response.addCookie( cookie );
			
			if( request.getParameter("u") != null )
				response.sendRedirect(request.getParameter("u"));
			else
				response.sendRedirect("home.jsp");
		%>
	</c:if>
</c:if>

<c:set var="APP_TITLE" value="<%=application.getInitParameter("app.title")%>"/>
<c:if test="${!empty error or (param.username==null and param.password==null)}">
	<t:public redirect_session="false">
		<jsp:attribute name="style">
			.centered { margin: 0 auto; }
			.login-box {
				width: 500px;
				padding: 20px 20px 40px 20px;
				background: #fff;
				border: solid 1px #ccc;
				border-radius: 4px;
				box-shadow: 0 2px 10px #bbb;
			}
			
			.error {
				color: #333;
				text-align: center; 
				background: #FFEBE8;
				padding: 10px 0;
				border: solid 1px #ff0000;
			}
			
			.form { width: 60%; margin-top: 20px; }
			.form label,
			.form .buttons { display:block; clear: both; margin-bottom: 5px; }
			.form input { margin: 0; }
			.form .caption { display: inline-block; width: 100px; }
			.form .buttons { padding-left: 100px; }
		</jsp:attribute>
		<jsp:body>
			<div class="centered login-box">
				<h2>${APP_TITLE} Login</h2>
				<div class="hr"></div>
				<c:if test="${not empty error}">
					<div class="error section">
						<p>The username or password is incorrect.</p>
					</div>
				</c:if>	
				<div class="centered form">
					<form action="login.jsp" method="post">
						<label>
							<span class="caption">Username:</span>
							<input id="uid" type="text" name="username" value="${param['username']}"/>
						</label>
						<label>
							<span class="caption">Password:</span>
							<input id="pwd" type="password" name="password"/>
						</label>
						<div class="buttons">
							<button type="submit">
								Login
							</button>
						</div>
						<div class="buttons">
							<a href="resetpass.jsp">
								Forgot your Password?
							</a>
						</div>
						<c:if test="${! empty param['u']}">
							<input type="hidden" name="u" value="${param['u']}"/>
						</c:if>
					</form>
					<script type="text/javascript">
						$("#${empty param['username']? 'uid' : 'pwd'}").focus();
					</script>
				</div>
			</div>
		</jsp:body>
	</t:public>
</c:if>



