<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>


<t:content title="Enrollment Form - For Approval">	
	<jsp:attribute name="head">		
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/js/ext/calendar/fullcalendar.css" type="text/css"/>
		<script src="${pageContext.servletContext.contextPath}/js/ext/calendar/fullcalendar.js"></script>
		<script src="${pageContext.servletContext.contextPath}/js/ext/calendar/calendar.js"></script>
		<script src="${pageContext.servletContext.contextPath}/js/apps/SkedUtil.js"></script>
		
		<script>
			$register({id:'#add-remarks', context:'for_approval_info', title: 'Post Remarks'});
			$put(
				"for_approval_info", 
				new function() 
				{
					var self = this;
					var util = new SkedUtil();

					this.classlist = <s:invoke service="EnrollmentService" method="getEnrolledClasses" params="${pageContext.request}" json="true"/>;;
					
					this.model = {
						minTime: 6,
						maxTime: 22,
						fetchList: function() {
							var arr = [];
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
					}

					this.listView = true;
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
					
					var _svc;
					function getSvc() {
						return _svc? _svc : (_svc = ProxyService.lookup("EnrollmentService"));
					}
					
					this.approve = function() {
						MsgBox.confirm(
							'Are you sure you want to <b>approve</b> this enrollment form?',
							function() {
								getSvc().approve( '${param.studentid}' );
								location.href = 'home.jsp?jobid=${param.jobid}';
							}
						);
					}
					
					this.disapprove = function() {
						MsgBox.confirm(
							'Are you sure you want to <b>disapprove</b> this enrollment form?',
							function() {
								getSvc().disapprove( '${param.studentid}' );
								location.href = 'home.jsp?jobid=${param.jobid}';
							}
						);
					}
					
					this.remarks;
					
					this.addRemarks = function() {
						this.remarks = this.selectedItem.remarks;
						return new PopupOpener('#add-remarks');
					}
					
					this.postRemarks = function() {
						getSvc().postRemarks( {classid: this.selectedItem.objid, remarks: this.remarks} );
						this.classlist = getSvc().getEnrolledClasses({studentid: '${param.studentid}'});
						this.listModel.load();
						return '_close';
					}
				}
			);
		</script>
		
		<style>
			
		</style>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div id="schedule_panel" style="display:none;">
			#{it.coursecode}<br>
			Rm: #{(it.roomno) ? it.roomno: 'unassigned'}<br>
			#{(it.teacher) ? it.teacher: 'unassigned'}
		</div>
		
		<div id="add-remarks" style="display:none">
			<t:popup>
				<jsp:attribute name="rightactions">
					<ui:button context="for_approval_info" action="postRemarks" caption="Post"/>
				</jsp:attribute>
				<jsp:body>
					<h4>Remarks</h4>
					<textarea r:context="for_approval_info" r:name="remarks" rows="8" style="width:100%"></textarea>
				</jsp:body>
			</t:popup>
		</div>
	</jsp:attribute>

	<jsp:body>
		<ui:context name="for_approval_info">
			<div class="clearfix" r:context="${context}" r:type="label">
				<span class="left">
					<ui:button action="approve" caption="Approve"/>
					<ui:button action="disapprove" caption="Disapprove"/>
				</span>
				<span class="right">
					<ui:button action="toggleView">
						#{listView? 'Calendar' : 'List'} View
					</ui:button>
				</span>
			</div>
			<div r:context="${context}" r:visibleWhen="#{!listView}" style="display:none">
				<div r:type="weekcalendar" r:context="${context}" r:model="model" class="sections"></div>
			</div>
			<div r:context="${context}" r:visibleWhen="#{listView}">
				<ui:grid model="listModel">
					<ui:col caption="Course Code" name="coursecode" width="80px"/>
					<ui:col caption="Title" name="coursetitle"/>
					<ui:col caption="Schedule" name="schedule"/>
					<ui:col caption="Remarks" name="remarks" width="200px" />
					<ui:col valign="top">
						<a r:context="${context}" r:name="addRemarks" title="#{item.remarks? 'Edit' : 'Add'} Remarks">
							#{item.remarks? 'Edit' : 'Add'}
						</a>
					</ui:col>
				</ui:grid>
			</div>
		</ui:context>
	</jsp:body>
</t:content>