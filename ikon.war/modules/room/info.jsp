<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/ui" prefix="ui" %>
<%@ taglib tagdir="/WEB-INF/tags/controller" prefix="ctl" %>

<t:popup>
	<jsp:attribute name="rightactions">
		<ui:button caption="Save" action="save" context="roominfo"/>
	</jsp:attribute>
	
	<jsp:body>
		<ui:context name="roominfo" object="room">
		 
			<ctl:crudform  service="RoomAdminService"/>
			
			<ui:form>
				<ui:text caption="Room No" name="roomno" required="true" />
				<ui:text caption="Description" name="description" required="true"  size="50"/>
			</ui:form>
			
		</ui:context>
	</jsp:body>
</t:popup>
