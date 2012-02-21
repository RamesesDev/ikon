<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>



<script>
	$put( "courseinfo", 
		new function() {
			var svc = ProxyService.lookup( "CourseService" );
			
			this.saveHandler;
			this.course = {}
			
			this.classifications = ["MAJOR","MINOR","GE"];
			
			this.save = function() {
				svc.update( this.course );
				if(this.saveHandler) this.saveHandler(this.course);
				return "_close";
			}
		}
	);
</script>


Code <input type="text" r:context="courseinfo" r:name="course.code" r:required="true" r:caption="Course Code" />
<br>
Title <input type="text" r:context="courseinfo" r:name="course.title" r:required="true" r:caption="Course Title" />
<br>
Units <input type="text" r:context="courseinfo" r:name="course.units" r:required="true" r:caption="Course Units" />
<br>
Classification <select r:context="courseinfo" r:name="course.classification" r:items="classifications" r:allowNull="true" 
	r:required="true" r:caption="Course Classification"></select>
<br>

<input type="button" r:context="courseinfo" r:name="save" value="Save"/>

