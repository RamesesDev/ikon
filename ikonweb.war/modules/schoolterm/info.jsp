<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="t" %>

<style>
	.col {
		font-size:11px;
		background-color: lightgrey;color:gray;
		border-bottom: 1px solid gray;
		font-weight:bolder;
		text-align:center;
		padding:2px;
		padding-left:4px;
		border-right:1px solid gray;
	}
	.cell {
		font-size:11px;
		border-right:1px solid lightgrey;
		padding:2px;
		padding-left:4px;
	}
	.group-head {
		font-size:11px;
		padding-top:15px;
		font-weight: bolder;
		color:red;
	}
</style>
		
<script>
	
	$put( "schoolterminfo", 
		new function() {
			var svc = ProxyService.lookup( "SchoolTermAdminService" );
			this.objid;
			this.schoolterm  = <t:invoke service="SchoolTermAdminService" method="read" params="<%=request%>" json="true" />;
			this.selectedEntry;
			
			var self = this;
			
			this.edit = function() {
			
			}
			
			var reloadList = function() {
				self.entryList.refresh(true);
			}
			
			this.addEntry = function() {
				return new PopupOpener("schoolterm:entry", { schooltermid: this.schoolterm.objid, mode: "create", saveHandler: reloadList });
			}
			
			this.entryList = {
				fetchList : function(o) {
					return svc.getEntries( {schooltermid : self.schoolterm.objid} );
				}
			}
		}
		
	);
</script>

<a r:context="schoolterminfo" r:name="edit">Edit</a>&nbsp;&nbsp;&nbsp;
<a r:context="schoolterminfo" r:name="addEntry">Add Entry</a>
<br>
Year <label r:context="schoolterminfo">#{schoolterm.year}</label>
<br>
Term <label r:context="schoolterminfo">#{schoolterm.term}</label>

<br>
Fromdate <label r:context="schoolterminfo">#{schoolterm.fromdate}</label>
<br>
To date <label r:context="schoolterminfo">#{schoolterm.todate}</label>

<table r:context="schoolterminfo" r:name="selectedEntry" r:model="entryList" width="40%" r:varStatus="stat"
	r:varName="item" cellpadding="0" cellspacing="0" border="1">
	<thead>
		<tr>
			<td>Phase</td>
			<td>From date</td>
			<td>To date</td>
		</tr>
	</thead>	
	<tbody>
		<tr>
			<td>#{item.phase}</td>
			<td>#{item.fromdate}</td>
			<td>#{item.fromdate}</td>
		</tr>
	</tbody>
</table>	

