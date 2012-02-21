<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>


<t:popup>
	<jsp:attribute name="head">
		<style>
			tr.selected {
				background-color: orange;
				color: white;
			}
			thead td {
				background-color: lightgrey;
				font-weight: bolder;
			}
		</style>

		<script>
			$put( "program_lookup", 
				new function() {
					var svc = ProxyService.lookup( "ProgramService" );
					
					var self = this;
					
					this.query = {}
					this.selectedItem;
					this.selectHandler;
					
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

	<jsp:attribute name="rightactions">
		<ui:button context="program_lookup" action="select" caption="OK"/> 
	</jsp:attribute>
	
	<jsp:body>
		<ui:context name="program_lookup">
			<ui:panel cols="2">
				<ui:section>
					<ui:form>
						<ui:text caption="Code" name="query.code" />
					</ui:form>
				</ui:section>
				<ui:section>
					<ui:button action="search" caption="Go"/> 
				</ui:section>
			</ui:panel>
			<ui:grid model="listModel">
				<ui:col name="code" caption="Program Code"/>
				<ui:col name="title" caption="Program Title"/>
			</ui:grid>
		</ui:context>
	</jsp:body>
</t:popup>
