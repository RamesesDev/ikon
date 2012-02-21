<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>


<t:popup>
	<jsp:attribute name="head">
		<style>
			.course-list tr.selected {
				background-color: orange;
				color: white;
			}
			</style>

		<script>
			
			$put( "course_lookup", 
				new function() {
					var svc = ProxyService.lookup( "CourseService" );
					
					var self = this;
					
					this.query = {}
					this.selectedItem;
					this.selectHandler;
					this.orgunit;
					
					this.listModel = {
						rows: 5,
						fetchList: function(o) {
							o.code = ( self.query.code ) ? self.query.code+"%" : null;
							return svc.getList( o );
						}
					}
					
					this.select = function() {
						this.selectHandler( this.selectedItem );
						return "_close";
					}
					
					this.search = function() {
						this.listModel.refresh(true);
					}
					
				}
			);
		</script>
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<ui:button context="course_lookup" action="add" caption="Add"/> 
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<ui:button context="course_lookup" action="select" caption="OK"/> 
	</jsp:attribute>
	
	<jsp:body>
		<ui:context name="course_lookup">
			<ui:panel cols="2">
				<ui:section>
					<ui:form>
						<ui:text caption="Code" name="query.code"/>
					</ui:form>
				</ui:section>
				<ui:section>
					<ui:button action="search" caption="Go"/> 
				</ui:section>
			</ui:panel>
			<ui:grid model="listModel" class="course-lookup">
				<ui:col caption="Course Code" name="code" width="100px"/>
				<ui:col caption="Course Title" name="title"/>
			</ui:grid>
		</ui:context>
	</jsp:body>
</t:popup>


