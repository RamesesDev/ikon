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
					this.items = Registry.lookup( "home:menu" );
				}
			}
		);
			
		
		$register({id:"#jobmenu", context:"home"});
		
		$put(
			"home",
			new function() {
				this.onload = function() {
					if( !location.hash && $ctx('apps').items && $ctx('apps').items.length > 0 ) 
						location.hash = $ctx('apps').items[0].id;
				}
				
				var jobMenu;						
				this.showJobs = function() {
					if( !jobMenu ) {
						jobMenu = new DropdownOpener( '#jobmenu' );
						jobMenu.options = {
							styleClass: 'dropdownmenu',
							handleClassOnOpen: 'menu_open',
							position: {my: 'right top', at: 'right bottom'}
						};
					}
					return jobMenu;
				}
			}
		);
	</jsp:attribute>

	<jsp:attribute name="header_middle">
		<a r:context="home" r:name="showJobs">
			${JOB.title} &nbsp;&nbsp;&#9660;
		</a>
		<div id="jobmenu" style="display:none">
			<ul>
				<c:forEach items="${JOB.others}" var="item">
					<li>
						<a href="?jobid=${item.objid}">
							${item.title}
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
	</jsp:attribute>
	
	<jsp:body>
		<table r:context="apps" r:items="items">
			<tr>
				<td><a href="##{id}">#{caption}</a></td>
			</tr>
		</table>
	</jsp:body>
</t:secured-master>