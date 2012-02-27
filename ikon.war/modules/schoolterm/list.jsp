<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:content title="School Term Calendar">

	<jsp:attribute name="script">
		$put( "schooltermlist", 
			new function() {
				var svc = ProxyService.lookup( "SchoolTermAdminService" );
				
				var self = this;
				
				this.selectedItem;
				this.listModel = {
					rows: 10,
					fetchList: function(o) {
						return svc.getList( o );	
					}
				}
				
				this.add = function() {
					var f = function(o) {
						svc.create(o);
						self.listModel.refresh(true);	
					}
					return new PopupOpener( "schoolterm:edit", {saveHandler:f} );
				}
			}
		);
	</jsp:attribute>
	
	<jsp:body>
		<ui:context name="schooltermlist">
			<ui:button caption="Add" action="add"/>
			<ui:grid model="listModel">	
				<ui:col caption="Year" name="year"/>
				<ui:col caption="Sem" name="term"/>
				<ui:col caption="From Date" name="fromdate"/>
				<ui:col caption="To Date" name="todate"/>
				<ui:col caption="Status" name="status"/>
				<ui:col align="center"><a href="#schoolterm:info?objid=#{item.objid}">View</a></ui:col>
			</ui:grid>
		</ui:context>
	</jsp:body>

</t:content>

