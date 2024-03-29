<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/common" prefix="com" %>


<s:invoke service="BlockScheduleService" method="getBlock" params="<%=request%>" var="INFO"/>

<t:content>

	<jsp:attribute name="title">
		Block Schedule - ${INFO.code}
	</jsp:attribute>
	
	<jsp:attribute name="head">
	  <script type="text/javascript">
	  
		$register( {id:"#context_menu", context: "blockinfo" });	
		$put( "blockinfo", 
			new function() {
				var svc = ProxyService.lookup("BlockScheduleService");
				this.blockinfo = <com:tojson value="${INFO}"/>;
				
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
										var z = {
											coursecode: clz.coursecode, roomno: c.roomno, roomid: c.roomid, 
											room_conflict: c.room_conflict, teacher_conflict: c.teacher_conflict, 
											teacher: clz.teacher, teacherid: clz.teacherid 
										};
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
					return new PopupOpener("blockschedule:addclass", { block:this.blockinfo, saveHandler:reloadModel } );
				}
				
				this.changeSchedule = function() {
					self._controller.navigate("_close");
					return new PopupOpener("blockschedule:editclass", { clazz:this.selectedClass, saveHandler:reloadModel } );
				}
				
				this.removeSchedule = function() {
					//self._controller.navigate("_close");
					if( confirm("Are you sure you want to remove this schedule?") ) {
						svc.removeClass( {objid: this.selectedClass.objid, blockid: this.blockinfo.objid}, function(z) {self.model.load();} ); 
					}
				}

				this.viewRoom = function() {
					alert('view room for ' + this.selectedSchedule.roomid + " " + this.selectedSchedule.roomno );
				}
			}	
		);
	  </script>
	</jsp:attribute>

	<jsp:attribute name="sections">
		<!-- scheduling template -->
		<div id="schedule_panel" style="display:none;">
			#{it.coursecode}<br>
			Rm: #{(it.roomno) ? it.roomno: 'unassigned'}<br>
			#{(it.teacher) ? it.teacher: 'unassigned'}<br>
			
			<div r:context="blockinfo" r:visibleWhen="#{it.room_conflict == true}">
				<a href="#schedule_conflict:room?objid=#{it.roomid}">
					<img src="${pageContext.request.contextPath}/img/red_flag.png"/>Room 
				</a>
			</div>
			<div r:context="blockinfo" r:visibleWhen="#{it.teacher_conflict == true}">
				<a href="#schedule_conflict:teacher?objid=#{it.teacherid}">
					<img src="${pageContext.request.contextPath}/img/red_flag.png"/>Teacher 
				</a>
			</div>
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
			<a r:context="blockinfo" r:name="removeSchedule">Remove Schedule</a>
			<br>
			<div r:context="blockinfo" r:type="label" r:visibleWhen="#{selectedSchedule.room_conflict!=null}">
				<font color=red>Room Conflicts</font> <a r:context="blockinfo" r:name="viewRoom">View Room</a>
				<br>
				#{ $template('room_conflict_template', selectedSchedule.room_conflict, true ) }
			</div>
		</div>
	</jsp:attribute>

	<jsp:body>
		<ui:context name="blockinfo">
			<ui:button caption="Add Entry" action="addClassSchedule"/>
			<ui:form>
				<ui:label caption="Block Code" rtexpression="true">#{blockinfo.code}</ui:label>
				<ui:label caption="Program" rtexpression="true">#{blockinfo.programcode} - #{blockinfo.programtitle}</ui:label>
				<ui:label caption="Year/Term" rtexpression="true">#{blockinfo.yearlevel} - #{blockinfo.term}</ui:label>
			</ui:form>	
		</ui:context>
		<hr>
		<div r:type="weekcalendar" r:context="blockinfo" r:model="model"></div>
	</jsp:body>
	
</t:content>
