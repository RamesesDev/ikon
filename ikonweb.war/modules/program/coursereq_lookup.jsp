<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

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
	
	$put( "program_coursereq_lookup", 
		new function() {
			var svc = ProxyService.lookup( "ProgramService" );
			var self = this;
		
			this.selectHandler;
			this.course;
			this.selectedItem;
			
			this.query = {}
			this.reqtype = "0";
			
			this.listModel = {
				fetchList : function(o) {
					var p = {};
					p.programid = self.course.programid; 
					p.courseid = self.course.courseid;
					p.code = "%";
					p.yearlevel =  self.course.yearlevel;
					p.term =  self.course.term;
					p.reqtype = self.reqtype;
					return svc.lookupCourseRequisites( p );
				}
			}

			this.select = function() {
				var x = this.selectedItem;
				var p = {
					programid: self.course.programid, 
					courseid: self.course.courseid, 
					reqcourseid: x.courseid, 
					reqtype: self.reqtype,
					coursecode: x.coursecode,
					coursetitle: x.coursetitle						
				};
				this.selectHandler(p);
				return "_close";
			}
		}
	);
</script>

Code <input type="text" r:context="program_coursereq_lookup" r:name="query.code" />
<input type="button" r:context="program_coursereq_lookup" r:name="search" value="Go"/> 
<br>
<table r:context="program_coursereq_lookup" r:model="listModel" r:varName="item" r:name="selectedItem" width="100%">
	<thead>
		<td width="100">Course Code</td>
		<td>Course Title</td>
	</thead>
	<tbody>
		<td>#{item.coursecode}</td>
		<td>#{item.coursetitle}</td>
	</tbody>
</table>

<br>
<input type="button" r:context="program_coursereq_lookup" r:name="select" value="OK"/>
			
		