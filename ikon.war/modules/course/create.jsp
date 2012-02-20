<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>
	$put( "course_create", 
		new function() {
			var svc = ProxyService.lookup( "CourseService" );
			
			this.saveHandler;
			this.course = {}
			this.orgunit;
			
			this.classifications = ["MAJOR","MINOR","GE"];
			
			this.save = function() {
				this.course.orgunitid = this.orgunit.objid;
				svc.create( this.course );
				if(this.saveHandler) this.saveHandler(this.course);
				return "_close";
			}
		}
	);
</script>

<label r:context="course_create">
	Org Unit : <b>#{orgunit.code} - #{orgunit.title}</b> 
</label> 
<br>

Code <input type="text" r:context="course_create" r:name="course.code" r:required="true" r:caption="Course Code" />
<br>
Title <input type="text" r:context="course_create" r:name="course.title" r:required="true" r:caption="Course Title" />
<br>
Units <input type="text" r:context="course_create" r:name="course.units" r:required="true" r:caption="Course Units" />
<br>
Classification <select r:context="course_create" r:name="course.classification" r:items="classifications" r:allowNull="true"
	r:required="true" r:caption="Course Classification"></select>
<br>

<input type="button" r:context="course_create" r:name="save" value="Save"/>

