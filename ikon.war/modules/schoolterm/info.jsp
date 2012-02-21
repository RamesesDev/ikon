<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/page" prefix="page" %>

<page:gantt-import/>

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
			
			this.events = [
						{from:"2012-01-01", to:"2012-01-10", caption:"Enrollment for 1st years"},
						{from:"2012-01-05", to:"2012-01-15", caption:"Enrollment for graduating" },
					];
			
			this.model = {
				fetchList: function() {
					return self.events;
				}	
			}
			
			this.editEvent = function() {
				this.events[1].to = '2012-01-18';
				this.events[1].caption = 'Enrollment for graduate students';
				this.model.load();
			}
			
			this.addEvent = function() {
				this.events.push( {from:"2012-01-10", to:"2012-01-15", caption:"Start Classes", color:"orange" } );
				this.model.load();
			}
			
			this.removeEvent = function() {
				this.events.remove( this.events[1] );
				this.model.load();
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
<input type="button" r:context="schoolterminfo" value="Add Event" r:name="addEvent"/>
<input type="button" r:context="schoolterminfo" value="Edit Event" r:name="editEvent"/>
<input type="button" r:context="schoolterminfo" value="Remove Event" r:name="removeEvent"/>


<div r:context="schoolterminfo" r:type="gantt" r:model="model" r:width="600" r:showNoOfDays="false"></div>
