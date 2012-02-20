<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>



<script>
		
	$put( "room_schedule_info", 
		new function() {
			
			var svc = ProxyService.lookup("RoomScheduleService");
			var self = this;
			var util = new SkedUtil();
			this.room = {schooltermid: "${param['schooltermid']}", roomid: "${param['roomid']}"};
			
			this.model = {
				minTime: 6,
				maxTime: 22,
				fetchList: function() {
					var list = svc.getRoomSchedules(self.room);
					var arr = [];
					for( var i=0; i<list.length; i++ ) {
						var c = list[i];	
						var func = function(d) {
							arr.push( {day: d, from: c.fromtime, to: c.totime, caption: c.coursecode, color: c.colorcode });		
						}
						util.fetchDays( c.days_of_week, func );
					}
					return arr;
				}
			};
			
			var reloadModel = function() {
				self.model.load();
			}
			
		}	
	);	
	
</script>

<table width="100%" height="100%">
	<tr>
		<td valign="top" width="150">Rooms</td>
		<td valign="top">
			<div r:type="weekcalendar" r:context="room_schedule_info" r:model="model"></div>
		</td>
	</tr>
</table>

