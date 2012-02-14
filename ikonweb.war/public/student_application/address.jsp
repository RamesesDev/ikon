<table cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td align="right">
			<span class="caption">Type:</span>
		</td>
		<td>
			<select r:context="student_appform" r:items="addressTypeList" r:name="${param.address}.type"></select>
		</td>
	</tr>
	<tr>
		<td align="right">
			<span class="caption">Address 1:</span>
		</td>
		<td>
			<input type="text"
				r:context="student_appform" r:name="${param.address}.address1" style="width:100%">
		</td>
	</tr>
	<tr>
		<td align="right">
			<span class="caption">Address 2:</span>
		</td>
		<td>
			<input type="text"
				r:context="student_appform" r:name="${param.address}.address2" style="width:100%">
		</td>
	</tr>
	<tr>
		<td align="right">
		</td>
		<td>
			<input type="text" r:context="student_appform" r:name="${param.address}.city" r:hint="City/Municipality">
			<input type="text" r:context="student_appform" r:name="${param.address}.province" r:hint="Province">
			<input type="text" r:context="student_appform" r:name="${param.address}.zipcode" r:hint="Zip Code" size="6">
		</td>
	</tr>
</table>