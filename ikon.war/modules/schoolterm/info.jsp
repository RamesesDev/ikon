<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/page" prefix="page" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<page:gantt-import/>
<s:invoke service="SchoolTermAdminService" method="read" params="<%=request%>" json="true" var="INFO"/>

<t:content title="School Term Calendar">

	<jsp:attribute name="script">
		$put( "schoolterminfo", 
			new function() {
				var svc = ProxyService.lookup( "SchoolTermAdminService" );
				this.objid;
				this.schoolterm  = ${INFO};
				this.selectedEntry;
				
				var self = this;
				
				this.edit = function() {
				
				}
				
				var reloadModel = function() {
					self.model.load();
				}
				
				this.addEntry = function() {
					return new PopupOpener("schoolterm:entry", { schooltermid: this.schoolterm.objid, mode: "create", saveHandler: reloadModel });
				}
				
				this.model = {
					fetchList: function() {
						var list = svc.getEntries( {schooltermid : self.schoolterm.objid} );
						var arr = [];
						for( var i=0; i<list.length; i++ ) {
							var x = list[i];
							arr.push( {from:x.fromdate, to:x.todate, caption:x.title } );
						}
						return arr;
					}	
				}
				
			}
			
		);
	</jsp:attribute>
		
	<jsp:body>
		
		<ui:context name="schoolterminfo">
			<ui:form object="schoolterm">
				<ui:label caption="Year / Term" rtexpression="true">#{schoolterm.year} / #{schoolterm.term}</ui:label>	
				<ui:label caption="Period" rtexpression="true">#{schoolterm.fromdate} to #{schoolterm.todate}</ui:label>	
			</ui:form>
			<ui:button caption="Edit" action="edit"/>
			<ui:button caption="Add Entry" action="addEntry"/>
		</ui:context>
		
		
		<div r:context="schoolterminfo" r:type="gantt" r:model="model" r:width="600" 
			r:showNoOfDays="false" r:from="#{schoolterm.fromdate}" r:to="#{schoolterm.todate}"></div>
	</jsp:body>	

</t:content>

