<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:popup>
	<jsp:attribute name="style">
		.grid tr.selected {
			background-color:orange;
		}
	</jsp:attribute>

	<jsp:attribute name="script">
		$put( "lookup_available_room_schedule", 
			new function() {
				this.schooltermid;
				this.roomid;
				var svc = ProxyService.lookup("RoomScheduleService");
				var self = this;
				this.selectedItem;
				this.selectHandler;
				
				this.listModel = {
					fetchList: function(o) {
						return svc.getUnassignedSchedules({schooltermid:self.schooltermid,roomid:self.roomid});	
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
		<ui:button action="select" caption="OK" context="lookup_available_room_schedule" />
	</jsp:attribute>
	
	<jsp:body>
		<ui:context name="lookup_available_room_schedule">
			<ui:grid model="listModel">
				<ui:col caption="Class Code" name="classcode"/>
				<ui:col caption="Days" name="days"/>
				<ui:col caption="From Time" name="fromtime"/>
				<ui:col caption="To Time" name="totime"/>
			</ui:grid>
		</ui:context>	
	</jsp:body>	

</t:popup>

		