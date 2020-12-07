<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>


</style>
<script>
	$(function(){
		// 메뉴를 선택하면 배경색이 변한다. 
		$('.selectable').click(function(){
// 			alert($(this).text());
			$('.selectable').parent().removeClass("active");
			$(this).parent().addClass("active");
		})
		
// 		$('.mkPjtBtn').click(function(){
// 			var plId = '${SMEMBER.memId}';
// 			$(location).attr('href', '/project/readReqList?plId='+plId);
// 		})
		
		
	})


</script>


<aside class="main-sidebar sidebar-light-teal elevation-4">
	<!-- Brand Logo -->
	<a href="/admin/adMainView" class="brand-link"> 
	<img src="/dist/img/AdminLoginImage.png" class="brand-image "style="float: none; margin: 15px 0px 10px 12px;">
	<img src="/dist/img/ants.png" style="width: 100px; margin: 0px 0px 0px 18px" >
	</a>

	<!-- Sidebar -->
	<div class="sidebar" style="font-size: 0.8em;">
		<!-- Sidebar Menu -->
		<nav class="mt-2">
			<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
				<li class="nav-item has-treeview menu-open">
		            <a href="#" class="nav-link active">
		              <i class="fas fa-newspaper"></i>
						<p>전체정보<i class="fas fa-angle-left right"></i></p>
		            </a>
		            <ul class="nav nav-treeview" style="display: block;">
		              <li class="nav-item">
		                <a href="${pageContext.request.contextPath}/admin/noticelist" class="nav-link">
		                 <i class="nav-icon fas fa-bullhorn"></i>
							<p class="selectable">공지사항</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="#" class="nav-link">
						<i class="nav-icon fas fa-bookmark"></i>
						<p class="selectable">IP 리스트</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="${pageContext.request.contextPath}/admin/admemberlist" class="nav-link">
						<i class="nav-icon far fa-lightbulb"></i>
						<p class="selectable">회원 리스트</p>
		                </a>
		              </li>
					</ul>
				</li><br>

					<br> 
					
				<li class="nav-item has-treeview menu-open">
					<c:choose>
						<c:when test="">
							<a href="#"	class="nav-link active"><i class="nav-icon fa fa-check"></i>
								<p>게시판<i class="fas fa-angle-left right"></i></p>
							</a>	
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="#" class="nav-link"><i	class="nav-icon fa fa-plus-square"></i>
										<p class="selectable mkPjtBtn">게시판  생성하기</p>
									</a>
								</li>
							</ul>
						</c:when>
					</c:choose>
				</li>
				<br>
				
				<!-- memType이 MEM일때  -->
				 <c:if test="${not empty memInProjectList}">
					<li class="nav-item has-treeview menu-open">
			            <a href="#" class="nav-link active">
				        	<i class="nav-icon fas fa-poll-h"></i>
							<p>생성된 프로젝트<i class="fas fa-angle-left right"></i></p>
						</a>
							
					    <ul class="nav nav-treeview" style="display: block;">
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
		<!-- /.sidebar-menu -->
	</div>
	<!-- /.sidebar -->
</aside>