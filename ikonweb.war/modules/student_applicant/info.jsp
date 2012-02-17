<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>



<script>
	$register( {id: "#student_applicant_approval", context:"studentapplicantinfo", options:{width:400,height:300} } );
	$put( "studentapplicantinfo", 
		new function() {
			this.info =  <s:invoke service="StudentApplicantService" method="read" params="<%=request%>" json="true" />;
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
						self.yearLevels.push( i+1);
					}
					self._controller.refresh();
				}
				return new PopupOpener("program:lookup", {selectHandler: handler } );
			}
			
			this.approve = function() {
				MsgBox.confirm( "You are about to accept this student. Continue?", function(){
					var svc = ProxyService.lookup( "StudentApplicantService" );
					svc.accept( self.info );
					MsgBox.alert( "Student successfully accepted" );
					window.location.hash = "student_applicant:list";
					self._controller.navigate("_close");
				});
			}
		}
	);
</script>

<style>
	.form th { text-align: right; font-weight:normal; }
	.form td { font-weight: bold; }
	.form td a { color: #06F; font-weight: normal; }
</style>

<button type="button" r:context="studentapplicantinfo" r:name="showApproval">Approve</button>
<div class="hr"></div>

<div r:context="studentapplicantinfo" r:type="label">
	<table class="form">
		<tr>
			<th>App. Type :</th>
			<td>#{info.apptype}</td>
		</tr>
		<tr>
			<th>App. No :</th>
			<td>#{info.objid}</td>
		</tr>
		<tr>
			<th>Last Name :</th>
			<td class="capitalized">#{info.lastname}</td>
		</tr>
		<tr>
			<th>First Name :</th>
			<td class="capitalized">#{info.firstname}</td>
		</tr>
	</table>
</div>



<div id="student_applicant_approval" style="display:none;">
	<div r:context="studentapplicantinfo" r:type="label">
		<table class="form">
			<tr>
				<th>Enter Student No:</th>
				<td>
					<input type="text" r:context="studentapplicantinfo" r:name="info.studentno" r:required="true" r:caption="Student No"/>
				</td>
			</tr>
			<tr>
				<th valign="top">Program:</th>
				<td valign="top">
					#{info.programid? info.programcode + ' - ' + info.programtitle : ''}
					&nbsp;
					#{info.programid? '<br>' : ''}
					<a r:context="studentapplicantinfo" r:name="lookupProgram" r:immediate="true">
						#{info.programid? 'Change' : 'Select'} Program
					</a>
				</td>
			</tr>
			<tr>
				<th>Year Level: </th>
				<td>
					<select r:context="studentapplicantinfo" r:items="yearLevels" r:name="info.yearlevel" 
					        r:allowNull="true" r:caption="Year Level" r:required="true"></select>  
				</td>
			</tr>
		</table>
	</div>
	
	<br/>
	<br/>
	<div class="align-r">
		<button r:context="studentapplicantinfo" r:name="approve">OK</button>
	</div>
</div>


