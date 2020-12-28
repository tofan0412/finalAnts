 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

   <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="${pageContext.request.contextPath}/member/mainView" class="nav-link">Home</a>
      </li>
    </ul>


    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
      <li class="jg" style="padding-top : 5px;">
      	<c:if test="${SADMIN.adminId ne null }">
    	  환영합니다, 관리자님!
   		</c:if>
<%--    		<c:if test="${projectId ne null }"> --%>
<%--     	  현재 프로젝트 번호 : ${projectId} --%>
<%--    		</c:if> --%>
   		
      </li>
      
      
		<!-- 관리자 메뉴바 -->
		<li class="nav-item dropdown">
			<a class="nav-link" data-toggle="dropdown" href="#">
			  <i class="fas fa-users-cog"></i>
			</a>
			<div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
				<a href="#" class="dropdown-item">
				<!-- Message Start -->
				<div class="media">
					<img src="/dist/img/user1-128x128.jpg" alt="User Avatar" class="img-size-50 mr-3 img-circle">
					<div class="media-body">
						<h3 class="dropdown-item-title">
						Brad Diesel
						<span class="float-right text-sm text-danger"><i class="fas fa-star"></i></span>
						</h3>
						<p class="text-sm">Call me whenever you can...</p>
						<p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
					</div>
				</div>
				<!-- Message End -->
				</a>
				<div class="dropdown-divider"></div>
				<a href="#" class="dropdown-item">
				</a>
				<div class="dropdown-divider"></div>
				<a href="#" class="dropdown-item">
				</a>
				<div class="dropdown-divider"></div>
				<a href="#" class="dropdown-item dropdown-footer">See All Messages</a>
			</div>
		</li>
      
       <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="far fa-user-circle"></i>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
<!--           <div class="dropdown-divider"></div> -->
<!--           <a href="/member/profile" class="dropdown-item"> -->
<!--             <i class="fas fa-user-edit mr-2"></i>프로필 -->
<!--           </a> -->
          
<!--           <div class="dropdown-divider"></div> -->
<!--           <a href="#" class="dropdown-item"> -->
<!--             <i class="fas fa-bell mr-2"></i>알림설정 -->
<!--           </a> -->
          
          <div class="dropdown-divider"></div>
          <a href="${pageContext.request.contextPath}/admin/adlogout" class="dropdown-item">
            <i class="fas fa-toggle-off mr-2"></i>로그아웃
          </a>
        </div>
          
      </li>
      <!-- right side bar -->
      <li class="nav-item">
        <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button">
          <i class="fas fa-th-large"></i>
        </a>
      </li>
      
      
    </ul>
  </nav>
  <!-- /.navbar -->