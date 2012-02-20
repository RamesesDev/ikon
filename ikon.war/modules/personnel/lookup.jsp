<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	$put( "personnellookup", 
		new function() {
			var svc = ProxyService.lookup( "PersonnelService" );
			this.selectHandler;
			this.selectedItem;
			this.myname;
			
			this.select = function() {
				this.selectHandler( this.selectedItem );
				return "_close";
			}
			
			this.lookupName = function(x) {
				return svc.getList( {lastname: x+"%"} );
			}
		}
	);
</script>

Enter Last name
<input type="text" r:context="personnellookup" r:suggestName="selectedItem" r:name="myname" 
	r:suggestExpression="#{lastname}, #{firstname}" r:suggest="lookupName"/> 
<br>
<br/>	
<input type="button" r:context="personnellookup" r:name="select" value="Select"/>			
		