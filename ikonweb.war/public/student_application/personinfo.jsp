<table>
	<tr>
		<td align="right">
			<span class="caption">Name:</span>
		</td>
		<td>
			<input type="text" size="40"
				r:context="student_appform" r:name="${param.info}.name">
		</td>
	</tr>
	<tr>
		<td align="right">
			<span class="caption">Occupation:</span>
		</td>
		<td>
			<input type="text" r:context="student_appform" r:name="${param.info}.occupation">
		</td>
	</tr>
	<tr>
		<td align="right">
			<span class="caption">Address:</span>
		</td>
		<td>
			<input type="text" size="50"
				r:context="student_appform" r:name="${param.info}.address">
		</td>
	</tr>
	<tr>
		<td align="right">
			<span class="caption">Phone:</span>
		</td>
		<td>
			<input type="text" r:context="student_appform" r:name="${param.info}.phone">
		</td>
	</tr>
</table>