<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>
	$put( "courseinfo", 
		new function() {
			var svc = ProxyService.lookup( "CourseService" );
			
			this.saveHandler;
			this.course = {}
			this.orgunitid;
			this.mode = "create";
			
			this.save = function() {
				if( this.mode == "create" ) {
					this.course.orgunitid = this.orgunitid;
					svc.create( this.course );
				}
				else {
					svc.update( this.course );
				}
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

<input type="button" r:context="courseinfo" r:name="save" value="Save"/>

