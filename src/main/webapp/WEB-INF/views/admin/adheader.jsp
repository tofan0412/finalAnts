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

    <!-- SEARCH FORM -->
    <form class="form-inline ml-3">
      <div class="input-group input-group-sm">
        <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
        <div class="input-group-append">
          <button class="btn btn-navbar" type="submit">
            <i class="fas fa-search"></i>
          </button>
        </div>
      </div>
    </form>

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