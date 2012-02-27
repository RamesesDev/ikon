<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/server" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<c:if test="${!empty param['objid']}">
	<s:invoke service="RoomAdminService" method="read" params="<%=request%>" var="INFO"/>
</c:if>

<t:content>

	<jsp:attribute name="style">
		.form-title {
			font-weight: bolder;
		}
	</jsp:attribute>

	<jsp:attribute name="title">
		Room Schedule Conflict 
		<c:if test="${! empty INFO}">
			&nbsp; for <b>${INFO.roomno}</b>
		</c:if>
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put( "room_conflict", 
			new function() {
				this.roomid = "${param['objid']}";
				
				var svc = ProxyService.lookup("RoomScheduleService");
				var self = this;

				this.listModel = {
					fetchList: function(o) {
						o.roomid = (self.roomid) ? self.roomid : null;
						return svc.getScheduleConflicts(o);	
					}
				}	
			}
		);
	</jsp:attribute>	

	<jsp:body>
		
		<ui:context name="room_conflict">
			<ui:grid model="listModel" width="100%">
				<ui:col caption="Room" width="20%">
					#{item.roomno}&nbsp;&nbsp;
					<a href="#room_schedule:info?objid=#{item.roomid}">View Schedule</a>
				</ui:col>
				<ui:col caption="Schedule 1">
					#{item.classcode1} <i>#{item.fromtime1}-#{item.totime1} #{item.days1}</i>&nbsp;&nbsp;
					<span r:context="${context}" r:visibleWhen="#{item.blockid2}">
						<a href="#blockschedule:blockinfo?objid=#{item.blockid2}">View Block</a>
					</span>
				</ui:col>
				<ui:col caption="Schedule 2">
					#{item.classcode2} <i>#{item.fromtime2}-#{item.totime2} #{item.days2}</i>&nbsp;&nbsp;
					<span r:context="${context}" r:visibleWhen="#{item.blockid1}">
						<a href="#blockschedule:blockinfo?objid=#{item.blockid1}">View Block</a>
					</span>
				</ui:col>
			</ui:grid>
		</ui:context>
	</jsp:body>
	
</t:content>


