<%@page import="java.util.*" %>

<%
	List list = (List)request.getAttribute("_event");
	StringBuffer sb = new StringBuffer();
	Iterator itr = list.iterator();
	while( itr.hasNext() ) {
		Map m = (Map)itr.next();
		sb.append(m.get("title") + "\n");
	}
	request.setAttribute("title", sb.toString());
%>
<span title="${title}">
	<b>Enrollment is now going on!</b>
</span>
<button>Enroll Now!</button>