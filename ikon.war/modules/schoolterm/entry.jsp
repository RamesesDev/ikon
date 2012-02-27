<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:popup>
	<jsp:attribute name="script">
		$put( "schooltermentry", 
			new function() {
				var svc = ProxyService.lookup( "SchoolTermAdminService" );
				this.entry;	
				this.phaseList;
				this.schooltermid;
				this.saveHandler;
				
				this.onload = function() {
					this.entry = { schooltermid: this.schooltermid };	
					this.phaseList = svc.getPhaseList();
				}	
				
				this.save = function() {
					svc.addEntry( this.entry );
					if(this.saveHandler) this.saveHandler();
					return "_close";
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<ui:button caption="Save" action="save" context="schooltermentry" />
	</jsp:attribute>
	
	<jsp:body>
		<ui:context name="schooltermentry">
			<ui:form object="entry">
				<ui:combo caption="Phase" items="phaseList" allowNull="true" required="true" name="phaseid" itemKey="objid" itemLabel="description"/>
				<ui:text caption="Title" name="title" size="80"/>
				<ui:date name="fromdate" caption="From Date"/>
				<ui:date name="todate" caption="To Date"/>
			</ui:form>	

			<div r:context="${context}" r:visibleWhen="#{entry.phaseid == 'ENROLLMENT'}" r:depends="entry.phaseid">
				<h2>Enrollment Settings</h2>
				<ui:form object="entry">
					<ui:text name="programid" caption="Program"/>
					<ui:combo name="yearlevel" caption="Year Level">
						<option value="0">Any</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</ui:combo>
				</ui:form>
			</div>
			
		</ui:context>
	</jsp:body>
	
	
</t:popup>


