<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:popup>
	<jsp:attribute name="style">
		.grid tr.selected {
			background-color:orange;
		}
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put( "lookup_available_teacher_schedule", 
			new function() {
				this.schooltermid;
				this.teacherid;
				this.orgunitid;
				
				var svc = ProxyService.lookup("TeacherScheduleService");
				var self = this;
				this.selectedItem;
				this.selectHandler;
				
				this.listModel = {
					fetchList: function(o) {
						return svc.getUnassignedSchedules({schooltermid:self.schooltermid,teacherid:self.teacherid, orgunitid: self.orgunitid});	
					}
				}	
				this.select = function() {
					this.selectHandler(this.selectedItem);
					return "_close";
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<ui:button context="lookup_available_teacher_schedule" action="select" caption="OK" />
	</jsp:attribute>
	
	<jsp:body>
		<ui:grid context="lookup_available_teacher_schedule" model="listModel" width="100%">
			<ui:col caption="Class Code" name="classcode"/>
			<ui:col caption="Days" name="days"/>
			<ui:col caption="From Time" name="fromtime"/>
			<ui:col caption="To Time" name="totime"/>
			<ui:col caption="Room No" name="roomno"/>
		</ui:grid>	
	</jsp:body>

</t:popup>

