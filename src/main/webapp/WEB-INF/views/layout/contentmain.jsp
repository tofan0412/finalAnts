<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@page import="java.util.ArrayList"%>
<%@page import="ants.com.board.memBoard.model.ScheduleVo"%>
<%@page import="java.util.List"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
 
<script src="https://cdn.jsdelivr.net/npm/@shopify/draggable@1.0.0-beta/lib/draggable.min.js"></script>
<script src="/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/dist/js/adminlte.min.js"></script>
<script src="/plugins/moment/moment.min.js"></script>
<script src="/plugins/fullcalendar/main.js"></script>

<script src="/plugins/fullcalendar-daygrid/main.js"></script>
<script src="/plugins/fullcalendar-interaction/main.js"></script>
<script src="/plugins/fullcalendar-timegrid/main.js"></script>

<link rel="stylesheet" href="/dist/css/adminlte.min.css">
<link rel="stylesheet" href="/plugins/fullcalendar/main.css">
<!-- Google Font: Source Sans Pro -->
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
	
<!-- Font Awesome -->
<link rel="stylesheet" href="/plugins/fontawesome-free/css/all.min.css">
<%
	List<ScheduleVo> list = (ArrayList<ScheduleVo>)request.getAttribute("showSchedule");
%>
<title>Insert title here</title>


<script>
$(function(){
	// 메뉴를 선택하면 배경색이 변한다. 
	$('.selectable').click(function(){
	// alert($(this).text());
		$('.selectable').parent().removeClass("active");
		$(this).parent().addClass("active");
	})
	
	$('.mkPjtBtn').click(function(){
		var plId = '${SMEMBER.memId}';
		$(location).attr('href', '/project/readReqList?plId='+plId);
	})
})
	
document.addEventListener('DOMContentLoaded', function() {
	var Calendar = FullCalendar.Calendar;
	var calendarEl = document.getElementById('calendar');
				
	var calendar = new FullCalendar.Calendar(calendarEl, {
		plugins: [ 'interaction', 'dayGrid' ],
		defaultDate: new Date(),
		center: 'title',
		events: [
	        <% 
			if(list.size() > 0){
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
			}	
			%>
	      ]
	});
	calendar.render();
});
</script>
<style>
.top{
	border: 1px solid lightgray; 
	font-size: 0.8em; 
	background-color:white; 
	min-height:500px;
	height:550px; 
	width:48%;
	float:left; 
	overflow: auto;
	
	padding-top:2%;
	padding-bottom:2%;
	padding-left:4%;
	padding-right:4%;
}
th{
	width:300px; 
} 
.bottom{
	border: 1px solid lightgray; 
	width:48%; 
	height:650px; 
	float:left; 
	background-color:white;
		
	padding-top:2%;
	padding-bottom:2%;
	padding-left:4%;
	padding-right:4%;
	margin: auto;
	vertical-align: middle;
	horizontal-align: middle;  
} 
.todoTable {
	width: 98%;
	border-collapse: collapse;
}	
#calendar { 
	width:700px;
	padding-left: 6%; 
} 
.fc-sat, .fc-sun, .fc-mon, .fc-tue, .fc-wed, .fc-thu, .fc-fri {width:10px;} 
</style>
</head>
	 
<body>
<div>
	<div class="top" style="margin-left:1.5%;"><h4>프로젝트 현황</h4>
	(이름 클릭하면 해당 프로젝트 정보 가져오게 할것임..예정.. <br>
	 프로젝트는 들어가기 버튼으로..)
		<nav class="mt-2">
			<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
				<!-- memType이 MEM일때  -->
				 <c:if test="${not empty memInProjectList}">
					<li class="nav-item has-treeview menu-open">
			            <a href="#" class="nav-link active" style="background-color:#6495ED;">
				        	<i class="nav-icon fas fa-poll-h"></i> 
							<p>참여중인 프로젝트<i class="fas fa-angle-left right"></i></p>
						</a>
					    <ul class="nav nav-treeview" style="display: none;">
							<table class="todoTable" style="margin-left:3%">
								<tr>
									<th style="padding-left:47px;">프로젝트명</th>
									<th>상태(일단 프로젝트번호)</th>
									<th>완료율</th>
									<th>생성일</th>
								</tr> 
								<tbody id=memInProjectList> 
									<c:forEach items="${memInProjectList}" var="project" varStatus="sts" >
									    <tr "data-privid="${project.reqId}">
											<td>
											<li class="nav-item">
												<a class="nav-link" href="${pageContext.request.contextPath}/schedule/mainClendar?reqId=${project.reqId}">
											 		<i class="nav-icon fas fa-layer-group"></i><p class="selectable">${project.proName}</p>
											 	</a>
											</li> 
											</td> 
											<td>${project.reqId}</td>
											<td>${project.percent}</td>
											<td>${project.regDt}</td>
											<td>

												<c:choose>
													<c:when test="${not empty project.reqId}">
														<a class="nav-link" href="${pageContext.request.contextPath}/todo/projectgetReq?reqId=${project.reqId}">
													 		<input type="button" value="들어가기">
													 	</a>
													
													</c:when>
													<c:otherwise>
														<a>참여중인 프로젝트가 없습니다.</a>
													</c:otherwise>
												</c:choose> 

											</td>	
										</tr>
									</c:forEach> 
								</tbody>
							</table>
						</ul>
					</li>
				 </c:if>
				 <!-- memType이 PL일때 -->
				 <c:if test="${not empty plInProjectList}">
					<li class="nav-item has-treeview menu-open">
			            <a href="#" class="nav-link active" style="background-color:#6495ED;">
				        	<i class="nav-icon fas fa-poll-h"></i>
							<p>프로젝트 관리(PL)<i class="fas fa-angle-left right"></i></p>
						</a>
					    <ul class="nav nav-treeview" >
							<table class="todoTable" style="margin-left:3%">
								<tr>
									<th style="padding-left:47px;">프로젝트명</th>
									<th>상태(일단 프로젝트번호)</th>
									<th>완료율</th>
									<th>생성일</th>
									  
								</tr> 
								<tbody id=plInProjectList> 
									<c:forEach items="${plInProjectList}" var="project" varStatus="sts" >
									    <tr "data-privid="${project.reqId}">
											<td>
											<li class="nav-item">
												<a class="nav-link" href="${pageContext.request.contextPath}/schedule/mainClendar?reqId=${project.reqId}">
											 		<i class="nav-icon fas fa-layer-group"></i><p class="selectable">${project.proName}</p>
											 	</a>
											</li>
											</td>
											<td>${project.reqId}</td>
											<td>${project.percent}</td>
											<td>${project.regDt}</td>
											<td>
												<c:choose>
													<c:when test="${not empty project.reqId}">
														<a class="nav-link" href="${pageContext.request.contextPath}/todo/projectgetReq?reqId=${project.reqId}">
													 		<input type="button" value="들어가기">
													 	</a>
													
													</c:when>
													<c:otherwise>
														<a>참여중인 프로젝트가 없습니다.</a>
													</c:otherwise>
												</c:choose>
											</td>	
										</tr>
									</c:forEach> 
								</tbody>
							</table>
						</ul>
					</li>
				 </c:if>
				 	
				 <!-- memType이 PM일때	
				 not empty pmInProjectList and pmInProjectList ne ' ' and pmInProjectList ne '' and pmInProjectList ne null
				  --> 	
				 <c:if test="${ not empty pmInProjectList }"> 
					<li class="nav-item has-treeview menu-open">
			            <a href="#" class="nav-link active" style="background-color:#6495ED;">
				        	<i class="nav-icon fas fa-poll-h"></i>
							<p>프로젝트 관리(PM)<i class="fas fa-angle-left right"></i></p> 
						</a>
					    <ul class="nav nav-treeview">
							<table class="todoTable" style="margin-left:3%">
								<tr>
									<th style="padding-left:47px;">프로젝트명</th>
									<th>상태(일단 프로젝트번호)</th>
									<th>완료율</th>
									<th>생성일</th>
								</tr> 	
								<tbody id=pmInProjectList> 
									<c:forEach items="${pmInProjectList}" var="project" varStatus="sts" >
									    <tr "data-privid="${project.reqId}">
											<td>
											<li class="nav-item">
												<a class="nav-link" href="${pageContext.request.contextPath}/schedule/mainClendar?reqId=${project.reqId}">
											 		<i class="nav-icon fas fa-layer-group"></i><p class="selectable">${project.proName}</p>
											 	</a> 
											</li>
											</td> 
											<td>${project.reqId}</td>
											<td>${project.percent}</td>
											<td>${project.regDt}</td>
											<td>
												<c:choose> 
													<c:when test="${not empty project.reqId}">
														<a class="nav-link" href="${pageContext.request.contextPath}/todo/projectgetReq?reqId=${project.reqId}">
													 		<input type="button" value="들어가기">
													 	</a>
													
													</c:when>
													<c:otherwise>
														<a>참여중인 프로젝트가 없습니다.</a>
													</c:otherwise>
												</c:choose>
											</td>	
										</tr>
									</c:forEach> 
								</tbody>
							</table>
						</ul>
					</li>
				 </c:if>
				 
				 <!-- 프로젝트없는 경우 -->
				 <c:if test="${memInProjectList eq null and plInProjectList eq null and pmInProjectList eq null}">
					<li class="nav-item has-treeview menu-close">
			            <a href="#" class="nav-link">
				        	<i class="nav-icon fas fa-poll-h"></i>
							<p>참여중인 프로젝트가 없습니다</p>
						</a>
				 </c:if>
				 
			</ul>
		</nav>
	</div>
	
	
	<!-- 위 오른쪽 공지사항 -->
	<div class="top" style="margin-left:1%;"><h4>공지사항</h4><br>
	</div> 

	
	<!-- 아래  -->
		<!-- 왼쪽 통계 -->
		<div class="bottom" style="margin-left:1.5%;"><h4>프로젝트별 통계</h4><br>
			<img src="/dist/img/통계.gif" style="height: 100%; width: 100%; ">
		</div>
		  
		<!-- 오른쪽 캘린더 -->
		<div class="bottom" style="margin-left:1%;">
        	<div id="calendar"></div>
		</div>
</div>
</body>
</html>