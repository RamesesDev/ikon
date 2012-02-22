<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<%@ page import="java.util.*" %>


<%
	Map m = new HashMap();
	m.put( "objid", request.getParameter("schooltermid"));
	request.setAttribute( "PARAMS", m );
%>
<s:invoke service="SchoolTermAdminService" method="read" params="${PARAMS}" json="true" var="INFO"/>

<t:content title="Block Schedules">

	<jsp:attribute name="script">
		$put( "blockschedule_list", 
			new function() {
				var svc = ProxyService.lookup( "BlockScheduleService" );
				var self = this;
				
				this.schoolterm = ${INFO};
				
				this.selectedItem;
				this.listModel = {
					rows: 10,
					fetchList: function(o) {
						o.schooltermid = "${param['schooltermid']}";
						return svc.getList( o );	
					}
				}
				this.addBlock = function() {
					var f = function(o) {
						window.location.hash = "blockschedule:blockinfo?objid="+o.objid;
					}
					return new PopupOpener("blockschedule:create", {schoolterm:this.schoolterm, saveHandler: f } );
				}
			}
		);
	</jsp:attribute>
		
	<jsp:attribute name="sections">
		<div id="schedule-formatter" style="display:none;">
			#{it.fromtime}-#{it.totime} #{it.days} #{(it.roomno)? '(' + it.roomno + ')': ''}<br> 
		</div>
	</jsp:attribute>	
		
	<jsp:body>
		<ui:context name="blockschedule_list">
			<ui:button caption="Add New" action="addBlock"/>
			<ui:grid model="listModel" width="100%">
				<ui:col caption="Block" name="blockcode"/>
				<ui:col caption="Class Code" name="code"/>
				<ui:col caption="Course">#{item.coursecode ? item.coursecode : ''}</ui:col>
				<ui:col caption="Schedule/Room">#{ $template('schedule-formatter', item.schedules, true ) }</ui:col>
				<ui:col caption="Teacher">#{ (item.teacher) ? item.teacher : '' }</ui:col>
				<ui:col caption="Program">#{ item.programcode? item.programcode : '' }</ui:col>
				<ui:col>
					<a href="#blockschedule:blockinfo?objid=#{item.blockid}">View Block</a>
				</ui:col>
			</ui:grid>
		</ui:context>
	</jsp:body>	

</t:content>
