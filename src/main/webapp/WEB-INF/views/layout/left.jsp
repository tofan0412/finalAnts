<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<aside class="main-sidebar sidebar-light-teal elevation-4">
	<!-- Brand Logo -->
	<a href="/index3.html" class="brand-link"> 
	<img src="/dist/img/antslogo.png" class="brand-image "style="float: none; margin: 15px 0px 10px 12px;">
	<img src="/dist/img/ants.png" style="width: 100px;">
	</a>

	<!-- Sidebar -->
	<div class="sidebar" style="font-size: 0.8em;">
		<!-- Sidebar Menu -->
		<nav class="mt-2">
			<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
				<li class="nav-item has-treeview menu-open">
		            <a href="#" class="nav-link">
		              <i class="nav-icon fas fa-newspaper"></i>
						<p>전체정보<i class="fas fa-angle-left right"></i></p>
		            </a>
		            <ul class="nav nav-treeview" style="display: block;">
		              <li class="nav-item">
		                <a href="#" class="nav-link">
		                 <i class="nav-icon fas fa-bullhorn"></i>
							<p>새로운 소식</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="#" class="nav-link">
						<i class="nav-icon fas fa-bookmark"></i>
						<p>북마크</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="#" class="nav-link">
						<i class="nav-icon far fa-lightbulb"></i>
						<p>내가작성한 이슈</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="#" class="nav-link">
		                <i class="nav-icon far fa-calendar-alt"></i>
						<p>전체캘린더</p>
		                </a>
		              </li>
					</ul>
				</li><br>

				<li class="nav-item has-treeview ">
		            <a href="#" class="nav-link">
			        	<i class="nav-icon fas fa-user-lock"></i>
						<p>개인공간<i class="fas fa-angle-left right"></i></p>
			        </a>
			        <ul class="nav nav-treeview" >
			        	<li class="nav-item">
			                <a href="#" class="nav-link">
			                	<i class="nav-icon fas fa-folder-open"></i>
								<p>파일함</p>
			                </a>
			            </li>
					</ul>
				</li>
					<br>
				<li class="nav-item has-treeview menu-open">
					<c:choose>
						<c:when test="${SMEMBER.memType eq 'PM' }">
							<a href="#"	class="nav-link active"><i class="nav-icon fa fa-check"></i>
								<p>요구사항공간<i class="fas fa-angle-left right"></i></p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="/req/reqList" class="nav-link"><i class=" nav-icon fas fa-clipboard-list"></i>
										<p>요구사항정의서 관리</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="/req/reqInsertView" class="nav-link"><i	class="nav-icon fa fa-plus-square"></i>
										<p>요구사항정의서  생성하기</p>
									</a>
								</li>
							</ul>	
						</c:when>
						<c:when test="${SMEMBER.memType ne 'PM' }">
							<a href="#"	class="nav-link active"><i class="nav-icon fa fa-check"></i>
								<p>협업공간</p>
							</a>	
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="#" class="nav-link"><i	class="nav-icon fa fa-plus-square"></i>
										<p>프로젝트  생성하기</p>
									</a>
								</li>
							</ul>
						</c:when>
					</c:choose>
				</li>
				<br>
				
				<!-- memType이 MEM일때  -->
				 <c:if test="${projectList ne null}">
					<li class="nav-item has-treeview menu-open">
			            <a href="#" class="nav-link">
				        	<i class="nav-icon fas fa-poll-h"></i>
							<p>진행중인 프로젝트<i class="fas fa-angle-left right"></i></p>
						</a>
							
					    <ul class="nav nav-treeview" style="display: block;">
					    	<c:forEach items="${projectList}" var="project">
						    	<li class="nav-item">
									<a class="nav-link" href="${pageContext.request.contextPath}/todo/projectgetReq?reqId=${project.reqId}">
								 		<i class="nav-icon fas fa-layer-group"></i><p>${project.proName}</p>
								 	</a>
								</li>
							</c:forEach>
						</ul>
					</li>
				 </c:if>
				 <!-- memType이 PM,PL일때 -->
				 <c:if test="${plpmList ne null}">
					<li class="nav-item has-treeview menu-open">
			            <a href="#" class="nav-link">
				        	<i class="nav-icon fas fa-poll-h"></i>
							<p>진행중인 프로젝트<i class="fas fa-angle-left right"></i></p>
						</a>
					    <ul class="nav nav-treeview" >
					    	<c:forEach items="${plpmList}" var="project">
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
				 <c:if test="${projectList eq null and plpmList eq null}">
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