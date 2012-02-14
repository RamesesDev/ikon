<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>



<script>
	$register( {id: "#student_applicant_approval", context:"studentapplicantinfo", options:{width:400,height:300} } );
	$put( "studentapplicantinfo", 
		new function() {
			this.info =  <s:invoke service="StudentApplicantService" method="read" params="<%=request%>" json="true" />;
			var self = this;
			this.showApproval = function() {
				var  p = new PopupOpener( "#student_applicant_approval" );
				p.title = "Approval for " + this.info.lastname + ", " + this.info.firstname;
				return p;
			}
			
			this.approve = function() {
				alert( "Alright yeah..." );
			}
			
			this.lookupProgram = function() {
				var handler = function(o) {
					self.info.programid = o.objid;
					self.info.programtitle = o.title;
					self.info.programcode = o.code;
					self._controller.refresh();
				}
				return new PopupOpener("program:lookup", {selectHandler: handler } );
			}
		}
	);
</script>

<div id="student_applicant_approval" style="display:none;">
	Enter Student No
	<br>
	<input type="text" r:context="studentapplicantinfo" r:name="info.studentno" r:required="true" r:caption="Student No"/>
	<br>
	<br>
	Select a Program
	<input type="button" r:context="studentapplicantinfo" r:name="lookupProgram" value="Program" r:immediate="true"/>
	<br>
	<label r:context="studentapplicantinfo" r:visibleWhen="#{info.programid!=null}">
		#{info.programcode} - #{info.programtitle}	
	</label>
	<br>
	<br>
	<input type="button" r:context="studentapplicantinfo" r:name="approve"  value="OK"/>	
</div>

<input type="button" r:context="studentapplicantinfo" r:name="showApproval"  value="Approve"/>
<br>


App No : <label r:context="studentapplicantinfo">#{info.objid}</label>
<br>

Last Name : <label r:context="studentapplicantinfo">#{info.lastname}</label>
<br>
First Name : <label r:context="studentapplicantinfo">#{info.firstname}</label>
<br>



