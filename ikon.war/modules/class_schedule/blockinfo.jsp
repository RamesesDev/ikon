<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>


<script>
	$register( {id:"#context_menu", context: "blockinfo" });	
	$put( "blockinfo", 
		new function() {
			
			var svc = ProxyService.lookup("ClassScheduleService");
		
			
			this.blockinfo = <s:invoke service="ClassScheduleService" method="getBlock" params="<%=request%>" json="true"/>;	
			this.classlist;
			var self = this;
				
			var util = new SkedUtil();
			var info = new InfoBox("#context_menu");
			
			this.selectedClass;
			this.selectedSchedule;

			this.model = {
				minTime: 6,
				maxTime: 22,
				onclick: function(o, e) {
					self.selectedClass = o.item.class;
					self.selectedSchedule = o.item.sked;
					window.console.log( $.toJSON(o.item.sked) );
					self._controller.navigate(new DropdownOpener( "#context_menu"), e );
				},
				fetchList: function() {
					var arr = [];
					self.classlist = svc.getBlockClasses( {blockid: self.blockinfo.objid } );
					self.classlist.each(
						function(clz) {
							for( var i=0;i<clz.schedules.length;i++ ) {
								var c = clz.schedules[i];	
								var func = function(d) {
									var z = {coursecode: clz.coursecode, roomno: c.roomno, room_conflict: c.room_conflict, teacher: clz.teacher }
									arr.push( {day: d, from: c.fromtime, to: c.totime, caption: $template('schedule_panel',z), 
										item:{class:clz,sked:c}, color: clz.colorcode });		
								}
								util.fetchDays( c.days_of_week, func );
							}
						}
					);
					return arr;
				}
			};
			
			var reloadModel = function() {
				self.model.load();
			}
			
			this.addClassSchedule = function() {
				return new PopupOpener("class_schedule:addblockclass", { block:this.blockinfo, saveHandler:reloadModel } );
			}
			
			this.changeSchedule = function() {
				self._controller.navigate("_close");
				return new PopupOpener("class_schedule:editblockclass", { class:this.selectedClass, saveHandler:reloadModel } );
			}
			
			this.removeClass = function() {
				alert( "remove " + $.toJSON(this.selectedClass) );
			}

			this.viewRoom = function() {
				alert('view room for ' + this.selectedSchedule.roomid + " " + this.selectedSchedule.roomno );
			}
		}	
	);	
	
</script>

<!-- scheduling template -->
<div id="schedule_panel" style="display:none;">
	#{it.coursecode}<br>
	Rm: #{(it.roomno) ? it.roomno: 'unassigned'}<br>
	#{(it.teacher) ? it.teacher: 'unassigned'}<br>
	#{(it.room_conflict) ? '**room conflict**' : '' }
</div>


<!-- room conflict template -->
<div id="room_conflict_template" style="display:none;">
	#{it.classcode} - #{it.days} #{it.fromtime}-#{it.totime}
</div>

<!-- context menu -->
<div id="context_menu" style="display:none;">
	<label r:context="blockinfo">
		<b>#{selectedClass.code}</b>
		<br>
	</label>
	<a r:context="blockinfo" r:name="changeSchedule">Change Schedule</a>
	<br>
	<div r:context="blockinfo" r:type="label" r:visibleWhen="#{selectedSchedule.room_conflict!=null}">
		<font color=red>Room Conflicts</font> <a r:context="blockinfo" r:name="viewRoom">View Room</a>
		<br>
		#{ $template('room_conflict_template', selectedSchedule.room_conflict, true ) }
	</div>
</div>

<input type="button" r:context="blockinfo" value="Add Course" r:name="addClassSchedule"/>

<br>
<b>Block Code</b> <label r:context="blockinfo">#{blockinfo.code}</label> 
<br>
<b>Program</b> <label r:context="blockinfo">#{blockinfo.programcode} - #{blockinfo.programtitle}</label> 
<br>
<b>Year Level</b> <label r:context="blockinfo">#{blockinfo.yearlevel}</label> 
<br>
<b>Term</b> <label r:context="blockinfo">#{blockinfo.term}</label> 
<br>
<hr>
<div r:type="weekcalendar" r:context="blockinfo" r:model="model">
</div>

