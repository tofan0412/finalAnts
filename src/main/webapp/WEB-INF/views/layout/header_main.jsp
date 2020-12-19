<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
header{
	position : fixed;
	top: 0;
	background-color : white;
  	/* width: 100% */
  	left: 0;
  	right: 0;
  	z-index: 3;
}
</style>
<script>
$(function(){
	$('#login').on('click', function(){
		$(location).attr('href', '/member/loginView');
	})
	$('#admin').on('click', function(){
		$(location).attr('href', '/admin/adloginView');
	})
})
</script>

<header>
	<div class="header_container">
		<div class="logo_container jg">
		 	<img alt="mainlogo" width=50px; height=50px; 
		 	src="${pageContext.request.contextPath }/resources/dist_main/img/main_logo.png" >
			<a href="/member/mainView">ANTS</a>
		</div>
		<div class="nav_container" id="nav_menu">

			<div class="login_container">
				<ul class="login" style="padding-top : 13px;">
					<button class="jg" id="admin" style="height : 45px; padding-top : 5px;">관리자</button>
					<button class="jg" id="login" style="height : 45px; padding-top : 5px;">로그인</button>
				</ul>
			</div>
		</div>
	</div>
</header>