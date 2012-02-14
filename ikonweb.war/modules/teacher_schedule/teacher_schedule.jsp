<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	$put( "teacher_schedule", 
		new function() {
			this.objid;
			this.teacher = {firstname:"Pat", lastname: "Nazareno"};
			this.model = new TimeWeekCalendar({
				fetchList: function() {
					var arr = [];
					return arr;
				}
			});
			
			this.addSchedule = function() {
				alert('adding schedule for ' + this.objid );
			}
		}
	);
</script>

<input type="button" r:context="teacher_schedule" r:name="addSchedule" value="Add Schedule"/>
<br>
Teacher :<label r:context="teacher_schedule">#{teacher.lastname}, #{teacher.firstname}</label>

<br>		
<br>		
<br>		

<div r:type="week_calendar" r:context="teacher_schedule" r:model="model"></div>