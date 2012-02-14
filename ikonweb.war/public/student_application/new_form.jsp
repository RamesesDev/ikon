<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="common" %>

<%
	request.setAttribute("APPID", "SAAP" + new java.rmi.server.UID());
%>

<t:public redirect_session="false">
	<jsp:attribute name="head">
		<script src="${pageContext.servletContext.contextPath}/js/ext/datetime.js"></script>
	</jsp:attribute>

	<jsp:attribute name="style">
		.caption {
			font-size:12px;
			font-style:italic;
		}
		table {
			font-size:12px;
			font-family:'Arial'
		}
		table tr td {
			padding:3px;
		}
	</jsp:attribute>

	<jsp:body>
	
		
	<script>
		<common:loadmodules name="modules"/>
	
		$put("student_appform", 
			new function() {
				var self = this;
				
				this.selectedContact;
				
				this.student = {
					objid: "${APPID}",
					contactinfo:[],
					primaryaddress:{},
					secondaryaddress:{},
					fathersinfo:{},
					mothersinfo:{},
					guardianinfo:{},
				};
				
				this.otherCitizenship;
				this.otherCivilstatus;
				
				this.genderList = [ 
					{id:"M", label:"Male"}, 
					{id:"F", label:"Female"}
				];
				this.citizenshipList = ["Filipino", "American","German","Taiwanese"];
				this.civilStatusList = ["Single","Married","Divorced","Widowed"];
				
				this.studentTypeList = ["New Student","Transferee","Cross Enrollee","Returnee"];
				
				this.addressTypeList = ["Home","Work"];
				this.contactTypeList = ["HOMEPHONE", "WORKPHONE", "MOBILE", "HOMEFAX", "WORKFAX"];
				
				this.propertyChangeListener = {
					"otherCitizenship" : function(o) {
						if(self.student.citizenship === "others")
							self.student.citizenship = o;
					}
				}
				
				this.step = 1;
				this.submit = function() {
					if( this.step < 3 ) {
						this.step++;
						return;
					}
					
					MsgBox.confirm(
						'You are about to submit this application.\nPlease check all the entries. Proceed?',
						function() {
							var svc = ProxyService.lookup( "StudentApplicantService" );
							var result = svc.submit(  self.student );
							window.location.href = "success.jsp?objid=" + result.objid; 
						}
					);
				}
				
				this.back = function() {
					this.step--;
				}
				
				this.addContact = function() {
					this.student.contactinfo.push({type:"", value:""});
				}
				
				this.deleteContact = function() {
					this.student.contactinfo.remove(this.selectedContact);
				}
				
				this.lookupProgram = function() {
					return new PopupOpener("program:lookup",{selectHandler: function(o){
						self.student.program = o;
						self.student.programid = o.objid;
					}});
				}
			}
		);
	</script>
	
	<div style="width:95%;">
		<h2>Application for New Students</h2>		
		<div class="hr"></div>
		
		<div r:context="student_appform" r:visibleWhen="#{step == 1}">
			<div class="section" r:context="student_appform" r:type="label">
				<span style="font-weight:bold;">Program Information</span>
				<table>
					<tr>
						<td class="caption" align="right">
							Program Code
						</td>
						<td>
							<b>#{student.program.code}</b>
							<div style="position:absolute;top:-100px;left:-100px;">
								<input type="text" r:context="student_appform" r:name="student.programid" r:required="true" r:caption="Program"/>
							</div>
						</td>
					</tr>
					<tr>
						<td class="caption" align="right">
							Title
						</td>
						<td>
							<b>#{student.program.title}</b>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<button r:context="student_appform" r:name="lookupProgram" r:immediate="true">
								#{student.program ? 'Change' : 'Select'} Program
							</button>
						</td>
					</tr>
					<tr>
						<td class="caption" align="right">
							Student Type
						</td>
						<td>
							<select r:context="student_appform" r:name="student.apptype">
								<option value="New">New</option>
								<option value="Transferee">Transferee</option>
							</select>
						</td>
					</tr>
				</table>
			</div>
			
			<div class="hr"></div>
			
			<div class="section">
				<jsp:include page="personal.jsp"/>
			</div>
		</div>
		
		<div r:context="student_appform" r:visibleWhen="#{step == 2}">
			<div class="section">
				<span style="font-weight:bold;">Primary Address</span>
				<jsp:include page="address.jsp">
					<jsp:param name="address" value="student.primaryaddress"/>
				</jsp:include>
			</div>
			
			<div class="section">
				<span style="font-weight:bold;">Secondary Address</span>
				<jsp:include page="address.jsp">
					<jsp:param name="address" value="student.secondaryaddress"/>
				</jsp:include>
			</div>
		</div>

		<div r:context="student_appform" r:visibleWhen="#{step == 3}">
			<div class="section">
				<span style="font-weight:bold;">Mother's Information</span>
				<jsp:include page="personinfo.jsp">
					<jsp:param name="info" value="student.mothersinfo"/>
				</jsp:include>
			</div>
			
			<div class="section">
				<span style="font-weight:bold;">Father's Information</span>
				<jsp:include page="personinfo.jsp">
					<jsp:param name="info" value="student.fathersinfo"/>
				</jsp:include>
			</div>
			
			<div class="section">
				<span style="font-weight:bold;">Legal Guardian</span>
				<jsp:include page="personinfo.jsp">
					<jsp:param name="info" value="student.guardianinfo"/>
				</jsp:include>
			</div>
		</div>
		
		<div class="section">
			<button type="button" r:context="student_appform" r:name="back" r:visibleWhen="#{step>1}">Back</button>
			<button type="button" r:context="student_appform" r:name="submit" r:visibleWhen="#{step<3}">Proceed</button>
			<button type="button" r:context="student_appform" r:name="submit" r:visibleWhen="#{step==3}">Submit</button>
		</div>
	</jsp:body>
	
	
	
</t:public>