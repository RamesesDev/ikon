<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/server" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<c:if test="${!empty param['objid']}">
	<s:invoke service="PersonnelService" method="read" params="<%=request%>" var="INFO"/>
</c:if>

<t:content>

	<jsp:attribute name="style">
		.form-title {
			font-weight: bolder;
		}
	</jsp:attribute>

	<jsp:attribute name="title">
		Teacher Schedule Conflict 
		<c:if test="${! empty INFO}">
			&nbsp; for <b>${INFO.lastname}, ${INFO.firstname}</b>
		</c:if>
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put( "teacher_conflict", 
			new function() {
				this.teacherid = "${param['objid']}";
				
				var svc = ProxyService.lookup("TeacherScheduleService");
				var self = this;

				this.listModel = {
					fetchList: function(o) {
						o.teacherid = (self.teacherid) ? self.teacherid : null;
						return svc.getScheduleConflicts(o);	
					}
				}	
			}
		);
	</jsp:attribute>	

	<jsp:body>
		<ui:context name="teacher_conflict">
			<ui:grid model="listModel" width="100%">
				<ui:col caption="Teacher" width="20%">
					#{item.lastname}, #{item.firstname} &nbsp;&nbsp;
					<a href="#teacher_schedule:info?objid=#{item.teacherid}">View Schedule</a>
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