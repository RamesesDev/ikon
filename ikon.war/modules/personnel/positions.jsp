<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:content title="Personnel Positions">
	<jsp:attribute name="head">
		<style>
			.headmenu {
				background-color:red;
				padding:4px;
				padding-right:8px;
				padding-left:8px;
				color:white;
				font-size:11px;
			}
		</style>

		<script>
			$put( "personnelpositions", 
				new function() {
					this.objid;
					this.positions = <s:invoke service="PersonnelService" method="getPositions" params="${param.objid}" json="true" />;
				}
			);
		</script>
	</jsp:attribute>
	<jsp:body>
		<table width="100%" cellpadding="4">
			<tr>
				<td>
					<div r:type="label" r:context="personnelpositions">
						<a class="headmenu" href="#personnel:info?objid=#{objid}">Information<a/>
					</div>
				</td>
				<td>
					<a class="headmenu">Positions<a/>
				</td>
				<td width="100%">&nbsp;</td>
			</tr>
		</table>
		<ui:context name="personnelpositions">
			<ui:grid items="positions">
				<ui:col name="code" caption="Code" width="20%"/>
				<ui:col name="title" caption="Title"/>
				<ui:col name="role" caption="Role"/>
			</ui:grid>
		</ui:context>
	</jsp:body>
</t:content>
