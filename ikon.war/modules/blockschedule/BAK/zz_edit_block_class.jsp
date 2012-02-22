<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>
	$put( "edit_block_class", 
		new function() {
			var svc = ProxyService.lookup("ClassService"); 
			this.class;
			this.programid;
			this.blockid;
			
			this.programCourse;
			this.selectedSchedule;
			this.saveHandler;
			this.courseName;
			
			this.onload = function() {
				this.programCourse = new ProgramCourse();
				if(!this.class) {
					this.programCourse.programid = this.programid;
					this.class = { schedules: [] };
					this.class.blockid = this.blockid;
					this.class.programid = this.programid;
					this.class.schooltermid = "${param['schooltermid']}";	
					this.class.colorcode = "lightgrey";
				}
				else {
					this.programCourse.programid = this.class.programid;
					this.courseName = this.class.coursecode + " - " + this.class.coursename ;
				}
			}
			
			var self = this;
			
			this.scheduleList = {
				fetchList: function(o)  {
					return self.class.schedules;
				}
			}
			
			this.addSchedule = function() {
				var f = function(o) {
					self.class.schedules.push(o);
					self.scheduleList.refresh();
				}
				return new PopupOpener("class_schedule:schedule", {saveHandler: f} );
			}
			
			this.editSchedule = function() {
				var f = function(o) {
					self.scheduleList.refresh();
				}
				return new PopupOpener("class_schedule:schedule", {saveHandler: f, schedule: this.selectedSchedule} );
			}
			
			this.removeSchedule = function() {
				if( confirm("You are about to remove this item. Continue?")) {
					this.class.schedules.remove( this.selectedSchedule );
					this.scheduleList.refresh();
				}
			}
			
			this.save = function() {
				this.class.courseid = this.programCourse.selectedCourse.objid;
				svc.saveClass( this.class );
				this.saveHandler();
				return "_close";
			}
		}	
	);
</script>

<div id="programTpl" style="display:none;">
	<a>#{code} - #{title}</a>
</div>
Class Code: <input type="text" r:context="edit_block_class" r:name="class.code" r:required="true" r:caption="Class Code"/> 
<br>
Select Course 
<input type="text" r:context="edit_block_class" r:name="courseName" size="50"  r:required="true" 
	r:suggest="programCourse.courseLookup" r:suggestName="programCourse.selectedCourse" 
	r:suggestExpression="#{code} - #{title}" r:suggestTemplate="programTpl" r:caption="Course"/>
<br>	
Color Code: <span r:type="colorpicker" r:context="edit_block_class" r:name="class.colorcode"></span> 
<br>
<b><u>Seat capacity</u></b>
<br>
Min Seats: <input type="text" r:context="edit_block_class" r:name="class.min_seats" r:required="true" r:caption="Min No. of Seats" size="4"/> 
Max Seats: <input type="text" r:context="edit_block_class" r:name="class.max_seats" r:required="true" r:caption="Max No. of Seats" size="4"/> 
<br>

Schedules
<table r:context="edit_block_class" r:model="scheduleList" r:varName="item" width="80%" r:name="selectedSchedule" border="1">
	<thead>
		<tr>
			<td>Days</td>
			<td>Time</td>
			<td>Room</td>
			<td>&nbsp;</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>#{item.days}</td>
			<td>#{item.fromtime} - #{item.totime}</td>
			<td>#{item.roomid}</td>
			<td>
				<a r:context="edit_block_class" r:name="editSchedule">Edit</a>
				&nbsp;&nbsp;&nbsp;
				<a r:context="edit_block_class" r:name="removeSchedule">Remove</a>
			</td>
		</tr>
	</tbody>	
</table>
<input type="button" r:context="edit_block_class" r:name="addSchedule" value="+" r:immediate="true" title="Add Schedule"/>
<br>
<br>
<input type="button" r:context="edit_block_class" r:name="save" value="Save"/>

	
	