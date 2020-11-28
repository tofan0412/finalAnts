<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<!-- <div class="chatbot_container"> -->
<!-- 		<ul class="chatbot"> -->
<!-- 			<li class="menu_chat"><a class="menu_title" href="#">챗봇</a></li> -->
<!-- 		</ul> -->
<!-- </div> -->

<style>
#main-left{
	float : left; 
	padding-left : 350px;
	padding-top : 100px;
}
#main-left-top{
	font-size : 3.5em; 
    color: white;
    line-height : 1.2em;
}
#main-left-bottom{
	font-size : 1.5em; 
    color : white;
}
#main-left-button{
	padding-top: 20px;
	padding-left : 20px;
}
.main-right{
	padding-top : 120px;
	float : right; 
	padding-right : 150px;
}

.shadow-pop-tr {
	-webkit-animation: shadow-pop-tr 0.3s linear both;
	        animation: shadow-pop-tr 0.3s linear both;
}
.text-focus-in {
	-webkit-animation: text-focus-in 1s cubic-bezier(0.550, 0.085, 0.680, 0.530) both;
	        animation: text-focus-in 1s cubic-bezier(0.550, 0.085, 0.680, 0.530) both;
}

.main_container{
	z-index : 2;
}
</style>
<div class="main_container jg">
	
	
	<div style="height : 600px; 
			background-image : 
			url('${pageContext.request.contextPath}/resources/dist_main/img/main_background.png');">
		
		<div id="main-left" class="text-focus-in">
			<div id="main-left-top">효과적인 팀워크<br>가벼워진 업무,<br>협업툴 Ants</div><br>
			<div id="main-left-bottom">이메일이 필요없는 간편한 소통과 파일 공유,<br>빠른 피드백 확인까지.<br>바라던 기능들을 모두 담았습니다.</div>
			
			<div id="main-left-button">
				<button>도입 문의</button>&nbsp;&nbsp;&nbsp;&nbsp;<button>회원가입</button>
			</div>
		</div>
		
		<div class="conA main-right">
			<div class="img1" >
				<img class="shadow-pop-tr" src="${pageContext.request.contextPath }/resources/dist_main/img/main_right_img.png"
					res=""></img>
			</div>
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
						<div class="conB_small_container">
				<div class="conB_icon">
					<i class="fas fa-file-download icon"></i>
				</div>
				<div class="conB_content">
					<h3>내용추가</h3>
					<p>Index 4</p>
				</div>
			</div>
						<div class="conB_small_container">
				<div class="conB_icon">
					<i class="fas fa-file-download icon"></i>
				</div>
				<div class="conB_content">
					<h3>내용추가</h3>
					<p>Index 5</p>
				</div>
			</div>
		</div>
	</div>
	<br>
	
	<div class="conB" style="position: relative; height:0; padding-bottom: 50.25%;">
		Ants 데모 영상<br>
		<iframe width="853" height="480" 
		src="https://www.youtube.com/embed/vO-kmDarLwM" 
		frameborder="0" allow="accelerometer; autoplay; 
		clipboard-write; encrypted-media; gyroscope; 
		picture-in-picture" allowfullscreen
		style="position: absolute; top:25%; left:25%;"
		>
		</iframe>
	</div>
	<br>
	<div class="conB">다음 내용</div>
	<br>
	<div class="conB">다음 내용</div>
	<br>
	<div class="conB">다음 내용</div>
	<br>
	
	
</div>