<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/common" prefix="com" %>



<s:invoke service="PersonnelService" method="read" params="<%=request%>" var="INFO"/>

<t:content>

	<jsp:attribute name="title">
		Schedule for <b>${INFO.lastname}, ${INFO.firstname}</b><br>
	</jsp:attribute>

	<jsp:attribute name="script">
		$register( {id:"#teacher_schedule_context_menu", context: "teacher_schedule_info" });
		$put( "teacher_schedule_info", 
		
			new function() {
				var util = new SkedUtil();
				var svc = ProxyService.lookup("TeacherScheduleService");
				var self = this;
				
				this.objid;
				this.schooltermid = "${param['schooltermid']}";	
				this.selectedSchedule;
				
				this.weekSchedule = {
					minTime: 6,
					maxTime: 22,
					onclick: function(o,e) {
						self.selectedSchedule = o.item;
						self._controller.navigate(new DropdownOpener( "#teacher_schedule_context_menu"), e );
					},
					fetchList: function() {
						var list = svc.getTeacherSchedules({schooltermid:self.schooltermid,teacherid:self.objid});
						var arr = [];
						for( var i=0; i<list.length; i++ ) {
							var c = list[i];	
							var func = function(d) {
								arr.push( {day: d, from: c.fromtime, to: c.totime, caption: $template('sked_caption', c), item:c, color: c.colorcode });		
							}
							util.fetchDays( c.days_of_week, func );
						}
						return arr;
					}
				};
				
				this.lookupAvailable = function() {
					var f = function(x) {
						svc.assignTeacher( {objid: x.classid, teacherid: self.objid } );
						self.weekSchedule.load();
					}
					return new PopupOpener( "teacher_schedule:lookup_available_schedule", 
						{selectHandler:f, schooltermid:this.schooltermid, teacherid: this.objid } 
					);
				}
				
				this.unassignTeacher = function() {
					self._controller.navigate( "_close");
					if( confirm( "This will remove room assignement. Proceed?")) {
						svc.unassignTeacher( {objid: self.selectedSchedule.classid, teacherid: self.selectedSchedule.teacherid } );
						self.weekSchedule.load();
					}
				}
			}
		);
	</jsp:attribute>

	<jsp:attribute name="sections">
		<div id="teacher_schedule_context_menu" style="display:none;">
			<label r:context="teacher_schedule_info">
				<b>#{selectedSchedule.code}</b>
				<br>
			</label>
			<a r:context="teacher_schedule_info" r:name="unassignTeacher">Unassign Teacher</a>
		</div>

		<!-- caption for schedule -->
		<div id="sked_caption" style="display:none;">
			#{it.classcode}<br>
			Rm: #{(it.roomno)?it.roomno:'unassigned'}<br>
		</div>
	</jsp:attribute>
	
	<jsp:body>
		<ui:button context="teacher_schedule_info" action="lookupAvailable" caption="Assign Schedule"/>
		<div r:type="weekcalendar" r:context="teacher_schedule_info" r:model="weekSchedule"></div>
	</jsp:body>
	
</t:content>





		