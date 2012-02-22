<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:content title="Student Applications">
	<jsp:attribute name="head">
		<script>
	
			$put( "studentapplicantlist", 
				new function() {
					var svc = ProxyService.lookup( "StudentApplicantService" );
					var self = this;
					this.selectedItem;
			
					this.listModel = {
						rows: 10,
						fetchList: function(o) {
							return svc.getList( o );	
						}
					}
					var reloadList = function() {
						self.listModel.refresh(true);	
					}
				}
			);
		</script>
	</jsp:attribute>

	<jsp:body>
		<ui:context name="studentapplicantlist">
			<ui:grid model="listModel" name="selectedItem" width="80%">
				<ui:col caption="App. No" name="objid"/>
				<ui:col caption="Last Name" name="lastname"/>
				<ui:col caption="First Name" name="firstname"/>
				<ui:col>
					<a href="#student_applicant:info?objid=#{item.objid}">View</a>
				</ui:col>
			</ui:grid>
		</ui:context>
	</jsp:body>
</t:content>
		
