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
	
							<!-- PL or PM일경우!!조건걸어서  -->
							<!-- 						<li class="nav-item"><a href="#" class="nav-link"> <i -->
							<!-- 								class="nav-icon far fa-copy"></i> -->
							<!-- 								<p>PM-PL이슈게시판</p> -->
							<!-- 						</a></li> -->
	
						</ul>
					</li>
				<br>

				<li class="nav-item has-treeview menu-close">
					<a href="#"	class="nav-link active"><i class="nav-icon fas fa-user-lock"></i>
						<p>개인공간</p>
					</a>
					<ul class="nav nav-treeview">
						<li class="nav-item">
						<a href="#" class="nav-link"><i	class="nav-icon far fa-folder-open"></i>
							<p>파일함</p>
						</a></li>
					</ul></li>

				<br>
				<li class="nav-item has-treeview menu-close">
					<a href="#"	class="nav-link active">
					 <i class="nav-icon fas fa-poll-h"></i>
						<p>	진행중인 프로젝트</p></a>
				<!-- 프로젝트 목록 불러오기 -->
					<ul class="nav nav-treeview">
						<li class="nav-item"><a href="#" class="nav-link">
						<i	class="nav-icon fas fa-layer-group"></i><p>프로젝트명</p></a></li>
						<li class="nav-item"><a href="#" class="nav-link">
						<i	class="nav-icon fas fa-layer-group"></i><p>프로젝트명</p></a></li>
					</ul>
				</li>
			</ul>
		</nav>
		<!-- /.sidebar-menu -->
	</div>
	<!-- /.sidebar -->
</aside>