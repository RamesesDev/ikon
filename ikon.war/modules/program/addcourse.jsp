<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:popup>
	<jsp:attribute name="head">
		<script>
			
			$put( "program_addcourse", 
				new function() {
					var svc = ProxyService.lookup( "ProgramService" );
					this.program;
					this.course;
					this.saveHandler;
					this.courseid;
					var self = this;
					this.yearlevels;
					this.selectedCourse;
					
					this.onload = function() {
						this.course = {programid:this.program.objid}
						this.yearlevels = [];
						for( var i=0; i<this.program.yearlevels; i++ ) {
							this.yearlevels.push(i+1);
						}	
					}	
					
					this.save = function() {
						if( !this.selectedCourse ) {
							alert("Please select a course" );
						}	
						else {	
							svc.addProgramCourse( this.course );
							if(this.saveHandler) this.saveHandler();
							return "_close";
						}
					}
					
					this.lookupCourse = function() {
						var h = function(x) {
							self.selectedCourse = x;
							self.course.courseid = x.objid;
							self.course.units = x.units;
						}
						return new PopupOpener( "course:lookup", {selectHandler: h,  orgunit:{objid: this.program.orgunitid} } );
					}
					
					this.termList = [
						{key:"1", label: "1st Semester"},
						{key:"2", label: "2nd Semester"},
						{key:"5", label: "Summer"}
					];
					
				}
			);
		</script>
	</jsp:attribute>

	<jsp:attribute name="rightactions">
		<ui:button context="program_addcourse" action="save" caption="Save"/>
	</jsp:attribute>
		
	<jsp:body>
		<ui:context name="program_addcourse">
			<ui:form object="course">
				<ui:label caption="Course Code" rtexpression="true" depends="selectedCourse" required="true">
					#{selectedCourse.code}
				</ui:label>
				<ui:label rtexpression="true" depends="selectedCourse">
					#{selectedCourse.title}
				</ui:label>
				<ui:label rtexpression="true" depends="selectedCourse">
					<ui:button action="lookupCourse" immediate="true">
						#{!course.courseid? 'Select' : 'Change'} Course
					</ui:button>
				</ui:label>
				<ui:combo name="yearlevel" caption="Year Level" required="true" items="yearlevels" allowNull="true"/>
				<ui:combo name="term" caption="Term / Semester" required="true" itemKey="key" itemLabel="label" items="termList" allowNull="true"/>
				<ui:text name="units" caption="Units" depends="selectedCourse" size="1" maxlength="1"/>
				<ui:text name="lab_hrs" caption="Lab Hrs" size="1" maxlength="1"/>
				<ui:text name="lec_hrs" caption="Lec Hrs" size="1" maxlength="1"/>
				<ui:text name="remarks" caption="Remarks"/>
			</ui:form>
		</ui:context>
	</jsp:body>
</t:popup>