<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:content title="Student Application">
	<jsp:attribute name="head">
		<script src="${pageContext.request.contextPath}/js/apps/PersonInfo.js"></script>
		
		<script>
			$register( {id: "#student_applicant_approval", context:"studentapplicantinfo", options:{width:400,height:300} } );
			$put( "studentapplicantinfo", 
				new function() {
					this.info =  <s:invoke service="StudentApplicantService" method="read" params="${pageContext.request}" json="true" debug="true"/>;
					var self = this;
					
					this.yearLevels = [];
					
					this.onload = function() {
						if( this.info.programid ) {
							for(var i=0; i<this.info.programyearlevels; ++i) {
								this.yearLevels.push( i+1 );
							}
						}
					}
					
					this.showApproval = function() {
						var  p = new PopupOpener( "#student_applicant_approval" );
						p.title = "Approval for " + this.info.lastname + ", " + this.info.firstname;
						return p;
					}
					
					this.lookupProgram = function() {
						var handler = function(o) {
							self.info.programid = o.objid;
							self.info.programtitle = o.title;
							self.info.programcode = o.code;
							self.yearLevels = [];
							for( var i=0; i < o.yearlevels; i++ ) {
								self.yearLevels.push( i + 1);
							}
							self._controller.refresh();
						}
						return new PopupOpener("program:lookup", {selectHandler: handler } );
					}
					
					this.approve = function() {
						if( confirm( "You are about to accept this student. Continue?") ) {
							var svc = ProxyService.lookup( "StudentApplicantService" );
							svc.accept( this.info );
							alert( "Student successfully accepted" );
							window.location.hash = "student_applicant:list";
							return "_close";
						}
					}
				}
			);
		</script>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div id="student_applicant_approval" style="display:none;">
			<t:popup>
				<jsp:attribute name="rightactions">
					<ui:button context="studentapplicantinfo" action="approve"  caption="Approve"/>	
				</jsp:attribute>
				<jsp:body>
					<ui:form context="studentapplicantinfo" object="info">
						<ui:label caption="Program Code:" required="true" rtexpression="true">
							#{info.programcode}
						</ui:label>
						<ui:label rtexpression="true">
							#{info.programtitle}	
						</ui:label>
						<ui:label rtexpression="true" depends="">
							<ui:button action="lookupProgram" immediate="true">
								#{info.programcode? 'Change' : 'Select'} Program
							</ui:button>
						</ui:label>
						<ui:text name="studentno" required="true" caption="Student No"/>
						<ui:combo name="yearlevel" items="yearLevels" allowNull="true" required="true" caption="Year Level"/>
					</ui:form>
				</jsp:body>
			</t:popup>
		</div>
	</jsp:attribute>
	
	<jsp:body>
		<ui:context name="studentapplicantinfo">
			<ui:button action="showApproval"  caption="Approve"/>
			<ui:panel cols="2">
				<ui:section width="300px">
					<ui:form styleClass="info-form">
						<ui:label caption="App. No. :" rtexpression="true">
							#{info.appno}
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
					<div r:context="studentapplicantinfo" r:type="label">
						<img class="student-photo" src="${pageContext.request.contextPath}/photo/temp/#{info.objid}"/>
						<div>Profile Photo</div>
					</div>
				</ui:section>
			</ui:panel>
		</ui:context>
	</jsp:body>
</t:content>



