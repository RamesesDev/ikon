<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="cui" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>

<t:popup>
	<jsp:attribute name="head">
		<s:invoke service="RoleService" method="getAllPermissions" params="${param['role']}" var="INFO" debug="true"/>
		<script>
		
			$put("role_permission",
				new function() {
					var svc = ProxyService.lookup( "RoleService" );
					this.rolename = "${param['role']}";
					this.included = <cui:tojson value="${INFO.included}"/>;
					this.savePermissions = function() {
						svc.updatePermissions( {name:this.rolename, included: this.included} );
						return "_close";	
					}
			
					//bind items
					this.onload = function() {
						var allcbox = $('input.all-modules').change(function(){
							if( this.checked )
								$('input.modulename').attr('checked', 'checked');
							else
								$('input.modulename').removeAttr('checked');
							$('input.modulename').trigger('change');
						});
				
						$('div.module').each(function(idx,mod){
							var modcbox = $(mod).find('input.modulename');
							modcbox.change(function(){
								if( this.checked )
									$('input.workunit', mod).attr('checked', 'checked');
								else {
									$('input.workunit', mod).removeAttr('checked');
									allcbox.removeAttr('checked');
								}
								$('input.workunit', mod).trigger('change');
							});
					
							$(mod).find('tr.item').each(function(idx,row){
								var rowcbox = $(row).find('input.workunit');
								var items = $(row).find('input.action');
						
								rowcbox.change(function(){
									if( this.checked )
										items.attr('checked', 'checked');
									else {
										items.removeAttr('checked');
										modcbox.removeAttr('checked');
										allcbox.removeAttr('checked');
									}
									items.trigger('change');
								});
						
								items.change(function() {
									if( this.checked ) return;
									rowcbox.removeAttr('checked');
									modcbox.removeAttr('checked');
									allcbox.removeAttr('checked');
								});
							});
						});
					}
					
				}
			);
		</script>

		<style>
			.role_permission .row-header 
			{
				padding-left: 0;
			}
			.role_permission td 
			{ 
				border-right: solid 1px #ccc; 
			}
		</style>
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<ui:button context="role_permission" action="savePermissions" caption="Save"/>
	</jsp:attribute>
	
	<jsp:body>
	<ui:form context="role_permission">
		<ui:label caption="Role : ">
			<b>${param['role']}</b>
		</ui:label>
	</ui:form>
	<input type="checkbox" class="all-modules"/>
	All Modules
	<div class="hr"></div>
	
	<c:forEach items="${INFO.modules}" var="m" varStatus="stat">
		<c:if test="${stat.index > 0}">
			<br/>
		</c:if>
		<div class="module">
			<h2>
				<input type="checkbox" class="modulename" id="${m.modulename}"/>
				${m.moduletitle}
			</h2>
			<table class="grid role_permission" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100px">
						Entity Name
					</td>
					<c:set var="count" value="${0}"/>
					<c:forEach items="${m.cols}" var="col">
						<c:set var="count" value="${count+1}"/>
						<td align="center" width="50px">
							${col}
						</td>
					</c:forEach>
					<c:if test="${count < 10}">
						<c:forEach begin="${count}" end="${10-1}">
							<td align="center" width="50px">
								&nbsp;
							</td>
						</c:forEach>
					</c:if>
				</tr>
				<c:forEach items="${m.rows}" var="row">
					<tr class="item">
						<td valign="top" class="row-header">
							<input type="checkbox" class="workunit" id="${m.modulename}:${row}"/> 
							${row}
						</td>
						<c:set var="count" value="${0}"/>
						<c:forEach items="${m.cols}" var="col">
							<c:set var="count" value="${count+1}"/>
							<c:set var="id">${m.modulename}:${row}.${col}</c:set>
							<td align="center" valign="top">
								<c:if test="${! empty m.index[id]}">
									<input type="checkbox" class="action" id="${id}"
											r:context="role_permission" r:name="included" r:mode="set" r:checkedValue="${id}" />
								</c:if>
							</td>	
						</c:forEach>
						<c:if test="${count < 10}">
							<c:forEach begin="${count}" end="${10-1}">
								<td align="center">
									&nbsp;
								</td>
							</c:forEach>
						</c:if>
					</tr>
				</c:forEach>
			</table>
		</div>
	</c:forEach>
	</jsp:body>
</t:popup>
