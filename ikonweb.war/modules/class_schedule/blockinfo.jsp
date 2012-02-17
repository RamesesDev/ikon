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

			this.model = {
				minTime: 6,
				maxTime: 22,
				onclick: function(o, e) {
					self.selectedClass = o.item.class;
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
									var caption = clz.coursecode;
									caption += "\n" + "Rm:" + ((c.roomno)?c.roomno:'unassigned');
									if( c.room_conflict ) caption += "\n" + "Rm conflicts:"+c.room_conflict;
									arr.push( {day: d, from: c.fromtime, to: c.totime, caption: caption, 
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

		}	
	);	
	
</script>

<div id="context_menu" style="display:none;">
	<label r:context="blockinfo">
		<b>#{selectedClass.code}</b>
		<br>
	</label>
	<a r:context="blockinfo" r:name="changeSchedule">Change Schedule</a>
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

