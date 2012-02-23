<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:content title="Personnel Information">
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
			$put( "personnelinfo", 
				new function() {
					this.info =  <s:invoke service="PersonnelService" method="read" params="${pageContext.request}" json="true" />;
				}
			);
		</script>

	</jsp:attribute>

	<jsp:body>
		<table width="100%" cellpadding="4">
			<tr>
				<td>
					<a class="headmenu">Information</a>
				</td>
				<td>
					<div r:type="label" r:context="personnelinfo">
						<a class="headmenu" href="#personnel:positions?objid=#{info.objid}">Positions<a/>
					</div>
				</td>
				<td width="100%">&nbsp;</td>
			</tr>
		</table>

		<ui:form context="personnelinfo">
			<ui:label rtexpression="true" caption="Staff No : ">
				#{info.staffno}
			</ui:label>
			<ui:label rtexpression="true" caption="Last Name : ">
				#{info.lastname}
			</ui:label>
			<ui:label rtexpression="true" caption="First Name : ">
				#{info.firstname}
			</ui:label>
		</ui:form>
	</jsp:body>
</t:content>
