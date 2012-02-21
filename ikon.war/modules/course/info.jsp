<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>


<t:popup>
	<jsp:attribute name="head">
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
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<ui:button context="courseinfo" action="save" caption="Save"/>
	</jsp:attribute>

	<jsp:body>
		<ui:form context="courseinfo" object="course">
			<ui:text name="code" caption="Code" required="true"/>
			<ui:text name="title" caption="Title" required="true"/>
			<ui:text name="units" caption="Units" required="true"/>
			<ui:combo name="classification" caption="Classification" items="classifications" required="true" allowNull="true"/>
		</ui:form>
	</jsp:body>
</t:popup>
