<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>


<t:content title="Enrollment">	
	<jsp:attribute name="head">
		<s:invoke service="StudentService" method="read" params="${SESSION_INFO}" var="STUDENT" debug="true"/>
		
		<script>
			$put(
				"enrollment", 
				new function() 
				{
					var self = this;
					var blocksvc = ProxyService.lookup("BlockScheduleService");;
					var events = <s:invoke service="SchoolEventService" method="getPhaseEvents" params="ENROLLMENT" debug="true" json="true"/>;
					
					this.message;
					this.schooltermid;
					
					this.schoolterms = [];
					
					this.onload = function() {
						if( events ) {
							var m = {};
							events.each(function(o){
								m[o.schooltermid] = {id: o.schooltermid, caption: "SY: " + o.schoolyear + " / Term: " + o.schoolterm};
							});
							for( var i in m )
								this.schoolterms.push( m[i] );
						}
					}
					
					this.listModel = {
						rows: 15,
						fetchList: function(o) {
							o.programid = '${STUDENT.programid}';
							o.schooltermid = self.schooltermid;
							return blocksvc.getBlockSchedules( o );
						}
					};
					
					this.propertyChangeListener = {
						'schooltermid': function() {
							self.listModel.load();
						}
					};
				}
			);
		</script>
	</jsp:attribute>

	<jsp:body>
		<ui:context name="enrollment">
			<ui:panel cols="2" width="100%">
				<ui:section>
					<ui:form>
						<ui:combo items="schoolterms" name="schooltermid" itemKey="id" itemLabel="caption" allowNull="true" caption="Select Schoolterm: "/>
					</ui:form>
				</ui:section>	
				<ui:section align="right">
					<a href="#enrollment:customize?objid=${STUDENT.objid}">Customize Schedule</a> 						
				</ui:section>
			</ui:panel>	

			<ui:grid model="listModel">
				<ui:col name="code" caption="Section" width="100px"/>
				<ui:col name="description" caption="Description"/>
				<ui:col align="center">
					<a href="#enrollment:schedule?objid=#{item.objid}">
						Select
					</a>
				</ui:col>
			</ui:grid>
		</ui:context>
	</jsp:body>
</t:content>