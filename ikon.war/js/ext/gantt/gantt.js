

BindingUtils.handlers.div_gantt = function( elem, controller, idx ) 
{
	var e = $(elem);
	var model = controller.get(R.attr(elem, "model"));
	var width = R.attr(elem, "width");
	var showWeekend = R.attr(elem, "showWeekend");
	var cellWidth = R.attr(elem, "cellWidth");
	var cellHeight = R.attr(elem, "cellHeight");
	var showNoOfDays = R.attr(elem, "showNoOfDays");
	var ganttViewModel = [];
	var term = [];
	
	var fromexp = R.attr(elem, "from");
	if(fromexp)
		model.from = fromexp.evaluate(controller.code);
		
	var toexp = R.attr(elem, "to");
	if(toexp)
		model.to = toexp.evaluate(controller.code);
	
	build();	
	function build() {
		term = [];
		ganttViewModel = [];
		e.empty();
		var events = model.fetchList();
		
		if(events.length == 0 ) {
			ganttViewModel = [];
		} else {
			for(var i=0 ; i<events.length ; i++) {
				ganttViewModel.push(
					{
						name: events[i].caption,
						start: buildDate(events[i].from),
						end: buildDate(events[i].to),
						color: events[i].color
					}
				);
			}
		}
		term.push( {series:ganttViewModel });
		e.ganttView(
			{
				data: term,
				from: model.from == null ? null : buildDate(model.from),
				to: model.to == null ? null : buildDate(model.to),
				slideWidth: width,
				showWeekends: showWeekend == null ? false : showWeekends,
				cellWidth: cellWidth,
				cellHeight: cellHeight,
				behavior: {
					clickable: model.clickable == null ? false : model.clickable,
					draggable: model.draggable == null ? false : model.draggable,
					resizable: model.resizable == null ? false : model.resizable,
					onClick: function(data, elem) {
						if(model.onclick)
							model.onclick(data, elem);
					},
					onDrag: function(data, elem) {
						if(model.ondrag)
							model.ondrag(data, elem);
					},
					onResize: function(data, elem){
						if(model.onresize)
							model.onresize(data, elem);
					}
				}
			}
		);
		
		//removes the EVENT HEADER
		var vtheader = e.find('div.ganttview-vtheader-item-name').remove();
		//set the (Month/Year)HEADER AND EVENT FONT COLOR
		e.find('div.ganttview-block-text').css( "color", "black" );

		//erases the text indicating the amount of days depending on : showNoOfDays
		if(showNoOfDays == "" || showNoOfDays == null)
			showNoOfDays = "false";
		
		//you can insert here the innerHtml/innerText of the EVENT displayed on the component
		if(showNoOfDays != "true") {
			var block_text = e.find('div.ganttview-block-text');
			for(var bt=0 ; bt<block_text.length ; bt++) {
				block_text[bt].innerText = "";
			}
		}
	}
	
	model.load = function() {
		build();
	}
	
	function buildDate(date) {
		var year= date.substring(0, date.indexOf("-"));
		var _month = date.replace(year+"-", "");
		var month = _month.substring(0, _month.indexOf("-"));
		var day = _month.substring(_month.lastIndexOf("-")+1, _month.length);
		return new Date(year, month-1, day);
	}
}

