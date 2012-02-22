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
		<ui:grid context="studentapplicantlist" model="listModel">
			<ui:col name="appno" caption="App. No."/>
			<ui:col name="lastname" caption="Last Name"/>
			<ui:col name="firstname" caption="First Name"/>
			<ui:col name="programcode" caption="Program"/>
			<ui:col>
				<a href="#student_applicant:info?objid=#{item.objid}">View</a>
			</ui:col>
		</ui:grid>
	</jsp:body>
</t:content>