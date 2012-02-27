<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/controller" prefix="ctl" %>


<t:content title="Program Adviser">

	<jsp:attribute name="head">
	 <script>
		$register({id:'#program-adviser-info', context:'program_adviser_list', title:'Select Year Level'});
		$put( "program_adviser_list",
			new function() {
			
				var svc = ProxyService.lookup( "ProgramAdviserService" );
				var progSvc = ProxyService.lookup( "ProgramService" );
				
				var self = this;
				this.selectedItem;
				this.programList;
				this.program;
				this.schooltermid ="${param['schooltermid']}" ;
				
				this.adviser;
				
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

					var teacherHandler = function(o) {
						self.adviser = {schooltermid:self.schooltermid, adviserid: o.objid, programid: self.program.objid, yearlevel: 0};
						self._controller.navigate(new PopupOpener('#program-adviser-info'));
					}
					return new PopupOpener( "teacher:lookup", {selectHandler: teacherHandler, programid: this.program.objid });
				}
				
				this.saveAdviser = function() {
					svc.create(this.adviser);
					self.listModel.refresh(true);
					return '_close';
				}
				
				this.removeEntry = function() {
					MsgBox.confirm(
						"You are about to remove this entry. Continue?",
						function() {
							svc.remove(self.selectedItem);
							self.listModel.refresh(true);
						}
					);
				}
				
				this.getYearLevels = function() {
					var list = [{lbl:'All', val: 0}];
					for(var i=1; i<=this.program.yearlevels; ++i) {
						list.push({lbl: i+'', val: i});
					}
					return list;
				}
			}
		);
	 </script>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div id="program-adviser-info" style="display:none">
			<t:popup>
				<jsp:attribute name="rightactions">
					<ui:button context="program_adviser_list" action="saveAdviser" caption="Save"/>
				</jsp:attribute>
				
				<jsp:body>
					<ui:context name="program_adviser_list">
						<ui:form>
							<ui:combo items="getYearLevels()" name="adviser.yearlevel" caption="Year Level" itemKey="val" itemLabel="lbl"/>
						</ui:form>
					</ui:context>
				</jsp:body>
			</t:popup>
		</div>
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
				<ui:col caption="Year" width="20" align="center">
					#{item.yearlevel? item.yearlevel : 'All'}
				</ui:col>
				<ui:col><a r:context="${context}" r:name="removeEntry">Remove</a></ui:col>
			</ui:grid> 
		</ui:context>
	</jsp:body>
	
</t:content>
	
		