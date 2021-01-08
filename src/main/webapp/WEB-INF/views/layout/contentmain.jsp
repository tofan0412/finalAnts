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
	    pickTime : false,
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
body{
    min-width: 1400px;
}
#maintop{
	width: 68%;
	height: 40%;
	float:left;
}
#maintop2{
	width: 32%;
	height: 100%;
	float:right;
}
#mainleft{
	width: 46%;	
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
.ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default, .ui-button, html .ui-button.ui-state-disabled:hover, html .ui-button.ui-state-disabled:active {
    border: 1px solid white;
    background: white;
    color: black;
    
}
.ui-state-highlight, .ui-widget-content .ui-state-highlight, .ui-widget-header .ui-state-highlight{
	background-color: #1D6A96;
	color: white; 
}
  .ui-datepicker{ font-size: 16px; width: auto; min-width: 205px;} 
.bani{
	font-size: 0.8em;
	float: right;
	margin-right: 3%;
}
</style>
</head>				
<body>
<div class="col-12 col-sm-12">
<div id="maintop" style="OVERFLOW-Y:auto; padding-left:2%; margin-top: 2%; max-height: 380px;">
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
						    <c:if test="${SMEMBER.memType eq 'PM' }">
							<td style="text-align: left; padding-left: 5%; font-size: 1em;"><a href="${pageContext.request.contextPath}/project/pmProjectgetReq?reqId=${project.reqId}">${project.proName }</a></td>
							</c:if>
						    <c:if test="${SMEMBER.memType ne 'PM' }">
							<td style="text-align: left; padding-left: 5%; font-size: 1em;"><a href="${pageContext.request.contextPath}/project/projectgetReq?reqId=${project.reqId}">${project.proName }</a></td>
							</c:if>
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
<div id="maintop2" style="padding-left: 2%;  margin-top: 2%; padding-right: 2%;">
	<div class="card" style="font-size: 0.9em;">
		<div class="card-header">
			<h3 class="card-title jg">Timeline</h3>
			</div>
			<div class="card-body pt-0 jg">
			<div class="timeline timeline-inverse">
			<c:if test="${empty alarmlistmain }">
			<br>
                      <div>
                        <i class="far fa-clock bg-gray"></i>
                        <div class="timeline-item">
                          <div class="timeline-body">
                            	미확인 알림이 없습니다.
                          </div>
                        </div>
                      </div>
			</c:if>
			<c:if test="${not empty alarmlistmain }">
			<br>
            <c:forEach items="${alarmlistmain }" var="a" varStatus="i">
            <c:choose>
            	<c:when test="${a.regDt eq today and i.index eq 0}">
            		<div class="time-label">
		            	<span class="bg-success ns">today</span>
		            </div>
            	</c:when>
            	<c:when test="${a.regDt ne today and i.index eq count }">
            		<div class="time-label">
		            	<span class="bg-danger ns">the old times</span>
		            </div>
            	</c:when>
			</c:choose>
                <div>
                <c:choose>
					<c:when test="${a.alarmType eq 'req-pl'}"><i class="fas fa-user bg-info"></i></c:when>
					<c:when test="${a.alarmType eq 'res-pl' }"><i class="fas fa-user bg-info"></i></c:when>
					<c:when test="${a.alarmType eq 'req-pro' }"><i class="fas fa-envelope bg-primary"></i></c:when>
					<c:when test="${a.alarmType eq 'res-pro' }"><i class="fas fa-envelope bg-primary"></i></c:when>
					<c:when test="${fn:contains(a.alarmType,'reply')}"><i class="fas fa-comments bg-warning"></i></c:when>
					<c:when test="${a.alarmType eq 'posts'}"><i class="fas fa-comments bg-warning"></i></c:when>
					<c:when test="${a.alarmType eq 'suggest'}"><i class="fas fa-exclamation-triangle"></i></c:when>
					<c:when test="${a.alarmType eq 'res-suggest'}"><i class="fas fa-exclamation-triangle"></i></c:when>
				</c:choose>
                	
                    <div class="timeline-item">
                    	<span class="time"><i class="far fa-clock">
                    	<c:if test="${a.regDt ne today}">${a.regDt }</c:if>
                    	<c:if test="${a.regDt eq today}">${a.regTime }</c:if>
                    	</i></span>
                    	<h4 class="timeline-header">
                    	<c:choose>
				        <c:when test="${a.alarmType eq 'req-pl'}">PL요청  <span class="bani"> Sender : ${fn:split(a.alarmCont,'&&')[1]}</span></c:when>
				        <c:when test="${a.alarmType eq 'res-pl' }">PL응답 <span class="bani"> Sender : ${fn:split(a.alarmCont,'&&')[1]}</span></c:when>
				        <c:when test="${a.alarmType eq 'req-pro' }">Project 초대 <span class="bani"> Sender : ${fn:split(a.alarmCont,'&&')[1]}</span></c:when>
				        <c:when test="${a.alarmType eq 'res-pro' }">Project초대 <span class="bani"> Sender : ${fn:split(a.alarmCont,'&&')[1]}</span> 결과</c:when>
				        <c:when test="${fn:contains(a.alarmType,'reply')}">
				        <c:if test="${a.alarmType eq 'reply-3' }">이슈 댓글 <span class="bani"> Sender : ${fn:split(a.alarmCont,'&&')[1]}</span></c:if>
				        <c:if test="${a.alarmType eq 'reply-4' }">건의사항 댓글 <span class="bani"> Sender : ${fn:split(a.alarmCont,'&&')[1]}</span></c:if>
				        <c:if test="${a.alarmType eq 'reply-6' }">일정 댓글 <span class="bani"> Sender : ${fn:split(a.alarmCont,'&&')[1]}</span></c:if>
				        <c:if test="${a.alarmType eq 'reply-10' }">투표 댓글 <span class="bani"> Sender : ${fn:split(a.alarmCont,'&&')[1]}</span></c:if>
				        </c:when>
				        <c:when test="${a.alarmType eq 'posts'}">PM-PL이슈 답글 <span class="bani"> Sender : ${fn:split(a.alarmCont,'&&')[1]}</span>
				        </c:when>
				        <c:when test="${a.alarmType eq 'suggest'}">건의사항 <span class="bani"> Sender : ${fn:split(a.alarmCont,'&&')[1]}</span></c:when>
				        <c:when test="${a.alarmType eq 'res-suggest'}">건의사항 결과 <span class="bani"> Sender : ${fn:split(a.alarmCont,'&&')[1]}</span></c:when>
				        </c:choose>
                    	</h4>
                    	<div class="timeline-body" style="font-size: 0.9em;">
                         <c:choose>
				         <c:when test="${a.alarmType eq 'req-pl'}">${fn:split(a.alarmCont,'&&')[4]}</c:when>
				         <c:when test="${a.alarmType eq 'res-pl' }">${fn:split(a.alarmCont,'&&')[4]}<br>[
					     <c:if test="${fn:split(a.alarmCont,'&&')[5] eq 'ACCEPT'}">PL요청을 수락했습니다.</c:if>
					     <c:if test="${fn:split(a.alarmCont,'&&')[5] eq 'REJECT'}">PL요청을 거절했습니다.</c:if>
					     ]</c:when>
				         <c:when test="${a.alarmType eq 'req-pro' }">${fn:split(a.alarmCont,'&&')[4]}</c:when>
				         <c:when test="${a.alarmType eq 'res-pro' }">${fn:split(a.alarmCont,'&&')[4]}<br>[
					     <c:if test="${fn:split(a.alarmCont,'&&')[5] eq 'ACCEPT'}">프로젝트 초대를 수락했습니다.</c:if>
					     <c:if test="${fn:split(a.alarmCont,'&&')[5] eq 'REJECT'}">프로젝트 초대를 거절했습니다.</c:if>
					     ]
				         </c:when>
				         <c:when test="${a.alarmType eq 'res-suggest'}">
					     ${fn:substring(fn:split(a.alarmCont,'&&')[6],0,30)}<br>[
					     <c:if test="${fn:split(a.alarmCont,'&&')[5] eq 'ACCEPT'}">건의사항이 승인됐습니다.</c:if>
					     <c:if test="${fn:split(a.alarmCont,'&&')[5] eq 'REJECT'}">건의사항이 반려됐습니다.</c:if>
					     ]
				         </c:when>
				         <c:when test="${a.alarmType eq 'posts'}">${fn:substring(fn:split(a.alarmCont,'&&')[6],0,30)}<br>
					     from.[${fn:substring(fn:split(a.alarmCont,'&&')[5],0,30) }]
				         </c:when>
				         <c:when test="${fn:contains(a.alarmType,'reply')}">                                                                                                                              
					     ${fn:substring(fn:split(a.alarmCont,'&&')[6],0,30)}<br>
					     from.${fn:substring(fn:split(a.alarmCont,'&&')[7],0,13)}&nbsp;&nbsp;&nbsp;
						     <c:if test="${fn:length(fn:substring(fn:split(a.alarmCont,'&&')[5],0,30)) > 10}">									
					     		[${fn:substring(fn:substring(fn:split(a.alarmCont,'&&')[5],0,30),0,8)}...]
							</c:if>
							<c:if test="${fn:length(fn:substring(fn:split(a.alarmCont,'&&')[5],0,30)) <= 10}">									
					     		[${fn:substring(fn:split(a.alarmCont,'&&')[5],0,30)}]
							</c:if>
				         </c:when>
				         <c:when test="${a.alarmType eq 'suggest'}">
					     ${fn:substring(fn:split(a.alarmCont,'&&')[6],0,30)}<br>
					     from.${fn:substring(fn:split(a.alarmCont,'&&')[8],0,13) }&nbsp;&nbsp;&nbsp;
					     <c:if test="${fn:length(fn:substring(fn:split(a.alarmCont,'&&')[5],0,30)) > 10}">									
					     		 [${fn:substring(fn:substring(fn:split(a.alarmCont,'&&')[5],0,30),0,8)}...]
							</c:if>
							<c:if test="${fn:length(fn:substring(fn:split(a.alarmCont,'&&')[5],0,30)) <= 10}">									
					     		 [${fn:substring(fn:split(a.alarmCont,'&&')[5],0,30) }]
							</c:if>
					    
				         </c:when>
				         </c:choose>
                    	</div>
                    </div>
                  </div>
                      </c:forEach>
                      <div>
                        <i class="far fa-clock bg-gray"></i>
                      </div>
                      </c:if>
                    </div>
			</div>
		</div>
	</div>

<div id="mainleft" style="padding-left: 2%; margin-top: 2%;">
	<div class="card" style="height: 340px;">
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
<div id="mainright" style="padding-left: 2%; margin-top: 2%;">
	<div class="card" style="height: auto; min-width: 240px;">
	<div class="card-header">
			<h3 class="card-title jg"><a href="${pageContext.request.contextPath}/schedule/MyclendarView">Calendar</a></h3>
		</div>
		<div class="card-body pt-0" style="min-width: 160px;"><br>
			<div id ="datePicker"></div>
		</div>           
	</div>

</div>
</div>
</html>
</body>