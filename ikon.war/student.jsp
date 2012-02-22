<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="common" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>


<s:invoke service="JobPermissionService" method="getUserJobposition" params="${param}" var="JOB" debug="true"/>
<t:secured-master>

	<jsp:attribute name="script">
		<common:loadmodules name="modules" permissions="${JOB.permissions}"/>
		
		$put("apps", 
			new function() {
				this.items;
				this.onload = function() {
					this.items = Registry.lookup( "student:menu" );
				}
			}
		);
		
		$put(
			"home",
			new function() {
				this.onload = function() {
					if( !location.hash && $ctx('apps').items && $ctx('apps').items.length > 0 ) 
						location.hash = $ctx('apps').items[0].id;
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="style">
		
	</jsp:attribute>
	
	<jsp:body>
		<table r:context="apps" r:items="items">
			<tr>
				<td><a href="##{id}">#{caption}</a></td>
			</tr>
		</table>
	</jsp:body>
</t:secured-master>