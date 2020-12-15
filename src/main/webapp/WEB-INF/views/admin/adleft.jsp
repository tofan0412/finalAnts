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


<aside class="main-sidebar sidebar-light-teal elevation-4" >
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
						<i class="nav-icon fas fa-network-wired"></i>
						<p class="selectable jg">관리자 허용ip 리스트</p>
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