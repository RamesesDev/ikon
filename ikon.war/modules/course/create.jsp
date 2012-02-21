<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>


<t:popup>
	<jsp:attribute name="head">
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
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<input type="button" r:context="course_create" r:name="save" value="Save"/>
	</jsp:attribute>

	<jsp:body>
		<ui:form context="course_create" object="course">
			<ui:label caption="Org Unit" rtexpression="true">
				<b>#{orgunit.code} - #{orgunit.title}</b> 
			</ui:label>
			<ui:text name="code" required="true" caption="Course Code"/>
			<ui:text name="title" required="true" caption="Course Title" size="50"/>
			<ui:text name="units" required="true" caption="Units"/>
			<ui:combo name="classification" items="classifications" required="true" caption="Classification" allowNull="true"/>
		</ui:form>
	</jsp:body>
</t:popup>

