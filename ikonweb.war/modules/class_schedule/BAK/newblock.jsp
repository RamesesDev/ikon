<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>



<div id="programTpl" style="display:none;">
	<a>#{code} - #{title}</a>
</div>

Block Code <input type="text" r:context="blockinfo" r:name="blockinfo.block" r:required="true" r:caption="Block" />
<br>
Program <input type="text" r:context="blockinfo" r:name="programName" size="50"
	r:suggest="programCourse.programLookup" r:suggestName="programCourse.selectedProgram" 
	r:suggestExpression="#{code} - #{title}" r:suggestTemplate="programTpl" r:caption="Program"/>

<br>	
Year Level <select r:context="blockinfo" r:name="blockinfo.yearlevel" 
	r:depends="programCourse.selectedProgram"
	r:items="programCourse.yearLevels"></select>
<br/>


<br>
<input type="button" r:context="blockinfo" r:name="addBlock" value="Next"/>

