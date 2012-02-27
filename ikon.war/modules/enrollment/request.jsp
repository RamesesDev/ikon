<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/common" prefix="com" %>


<t:content>
	
	<jsp:attribute name="title">
		Enrollment Request Form (SY ${param.year})
	</jsp:attribute>
	
	<jsp:attribute name="head">
		<s:invoke service="StudentService" method="read" params="${SESSION_INFO}" var="STUDENT" debug="true"/>
		<com:uid var="REQID" prefix="ENREQ"/>
	
		<script>
			$put( 
				"request",			
				new function() 
				{
					var self = this;
					var svc = ProxyService.lookup("EnrollmentService");
					
					this.request = {
						objid: '${REQID}',
						schooltermid: '${param.schooltermid}'
					};
					
					this.submit = function() {
						MsgBox.confirm(
							'You are about to submit this request.\nPlease verify that all entries correct. Proceed?',
							function() {
								location.href = 'home.jsp';
							}
						);
					}
				}	
			);
		</script>
	</jsp:attribute>
	
	<jsp:body>
		<ui:context name="request">
			<div>
				<ui:button action="submit" caption="Submit"/>
			</div>
			<ui:form styleClass="info-form">
				<ui:label caption="Student No. :">
					${STUDENT.studentno}
				</ui:label>
				<ui:label caption="Name :">
					${STUDENT.lastname}, ${STUDENT.firstname} ${STUDENT.middlename}
				</ui:label>
				<ui:label caption="Year :">
					${STUDENT.yearlevel}
				</ui:label>
				<ui:label caption="Remarks :">
					<textarea r:context="${context}" r:name="request.remarks" rows="5" cols="50"/>
				</ui:label>
			</ui:form>
		</ui:context>
	</jsp:body>


</t:content>