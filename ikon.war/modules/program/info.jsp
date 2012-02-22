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
	$put( "programinfo", 
		new function() {
			var svc = ProxyService.lookup( "ProgramService" );
		
			this.objid;
			this.program = <t:invoke service="ProgramService" method="read" params="<%=request%>" json="true" />;
			
			var self = this;
			
			this.selectedCourse;
			this.courses;
			
			this.edit = function() {
				var f = function(o) {
					self.program = o;
				}
				return new PopupOpener("program:edit", { saveHandler:f, program: this.program,mode:'edit' });
			}
			
			this.courseList = {
				fetchList : function(o) {
					self.courses = svc.getProgramCourses( {objid:self.program.objid} );
					return self.courses;
				}
			}
			
			var reloadList = function() {
				self.courseList.refresh(true);
			}
			
			this.addCourse = function() {
				return new PopupOpener("program:addcourse", { program: this.program, saveHandler: reloadList });
			}
			
			this.editCourse = function() {
				alert( 'editing course ' + $.toJSON(this.selectedCourse) );
				return "_close";
			}
			
			this.removeCourse = function() {
				if(confirm("You are about to remove this entry. Continue?")) {
					svc.removeProgramCourse( this.selectedCourse );
					this.courseList.refresh(true);
				}
				return "_close";
			}
			
			var _addRequisite = function(o) {
				svc.addCourseRequisite( o );
				reloadList();
			}
			
			this.addPrerequisite = function() {
				return new DropdownOpener( "program:coursereq_lookup", {selectHandler: _addRequisite, reqtype: "0",
					course: this.selectedCourse} );
			}
			
			this.addCorequisite = function() {
				return new DropdownOpener( "program:coursereq_lookup", {selectHandler:  _addRequisite, reqtype: "1",
					course: this.selectedCourse} );
			}
			
			this.showReqList = function(reqList) {
				var arr = [];
				if( reqList ) reqList.each(function(o){ arr.push(o.coursecode); });
				return arr.join(', ');
			} 
		}
		
	);
</script>

<a r:context="programinfo" r:name="edit">Edit</a>&nbsp;&nbsp;&nbsp;
<a r:context="programinfo" r:name="addCourse">Add Course</a>
<br>
Code : <label r:context="programinfo">#{program.code}</label>
<br>
Title : <label r:context="programinfo">#{program.title}</label>
<br>
No. of year levels : <label r:context="programinfo">#{program.yearlevels}</label>
<br>
<table r:context="programinfo" r:name="selectedCourse" r:model="courseList" width="100%" r:varStatus="stat" r:varName="item" cellpadding="0" cellspacing="0">
	<tbody>
		<tr r:visibleWhen="#{ (stat.prevItem==null) || (stat.prevItem.yearlevel != item.yearlevel) || (stat.prevItem.term != item.term) }">
			<td class="group-head" colspan="6">Year Level: #{item.yearlevel} &nbsp;&nbsp;&nbsp;&nbsp;Sem: #{item.term}</td>
		</tr>
		<tr r:visibleWhen="#{ (stat.prevItem==null) || (stat.prevItem.yearlevel != item.yearlevel) || (stat.prevItem.term != item.term) }">
			<td class="col" width="50">Code</td>
			<td class="col" width="220">Course</td>
			<td class="col" width="50">Units</td>
			<td class="col">Remarks</td>
			<td class="col">Prerequisites</td>
			<td class="col">Corequisites</td>
		</tr>
		<tr r:context="programinfo">
			<td class="cell">#{item.coursecode}</td>
			<td class="cell">#{item.coursetitle}</td>
			<td class="cell" align="center">#{item.units}</td>
			<td class="cell">#{item.remarks==null? '' : item.remarks}</td>
			<td class="cell">
				#{item.prerequisites!=null? showReqList(item.prerequisites) : '' }
				<a r:context="programinfo" r:name="addPrerequisite" r:immediate="true" r:visibleWhen="#{item.yearlevel+item.term!=2}">
					[Add]
				</a>
			</td>
			<td class="cell">
				#{item.corequisites!=null? showReqList(item.corequisites):''}
				<a r:context="programinfo" r:name="addCorequisite" r:immediate="true" r:visibleWhen="#{item.yearlevel+item.term!=2}">
					[Add]
				</a>
			</td>
		</tr>
		<tr r:visibleWhen="#{ (stat.nextItem==null) || (stat.nextItem.yearlevel!=item.yearlevel) || (stat.nextItem.term !=item.term) }">
			<td colspan="6" style="border-top:1px dashed gray;">-</td>
		</tr>				
	</tbody>
</table>	
