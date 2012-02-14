<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>


<script>
		
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
				return new PopupOpener("class_schedule:edit_block", {programid: this.blockinfo.programid, blockid:this.blockinfo.objid, saveHandler:func });
			}
			
			this.model = {
				minTime: 6,
				maxTime: 22,
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
			};
			
			this.editClass = function() {
				var func = function() {
					self.model.load();
				}
				return new PopupOpener("class_schedule:edit_block", {class: this.selectedClass.item.class, saveHandler:func });
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
<div r:type="weekcalendar" r:context="blockinfo" r:model="model">
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
