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
					return new PopupOpener("blockschedule:addclass", { block:this.blockinfo, saveHandler:reloadModel } );
				}
				
				this.changeSchedule = function() {
					self._controller.navigate("_close");
					return new PopupOpener("blockschedule:editclass", { class:this.selectedClass, saveHandler:reloadModel } );
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
	</jsp:attribute>


	<jsp:body>
		<div r:type="weekcalendar" r:context="blockinfo" r:model="model"></div>
	</jsp:body>
	
</t:content>
