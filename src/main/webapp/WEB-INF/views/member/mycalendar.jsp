<%@page import="java.util.ArrayList"%>
<%@page import="ants.com.board.memBoard.model.ScheduleVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../layout/fullcalendarLib.jsp"%>
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<%
	List<ScheduleVo> list = (ArrayList<ScheduleVo>)request.getAttribute("showSchedule");
%>   
<script type="text/javascript">
function ini_events(ele) {
    ele.each(function () {

      // create an Event Object (https://fullcalendar.io/docs/event-object)
      // it doesn't need to have a start or end
      var eventObject = {
        title: $.trim($(this).text()) // use the element's text as the event title
      }

      // store the Event Object in the DOM element so we can get to it later
      $(this).data('eventObject', eventObject)

      // make the event draggable using jQuery UI
      $(this).draggable({
        zIndex        : 1070,
        revert        : true, // will cause the event to go back to its
        revertDuration: 0  //  original position after the drag
      })

    })
  }
  
function calendarInsert(title, start, calcss) {
	$.ajax({
		url : "/schedule/calendarInsert",
		method : "get",
		data : {
			scheTitle : title,
			startDt : start,
			calendarcss : calcss
		},
		success : function(data) {
		}

	});

}

function calendarUpdate(id, title, start, end) {
	$.ajax({
		url : "/schedule/calendarUpdate",
		method : "get",
		data : {
			scheId : id,
			scheTitle : title,
			startDt : start,
			endDt : end
		},
		success : function(data) {
		}

	});

}
function calendarUpdate2(id, title, start) {
	$.ajax({
		url : "/schedule/calendarUpdate",
		method : "get",
		data : {
			scheId : id,
			scheTitle : title,
			startDt : start
		},
		success : function(data) {
		}

	});

}

function calendarDetail(id) {
	$.ajax({
		url : "/schedule/calendarDetail",
		method : "get",
		data : {
			scheId : id
		},
		success : function(data) {
			$("#scheId").val(data.scheduleVo.scheId);
			$("#memId").val(data.scheduleVo.memId);
			$("#scheTitle").val(data.scheduleVo.scheTitle);
			$("#scheCont").html(data.scheduleVo.scheCont);
			
			if(data.scheduleVo.endDt != null){
				$("#startDt").val(data.scheduleVo.startDt +" ~ "+ data.scheduleVo.endDt);
			}
			
			if(data.scheduleVo.endDt == null){
				$("#startDt").val(data.scheduleVo.startDt +" ~ "+ data.scheduleVo.startDt);
			}
			
			if(data.scheduleVo.juso ==null){
				$("#injuso").hide();
			}
			if(data.scheduleVo.juso !=null){
				$("#juso").val(data.scheduleVo.juso);
			}
		}

	});

}
function calendarDelete(id) {
	$.ajax({
		url : "/schedule/calendarDelete",
		method : "get",
		data : {
			scheId : id
		},
		success : function(data) {
		}

	});

}



  ini_events($('#external-events div.external-event'))
document.addEventListener('DOMContentLoaded', function() {
	$("#modalbtn").hide();
	var Calendar = FullCalendar.Calendar;
	var Draggable = FullCalendar.Draggable;
	var containerEl = document.getElementById('external-events');
	var checkbox = document.getElementById('drop-remove');
	var calendarEl = document.getElementById('calendar');
	
	var calendar = new FullCalendar.Calendar(calendarEl, { 
		plugins: [ 'interaction', 'dayGrid', 'timeGrid' ], 
		defaultView: 'dayGridMonth', 
		defaultDate: new Date(),
		header: { left: 'prev,next today', center: 'title',  right : 'dayGridMonth,timeGridWeek,timeGridDay' },
		editable: true,
		eventLimit : true,
		droppable: true, 
	    selectable: true,
	    draggable :true,
		themeSystem: 'bootstrap',
		displayEventTime: false,
		eventClick: function(info) {
			var scheIdz = info.event.id;
			$("#modalbtn").trigger("click");
			$("#scheId").append(scheIdz);
			calendarDetail(scheIdz);
		  },
		eventDrop: function(info) {
			    if (!confirm("일정 변경을 저장하시겠습니까??")) {
			      info.revert();
			    }else{
			    	if(info.event.end!=null){
			    		var start = moment(info.event.start).format('YYYY-MM-DD');
			    		var end = moment(info.event.end).format('YYYY-MM-DD');
					      calendarUpdate(info.event.id, info.event.title, start, end);			    	
					    }
					if(info.event.end==null){
			    		var start = moment(info.event.start).format('YYYY-MM-DD');
					      calendarUpdate2(info.event.id, info.event.title, start);			    				 		
					 	}
			    }
			  },
			  eventDragStop: function (info) {
				    var trashEl = jQuery('.calendarTrash');
				    var ofs = trashEl.offset();
				    var x1 = ofs.left;
				    var x2 = ofs.left + trashEl.outerWidth(true);
				    var y1 = ofs.top;
				    var y2 = ofs.top + trashEl.outerHeight(true);
				    var x = info.jsEvent.pageX;
		 	    	var y = info.jsEvent.pageY;
				    if (x >= x1 && x <= x2 &&
				        y >= y1 && y <= y2) {
				    	info.event.remove();
				    	calendarDelete(info.event.id);
				    }
				},
		events: [
		        <%
		         for(int i =0; i<list.size(); i++){
		        	 ScheduleVo dto = (ScheduleVo)list.get(i);
		         
		        %>
				{
					id : '<%= dto.getScheId()%>',
					navLinks: true,
					title : '<%= dto.getScheTitle()%>',
					backgroundColor: '<%= dto.getCalendarcss()%>',
					start: '<%= dto.getStartDt()%>',
					end: '<%= dto.getEndDt()%>'
				},
				<%
		         }
				%>
					
		      ]
		
	});
	calendar.render();
	
	var currColor = '#0073b7';
	$("#color-chooser > li > a").on("click", function () {
		currColor = $(this).css('color')
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
        	  $(".external-event").remove();
        	  $('.fc-day').mouseover( function () {
        	       var sel = $(this).closest('.fc-day');
        	       var strDate_yyyy_mm_dd = sel.data('date');
        	       calendar.addEvent( {'title':addcalendar, 'start':strDate_yyyy_mm_dd, 'backgroundColor':currColor}); 
        	  		calendarInsert(addcalendar, strDate_yyyy_mm_dd, currColor);
        	     }).mouseout(function(){
        	    	 $(".fc-day").unbind("mouseover");
        	     });
    	  }
      }});
	})
});
  
  

</script>

<style type="text/css">

.fc-title {
    color: white;
}
.fc-event {
    border: none;
}
.bani_contol{
    width: 80%;
    height: calc(2.25rem + 2px);
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: .25rem;
    box-shadow: inset 0 0 0 transparent;
    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}

</style>
</head>
<body class="ns">
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
                  <h4 class="card-title">Drag Calendar</h4>
                </div>
                <div class="card-body">
                  <!-- the events -->
                  <div id="external-events">
                    
                    <div class="checkbox">
                      <label for="drop-remove">
                        
                      </label>
                    </div>
                  </div>
                </div>
                <!-- /.card-body -->
              </div>
              <!-- /.card -->
              <div class="card">
                <div class="card-header">
                  <h3 class="card-title">Create Calendar</h3>
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
              <div class="card">
                <div class="card-header">
                  <h4 class="card-title">delete Calendar<i class="far fa-trash-alt"></i></h4>
                </div>
                <div class="card-body">
                  <!-- the events -->
                  <div id="external-events">                   
                    <div class="calendarTrash" id="calendarTrash">
                 <br><br>
                    </div>
                  </div>
                </div>
                <!-- /.card-body -->
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
    <button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal" id ="modalbtn"></button>	
    
    <!-- Modal -->
    
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"  >
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">일정 상세보기</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
      </div>
      <div class="modal-body">
	  		<input type="hidden" id="scheId" class="form-control">
      	<label for="scheTitle" class="col-sm-2 control-label">제목  </label>
	  		<input type="text" id="scheTitle" class="bani_contol" readonly="readonly" ><br><br>
      	<label for="startDt" class="col-sm-2 control-label">기간  </label>
	  		<input type="text" id="startDt" class="bani_contol" readonly="readonly"><br><br>
      	<label for="scheCont" class="col-sm-2 control-label" style="position: relative; top: -165px;" >내용 : </label>
      	<div id="scheCont" class="bani_contol" style="margin-top: 0px; margin-bottom: 0px; overflow-y :scroll; height: 180px; display: inline-block;"></div>
      	<div id="injuso">
      	<label for="juso" class="col-sm-2 control-label">주소  </label>
	  		<input type="text" id="juso" class="bani_contol" readonly="readonly"><br><br>
       	</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>