<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>	
	$put( "class_list", 
		new function() {
			var svc = ProxyService.lookup( "ClassService" );
			var self = this;
			
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
				return new PopupOpener("class_schedule:editblock", {saveHandler: f } );
			}
			this.addClass = function() {
				return new PopupOpener("class_schedule:edit");
			}
		}
	);
	
	function formatSchedule(arr) {
		if(!arr) return "";
		var str = "";
		var a = arr.split(";");
		for( var i=0;i< a.length;i++ ) {
			if(i>0) str += "<br>";
			str += a[i];
		}	
		return str;
	}
</script>


<input type="button" value="Add Block" r:context="class_list" r:name="addBlock" />
<input type="button" value="Add Class" r:context="class_list" r:name="addClass" />
<br>

<table r:context="class_list" r:model="listModel" r:varName="item" r:varStatus="stat" r:name="selectedItem" border="1" width="80%">
	<thead>
		<tr>
			<td>Class Code</td>
			<td>Block</td>
			<td>Course</td>
			<td>Schedule</td>
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
			<td>#{item.schedules.join('<br>')}</td>
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
			
		