<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script src="${pageContext.servletContext.contextPath}/js/apps/SkedUtil.js"></script>

<script>
	$put( "scheduling_dow_schedule",
		new function() {
			this.schedule = {};
			this.saveHandler;
			this.DOW = new SkedUtil();
			this.fromtime;
			this.totime;
			
			this.onload = function() {
				this.DOW.initDays( this.schedule.days_of_week );
				this.fromtime = this.DOW.createTime( this.schedule.fromtime );
				this.totime = this.DOW.createTime( this.schedule.totime );
			}

			this.save = function() {
				this.schedule.days_of_week = this.DOW.daysToNumber();
				
				this.schedule.days = this.DOW.daysToString();
				this.schedule.fromtime = this.fromtime.toNumber();
				this.schedule.totime = this.totime.toNumber();
				
				if( this.schedule.days_of_week == 0 ) throw new Error("Please specify at least one day of the week"); 
				if( this.schedule.fromtime == 0 ) throw new Error("From time must be specified"); 
				if( this.schedule.totime == 0 ) throw new Error("To time must be specified");
				if( this.schedule.totime < this.schedule.fromtime ) throw new Error("To time must be greater than from time");
				
				if(this.saveHandler) this.saveHandler( this.schedule );
				return "_close";
			}
			
		}	
	);
</script>

<table width="100%">
	<tr>
		<td valign="top">
			<input type="checkbox" r:context="scheduling_dow_schedule" r:name="DOW.mon" />Mon<br>
			<input type="checkbox" r:context="scheduling_dow_schedule" r:name="DOW.tue" />Tue<br>
			<input type="checkbox" r:context="scheduling_dow_schedule" r:name="DOW.wed" />Wed<br>
			<input type="checkbox" r:context="scheduling_dow_schedule" r:name="DOW.thu" />Thu<br>
			<input type="checkbox" r:context="scheduling_dow_schedule" r:name="DOW.fri" />Fri<br>
			<input type="checkbox" r:context="scheduling_dow_schedule" r:name="DOW.sat" />Sat<br>
			<input type="checkbox" r:context="scheduling_dow_schedule" r:name="DOW.sun" />Sun<br>
		</td>
		<td valign="top">
			From Time : <select r:context="scheduling_dow_schedule" r:name="fromtime.hour" r:items="DOW.getHours()"/>
				:<select r:context="scheduling_dow_schedule" r:name="fromtime.minute" r:items="DOW.getMinutes(15)"/>
			<br>
			To Time : <select r:context="scheduling_dow_schedule" r:name="totime.hour" r:items="DOW.getHours()"/>
				:<select r:context="scheduling_dow_schedule" r:name="totime.minute" r:items="DOW.getMinutes(15)"/>
		</td>
	</tr>
	<tr>
		<td colspan="2" valign="top">
			<input type="button" r:context="scheduling_dow_schedule" r:name="save" value="Save"/>
		</td>
	</tr>
</table>
