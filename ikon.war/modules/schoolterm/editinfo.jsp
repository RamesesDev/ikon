<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:popup>
	<jsp:attribute name="script">
		$put( "schoolterm", 
			new function() {
			
				this.saveHandler;
				this.schoolterm = {}
				
				this.save = function() {
					this.saveHandler(this.schoolterm);
					return "_close";
				}
				
				this.termList = [
					{key:"1", label: "1st Semester"},
					{key:"2", label: "2nd Semester"},
					{key:"5", label: "Summer"}
				];
				
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<ui:button context="schoolterm" caption="Save" action="save"/>
	</jsp:attribute>
	
	<jsp:body>
		<ui:form context="schoolterm" object="schoolterm">
			<ui:text caption="Year" name="year" required="true"/>
			<ui:combo caption="Semester" name="term" items="termList" itemKey="key" itemLabel="label" required="true" />
			<ui:date caption="From date" name="fromdate" required="true"/>
			<ui:date caption="To date" name="todate" required="true"/>
		</ui:form>
	</jsp:body>
</t:popup>

