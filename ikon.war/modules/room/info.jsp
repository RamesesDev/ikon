<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/controller" prefix="ctl" %>

<ui:context name="roominfo" object="room">
 
	<ctl:crudform  service="RoomAdminService"/>
	
	<ui:form>
		<ui:text caption="Code" name="code" required="true" />
		<ui:text caption="Room No" name="roomno" required="true" />
		<ui:label>
			<ui:button caption="Save" action="save" />
		</ui:label>	
	</ui:form>
	
</ui:context>	
