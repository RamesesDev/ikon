<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:popup>

	<jsp:attribute name="style">
		.grid tr.selected {
			background-color: orange;
		}
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put( "teacher_lookup",
			new function() {
			
				var svc = ProxyService.lookup( "TeacherService" );
				this.selectHandler;
				this.programid;
				this.selectedItem;
				var self = this;
				
				this.listModel = {
					rows: 10,
					fetchList: function(o) {
						if(self.programid) o.programid = self.programid;
						return svc.getList( o );	
					}
				}
				var reloadList = function() {
					self.listModel.refresh(true);	
				}
				
				this.select = function() {
					this.selectHandler(this.selectedItem);
					return "_close";
				}
			}
		);	
	</jsp:attribute>

	<jsp:attribute name="rightactions">
		<ui:button caption="Select" action="select" context="teacher_lookup"/>
	</jsp:attribute>
	
	<jsp:body>
		<ui:context name="teacher_lookup">
			<ui:grid model="listModel" width="100%">
				<ui:col caption="Last Name" name="lastname"/>
				<ui:col caption="First Name" name="firstname" />
			</ui:grid> 
		</ui:context>
	</jsp:body>
	
</t:popup>
	
		