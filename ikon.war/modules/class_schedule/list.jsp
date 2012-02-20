<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>


<%
	Map m = new HashMap();
	m.put( "objid", request.getParameter("schooltermid"));
	request.setAttribute( "PARAMS", m );
%>

<script>	
	$put( "class_list", 
		new function() {
			var svc = ProxyService.lookup( "ClassScheduleService" );
			var self = this;
			
			this.schoolterm = <s:invoke service="SchoolTermAdminService" method="read" params="${PARAMS}" json="true" />
			
			this.selectedItem;
			this.listModel = {
				rows: 10,
				fetchList: function(o) {
					o.schooltermid = "${param['schooltermid']}";
					return svc.getList( o );	
				}
			}
			this.addBlock = function() {
				var f = function(o) {
					window.location.hash = "class_schedule:blockinfo?objid="+o.objid;
				}
				return new PopupOpener("class_schedule:addblock", {schoolterm:this.schoolterm, saveHandler: f } );
			}
		}
	);
</script>

<div id="schedule-formatter" style="display:none;">
    #{it.fromtime}-#{it.totime} #{it.days} #{(it.roomno)? '(' + it.roomno + ')': ''}<br> 
</div>

<input type="button" value="Add Block" r:context="class_list" r:name="addBlock" />
<br>

<table r:context="class_list" r:model="listModel" r:varName="item" r:varStatus="stat" r:name="selectedItem" border="1" width="100%">
	<thead>
		<tr>
			<td>Class Code</td>
			<td>Block</td>
			<td>Course</td>
			<td>Schedule/Room</td>
			<td>Teacher</td>
			<td>Program</td>
			<td>&nbsp;</td>
		</tr>
	</thead>
	<tbody>
		<tr r:visibleWhen="#{ item.coursecode ==null }">
			<td colspan="4">
				<a href="#class_schedule:blockinfo?objid=#{item.blockid}">
					Unfinished block #{item.blockcode}
				</a>
			</td>
			<td>#{item.programcode}</td>
			<td>&nbsp;</td>
		</tr>
		<tr r:visibleWhen="#{ item.coursecode !=null }">
			<td>#{item.code}</td>
			<td>
				<div r:context="class_list" r:visibleWhen="#{item.blockcode!=null}">
					#{item.blockcode}
				</div>
			</td>
			<td>#{item.coursecode}</td>
			<td>#{ $template('schedule-formatter', item.schedules, true ) }</td>
			<td>#{ (item.teacher) ? item.teacher : '' }</td>
			<td>#{item.programcode}</td>
			<td>
				<div r:context="class_list" r:visibleWhen="#{item.blockid != null}" style="display:none;">
					<a href="#class_schedule:blockinfo?objid=#{item.blockid}">View Block</a>
				</div>
				<div r:context="class_list" r:visibleWhen="#{item.blockid == null}" style="display:none;">
					<a href="#class_schedule:info?objid=#{item.objid}">View Class</a>
				</div>
			</td>
		</tr>
	</tbody>
</table>
			
		