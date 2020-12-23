<%@page import="java.util.ArrayList"%>
<%@page import="ants.com.board.memBoard.model.ScheduleVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html >
<head>
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<script>
$(document).ready(function() {
	chartmain();
	$('#datePicker').datepicker({
	    format: "yyyy-mm-dd",	
	    calendarWeeks : false, 
	    clearBtn : false, 
	    disableTouchKeyboard : false,	
	    immediateUpdates: false,	
	    multidate : false, 
	    multidateSeparator :",", 
	    templates : {
	        leftArrow: '&laquo;',
	        rightArrow: '&raquo;'
	    }, 
	    showWeekDays : true ,
	    todayHighlight : true , 
	    weekStart : 0 
	  
	    
	});//datepicker end
});
function chartmain() {
	$.ajax({
		url : "/member/chartmain",
		method : "get",
		success : function(data) {
			var num = [];
			var percent=[];
			for(i=0; i<data.dbsize; i++){
			num.push(data.projectList_main[i].proName);	
			percent.push(data.projectList_main[i].percent);
			}
			var lineChartData = {
					labels : num,
					 datasets: [
					        {
					          label               : '진행도 : %',
					          backgroundColor     : '#87C488',
					          borderColor         : '#87C488',
					          pointRadius          : false,
					          pointColor          : '#87C488',
					          pointStrokeColor    : '#87C488',
					          pointHighlightFill  : '#fff',
					          pointHighlightStroke: '#87C488',
					          data                : percent,
					          barThickness: 30
					        }]
			};
			 var lineChartOptions     = {
					 responsive              : true,
				      maintainAspectRatio     : false,
				      datasetFill  			  : false,
				      scales: {
					        xAxes: [{
					          display : false
					        }],
					        yAxes: [{
					        	ticks: {
					                  stepSize: 10,
					                  suggestedMax: 100, 
					                  beginAtZero: true
					          }
					        }]
					      }
				    };
			var dctx = document.getElementById('chartmain').getContext('2d');
			var lineChart = new Chart(dctx, {
				  type: 'bar',
				  data: lineChartData,
				  options: lineChartOptions
			    });
			}
		});
	}
</script>
<style>
#maintop{
	width: 65%;
	height: 40%;
	float:left;
}
#maintop2{
	width: 35%;
	height: 100%;
	float:right;
}
#mainleft{
	width: 43%;	
	min-height: 20%;
	float:left;
	
}
#mainright{
	width: 21%;
	min-height: 20%;
	float:left;
}
#project_table{
	width : 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
    text-align: center;
	font-size: 0.8em;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 6px;
  }
 tr{
 height: 30px;
 }
#maintop::-webkit-scrollbar {
    width: 10px;
  }
#maintop::-webkit-scrollbar-thumb {
    background-color: white;
  }
#maintop::-webkit-scrollbar-track {
    background-color: white;
  }
</style>
</head>				
<body>
 <div class="col-12 col-sm-12">
 
<div id="maintop" style="OVERFLOW-Y:auto; padding-left:2%; margin-top: 1%; height: 380px;">
	<div class="card card card-success card-outline">
		<div class="card-header">
			<h3 class="card-title jg">Project List</h3>
		</div>
		<div class="card-body pt-0" style=" margin-left: 2%; margin-right: 2%; margin-top: 1%;" >
			<table id="project_table" class="ns">
				<tr style="background-color: #f6f6f6">
					<th>프로젝트 이름</th>
					<th>진행도</th>
					<th>기간</th>
					<th>PL</th>
				</tr>
				<tbody >
						<c:forEach items="${projectList_main }" var="project" varStatus="sts" >
						    <tr>
							<td style="text-align: left; font-size: 1em; padding-left: 5%">${project.proName }</td>
							<c:if test="${empty project.percent }">
							<td >0%</td>
							</c:if>					
							<c:if test="${not empty project.percent }">
							<td>${project.percent }%</td>
							</c:if>					
							<td >${project.regDt }&nbsp;&nbsp;~&nbsp;&nbsp; ${project.endDt }</td>			
							<td >${project.memId }</td>			
							</tr>
						</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
<div id="maintop2" style="padding-left: 2%;  margin-top: 1%; padding-right: 2%;">
	<div class="card">
		<div class="card-header">
			<h3 class="card-title jg">Timeline</h3>
			</div>
			<div class="card-body pt-0 jg">
			<div class="timeline timeline-inverse">
				<br>
                      <div class="time-label">
                        <span class="bg-danger ns">
                          	today
                        </span>
                      </div>
                      <div>
                        <i class="fas fa-envelope bg-primary"></i>
                        <div class="timeline-item">
                          <span class="time"><i class="far fa-clock"></i> 12:05</span>
                          <h3 class="timeline-header">PL 요청</h3>
                          <div class="timeline-body">
                            	보낸사람 - 요구사항정의서 제목
                          </div>
                        </div>
                      </div>
                      <div>
                        <i class="fas fa-user bg-info"></i>
                        <div class="timeline-item">
                          <span class="time"><i class="far fa-clock"></i> 09:50</span>
                          <h3 class="timeline-header">댓글</h3>
                          <div class="timeline-body">
                            	댓글 작성한 사람 - 댓글이 작성된 글제목
                          </div>
                        </div>
                      </div>
                      <div>
                        <i class="fas fa-comments bg-warning"></i>
                        <div class="timeline-item">
                          <span class="time"><i class="far fa-clock"></i> 06:00</span>
                          <h3 class="timeline-header">프로젝트 초대</h3>
                          <div class="timeline-body">
                            	보낸사람 - 프로젝트이름
                          </div>
                        </div>
                      </div>
                      <div class="time-label">
                        <span class="bg-success ns">
                          	the old times
                        </span>
                      </div>
                      <div>
                        <i class="fas fa-user bg-info"></i>
                        <div class="timeline-item">
                          <span class="time"><i class="far fa-clock"></i> 09:50</span>
                          <h3 class="timeline-header">몰라</h3>
                          <div class="timeline-body">
                            	이거 내용 많아지면 스크롤 만들어...
                          </div>
                        </div>
                      </div>
                      <div>
                        <i class="fas fa-comments bg-warning"></i>
                        <div class="timeline-item">
                          <span class="time"><i class="far fa-clock"></i> 06:00</span>
                          <h3 class="timeline-header">테스트</h3>
                          <div class="timeline-body">
                            	좀 큰 느낌인디
                          </div>
                        </div>
                      </div>
                      <div>
                        <i class="far fa-clock bg-gray"></i>
                      </div>
                    </div>
			</div>
		</div>
	</div>
</div>
<div id="mainleft" style="padding-left: 2%; margin-top: 3%;">
	<div class="card card-success card-outline" style="height: 340px;">
		<div class="card-header">
			<h3 class="card-title jg">Progress Chart</h3>
		</div>
		<div class="card-body pt-0">
			<div class="chart" style="padding-top: 2%;">
				<div class="chartjs-size-monitor">
					<div class="chartjs-size-monitor-expand">
						<div class=""></div>
					</div>
					<div class="chartjs-size-monitor-shrink">
						<div class=""></div>
					</div>
				</div>
				<canvas id="chartmain" style="min-height: 200px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 100px;" width="100" height="250" class="chartjs-render-monitor"></canvas>
			</div>
		</div>
	</div>
</div>
<div id="mainright" style="padding-left: 2%; margin-top: 3%;">
	<div class="card card-success card-outline" style="height: 330px;">
		<div class="card-header">
			<h3 class="card-title jg" style="text-align: center;">Calendar</h3>
		</div>
		<div class="card-body pt-0">
			<div id ="datePicker" style="width: auto;"></div>
		</div>           
	</div>
</div>
</div>
</html>
</body>