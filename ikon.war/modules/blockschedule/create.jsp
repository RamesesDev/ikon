<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:popup>

	<jsp:attribute name="script">
		$put( "blockschedule_create", 
			new function() {
				
				var svc = ProxyService.lookup( "BlockScheduleService" );
				
				this.schoolterm;
				this.saveHandler;
				this.block;
				this.program;
				this.yearLevels;
				
				var self = this;

				this.onload = function() {
					this.block = {};
					this.block.schooltermid = this.schoolterm.objid;
					this.block.term = this.schoolterm.term;
				}
				
				this.lookupProgram = function() {
					var h = function(o) {
						self.program = o;
						self.block.programid = o.objid;
						self.yearLevels = [];
						for( var i=0; i<o.yearlevels; i++){
							self.yearLevels.push(i+1);
						}
					}
					return new PopupOpener( "program:lookup", {selectHandler: h} );
				}
				
				this.save = function() {
					this.block = svc.saveBlock( this.block );
					this.saveHandler(this.block);
					return "_close";
				}
			}	
		);
	</jsp:attribute>

	<jsp:attribute name="rightactions">
		<ui:button context="blockschedule_create" caption="Save" action="save"/>
	</jsp:attribute>
	
	<jsp:body>
		<ui:context name="blockschedule_create">
			<ui:form object="block">
				<ui:text caption="Block Code" name="code" required="true"/>
				<ui:text caption="Description" name="description" required="true" size="60"/>
				<ui:label caption="Program" rtexpression="true">#{program.code} - #{program.title}</ui:label>
				<ui:label>
					<ui:button caption="Select Program" action="lookupProgram" immediate="true" />
				</ui:label>
				<ui:combo caption="Year Level" name="yearlevel" items="yearLevels" allowNull="true" required="true" />	
				<ui:label caption="Term" rtexpression="true">#{block.term}</ui:label>
			</ui:form>
		
		</ui:context>
		
	</jsp:body>

</t:popup>
