<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>


<t:content title="Pending Enrollment Form">	
	<jsp:attribute name="head">
		<s:invoke service="StudentService" method="read" params="${SESSION_INFO}" var="STUDENT" debug="true"/>
		
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/js/ext/calendar/fullcalendar.css" type="text/css"/>
		<script src="${pageContext.servletContext.contextPath}/js/ext/calendar/fullcalendar.js"></script>
		<script src="${pageContext.servletContext.contextPath}/js/ext/calendar/calendar.js"></script>
		<script src="${pageContext.servletContext.contextPath}/js/apps/SkedUtil.js"></script>
		
		<script>
			$put(
				"pending", 
				new function() 
				{
					var self = this;
					var util = new SkedUtil();

					this.classlist = <s:invoke service="EnrollmentService" method="getPendingEnrollment" json="true"/>
					
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

					this.listView = false;
					this.toggleView = function() {
						this.listView = !this.listView;
					}
					
					this.getClassList = function() {
						return this.classlist.each(buildListInfo);
					}
					
					function buildListInfo(cl){
						var arr = [];
						cl.schedules.each(function(sk){
							console.log( sk );
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
					
				}
			);
		</script>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div id="schedule_panel" style="display:none;">
			#{it.coursecode}<br>
			Rm: #{(it.roomno) ? it.roomno: 'unassigned'}<br>
			#{(it.teacher) ? it.teacher: 'unassigned'}
		</div>
	</jsp:attribute>

	<jsp:body>
		<ui:context name="pending">
			<div class="clearfix" r:context="${context}" r:type="label">
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
				<ui:grid items="getClassList()">
					<ui:col caption="Course Code" name="coursecode"/>
					<ui:col caption="Title" name="coursetitle"/>
					<ui:col caption="Schedule" name="schedule" width="200px"/>
				</ui:grid>
			</div>
		</ui:context>
	</jsp:body>
</t:content>