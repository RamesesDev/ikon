<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/app" prefix="app" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>


<t:content title="Student - Information">
	<jsp:attribute name="head">
		<script src="${pageContext.request.contextPath}/js/apps/PersonInfo.js"></script>

		<script>
			$put( "studentinfo", 
				new function() {
					this.info =  <s:invoke service="StudentService" method="read" params="${pageContext.request}" json="true" />;
				}
			);
		</script>
	</jsp:attribute>
	
	<jsp:body>
		<app:studentinfo objid="${param['objid']}"/>

		<ui:context name="studentinfo">
			<ui:panel cols="2">
				<ui:section width="300px">
					<ui:form styleClass="info-form">
						<ui:label caption="Student No. :" rtexpression="true">
							#{info.studentno}
						</ui:label>
						<ui:label caption="Last Name :" rtexpression="true">
							#{info.lastname}
						</ui:label>
						<ui:label caption="First Name :" rtexpression="true">
							#{info.firstname}
						</ui:label>
						<ui:label caption="Middle Name :" rtexpression="true">
							#{info.middlename}
						</ui:label>
						<ui:label caption="Gender :" rtexpression="true">
							#{info.gender=='M'? 'Male' : info.gender=='F'? 'Female' : ''}
						</ui:label>
						<ui:label caption="Citizenship :" rtexpression="true">
							#{info.citizenship}
						</ui:label>
						<ui:label caption="Civil Status :" rtexpression="true">
							#{info.civilstatus}
						</ui:label>
						<ui:label caption="Place of Birth :" rtexpression="true">
							#{info.birthplace}
						</ui:label>
						<ui:label caption="Date of Birth :" rtexpression="true">
							#{info.birthdate}
						</ui:label>
						<ui:label caption="Email Address :" rtexpression="true">
							#{info.email}
						</ui:label>
						<ui:label caption="Religion :" rtexpression="true">
							#{info.religion}
						</ui:label>
						<ui:label caption="Primary Address :" rtexpression="true">
							#{PersonInfo.formatAddress(info.primaryaddress)}
						</ui:label>
					</ui:form>
				</ui:section>
				<ui:section align="center">
					<div r:type="label" r:context="studentinfo">
						<img class="student-photo" src="${pageContext.request.contextPath}/photo/profile/#{info.objid}"/>
						<div>Profile Photo</div>
					</div>
				</ui:section>
			</ui:panel>
		</ui:context>
	</jsp:body>
</t:content>

