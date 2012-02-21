<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>


<t:popup>
	<jsp:attribute name="head">
		<script>
			$put( "program_create", 
				new function() {
				
					var svc = ProxyService.lookup( "ProgramService" );
				
					this.orgunit;
					this.saveHandler;
					this.program = {}
					
					this.save = function() {
						this.program.orgunitid = this.orgunit.objid;
						this.program = svc.create(this.program);
						this.saveHandler(this.program);
						return "_close";
					}
					
				}
			);
		</script>
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<ui:button context="program_create" action="save" caption="Save"/>
	</jsp:attribute>

	<jsp:body>
		<ui:form context="program_create" object="program">
			<ui:label caption="Academic Org. Unit" rtexpression="true">
				<b>#{orgunit.code} - #{orgunit.title}</b>
			</ui:label>
			<ui:text caption="Code" name="code" required="true"/>
			<ui:text caption="Title" name="title" required="true" size="70"/>
			<ui:text caption="Rev. Year" name="revyear" required="true" size="4" maxlength="4"/>
			<ui:text caption="Year Levels" name="yearlevels" required="true" size="2" maxlength="2"/>
		</ui:form>
	</jsp:body>
</t:popup>
