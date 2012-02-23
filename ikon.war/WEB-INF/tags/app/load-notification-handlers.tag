<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common" prefix="com" %>

<%@ tag import="java.util.*" %>

<%@ attribute name="events" type="java.lang.Object" %>
<%@ attribute name="var" %>
<%@ attribute name="type" %>

<com:loadmodules type="${type}" var="${var}" encodejs="false"/>
<%
	Map events = (Map) request.getAttribute("events");
	List handlers = (List) request.getAttribute(var);
	List newHandlers = new ArrayList();
	
	if( events != null && handlers != null )
	{
		Iterator itr = handlers.iterator();
		while( itr.hasNext() )
		{
			Map inv = (Map) itr.next();
			String phase = (String) inv.get("phase");
			if( phase == null || events.get(phase)==null ) continue;
			
			newHandlers.add( inv );
		}
	}
	
	if( var != null )
		request.setAttribute(var, newHandlers);
%>