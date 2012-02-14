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
	$register( {id:"#programcourse_context_menu", context:"programinfo"} );

	$put( "programinfo", 
		new function() {
			var svc = ProxyService.lookup( "ProgramAdminService" );
		
			this.objid;
			this.program = <t:invoke service="ProgramAdminService" method="read" params="<%=request%>" json="true" />;
			
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
				return new PopupOpener("program:course", { programid: this.program.objid, mode: "create", saveHandler: reloadList });
			}
			
			this.showContextMenu = function() {
				return new DropdownOpener("#programcourse_context_menu");
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
			
			this.showPrerequisites = function() {
				this._controller.navigate( "_close" );
				var p = new PopupOpener("course:req", {programCourse:this.selectedCourse, reqtype: 0, saveHandler:reloadList } );	
				p.title = "Prerequisites for " + this.selectedCourse.coursecode;
				
				return p;
			}

			this.showCorequisites = function() {
				this._controller.navigate( "_close" );
				var p = new PopupOpener("course:req", {programCourse:this.selectedCourse, reqtype: 1, saveHandler:reloadList } );	
				p.title = "Corequisites for " + this.selectedCourse.coursecode;
				return p;
			}
			
		}
		
	);
</script>

<a r:context="programinfo" r:name="edit">Edit</a>&nbsp;&nbsp;&nbsp;
<a r:context="programinfo" r:name="addCourse">Add Course</a>
<br>
Code <label r:context="programinfo">#{program.code}</label>
<br>
Title <label r:context="programinfo">#{program.title}</label>

<table r:context="programinfo" r:name="selectedCourse" r:model="courseList" width="80%" r:varStatus="stat" r:varName="item" cellpadding="0" cellspacing="0">
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
		<tr r:context="programinfo" r:action="showContextMenu">
			<td class="cell">#{item.coursecode}</td>
			<td class="cell">#{item.coursetitle}</td>
			<td class="cell" align="center">#{item.units}</td>
			<td class="cell">#{item.remarks==null? '' : item.remarks}</td>
			<td class="cell">#{item.prerequisites!=null? item.prerequisites : '' }</td>
			<td class="cell">#{item.corequisites!=null?item.corequisites:''}</td>
		</tr>
		<tr r:visibleWhen="#{ (stat.nextItem==null) || (stat.nextItem.yearlevel!=item.yearlevel) || (stat.nextItem.term !=item.term) }">
			<td colspan="6" style="border-top:1px dashed gray;">-</td>
		</tr>				
	</tbody>
</table>	

<div id="programcourse_context_menu" style="display:none;">
	<label r:context="programinfo"><b>#{selectedCourse.coursecode}</b></label>
	<br>
	<a r:context="programinfo" r:name="editCourse">Edit</a>
	<br>
	<a r:context="programinfo" r:name="showPrerequisites" r:visibleWhen="#{ !(selectedCourse.yearlevel==1 && selectedCourse.term==1) }">Prerequisites</a>
	<div r:context="programinfo" r:visibleWhen="#{ !(selectedCourse.yearlevel==1 && selectedCourse.term==1)}"></div>
	<a r:context="programinfo" r:name="showCorequisites">Corequisites</a>
	<br>
	<a r:context="programinfo" r:name="removeCourse">Remove</a>
</div>
