<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@page import="java.util.ArrayList"%>
<%@page import="ants.com.board.memBoard.model.ScheduleVo"%>
<%@page import="java.util.List"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
 
<script src="https://cdn.jsdelivr.net/npm/@shopify/draggable@1.0.0-beta/lib/draggable.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/dist/js/adminlte.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/plugins/moment/moment.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/plugins/fullcalendar/main.js"></script>

<script src="${pageContext.request.contextPath }/resources/plugins/fullcalendar-daygrid/main.js"></script>
<script src="${pageContext.request.contextPath }/resources/plugins/fullcalendar-interaction/main.js"></script>
<script src="${pageContext.request.contextPath }/resources/plugins/fullcalendar-timegrid/main.js"></script>


<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/dist/css/adminlte.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/plugins/fullcalendar/main.css">
<!-- Google Font: Source Sans Pro -->
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
	
<!-- Font Awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/plugins/fontawesome-free/css/all.min.css">
 

<%
	List<ScheduleVo> list = (ArrayList<ScheduleVo>)request.getAttribute("showSchedule");
%>
<title>Insert title here</title>
<script>
$(function(){
	// 메뉴를 선택하면 배경색이 변한다. 
	$('.selectable').click(function(){
//			alert($(this).text());
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
});

</script>
<style>
@keyframes blink{
0% {
	opacity:1;
}
50% {
	opacity:0;
}
100% {
	opacity:1;
}
}
.blink-image{
    -moz-animation:blink normal 2.5s infinite ease-in-out;
	-webkit-animation:blink normal 2.5s infinite ease-in-out;
    -ms-animation:blink normal 2.5s infinite ease-in-out;
    animation:blink normal 2.5s infinite ease-in-out;
}
body{
	min-width: 2000px;
	min-height: 1000px;
}			
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
	
	margin-top:0.5%;
}
th{
	width:300px; 
} 
.bottom{
	border: 1px solid lightgray; 
	width:48%; 
	height:700px; 	
	float:left; 
	background-color:white;	
				
	padding-top:2%;
	padding-bottom:2%;
	padding-left:4%;
	padding-right:4%;
	margin: auto;
	vertical-align: middle;
	horizontal-align: middle;  
	
	margin-top:0.5%;	
} 
.todoTable {
	width: 98%;
	border-collapse: collapse;
}	
#calendar { 
	width:700px;
	padding-left: 6%; 
} 
.fc-event {
    border: none;
}
.inbt{	
	background-color:white;
	border-radius: 15px;
	outline:none;	
}
.fc-sat, .fc-sun, .fc-mon, .fc-tue, .fc-wed, .fc-thu, .fc-fri {width:10px;} 
</style>
</head>
	 		
<body>
<div>	
	<div class="top" style="margin-left:1.5%;"><h4>프로젝트 현황</h4>
		<div class="mt-2" style="padding-top:2%;">
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
									<th></th>
								</tr>  
								<tbody id=memInProjectList> 
									<c:forEach items="${memInProjectList}" var="project" varStatus="sts" >
										<c:if test="${project.memId != SMEMBER.memId }">
										    <tr "data-privid="${project.reqId}">
												<td>
												<li class="nav-item">
													<a class="nav-link" href="${pageContext.request.contextPath}/mainpage/maindata?reqId=${project.reqId}">
												 		<i class="nav-icon fas fa-layer-group"></i><p class="selectable">${project.proName}</p>
												 	</a>
												</li> 
												</td> 
												<td>${project.reqId}</td>
												<td>${project.percent}</td>
												<td>${fn:substring(project.regDt,0,10)}</td>
												<td>	
					
													<c:choose>
														<c:when test="${not empty project.reqId}">
															<a class="nav-link" href="${pageContext.request.contextPath}/project/projectgetReq?reqId=${project.reqId}">
														 		<input class="inbt" type="button" value="들어가기">
														 	</a>
														
														</c:when>
														<c:otherwise>
															<a>참여중인 프로젝트가 없습니다.</a>
														</c:otherwise>
													</c:choose> 
	
												</td>	
											</tr>
										</c:if>
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
									<th></th>
								</tr> 
								<tbody id=plInProjectList> 
									<c:forEach items="${plInProjectList}" var="project" varStatus="sts" >
										<c:if test="${project.proName != '' and project.proName != null}">
										    <tr "data-privid="${project.reqId}">
												<td>
												<li class="nav-item">
													<a class="nav-link" href="${pageContext.request.contextPath}/mainpage/maindata?reqId=${project.reqId}">
												 		<i class="nav-icon fas fa-layer-group"></i><p class="selectable">${project.proName}</p>
												 	</a>
												</li>
												</td>
												<td>${project.reqId}</td>
												<td>${project.percent}</td>
												<td>${fn:substring(project.regDt,0,10)}</td>
												<td>
													<c:choose>
														<c:when test="${not empty project.reqId}">
															<a class="nav-link" href="${pageContext.request.contextPath}/project/projectgetReq?reqId=${project.reqId}">
														 		<input class="inbt" type="button" value="들어가기">
														 	</a>
														</c:when>
														<c:otherwise>
															<a>참여중인 프로젝트가 없습니다.</a>
														</c:otherwise>
													</c:choose>
												</td>	
											</tr>
										</c:if>
									</c:forEach> 
								</tbody>
							</table>
						</ul>
					</li>
				 </c:if>
				 
				 <!-- memType이 PM일때 -->
				 <c:if test="${not empty pmInProjectList}">
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
									<th></th>
								</tr> 	
								<tbody id=pmInProjectList> 
									<c:forEach items="${pmInProjectList}" var="project" varStatus="sts" >
										<c:if test="${project.proName != '' and project.proName != null}">
										    <tr "data-privid="${project.reqId}">
												<td>
												<li class="nav-item">
													<a class="nav-link" href="${pageContext.request.contextPath}/mainpage/maindata?reqId=${project.reqId}">
												 		<i class="nav-icon fas fa-layer-group"></i><p class="selectable">${project.proName}</p>
												 	</a> 
												</li>
												</td> 	
												<td>${project.reqId}</td>
												<td>${project.percent}</td>
												<td>${fn:substring(project.regDt,0,10)}</td>
												<td>	
													<c:choose> 
														<c:when test="${not empty project.reqId}">
															<a class="nav-link" href="${pageContext.request.contextPath}/project/projectgetReq?reqId=${project.reqId}">
														 		<input class="inbt" type="button" value="들어가기">
														 	</a>
															
														</c:when>
														<c:otherwise>
															<a>참여중인 프로젝트가 없습니다.</a>
														</c:otherwise>
													</c:choose>
												</td>	
											</tr>
										</c:if>
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
		</div>
	</div>
	
	
	
	
			
	<!-- 위 오른쪽 공지사항 -->
	<div class="top" style="margin-left:1%;"><h4>공지사항</h4>
		<div style="padding-top:7%; width:100%; height:100%">
			<table class="table">
				<thead>					
					<tr>					
						<th style="width: 150px; padding-left: 50px; text-align: center;">최신글</th>
						<th style="padding-left: 30px; text-align: center;" class="jg">  이슈 제목</th> 
						<th style="text-align: center;" class="jg">   작성자 </th>
						<th style="text-align: center;" class="jg">   날짜   </th>
					</tr>
				</thead>	
			<tbody>			 
				<c:forEach items = "${issuelist }" var ="issue" varStatus="status" end="4">
					<tr>	
						<td class="jg" style="width: 150px; padding-left: 50px; text-align: center;">
							<img src="../dist/img/new.png" class="blink-image">
							<%-- <c:out value="${  ((issueVo.pageIndex-1) * issueVo.pageUnit + (status.index+1))}"/>. --%>
						</td>
						<td class="jg"  style="padding-left: 30px; text-align: center;">
							<a href="${pageContext.request.contextPath}/projectMember/eachissueDetail?issueId=${issue.issueId}&reqId=${reqId}"> ${issue.issueTitle }</a> 
						</td>
								
						<td class="jg" style="text-align: center;"> ${issue.memId }</td>
						<td class="jg" style="text-align: center;"> ${issue.regDt }</td>
						
						<c:if test="${issue.issueKind == 'issue'}">
							<td style="text-align: center;" class="jg"> 이슈</td>										
						</c:if>
					</tr>
				</c:forEach> 
					<c:if test="${issuelist.size() == 0}">
						<td colspan="7" style="text-align: center;"  class="jg"><br> [ 결과가 없습니다. ] </td>
					</c:if>
			</tbody>
			</table>
		</div>
	</div> 

	
	<!-- 아래  -->
		<!-- 왼쪽 통계 -->
		<div class="bottom" style="margin-left:1.5%;"><h4>프로젝트 통계</h4><br>
			<img src="/dist/img/통계.gif" style="height: 100%; width: 100%; ">
		</div>
		  	
		<!-- 오른쪽 캘린더 -->
		<div class="bottom" style="margin-left:1%;"><h4>프로젝트 일정</h4>
        	<div id="calendar" style="margin-left:12%;"></div>
		</div>	
</div>
</body>
</html>