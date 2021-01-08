<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>


</style>
<script>
	$(function(){
		// 메뉴를 선택하면 배경색이 변한다. 
		$('.selectable').click(function(){
			$('.selectable').parent().removeClass("active");
			$(this).parent().addClass("active");
		})
		
	})


</script>


<aside class="main-sidebar sidebar-light-teal elevation-4" >
	<!-- Brand Logo -->
	<div style="margin: 20px 20px 20px 3px; min-width: max-content;">
		<a href="${pageContext.request.contextPath}/admin/adMainView" class="brand-link" style="border-bottom: none;"> 
			<img src="${pageContext.request.contextPath}/resources/dist/img/adminicon.png" alt="이미지" style="float: none;width: 60px;margin: 15px 8px 10px 0px;height: 50px; background-color: white">
			<img src="${pageContext.request.contextPath}/resources/dist/img/ants.png" style="width: 100px;">
		</a>
	</div>

	<!-- Sidebar -->
	<div class="sidebar" style="font-size: 0.8em;">
		<!-- Sidebar Menu -->
		<nav class="mt-2">
		
			<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
			
				<li class="nav-item has-treeview menu-open" >
		            <a href="#" class="nav-link active">
		              <i class="nav-icon fas fa-newspaper"></i>
						<p class="jg">전체정보<i class="fas fa-angle-left right"></i></p>
		            </a>
		            <ul class="nav nav-treeview" style="display: block;">
		            
		              <li class="nav-item">
		                <a href="${pageContext.request.contextPath}/admin/noticelist" class="nav-link" >
		                 <i class="nav-icon fas fa-clipboard-list"></i>
							<p class="selectable jg">공지사항</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="${pageContext.request.contextPath}/admin/memberlist" class="nav-link" >
						<i class="nav-icon fas fa-address-book"></i>
						<p class="selectable jg">회원 리스트</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="/admin/ipMain" class="nav-link" >
						<i class="nav-icon fas fa-unlock-alt"></i>
						<p class="selectable jg">관리자 허용ip 리스트</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="${pageContext.request.contextPath}/admin/projectlist" class="nav-link" >
		                 <i class="nav-icon fas fa-tasks"></i>
							<p class="selectable jg">프로젝트 목록</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="${pageContext.request.contextPath}/msg/msgList" class="nav-link" >
		                 <i class="nav-icon fas fa-envelope"></i>
							<p class="selectable jg">쪽지 관리</p>
		                </a>
		              </li>
		              
					</ul>
				</li><br>
				 
			</ul>
			
		</nav>
		<!-- /.sidebar-menu -->
	</div>
	<!-- /.sidebar -->
</aside>