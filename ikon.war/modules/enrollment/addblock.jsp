<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:popup>

	<jsp:attribute name="style">
		.grid tr.selected {
			background-color: orange;
		}
	</jsp:attribute>

	<jsp:attribute name="script">
		$put( "enrollment_customize_addblock", 
			new function() {
			
				var svc = ProxyService.lookup("EnrollmentService");
				this.studentid = "${SESSION_INFO.objid}";
				this.schooltermid = "${param['schooltermid']}";
				
				this.saveHandler;
				this.selectedBlock;
				var self = this;
				
				this.blocks;
				
				this.onload = function() {
					var v = {studentid: this.studentid, schooltermid: this.schooltermid};
					this.blocks = svc.getAvailableBlocks(v);
				}
				
				this.listModel = {
					fetchList : function(x) {
						if( !self.selectedBlock) return [];
						return svc.getBlockSchedules( {blockid: self.selectedBlock.objid} );
					}
				}
				
				this.propertyChangeListener = {
					"selectedBlock": function(x) {
						self.listModel.refresh(true);
					}
				}
				
				this.save = function() {
				    if( !this.selectedBlock ) alert( "Please select a block" );
					var p = {
						studentid: this.studentid,
						blockid: this.selectedBlock.objid 
					}
					this.saveHandler( p );	
					return "_close";
				}
			}
		);	
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<ui:button caption="Add Block" action="save" context="enrollment_customize_addblock"/>						
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div id="sked_template" style="display:none;">
			#{it.fromtime}-#{it.totime} #{it.days} 
		</div>
	</jsp:attribute>
	
	<jsp:body>
		<ui:context name="enrollment_customize_addblock">
			<ui:panel cols="2" width="100%" height="300">
				<ui:section width="150">
					<b>Block Schedules</b><br>
					<select r:items="blocks" r:name="selectedBlock" r:context="${context}" 
						r:itemLabel="blockcode" style="width:100%;height:100%" size="15"></select>
				</ui:section>
				<ui:section>
					<label r:context="${context}" r:depends="selectedBlock">
						<b>Block Code:</b> &nbsp;#{selectedBlock.blockcode}<br>
					</label> 
					<ui:grid model="listModel">
						<ui:col caption="Class Code" name="coursecode"/>
						<ui:col caption="Schedule / Room">#{$template('sked_template', item.schedules, true )}</ui:col>
						<ui:col caption="Seats Alloc." name="max_seats"/>
						<ui:col caption="Pending" name="pending"/>
						<ui:col caption="Enrolled" name="enrolled"/>
						<ui:col caption="Program">#{item.programcode}</ui:col>
					</ui:grid>
				</ui:section>
			</ui:panel>
		</ui:context>
	</jsp:body>
	
</t:popup>