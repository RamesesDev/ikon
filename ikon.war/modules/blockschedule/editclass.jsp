<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:popup>
	<jsp:attribute name="script">
		$put( "blockschedule_editclass", 
			new function() {
				var svc = ProxyService.lookup("BlockScheduleService"); 
				this.class;
				this.selectedSchedule;
				this.saveHandler;
				var self = this;
				
				this.scheduleList = {
					fetchList: function(o)  {
						return self.class.schedules;
					}
				}
				
				var refreshSchedule = function(o) {
					self.scheduleList.refresh();
				}
				
				this.addSchedule = function() {
					var f = function(o) {
						self.class.schedules.push(o);
						refreshSchedule();
					}
					return new PopupOpener("scheduling:dow_schedule", {saveHandler: f} );
				}
				
				this.editSchedule = function() {
					return new PopupOpener("scheduling:dow_schedule", {saveHandler: refreshSchedule, schedule: this.selectedSchedule} );
				}
				
				this.removeSchedule = function() {
					this.class.schedules.remove( this.selectedSchedule );
					if( !this.class.removedSchedules ) this.class.removedSchedules = [];
					this.class.removedSchedules.push( this.selectedSchedule );
					refreshSchedule();
				}
				
				this.save = function() {
					svc.changeSchedule( this.class );
					this.saveHandler();
					return "_close";
				}
			}	
		);
	</jsp:attribute>

	<jsp:attribute name="rightactions">
		<ui:button context="blockschedule_editclass" action="save" caption="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		<ui:context name="blockschedule_editclass">
			<ui:form>
				<ui:label caption="Class Code" rtexpression="true">#{class.code}</ui:label>
				<ui:label caption="Class Code" rtexpression="true">#{class.coursecode} - #{class.coursetitle}</ui:label>
			</ui:form>

			<b>Schedules</b>
			<ui:grid model="scheduleList" name="selectedSchedule" width="80%">
				<ui:col caption="Days">#{item.days}</ui:col>
				<ui:col caption="Time">#{item.fromtime} - #{item.totime}</ui:col>
				<ui:col>
					<a r:context="${context}" r:name="editSchedule" r:immediate="true">Edit</a>
					&nbsp;&nbsp;&nbsp;
					<a r:context="${context}" r:name="removeSchedule" r:immediate="true">Remove</a>
				</ui:col>
			</ui:grid>
			<ui:button caption="+" action="addSchedule" immediate="true" title="Add Schedule"/>
		</ui:context>
		
	
	</jsp:body>
	

</t:popup>



	
	