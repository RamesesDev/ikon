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
					
					this.message;
					this.schooltermid = "${param['schooltermid']}";
					
					this.listModel = {
						rows: 15,
						fetchList: function(o) {
							o.programid = '${STUDENT.programid}';
							o.schooltermid = self.schooltermid;
							return blocksvc.getBlockSchedules( o );
						}
					};
				}
			);
		</script>
	</jsp:attribute>

	<jsp:body>
		<ui:context name="enrollment">
			<ui:panel width="100%">
				<ui:section align="right">
					<a href="#enrollment:customize?schooltermid=${param['schooltermid']}&objid=${STUDENT.objid}">Customize Schedule</a> 						
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