<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>
	$put( "class_schedule_addclass", 
	
		new function() {
			var svc = ProxyService.lookup("ClassScheduleService"); 
			
			this.class;
			this.block;
			
			this.selectedSchedule;
			this.saveHandler;
			
			this.scheduletype = "regular";
			this.courseList;
			
			this.getCourseList = function() {
				var p = {}
				p.scheduletype = this.scheduletype;
				p.yearlevel = this.block.yearlevel;
				p.term = this.block.term;
				p.blockid = this.block.objid;
				p.programid = this.block.programid;
				return svc.lookupProgramCourses( p );
			}
			
			this.onload = function() {
				this.class = {schedules: [] };
				this.class.blockid = this.block.objid;
				this.class.programid = this.block.programid;
				this.class.schooltermid = this.block.schooltermid;	
				this.class.colorcode = "lightgrey";
			}
			
			var self = this;
			
			this.scheduleList = {
				fetchList: function(o)  {
					return self.class.schedules;
				}
			}
			
			var refreshSchedule = function(o) {
				self.scheduleList.refresh();
			}
			
			this.addSchedule = function() {
				var f = function(o) {
					self.class.schedules.push(o);
					refreshSchedule();
				}
				return new PopupOpener("scheduling:dow_schedule", {saveHandler: f} );
			}
			
			this.editSchedule = function() {
				return new PopupOpener("scheduling:dow_schedule", {saveHandler: refreshSchedule, schedule: this.selectedSchedule} );
			}
			
			this.removeSchedule = function() {
				if( confirm("You are about to remove this item. Continue?")) {
					this.class.schedules.remove( this.selectedSchedule );
					refreshSchedule();
				}
			}
			
			this.save = function() {
				svc.saveClass( this.class );
				this.saveHandler();
				return "_close";
			}
		}	
	);
</script>

<label r:context="class_schedule_addclass">
	Year Level : <b>#{block.yearlevel}</b><br>
	Term : <b>#{block.term}</b><br>
</label>
<br>

Schedule a course<br>
<input type="radio" r:context="class_schedule_addclass" r:name="scheduletype" value="regular"/>Regular
<input type="radio" r:context="class_schedule_addclass" r:name="scheduletype" value="nonregular"/>Non Regular
<select r:context="class_schedule_addclass" r:items="getCourseList()" r:depends="scheduletype" r:name="class.courseid" 
	r:itemKey="courseid" r:itemLabel="coursecode" r:allowNull="true" r:required="true" r:caption="Course" rows="10"/>

<br>	
Class Code: <input type="text" r:context="class_schedule_addclass" r:name="class.code" r:required="true" r:caption="Class Code"/> 
<br>	
Color Code: <span r:type="colorpicker" r:context="class_schedule_addclass" r:name="class.colorcode"></span> 
<br>
<b><u>Seat capacity</u></b>
<br>
Min Seats: <input type="text" r:context="class_schedule_addclass" r:name="class.min_seats" r:required="true" r:caption="Min No. of Seats" size="4"/> 
Max Seats: <input type="text" r:context="class_schedule_addclass" r:name="class.max_seats" r:required="true" r:caption="Max No. of Seats" size="4"/> 
<br>

Schedules
<table r:context="class_schedule_addclass" r:model="scheduleList" r:varName="item" width="80%" r:name="selectedSchedule" border="1">
	<thead>
		<tr>
			<td>Days</td>
			<td>Time</td>
			<td>&nbsp;</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>#{item.days}</td>
			<td>#{item.fromtime} - #{item.totime}</td>
			<td>
				<a r:context="class_schedule_addclass" r:name="editSchedule" r:immediate="true">Edit</a>
				&nbsp;&nbsp;&nbsp;
				<a r:context="class_schedule_addclass" r:name="removeSchedule" r:immediate="true">Remove</a>
			</td>
		</tr>
	</tbody>	
</table>
<input type="button" r:context="class_schedule_addclass" r:name="addSchedule" value="+" r:immediate="true" title="Add Schedule"/>
<br>
<br>
<input type="button" r:context="class_schedule_addclass" r:name="save" value="Save"/>

	
	