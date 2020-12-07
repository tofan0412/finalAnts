<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../layout/fullcalendarLib.jsp"%>

   
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
	
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, { 
		plugins: [ 'interaction', 'dayGrid', 'timeGrid' ], 
		defaultView: 'dayGridMonth', 
		defaultDate: new Date(),
		header: { left: 'prev,next today', center: 'title',  right : 'dayGridMonth,timeGridWeek,timeGridDay' },
		editable:true,
		eventLimit : true,
		droppable : true,
		dateClick: function(){
			 calendar.addEvent( {'title':'f', 'start':'2020-12-23', 'end':'2020-12-23'});
		},
		themeSystem: 'bootstrap',
		eventClick: function(info) {
		    alert('Event: ' + info.event.title);
		    alert('id: ' + info.event.id);
		    alert('Coordinates: ' + info.jsEvent.pageX + ',' + info.jsEvent.pageY);
		    alert('start day: ' + info.event.start);
		    alert('end day: ' + info.event.end);
		  },
		 eventDrop: function(info) {
				alert(info.event.title + " 를 " + info.event.start +" 로 이동 ");
			    if (!confirm("일정 변경을 저장하시겠습니까??")) {
			      info.revert();
			    }
			  },
	 	 eventResize: function(info) {
			alert(info.event.title + "를" + info.event.end+" 로 이동");

			if (!confirm("일정 변경을 저장하시겠습니까??")) {
			info.revert();
			}
	 	  },
		events: [
		        {
		          id :'1',
		          navLinks: true,
		          backgroundColor: '#f56954', //red
		          borderColor    : '#f56954', //red
		          allDay         : true,
		          title          : '달력끝내기',
		          start          : "2020-12-07",
		          end          : "2020-12-10"
		        },
		        {
		          id :'2',
		          navLinks: true,
		          backgroundColor: '#28a745', //red
		          borderColor    : '#28a745', //red
		          title          : '집',
		          start          : "2020-12-07"
		        },
		      ],
		
	});
	calendar.render();
	
	var currColor = '#3c8dbc';
	$("#color-chooser > li > a").on("click", function () {
		currColor = $(this).css('color')
	      // Add color effect to button
	      $('#add-new-event').css({
	        'background-color': currColor,
	        'border-color'    : currColor
	      })
	    })
		
	$("#add-new-event").on("click", function() {
		var addcalendar = $("#new-event").val();
		if (addcalendar.length == 0) {
	        return
	      }
		var event = $('<div />')
		event.css({
        'background-color': currColor,
        'border-color'    : currColor,
        'color'           : '#fff'
      }).addClass('external-event')
      event.text(addcalendar)
      $('#external-events').prepend(event)
	  $('#new-event').val('')
      $(".external-event").draggable({stop: function(){
    	  var x = $(".external-event").position().top;
    	  var y = $(".external-event").position().left;
    	  if(x!=null && y!=null){
    		  alert(x);
        	  alert(y);
        	  $(".external-event").remove();
    	  }
      }});
	})
	
	
	
});

</script>


<title>Insert title here</title>
</head>
<body>
 <div class="content-wrapper" style="min-height: 1230.88px;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Calendar</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Calendar</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

   <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-3">
            <div class="sticky-top mb-3">
              <div class="card">
                <div class="card-header">
                  <h4 class="card-title">Draggable Events</h4>
                </div>
                <div class="card-body">
                  <!-- the events -->
                  <div id="external-events">
                    
                    <div class="checkbox">
                      <label for="drop-remove">
                        <input type="checkbox" id="drop-remove">
                        remove after drop
                      </label>
                    </div>
                  </div>
                </div>
                <!-- /.card-body -->
              </div>
              <!-- /.card -->
              <div class="card">
                <div class="card-header">
                  <h3 class="card-title">Create Event</h3>
                </div>
                <div class="card-body">
                  <div class="btn-group" style="width: 100%; margin-bottom: 10px;">
                    <ul class="fc-color-picker" id="color-chooser">
                      <li><a class="text-primary" href="#"><i class="fas fa-square"></i></a></li>
                      <li><a class="text-warning" href="#"><i class="fas fa-square"></i></a></li>
                      <li><a class="text-success" href="#"><i class="fas fa-square"></i></a></li>
                      <li><a class="text-danger" href="#"><i class="fas fa-square"></i></a></li>
                    </ul>
                  </div>
                  <!-- /btn-group -->
                  <div class="input-group">
                    <input id="new-event" type="text" class="form-control" placeholder="Event Title">

                    <div class="input-group-append">
                      <button id="add-new-event" type="button" class="btn btn-primary">Add</button>
                    </div>
                    <!-- /btn-group -->
                  </div>
                  <!-- /input-group -->
                </div>
              </div>
            </div>
          </div>
          <!-- /.col -->
          <div class="col-md-9">
            <div class="card card-primary">
              <div class="card-body p-0">
                <!-- THE CALENDAR -->
                <div id="calendar" class="fc fc-media-screen fc-direction-ltr fc-theme-bootstrap">
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </section>
</body>
</html>