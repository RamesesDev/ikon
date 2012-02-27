<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/common" prefix="com" %>


<t:content>
	
	<jsp:attribute name="title">
		Class Schedule
	</jsp:attribute>
	
	<jsp:attribute name="head">
		<s:invoke service="StudentService" method="read" params="${SESSION_INFO}" var="STUDENT" debug="true"/>		
	
		<script>
			$register( {id: "#enrollment_context_menu", context: "enrollment_customize"} );
			$put( 
				"enrollment_customize", 			
				new function() {
					var svc = ProxyService.lookup("EnrollmentService");
					this.blockinfo = {}
					
					this.classlist;
					var self = this;
					this.schooltermid = "${param['schooltermid']}";
					this.student = <com:tojson value="${STUDENT}"/>;
			
					var util = new SkedUtil();
					
					this.listView = false;
					
					this.selectedClass;
					this.selectedSchedule;

					this.model = {
						minTime: 6,
						maxTime: 22,
						onclick: function(o, e) {
							self.selectedClass = o.item.class;
							self.selectedSchedule = o.item.sked;
							self._controller.navigate(new DropdownOpener( "#enrollment_context_menu"), e );
						},
						fetchList: function() {
							var arr = [];
							self.classlist = svc.getEnrolledClasses( {schooltermid: self.schooltermid, studentid: self.student.objid} );
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
						self.listModel.load();
					}
					
					
					
					this.toggleView = function() {
						this.listView = !this.listView;
					}
					
					this.listModel = {
						fetchList: function() {
							return self.classlist.each(buildListInfo);
						}
					}
						
					function buildListInfo(cl){
						var arr = [];
						cl.schedules.each(function(sk){
							arr.push(
								"<b>"+ sk.days + "</b> / " + 
								formatToTime(sk.fromtime) + "-" + formatToTime(sk.totime) +
								" / " + (sk.roomno? sk.roomno : '<i>unassigned</i>')
							);
						});
						cl.schedule = arr.join(' , ');
					}
					
					function formatToTime( num ) {
						return (num+"").replace(/(\d+)(\d{2})$/, "$1:$2");
					}
					
					this.addClass = function() {
						var s = function(x) {
							svc.addClassSchedule( x );
							reloadModel();
						}
						return new PopupOpener( "enrollment:customize_addclass", {saveHandler:s} );
					}
					
					this.addBlock = function() {
						var s = function(x) {
							svc.addBlockSchedule( x );
							reloadModel();
						}
						return new PopupOpener( "enrollment:customize_addblock", {saveHandler:s} );
					}
					
					this.removeClass = function() {
						if( this.selectedClass ) {
							MsgBox.confirm(
								'Are you sure you want to remove the selected item?',
								function() {
									self._controller.navigate( "_close" );
									svc.removeClassSchedule( {studentid: self.student.objid, classid: self.selectedClass.objid } );
									reloadModel();
								}
							);
						}
						
					}
					
					this.submit = function() {
						MsgBox.confirm(
							'You are about to submit this enrollment form.\nPlease verify that your schedules are correct. Proceed?',
							function() 
							{
								svc.submitForApproval( self.student, self.schooltermid );								
								MsgBox.alert('Enrollment form submitted successfully.', function(){
									window.location.href = 'index.jsp';
								});
							}
						);
					}
				}	
			);
		</script>
		
		<style>
			span.remarks { color: red; }
		</style>
	</jsp:attribute>

	<jsp:attribute name="sections">
		<div id="schedule_panel" style="display:none;">
			#{it.coursecode}<br>
			Rm: #{(it.roomno) ? it.roomno: 'unassigned'}<br>
			#{(it.teacher) ? it.teacher: 'unassigned'}
		</div>
		
		<div id="enrollment_context_menu" style="display:none;">
			<label r:context="enrollment_customize">Class Code: #{selectedClass.code}</label>
			<br>
			<a r:context="enrollment_customize" r:name="removeClass">Remove Class Schedule</a>
		</div>		
	</jsp:attribute>
	
	<jsp:body>
		<b>School Year Term :</b>
		<br>
		<b>No of Units:</b>
		<ui:context name="enrollment_customize">
			<div class="clearfix" r:context="${context}" r:type="label">
				<span class="left">
					<ui:button action="submit" caption="Submit"/>
					<ui:button action="addBlock" caption="Add Block"/>
					<ui:button action="addClass" caption="Add Class"/>
				</span>
				<span class="right">
					<ui:button action="toggleView">
						#{listView? 'Calendar' : 'List'} View
					</ui:button>
				</span>
			</div>
			<div r:context="${context}" r:visibleWhen="#{!listView}">
				<div r:type="weekcalendar" r:context="${context}" r:model="model" class="sections"></div>
			</div>
			<div r:context="${context}" r:visibleWhen="#{listView}">
				<ui:grid model="listModel" name="selectedClass">
					<ui:col caption="Course Code" name="coursecode"/>
					<ui:col caption="Title" name="coursetitle"/>
					<ui:col caption="Schedule" name="schedule" width="200px"/>
					<c:if test="${!empty param.pending}">
						<ui:col caption="Remarks" width="200px">
							<span class="remarks">
								#{item.remarks}
							</span>
						</ui:col>
					</c:if>
					<ui:col>
						<a r:context="${context}" r:name="removeClass" title="Remove class">
							Remove
						</a>
					</ui:col>
				</ui:grid>
			</div>
		</ui:context>
	</jsp:body>


</t:content>