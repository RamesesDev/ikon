<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/controller" prefix="ctl" %>


<t:content title="Program Adviser">

	<jsp:attribute name="script">
		$put( "program_adviser_list",
			new function() {
			
				var svc = ProxyService.lookup( "ProgramAdviserService" );
				var progSvc = ProxyService.lookup( "ProgramService" );
				
				var self = this;
				this.selectedItem;
				this.programList;
				this.program;
				this.schooltermid ="${param['schooltermid']}" ;
				
				this.onload = function() {
					this.programList = progSvc.getList({});
					if( this.programList && this.programList.length > 0 ) {
						this.program = this.programList[0];
					}
				}
				
				this.listModel = {
					rows: 10,
					fetchList: function(o) {
						if( !self.program ) return [];
						o.programid = self.program.objid;
						o.schooltermid = self.schooltermid;
						return svc.getList( o );	
					}
				}
				var reloadList = function() {
					self.listModel.refresh(true);	
				}
				
				this.add = function() {
					if( !this.program ) {
						throw new Error( 'Program must be provided' )
					}
					var t = function(o) {
						svc.create({schooltermid:self.schooltermid, adviserid: o.objid, programid: self.program.objid, yearlevel: 1 });
						self.listModel.refresh(true);
					}
					return new PopupOpener( "teacher:lookup", {selectHandler: t, programid: this.program.objid } );
				}
				
				this.removeEntry = function() {
					if( confirm("You are about to remove this entry. Continue?") ) {
						svc.remove(this.selectedItem);
						self.listModel.refresh(true);
					}
				}
			}
		);	
	</jsp:attribute>

	<jsp:body>
		<ui:context name="program_adviser_list">
			<ui:form>
				<ui:combo caption="Select a Program" items="programList" itemLabel="code" name="program" />
			</ui:form>
			<ui:button caption="Add" action="add"/>
			<ui:grid model="listModel" width="100%">
				<ui:col caption="Last Name" name="lastname" width="120"/>
				<ui:col caption="First Name" name="firstname" width="120"/>
				<ui:col caption="Program">#{item.programcode} - #{item.programtitle}</ui:col>
				<ui:col caption="Year" name="yearlevel" width="20"/>
				<ui:col><a r:context="${context}" r:name="removeEntry">Remove</a></ui:col>
			</ui:grid> 
		</ui:context>
	</jsp:body>
	
</t:content>
	
		