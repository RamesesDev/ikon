<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>
	$put( "roominfo", 
		new function() {
			
			this.saveHandler;
			this.room = {}
			this.mode = "create";
			
			this.save = function() {
				this.saveHandler(this.room);
				return "_close";
			}
		}
	);
</script>

Code <input type="text" r:context="roominfo" r:name="room.code" r:required="true" r:caption="Code"/>

<br>
Room No <input type="text" r:context="roominfo" r:name="room.roomno" r:required="true" r:caption="Room No" />
<br>

<input type="button" r:context="roominfo" r:name="save" value="Save"/>

