<%@page import="java.util.ArrayList"%>
<%@page import="ants.com.board.memBoard.model.ScheduleVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<html>
<head>
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<%
	List<ScheduleVo> list = (ArrayList<ScheduleVo>)request.getAttribute("showSchedule");
%>   
<script type="text/javascript">
function ini_events(ele) {
    ele.each(function () {
      var eventObject = {
        title: $.trim($(this).text()) 
      }

      $(this).data('eventObject', eventObject)

      $(this).draggable({
        zIndex        : 1070,
        revert        : true, 
        revertDuration: 0  
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
			window.location.reload()
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
			window.location.reload()
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
			window.location.reload()
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
				$("#startDtmodal").val(data.scheduleVo.startDt);
				$("#endDtmodal").val(data.scheduleVo.endDt);	
			}
			
			if(data.scheduleVo.endDt == null){
				$("#startDt").val(data.scheduleVo.startDt +" ~ "+ data.scheduleVo.startDt);
				$("#startDtmodal").val(data.scheduleVo.startDt);
				$("#endDtmodal").val(data.scheduleVo.startDt);
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
			window.location.reload()
		}

	});

}

ini_events($('#external-events div.external-event'))
document.addEventListener('DOMContentLoaded', function() {
	$('#aftUpdate').hide();
	$("#modalbtn").hide();
	$('#dateupdate').hide();
	var Calendar = FullCalendar.Calendar;
	var Draggable = FullCalendar.Draggable;
	var containerEl = document.getElementById('external-events');
	var checkbox = document.getElementById('drop-remove');
	var calendarEl = document.getElementById('calendar');
	
	var calendar = new FullCalendar.Calendar(calendarEl, { 
		plugins: [ 'interaction', 'dayGrid', 'timeGrid' ], 
		defaultView: 'dayGridMonth', 
		defaultDate: new Date(),
		header: { left: 'prev,next', center: 'title',  right : 'today' },
		editable: true,
		eventLimit : true,
		droppable: true, 
	    selectable: true,
	    draggable :true,
		themeSystem: 'bootstrap',
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
			  eventResize: function(info) {
		            if (!confirm("일정 변경을 저장하시겠습니까??")) {
		            info.revert();
		            }else{
		            var start = moment(info.event.start).format('YYYY-MM-DD');
		    		var end = moment(info.event.end).format('YYYY-MM-DD');
				      calendarUpdate(info.event.id, info.event.title, start, end);
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
	});
	
	$("#updateBtn").on("click", function () {
		 $('#befUpdate').hide();
		 $('#aftUpdate').show();
		 $('#dateupdate').show();		 
		 $('#datehide').hide();
		 $('#scheTitle').attr('readonly', false);
	    })
	    
	$("#updateBtnfinal").on("click", function () {
		cnt = 0;
 		// 각 칸이 빈칸인지 확인
 		if ($('#scheTitle').val().length == 0){
			$('.warningscheTitle').text("제목을 작성해 주세요.");  
			cnt++;
 		}else{
			$('.warningscheTitle').text('');
		}
 		if ($('#startDtmodal').val().length == 0){
			$('.warningstartD').text("시작일을 지정해 주세요");  
			cnt++;
 		}else{
			$('.warningstartD').text('');
		}
 		if ($('#endDtmodal').val().length == 0){
			$('.warningendD').text("종료일을 지정해 주세요");  
			cnt++;
 		}else{
			$('.warningendD').text('');
		}
 		if(cnt == 0){
			 $('#scheTitle').attr('readonly', true);
	 		timestart = $('#startDtmodal').val();
	 		timeend = $('#endDtmodal').val();

	 		a = timestart;
	 		b = timeend;
	 		Y = a.substring(0,4) // 년
	 		M = a.substring(5,7) //월
	 		D = a.substring(8,10) //일
	 		H = a.substring(11,13) //시
	 		m = a.substring(14) //분
	 		
	 		Y2 = b.substring(0,4) // 년
	 		M2 = b.substring(5,7) //월
	 		D2 = b.substring(8,10) //일
	 		H2 = b.substring(11,13) //시
	 		m2 = b.substring(14) //분

	 		timestartres = Y+M+D+H+m
	 		timeendres = Y2+M2+D2+H2+m2
	 		 $('#startDtmodal2').val(timestartres);
	 		 $('#endDtmodal2').val(timeendres);
	 		 var s = $('#scheCont').html();
	 		 $('#scheCont2').val(s);
 			 $("#sheForm").submit();
 		}
		
	    })
	    
	$("#rollbackbtn").on("click", function () {
		 $('#befUpdate').show();
		 $('#aftUpdate').hide();
		 $('#dateupdate').hide();
		 $('#datehide').show();
		 $('#scheTitle').attr('readonly', true);
		 $('#scheCont').attr('readonly', true);
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
<%@include file="../layout/contentmenu.jsp"%>
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
             <div  class="card-tools float-left" style="width: 450px;">
					<h3 class="jg" style="padding-left: 10px;">Calendar / <a style="color: black;" href="${pageContext.request.contextPath}/schedule/scheduleplaceView">일정</a></h3>
			</div>
          </div>
        </div>
      </div>
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
                  <div id="external-events">
                    <div class="checkbox">
                      <label for="drop-remove">
                      </label>
                    </div>
                  </div>
                </div>
              </div>
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
                  <div class="input-group">
                    <input id="new-event" type="text" class="form-control" placeholder="Event Title">

                    <div class="input-group-append">
                      <button id="add-new-event" type="button" class="btn btn-primary">Add</button>
                    </div>
                  </div>
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
              </div>
            </div>
          </div>
          <div class="col-md-9">
            <div class="card card-primary">
              <div class="card-body p-0">
                <div id="calendar" class="fc fc-media-screen fc-direction-ltr fc-theme-bootstrap ns">
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal" id ="modalbtn"></button>	
    
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"  >
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">일정 상세보기</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
      </div>
      <div class="modal-body">
      <form id="sheForm" name="sheForm" method="post" action="${pageContext.request.contextPath}/schedule/calendar_total">
      <input type="hidden" id="scheId" class="form-control" name="scheId">
      	<label for="scheTitle" class="col-sm-2 control-label">제목  </label>
	  		<input type="text" id="scheTitle" class="bani_contol" readonly="readonly" name="scheTitle">
	  		<div class="jg" style=" padding-left: 18%;"><span class="jg warningscheTitle" style="color : red;"></span></div><br>
      	<div id="datehide">
      	<label for="startDt" class="col-sm-2 control-label">기간  </label>
	  		<input type="text" id="startDt" class="bani_contol" readonly="readonly" ><br><br>
	  	</div>
	  	<div id="dateupdate">
      	<label for="startDt" class="col-sm-2 control-label">시작 일</label>
	  		<input type="datetime-local" id="startDtmodal" name="startDt2"/>
	  		<input type="hidden" id="startDtmodal2" name="startDt"/>
	  		<div class="jg" style=" padding-left: 18%;"><span class="jg warningstartD" style="color : red;"></span></div><br>
      	<label for="endDt" class="col-sm-2 control-label">종료 일</label>
	  		<input type="datetime-local" id= endDtmodal name="endDt2"/>
	  		<input type="hidden" id= endDtmodal2 name="endDt"/>
	  		<div class="jg" style=" padding-left: 18%;"><span class="jg warningendD" style="color : red;"></span></div><br>
	  	</div>
	  	
      	<label for="memId" class="col-sm-2 control-label">작성자  </label>
	  		<input type="text" id="memId" class="bani_contol" readonly="readonly"><br><br>
      	<label for="scheCont" class="col-sm-2 control-label" style="position: relative;" >내용 : </label>
      	<div id="scheCont" class="bani_contol" style="-webkit-user-modify: read-write; margin-top: -30px;margin-left: 17%;"></div>
      	<input id="scheCont2" type="hidden" class="bani_contol" style="-webkit-user-modify: read-write;" name="scheCont">
	  	<div class="jg" style=" padding-left: 18%;"><span class="jg warningscheCont" style="color : red;"></span></div><br>
      	<div id="injuso">
      	<label for="juso" class="col-sm-2 control-label">주소  </label>
	  		<input type="text" id="juso" class="bani_contol" readonly="readonly"><br><br>
       	</div>
       	</form>
      </div>
      <div class="modal-footer">
      <div id="befUpdate">
        <button type="button" class="btn btn-default" id="updateBtn">수정</button>
        </div>
      	<div id="aftUpdate">
        <button type="button" class="btn btn-default" id="updateBtnfinal">등록</button>
        </div>
        <button type="button" class="btn btn-default" data-dismiss="modal" id ="rollbackbtn">Close</button>
    </div>
  </div>
</div>
</div>
</body>
</html>