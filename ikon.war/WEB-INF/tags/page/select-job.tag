<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ attribute name="title" %>
<%@ attribute name="list" type="java.lang.Object" %>

<script type="text/javascript">
	$register({id:"#jobmenu", context:"job_menu"});
	
	$put(
		"job_menu",
		new function() {
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
</script>

<a r:context="job_menu" r:name="showJobs">
	${title} &nbsp;&nbsp;&#9660;
</a>
<div id="jobmenu" style="display:none">
	<ul>
		<c:forEach items="${list}" var="item">
			<li>
				<a href="?jobid=${item.objid}">
					${item.title}
				</a>
			</li>
		</c:forEach>
	</ul>
</div>