<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@page import="java.util.ArrayList"%>
<%@page import="ants.com.board.memBoard.model.ScheduleVo"%>
<%@page import="java.util.List"%>

<script src="https://cdn.jsdelivr.net/npm/@shopify/draggable@1.0.0-beta/lib/draggable.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/plugins/moment/moment.min.js"></script>



<!-- Font Awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/plugins/fontawesome-free/css/all.min.css">
 
<%
	List<ScheduleVo> list = (ArrayList<ScheduleVo>)request.getAttribute("showSchedule");
%>
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
	width:100%;
	padding-left: 6%; 
} 		
.fc-event {
    border: none;
}	
.inbt{		
	border: 1px solid;
	background-color:white;
	border-radius: 15px;
	outline:none;	
	font-size: 6px;	
}		
.fc-sat, .fc-sun, .fc-mon, .fc-tue, .fc-wed, .fc-thu, .fc-fri {width:10px;} 


.container{
	padding-bottom:3%;
}
.panel-heading{
	padding-left:10px;
	background-color:#6495ED; 
	border:2px solid lightgray; 
	border-radius:5px; 
	height:36px;	
}			
.divtitle{
	color:white;
	font-size:15px;
	font-weight:bold;
}	
body{
	min-width:1000px;
}
</style>
	 				
<body>
<div>	
	<div class="top" style="margin-left:1.5%;"><h4>프로젝트 현황</h4>
		<div class="mt-2" style="padding-top:2%;">
			<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
				
				<!-- memType이 MEM일때  -->
				 <c:if test="${not empty memInProjectList}">
					<div class="container">
					  <div class="panel-group">
					    <div class="panel panel-default">
					      <div class="panel-heading">
					        <h4 class="panel-title">			
					          <a data-toggle="collapse" href="#collapse1" class="divtitle">참여중인 프로젝트</a>
					        </h4>	
					      </div> 	
					      <div id="collapse1" class="panel-collapse collapse">
					        <div class="panel-body">
						       	
						        <table class="todoTable" style="margin-left:3%">
									<tr>
										<th style="width:43.5%;">프로젝트명</th>
										<th>완료율</th>	
										<th>생성일</th>			
										<th></th>		
									</tr>  								
									<tbody id=memInProjectList> 	
										<c:forEach items="${memInProjectList}" var="project" varStatus="sts" >
											<c:if test="${project.memId != SMEMBER.memId }">
											    <tr "data-privid="${project.reqId}" style="height:27px;">
													<td>	
														<a href="${pageContext.request.contextPath}/mainpage/maindata?reqId=${project.reqId}&proName=${project.proName}">${project.proName}</a>
													</td>  
													<td>
														<c:choose>
															<c:when test="${not empty project.percent}">
																${project.percent} % 
															</c:when>
															<c:otherwise>
																0 % 
															</c:otherwise>
														</c:choose> 
													</td>	
													<td>${fn:substring(project.regDt,0,10)}</td>
													<td>	
														<c:choose>
															<c:when test="${not empty project.reqId}">
																<a href="${pageContext.request.contextPath}/project/projectgetReq?reqId=${project.reqId}">
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
							
					        </div>
					      </div>
					    </div>
					  </div>
					</div>
				 </c:if>
				
				 <!-- memType이 PL일때 -->
				 <c:if test="${not empty plInProjectList}">
				
					<div class="container">
					  <div class="panel-group">
					    <div class="panel panel-default">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					          <a data-toggle="collapse" href="#collapse2" class="divtitle">내가 PL인 프로젝트</a>
					        </h4>
					      </div>			
					      <div id="collapse2" class="panel-collapse collapse show">
					        <div class="panel-body">
					       
						      <table class="todoTable" style="margin-left:3%">
									<tr>
										<th style="width:43.5%;">프로젝트명</th>
										<th>완료율</th>
										<th>생성일</th>
										<th></th>			
									</tr> 		
									<tbody id=plInProjectList> 
										<c:forEach items="${plInProjectList}" var="project" varStatus="sts" >
											<c:if test="${project.proName != '' and project.proName != null}">
											    <tr "data-privid="${project.reqId}" style="height:27px;">
													<td>	
														<a href="${pageContext.request.contextPath}/mainpage/maindata?reqId=${project.reqId}&proName=${project.proName}">${project.proName}</a>
													</td>	
													<td>	  						
														<c:choose>		
															<c:when test="${not empty project.percent}">
																${project.percent} % 
															</c:when>
															<c:otherwise>
																0 % 
															</c:otherwise>
														</c:choose> 
													</td>
													<td>${fn:substring(project.regDt,0,10)}</td>
													<td>
														<c:choose>
															<c:when test="${not empty project.reqId}">
																<a href="${pageContext.request.contextPath}/project/projectgetReq?reqId=${project.reqId}">
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
							
					        </div>
					      </div>
					    </div>
					  </div>
					</div>
				 </c:if>
				 		
				 <!-- memType이 PM일때 -->
				 <c:if test="${not empty pmInProjectList}">
					<div class="container">
					  <div class="panel-group">
					    <div class="panel panel-default">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					          <a data-toggle="collapse" href="#collapse3" class="divtitle">프로젝트 관리(PM)</a>
					        </h4>
					      </div>			
					      <div id="collapse3" class="panel-collapse collapse show">
					        <div class="panel-body">
					       
							  <table class="todoTable" style="margin-left:3%">
									<tr>
										<th  style="width:43.5%;">프로젝트명</th>
										<th>완료율</th>
										<th>생성일</th>
										<th></th>
									</tr>		
									<tbody id=pmInProjectList> 
										<c:forEach items="${pmInProjectList}" var="project" varStatus="sts" >
											<c:if test="${project.proName != '' and project.proName != null}">
											    <tr "data-privid="${project.reqId}" style="height:27px;">
													<td>
														<a href="${pageContext.request.contextPath}/mainpage/maindata?reqId=${project.reqId}&proName=${project.proName}">${project.proName}</a> 
													</td> 		
													<td>		
														<c:choose>
															<c:when test="${not empty project.percent}">
																${project.percent} % 
															</c:when>
															<c:otherwise>
																0 % 
															</c:otherwise>
														</c:choose> 
													</td>	
													<td>${fn:substring(project.regDt,0,10)}</td>	
													<td>
														<c:choose> 
															<c:when test="${not empty project.reqId}">
																<a href="${pageContext.request.contextPath}/project/projectgetReq?reqId=${project.reqId}">
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
							
					        </div>
					      </div>
					    </div>
					  </div>
					</div>
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
	<div class="top" style="margin-left:1%;"><h4>공지사항( ${proName} )</h4>
		<div style="padding-top:7%; width:100%; height:90%">
			<table class="table"> 
				<thead>						
					<tr>							
						<th style="width: 150px; padding-left: 50px; text-align: center;">최신글</th>
						<th style="padding-left: 30px; text-align: center;" class="jg">  이슈 제목</th> 
						<th style="text-align: center;" class="jg">   작성자 </th>
						<th style="text-align: center; width: 200px;" class="jg">   날짜   </th>
					</tr>
				</thead>	
			<tbody>			 	
				<c:forEach items = "${issuelist }" var ="issue" varStatus="status" end="6">
					<c:set var="issueDt1" value="${fn: replace(issue.regDt,'-','')}"/> 		
						<c:set var="issueDt2" value="${fn: substringBefore(issueDt1,' ')}"/> 	
						<fmt:parseNumber var="issueDt3" value="${issueDt2 + 3}" integerOnly="true"/>
							
						<jsp:useBean id="now" class="java.util.Date"/>
						<fmt:formatDate var="today1" value="${now}" pattern="yyyyMMdd"/>
						<c:set var="today2" value="${fn: replace(today1,'-','')}"/> 	
						<fmt:parseNumber var="today3" value="${today2}" integerOnly="true"/>
						
						<c:set var="day" value="${issueDt3 - today2}"/>	
								
					<c:if test="${day >= 0}">
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
					</c:if>
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
			<img src="/dist/img/통계.gif" style="height: 90%; width: 100%; ">
		</div>
		  	
		<!-- 오른쪽 캘린더 -->
		<div class="bottom" style="margin-left:1%;"><h4>프로젝트 일정</h4>
        	<div id="calendar"></div>
		</div>	
</div>
</body>