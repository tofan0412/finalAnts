<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	$(function(){
		// 메뉴를 선택하면 배경색이 변한다. 
		$('.selectable').click(function(){
// 			alert($(this).text());
			$('.selectable').parent().removeClass("active");
			$(this).parent().addClass("active");
		})
		
		$('.mkPjtBtn').click(function(){
			var plId = '${SMEMBER.memId}';
			$(location).attr('href', '/project/readReqList?plId='+plId);
		})
		
		
	})


</script>
<style>
body{
	 background-color:white;
}
.top{
	font-size: 0.8em; 
	background-color:white; 
	min-height:300px;
	height:30%; 
	padding-top:2%;
	padding-bottom:2%;
	padding-left:4%;
	padding-right:4%;
}
th{
	width:300px; 
}
</style>
</head> 
  
<body>
	<div class="top">
		<nav class="mt-2">
			<table>
				<tr>
					<th>프로젝트명</th>
					<th>상태</th>
					<th>완료율</th>
					<th>시작일</th>
					<th>종료일</th>
				</tr>
			</table>
		
			<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
	<!-- memType이 MEM일때  -->
				 <c:if test="${not empty memInProjectList}">
					<li class="nav-item has-treeview menu-open">
			            <a href="#" class="nav-link active">
				        	<i class="nav-icon fas fa-poll-h"></i>
							<p>참여중인 프로젝트<i class="fas fa-angle-left right"></i></p>
						</a>
							
					    <ul class="nav nav-treeview" style="display: none;">
					    	<c:forEach items="${memInProjectList}" var="project">
						    	<li class="nav-item">
									<a class="nav-link" href="${pageContext.request.contextPath}/todo/projectgetReq?reqId=${project.reqId}">
								 		<i class="nav-icon fas fa-layer-group"></i><p class="selectable">${project.proName}</p>
								 	</a>
								</li> 
							</c:forEach>
						</ul>
					</li>
				 </c:if>
				 <!-- memType이 PL일때 -->
				 <c:if test="${not empty plInProjectList}">
					<li class="nav-item has-treeview menu-open">
			            <a href="#" class="nav-link active">
				        	<i class="nav-icon fas fa-poll-h"></i>
							<p>내가 PL인 프로젝트<i class="fas fa-angle-left right"></i></p>
						</a>
					    <ul class="nav nav-treeview" >
					    	<c:forEach items="${plInProjectList}" var="project">
						    	<li class="nav-item">
									<a class="nav-link" href="${pageContext.request.contextPath}/todo/projectgetReq?reqId=${project.reqId}">
								 		<i class="nav-icon fas fa-layer-group"></i><p>${project.proName}</p>
								 	</a>
								</li>
							</c:forEach>
						</ul>
					</li>
				 </c:if>
				 <!-- memType이 PM일때 -->
				 <c:if test="${not empty pmInProjectList}">
					<li class="nav-item has-treeview menu-open">
			            <a href="#" class="nav-link active">
				        	<i class="nav-icon fas fa-poll-h"></i>
							<p>프로젝트관리<i class="fas fa-angle-left right"></i></p>
						</a>
					    <ul class="nav nav-treeview" >
					    	<c:forEach items="${pmInProjectList}" var="project">
						    	<li class="nav-item">
									<a class="nav-link" href="${pageContext.request.contextPath}/todo/projectgetReq?reqId=${project.reqId}">
								 		<i class="nav-icon fas fa-layer-group"></i><p>${project.proName}</p>
								 	</a>
								</li>
							</c:forEach>
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
	<hr>
	
	
	<div>
		<div style="border: 1px solid lightgray; width:48%; height:500px; float:left; margin-left:1.5%; background-color:white;">1. 프로젝트별 통계<br>
			<img src="/dist/img/통계.gif" style="height: 100%; width: 100%; ">
		</div>
		<div style="border: 1px solid lightgray; width:48%; height:500px; float:left; margin-left:1%; background-color:white;">2. 프로젝트 일정<br>
			<img src="/dist/img/캘린.jpg" style="height: 100%; width: 100%; ">
		</div>
	</div>
	
	
</body>
</html>