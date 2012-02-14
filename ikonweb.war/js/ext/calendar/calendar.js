
BindingUtils.handlers.div_monthcalendar = function( elem, controller, idx ) 
{
	var e = $(elem);
	var model = controller.get(R.attr(elem, "model"));
	
	$(elem).fullCalendar(
		{
			defaultView: "month",
			editable: (model.editable == true),
			events: model.events
		}
	);
}

BindingUtils.handlers.div_weekcalendar = function( elem, controller, idx ) 
{
	var e = $(elem);
	var model = controller.get(R.attr(elem, "model"));
	var d = 1;
	var m = 0;
	var y = 2012;
	
	var calendarModel = [];
	
	build();
	function build() {
		var events = model.fetchList();
		events.start = {};
		events.end = {};
		e.fullCalendar( 'destroy' );
		
		for(var i=0 ; i<events.length ; i++) {
			var temp = [];
			var day = events[i].day.toUpperCase();
			
			events[i].start = breakProtoTime(events[i].from);
			events[i].end = breakProtoTime(events[i].to);
			
			if(day == "SUN") {
				temp.start = new Date(y, m, d, events[i].start.hr, events[i].start.min);
				temp.end = new Date(y, m, d, events[i].end.hr, events[i].end.min);
			} else if(day == "MON") {
				temp.start = new Date(y, m, d+1, events[i].start.hr, events[i].start.min);
				temp.end = new Date(y, m, d+1, events[i].end.hr, events[i].end.min);
			}else if(day == "TUE") {
				temp.start = new Date(y, m, d+2, events[i].start.hr, events[i].start.min);
				temp.end = new Date(y, m, d+2, events[i].end.hr, events[i].end.min);
			}else if(day == "WED") {
				temp.start = new Date(y, m, d+3, events[i].start.hr, events[i].start.min);
				temp.end = new Date(y, m, d+3, events[i].end.hr, events[i].end.min);
			}else if(day == "THU") {
				temp.start = new Date(y, m, d+4, events[i].start.hr, events[i].start.min);
				temp.end = new Date(y, m, d+4, events[i].end.hr, events[i].end.min);
			}else if(day == "FRI") {
				temp.start = new Date(y, m, d+5, events[i].start.hr, events[i].start.min);
				temp.end = new Date(y, m, d+5, events[i].end.hr, events[i].end.min);
			}else if(day == "SAT") {
				temp.start = new Date(y, m, d+6, events[i].start.hr, events[i].start.min);
				temp.end = new Date(y, m, d+6, events[i].end.hr, events[i].end.min);
			}
		
			calendarModel.push(
				{
					id: events[i].id,
					title: events[i].caption,
					start: temp.start,
					end: temp.end,
					allDay: false,
					color: events[i].color
				}
			);
		}
	
		var calendar = $(elem).fullCalendar(
			{
				events: calendarModel,
				defaultView: model.view == "basic" ? "basicWeek" : "agendaWeek",
				editable: (model.editable == true),
				columnFormat: "ddd",
				titleFormat: "",
				allDaySlot: false,
				header: { right:'', },
				year:2012,
				month:0,
				date:1,
				slotMinutes: 15,
				minTime: model.minTime ? model.minTime : 6,
				maxTime: model.maxTime ? model.maxTime : 18,
				selectable: false,
				selectHelper: true,
				select: function(start, end, allDay) {
					
				},
				eventClick : function(event, element) {
					if(model.eventClick) 
						model.eventClick(event);
				},
				eventDragStart : function( event, jsEvent, ui, view ) { 
					if(model.eventDragStart)
						model.eventDragStart(event);
				},
				eventDragStop : function( event, jsEvent, ui, view ) { 
					if(model.eventDragStop)
						model.eventDragStop(event);
				},
				eventDrop : function( event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view ) { 
					if(model.eventDrop)
						model.eventDrop(event);
				},
				eventResizeStart : function( event, jsEvent, ui, view ) { 
					if(model.eventResizeStart)
						model.eventResizeStart(event);
				},
				eventResizeStop : function( event, jsEvent, ui, view ) { 
					if(model.eventResizeStop)
						model.eventResizeStop(event);
				},
				eventResize : function( event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view ) {
					if(model.eventResize)
						model.eventResize(event);
				}
			}
		);
	}
	
	model.load = function() {
		build();
	}
	
	function breakProtoTime( time ) {
		return { 
			hr:Math.floor(time/100),
			min: time % 100
		};
	}
}

BindingUtils.handlers.div_daycalendar = function( elem, controller, idx ) 
{
	var e = $(elem);
	var model = controller.get(R.attr(elem, "model"));
	

	
	$(elem).fullCalendar(
		{
			defaultView: model.view == "basic" ? "basicDay" : "agendaDay",
			editable: (model.editable == true),
			events: model.events
		}
	);
}
