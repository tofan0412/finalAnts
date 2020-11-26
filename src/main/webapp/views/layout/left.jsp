<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<aside class="main-sidebar sidebar-light-teal elevation-4">
	<!-- Brand Logo -->
	<a href="/index3.html" class="brand-link"> 
	<img src="/dist/img/antslogo.png" class="brand-image "style="float: none; margin: 15px 0px 10px 12px;">
	<img src="/dist/img/ants.png" style="width: 100px;">
	</a>

	<!-- Sidebar -->
	<div class="sidebar">
		<!-- Sidebar Menu -->
		<nav class="mt-2">
			<ul class="nav nav-pills nav-sidebar flex-column"
				data-widget="treeview" role="menu" data-accordion="false">
				<li class="nav-item has-treeview menu-open">
					<a href="#"	class="nav-link active">
					
					<i class="nav-icon fas fa-newspaper"></i>
						<p>전체정보</p>
					</a>
						<ul class="nav nav-treeview">
							<li class="nav-item">
								<a href="#" class="nav-link"> 
									<i class="nav-icon far fa-alert"></i>
										<p>새로운 소식</p>
								</a>
							</li>
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-bookmarks-outline nav-icon"></i>
										<p>북마크</p>
								</a>
							</li>
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-alert-circle-outline nav-icon"></i>
										<p>내가작성한 이슈</p>
								</a>
							</li>
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="far calendar-outline nav-icon"></i>
										<p>전체캘린더</p>
								</a>
							</li>
	
							<!-- PL or PM일경우!!조건걸어서  -->
							<!-- 						<li class="nav-item"><a href="#" class="nav-link"> <i -->
							<!-- 								class="far fa-circle nav-icon"></i> -->
							<!-- 								<p>PM-PL이슈게시판</p> -->
							<!-- 						</a></li> -->
	
						</ul>
					</li>
				<br>

				<li class="nav-item has-treeview menu-close">
					<a href="#"	class="nav-link active"><i class="nav-icon fas fa-tachometer-alt"></i>
						<p>개인공간</p>
					</a>
					<ul class="nav nav-treeview">
						<li class="nav-item">
						<a href="#" class="nav-link"><i	class="far fa-circle nav-icon"></i>
							<p>개인공간</p>
						</a></li>
					</ul></li>

				<br>
				<li class="nav-item has-treeview menu-close">
					<a href="#"	class="nav-link active">
					<i class="nav-icon fas fa-tachometer-alt"></i>
						<p>	진행중인 프로젝트 <i class="right fas fa-angle-left"></i></p></a>
				<!-- 프로젝트 목록 불러오기 -->
					<ul class="nav nav-treeview">
						<li class="nav-item"><a href="#" class="nav-link">
						<i	class="far fa-circle nav-icon"></i><p>프로젝트명</p></a></li>
						<li class="nav-item"><a href="#" class="nav-link">
						<i	class="far fa-circle nav-icon"></i><p>프로젝트명</p></a></li>
					</ul>
				</li>
			</ul>
		</nav>
		<!-- /.sidebar-menu -->
	</div>
	<!-- /.sidebar -->
</aside>