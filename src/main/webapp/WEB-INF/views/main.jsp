<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<!-- <div class="chatbot_container"> -->
<!-- 		<ul class="chatbot"> -->
<!-- 			<li class="menu_chat"><a class="menu_title" href="#">챗봇</a></li> -->
<!-- 		</ul> -->
<!-- </div> -->

<div class="main_container jg">
	
	
	<div style="height : 400px; background-color : lightblue;">
		<div class="conA" style="float : left; padding-left : 150px;">
			<div class="img1">
				<img src="${pageContext.request.contextPath }/resources/dist_main/img/mainimg.jpg"
					res=""><a class="menu_title" href="#">회원가입</a></img>
			</div>
		</div>
		
		<div style="float : right; padding-right : 150px;">
			div2
		</div>
	</div>

		<div class="conB_title">
			<h4>Ants 주요기능</h4>
		</div>
		<div class="conB_container">
			<div class="conB_small_container">
				<div class="conB_icon">
					<i class="fas fa-chart-bar icon"></i>
				</div>
				<div class="conB_content">
					<h3>팀사용량</h3>
					<p>Index 1</p>
				</div>
			</div>
			<div class="conB_small_container">
				<div class="conB_icon">
					<i class="fas fa-users icon"></i>
				</div>
				<div class="conB_content">
					<h3>조직관리</h3>
					<p>Index 2</p>
				</div>
			</div>
			<div class="conB_small_container">
				<div class="conB_icon">
					<i class="fas fa-file-download icon"></i>
				</div>
				<div class="conB_content">
					<h3>다운로드</h3>
					<p>Index 3</p>
				</div>
			</div>
		</div>
	</div>
</div>