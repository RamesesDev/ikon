<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<s:invoke service="RoomAdminService" method="read" params="<%=request%>" var="INFO"/>

<script>
	$register( {id:"#context_menu", context: "room_schedule_info" });
	$put( "room_schedule_info", 
		new function() {
			var util = new SkedUtil();
			var svc = ProxyService.lookup("RoomScheduleService");
			this.objid;
			var self = this;
			
			this.schooltermid = "${param['schooltermid']}";	
			
			this.selectedSchedule;
			
			this.weekSchedule = {
				minTime: 6,
				maxTime: 22,
				onclick: function(o,e) {
					self.selectedSchedule = o.item;
					self._controller.navigate(new DropdownOpener( "#context_menu"), e );
				},
				fetchList: function() {
					var list = svc.getRoomSchedules({schooltermid:self.schooltermid,roomid:self.objid});
					var arr = [];
					for( var i=0; i<list.length; i++ ) {
						var c = list[i];	
						var func = function(d) {
							arr.push( {day: d, from: c.fromtime, to: c.totime, caption: $template('sked_caption',c), item:c, color: c.colorcode });		
						}
						util.fetchDays( c.days_of_week, func );
					}
					return arr;
				}
			};
			
			this.lookupAvailable = function() {
				var f = function(x) {
					svc.assignRoom( {objid: x.objid, roomid: self.objid } );
					self.weekSchedule.load();
				}
				return new PopupOpener( "room_schedule:lookup_available_schedule", 
					{selectHandler:f, schooltermid:this.schooltermid, roomid: this.objid } 
				);
			}
			
			this.unassignRoom = function() {
				self._controller.navigate( "_close");
				if( confirm( "This will remove room assignement. Proceed?")) {
					svc.unassignRoom( {objid: self.selectedSchedule.objid, roomid: self.selectedSchedule.roomid } );
					self.weekSchedule.load();
				}
			}
		}
	);
</script>

<!-- menu template -->
<div id="context_menu" style="display:none;">
	<label r:context="room_schedule_info">
		<b>#{selectedSchedule.code}</b>
		<br>
	</label>
	<a r:context="room_schedule_info" r:name="unassignRoom">Unassign Room</a>
</div>

<!-- calendar template -->
<div id="sked_caption" style="display:none;">
	#{it.classcode}<br>
	#{(it.teacher)?it.teacher:'unassigned'}<br>
</div>

Room No : ${INFO.roomno}<br>

<input type="button" r:context="room_schedule_info" r:name="lookupAvailable" value="Assign Schedule"/>
<div r:type="weekcalendar" r:context="room_schedule_info" r:model="weekSchedule"></div>

		