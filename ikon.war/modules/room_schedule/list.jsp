<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<style>
	.room_search_results td {
		padding-left:5px;
	}
	.room_search_results tr.selected {
		background-color:orange;
	}
</style>

<script>
	$register( {id:"#context_menu", context: "room_schedule_list" });
	$put( "room_schedule_list", 
		new function() {
			var util = new SkedUtil();
			var svc = ProxyService.lookup("RoomScheduleService");
			this.schedule;
			var self = this;
			
			
			this.schooltermid = "${param['schooltermid']}";	
			this.selectedItem;
			
			this.selectedSchedule;
			
			this.listModel = {
				fetchList: function(o) {
					if( !self.schedule ) return [];
					self.schedule.schooltermid = self.schooltermid;
					return svc.getRoomAvailability(self.schedule);	
				}
			}	
			this.defineSchedule = function() {
				var f = function(x) {
					self.schedule = x;
					refreshScreen();
				}
				return new DropdownOpener( "scheduling:dow_schedule", {saveHandler: f} );
			}

			var refreshScreen = function() {
				self.listModel.refresh(true);
				self.selectedItem = null;
				self._controller.notifyDependents("selectedItem");
			}

			this.resetSchedule = function() {
				this.schedule = null;
				refreshScreen();
			}
			
			this.weekSchedule = {
				minTime: 6,
				maxTime: 22,
				onclick: function(o,e) {
					self.selectedSchedule = o.item;
					self._controller.navigate(new DropdownOpener( "#context_menu"), e );
				},
				fetchList: function() {
					if( !self.selectedItem) return [];
					var list = svc.getRoomSchedules({schooltermid:self.schooltermid,roomid:self.selectedItem.objid});
					var arr = [];
					for( var i=0; i<list.length; i++ ) {
						var c = list[i];	
						var func = function(d) {
							arr.push( {day: d, from: c.fromtime, to: c.totime, caption: c.classcode, item:c, color: c.colorcode });		
						}
						util.fetchDays( c.days_of_week, func );
					}
					return arr;
				}
			};
			
			this.lookupAvailable = function() {
				var f = function(x) {
					svc.assignRoom( {objid: x.objid, roomid: self.selectedItem.objid } );
					self.weekSchedule.load();
				}
				return new PopupOpener( "room_schedule:lookup_available_schedule", 
					{selectHandler:f, schooltermid:this.schooltermid, roomid: this.selectedItem.objid } 
				);
			}
			
			this.unassignRoom = function() {
				self._controller.navigate( "_close");
				if( confirm( "This will remove room assignement. Proceed?")) {
					svc.unassignRoom( {objid: self.selectedSchedule.objid, roomid: self.selectedSchedule.roomid } );
					self.weekSchedule.load();
				}
			}
			
			this.propertyChangeListener = {
				"selectedItem": function(o) {
					self.weekSchedule.load();
				}
			}
		}
	);
</script>

<div id="context_menu" style="display:none;">
	<label r:context="room_schedule_list">
		<b>#{selectedSchedule.code}</b>
		<br>
	</label>
	<a r:context="room_schedule_list" r:name="unassignRoom">Unassign Room</a>
</div>



<table width="100%" height="100%">
	<tr>
		<td colspan="2" height="40" valign="top" style="border-bottom:1px solid lightgrey;padding-bottom:10px;">
			<b>Room Schedules</b><br>
			<input type="button" r:context="room_schedule_list" r:name="defineSchedule" value="Search"/><br>
			<label r:context="room_schedule_list" r:visibleWhen="#{schedule}">
				<b>Schedule: #{schedule.days} #{schedule.fromtime}-#{schedule.totime}</b> 
				<br>
				<a r:context="room_schedule_list" r:name="resetSchedule">Reset</a>
			</label>
		</td>
	</tr>
	<tr>
		<td width="120" valign="top" style="border-right:1px solid lightgrey;">
			<b><u>Rooms</u></b>
			<table r:context="room_schedule_list" r:model="listModel" r:varName="item" r:varStatus="stat" r:name="selectedItem" width="80%" class="room_search_results">
				<tr><td>#{item.roomno}</td></tr>
			</table>
		</td>
		
		<td valign="top">
			<label r:context="room_schedule_list" r:depends="selectedItem" r:visibleWhen="#{selectedItem!=null}">
				Room: <b>#{selectedItem.roomno}</b>
				<input type="button" r:context="room_schedule_list" r:name="lookupAvailable" value="Assign Schedule"/>
				<br>
			</label>
			<div r:type="weekcalendar" r:context="room_schedule_list" r:model="weekSchedule"></div>
		</td>
	</tr>
</table>

		