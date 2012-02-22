<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>


<script>
	$register( {id:"edit_block_class", context:"edit_block_class", page: "class/edit_block_class.jsp", 
		title:"Course Schedule", options:{width:600, height:400}} );
		
	$register( {id:"class_schedule", context:"class_schedule", page: "class/class_schedule.jsp", 
		title:"Class Schedule", options:{width:500, height:300}} );
		
	$put( "blockinfo", 
		new function() {
			
			var svc = ProxyService.lookup("ClassService");
		
			
			this.blockinfo = <s:invoke service="ClassService" method="getBlock" params="<%=request%>" json="true"/>;	
			this.classlist;
			var self = this;
				
			var util = new SkedUtil();
			
			this.selectedClass = {};
			var ibox = new InfoBox('#infobox','right', {x:-10, y:20});
			
			this.addCourseSchedule = function() {
				var func = function() {
					self.model.load();
				}
				return new PopupOpener("edit_block_class", {programid: this.blockinfo.programid, blockid:this.blockinfo.objid, saveHandler:func });
			}
			
			this.model = new TimeWeekCalendar({
				onmouseover: function(sked, elem) {
					self.selectedClass = sked;
					ibox.show(elem);
				},
				fetchList: function() {
					var arr = [];
					self.classlist = svc.getBlockClasses( {blockid: self.blockinfo.objid } );
					self.classlist.each(
						function(clz) {
							for( var i=0;i<clz.schedules.length;i++ ) {
								var c = clz.schedules[i];	
								var func = function(d) {
									arr.push( {day: d, from: c.fromtime, to: c.totime, caption: clz.coursecode, item:{class:clz,sked:c}, color: clz.colorcode });		
								}
								util.fetchDays( c.days_of_week, func );
							}
						}
					);
					return arr;
				}
			});
			
			this.editClass = function() {
				var func = function() {
					self.model.load();
				}
				return new PopupOpener("edit_block_class", {class: this.selectedClass.item.class, saveHandler:func });
			}
			
			this.removeClass = function() {
				alert( "remove " + $.toJSON(this.selectedClass) );
			}

		}	
	);	
	
</script>

<input type="button" r:context="blockinfo" value="Add Course" r:name="addCourseSchedule"/>
<br>
<b>Block Code</b> <label r:context="blockinfo">#{blockinfo.code}</label> 
<br>
<b>Program</b> <label r:context="blockinfo">#{blockinfo.programcode} - #{blockinfo.programtitle}</label> 
<br>
<b>Year Level</b> <label r:context="blockinfo">#{blockinfo.yearlevel}</label> 
<br>
<hr>
<div r:type="week_calendar" r:context="blockinfo" r:model="model">
</div>


<div id="infobox" style="display:none">
	<div r:context="blockinfo" r:type="label">
		Time: #{selectedClass.from} - #{selectedClass.to}<br/>
		Subject: #{selectedClass.caption}<br/>
		Instructor: <i>Not yet assigned.</i><br/>
		Room: <i>#{selectedClass.item.sked.roomid}</i><br/>
		<a r:context="blockinfo" r:name="editClass">Edit</a>&nbsp;&nbsp;<a r:context="blockinfo" r:name="removeClass">Remove</a>
	</div>
</div>
