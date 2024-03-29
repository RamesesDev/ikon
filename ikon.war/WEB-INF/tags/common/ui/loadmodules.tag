<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags/common" prefix="common" %>
<%@ tag import="com.rameses.web.support.*" %>
<%@ tag import="com.rameses.server.common.*" %>
<%@ tag import="java.util.*" %>

<%@ attribute name="name" %>
<%@ attribute name="role" %>
<%@ attribute name="permissions" rtexprvalue="true" type="java.lang.Object" %>

<%
	List permList = new ArrayList();
	List p = (List) request.getAttribute("PERMISSIONS");
	if( p != null ) {
		permList.addAll( p );
	}
	if( permissions instanceof List ) {
		permList.addAll( (List)permissions );
	}
	
	List invokers = ModuleUtil.getEntries( application, "invokers", name, name );
	List newList = new ArrayList();
	Iterator itr = invokers.iterator();
	
	String ctxpath = request.getContextPath();
	if(ctxpath == null) ctxpath = "/";
	
	while( itr.hasNext() ) 
	{
		boolean isPermitted = true;
		Map inv = (Map) itr.next();
		String modname = (String) inv.get("_name" );
		String perm = (String) inv.get("permission");
		
		if( perm!=null ) 
		{
			if(!perm.contains(":")) perm = modname + ":" + perm;
			isPermitted = permList.contains(perm);
		}
		if( role!=null && inv.get("role")!=null ) 
		{
			isPermitted = ( inv.get("role").toString().matches( role ) ); 
		}
		
		if(isPermitted) 
		{
			Map m = new HashMap();
			if(inv.get("id")!=null ) 
			{
				m.putAll( inv );
				m.remove("_parent");
				
				if( m.get("page")==null ) 
				{
					m.put( "page", inv.get("id") + ".jsp" );
				}
				m.put( "page", ctxpath + "/" + name + "/" + modname + "/" + m.get("page" ) );
				m.put( "id", modname + ":" + m.get("id") );
				if( m.get("parent")!=null) 
				{
					m.put( "parent", modname + ":" + m.get("parent") );
				}
				if( m.get("context")==null) 
				{
					m.put( "context", inv.get("id") );
				}
				
				m.remove("_name");
				newList.add(m);
			}
		}	
	}
	request.setAttribute("APPLIST", newList );
%>

<c:forEach items="${APPLIST}" var="item">
	<c:set var="item" scope="request" value="${item}"/>
	$register( <%=JsonUtil.toString( request.getAttribute("item"))%>  );
</c:forEach>


