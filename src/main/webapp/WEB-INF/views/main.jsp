<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!-- ytp-large-play-button ytp-button : youtube 실행 버튼 -->

<style>
#main-left{
	float : left; 
	padding-left : 300px;
	padding-top : 130px;
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
   	-webkit-animation: fadein 2.5s; /* Safari and Chrome */
    border-radius: 0.6rem;
}

@-webkit-keyframes fadein { /* Safari and Chrome */
    from {
        opacity:0;
    }
    to {
        opacity:1;
    }
}

.text-focus-in {
	-webkit-animation: text-focus-in 1s cubic-bezier(0.550, 0.085, 0.680, 0.530) both;
    animation: text-focus-in 1s cubic-bezier(0.550, 0.085, 0.680, 0.530) both;
}

.main_container{
	z-index : 2;
	overflow:hidden;
	height:auto;
	width : 100%;
}
.content{
	overflow:hidden;
	height:auto;
	padding-top : 120px;
	padding-bottom : 120px;
	
}
.content-text-left{
	float : left; 
	padding-top : 50px;
	padding-left : 200px;
	font-size : 1.3em;
}
.content-text-right{
	float : right; 
	padding-top : 50px;
	padding-right : 200px;
	font-size : 1.3em;
}
.img{
	width : 600px;
	height : 400px;
}
.introText{
	padding-top : 200px;
}
</style>
	
<!-- Channel Plugin Scripts -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(function() {
		var w = window;
		if (w.ChannelIO) {
			return (window.console.error || window.console.log || function() {
			})('ChannelIO script included twice.');
		}
		var ch = function() {
			ch.c(arguments);
		};
		ch.q = [];
		ch.c = function(args) {
			ch.q.push(args);
		};
		w.ChannelIO = ch;
		function l() {
			if (w.ChannelIOInitialized) {
				return;
			}
			w.ChannelIOInitialized = true;
			var s = document.createElement('script');
			s.type = 'text/javascript';
			s.async = true;
			s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
			s.charset = 'UTF-8';
			var x = document.getElementsByTagName('script')[0];
			x.parentNode.insertBefore(s, x);
		}
		if (document.readyState === 'complete') {
			l();
		} else if (window.attachEvent) {
			window.attachEvent('onload', l);
		} else {
			window.addEventListener('DOMContentLoaded', l, false);
			window.addEventListener('load', l, false);
		}

		sc16 = 1;
		sc21 = 1;
		sc27 = 1;
		sc32 = 1;
		scEnd = 1;
		$(window).on('scroll', function() {
			$('#scrollVal').val(window.scrollY);
			if ($('#scrollVal').val() >= 1600 && sc16 == 1) { // 한 눈에 볼 수 있는 프로젝트 진행도
				setTimeout(function(){
					$('#statisticsImg').css("-webkit-animation", "fadein 2.5s");
				}, 2000);
				sc16 = 0;
			}

			if ($('#scrollVal').val() >= 2100 && sc21 == 1) { // 팀원간 대화를 간편하게
				setTimeout(function(){
					$('#chattingImg').css("-webkit-animation", "fadein 2.5s");
				}, 2000);
				sc21 = 0;
			}

			if ($('#scrollVal').val() >= 2700 && sc27 == 1) { // 간편한 일정 공유
				setTimeout(function(){
					$('#calendarImg').css("-webkit-animation", "fadein 2.5s");
				}, 2000);
				sc27 = 0;
			}

			if ($('#scrollVal').val() >= 3200 && sc32 == 1) { // 편리한 공용 파일함
				setTimeout(function(){
					$('#fileHamImg').css("-webkit-animation", "fadein 2.5s");
				}, 2000);
				sc32 = 0;
			}

			if ($('#scrollVal').val() >= 3440 && scEnd == 1) { // 마지막 부분
				setTimeout(function(){
					
				}, 2000);
				scEnd = 0;
			}
		})
		ChannelIO('boot', {
			"pluginKey" : "9fecedd4-d5c5-4ee5-bdcc-ddf8f29b6c2e"
		});
	});
</script>
<!-- End Channel Plugin -->

<div class="main_container jg">
    <input id="scrollVal" type="text" hidden="hidden" readonly/>
	
	<div style="height : 600px; 
			background-image : 
			url('${pageContext.request.contextPath}/resources/dist_main/img/main_background.png');">
		
		<div id="main-left" class="text-focus-in">
			<div id="main-left-top">효과적인 팀워크<br>가벼워진 업무,<br>협업툴 Ants</div><br>
			<div id="main-left-bottom">이메일이 필요없는 간편한 소통과 파일 공유,<br>빠른 피드백 확인까지.<br>바라던 기능들을 모두 담았습니다.</div>
			
			<div id="main-left-button">
				<a href="/member/noticelistmemview?main=Y" style="color: #0BB783;"><button>공지사항</button></a>&emsp; 
				
				<a href="/member/memberRegistview" style="color: #0BB783;"><button>회원가입</button></a>
			</div>
		</div>
				
		<div class="conA main-right">
			<div class="img1" style="overflow : hidden;">
				<img class="shadow-pop-tr" 
					src="${pageContext.request.contextPath }/resources/dist_main/img/main_right_img.png"/>
			</div>
		</div>
	</div>

	<div class="conB" style="float : bottom; ">
		<div class="conB_title">
			<h1>Ants 주요기능</h1>
		</div>
		<div class="conB_container">
			
			<div class="conB_small_container">
				<div class="conB_icon">
					<i class="fas fa-chart-bar icon"></i>
				</div>
                <div class="conB_content">
					<h3>GANTT 및 통계</h3>
					<p>프로젝트를 한 눈에 <br>살펴볼 수 있습니다.</p>
				</div>
			</div>
			
			<div class="conB_small_container">
				<div class="conB_icon">
					<i class="fas fa-users icon"></i>
				</div>
                <div class="conB_content">
					<h3>대화방</h3>
					<p>팀원끼리 빠르게<br>메시지를 보내보세요</p>
				</div>
			</div>
			
			<div class="conB_small_container">
				<div class="conB_icon">
					<i class="fas fa-calendar icon"></i>
				</div>
                <div class="conB_content">
					<h3>간편한 일정 공유</h3>
					<p>서로의 일정을<br> 한 눈에 확인할 수 있습니다.</p>
				</div>
			</div>
			
			<div class="conB_small_container">
				<div class="conB_icon">
					<i class="fas fa-file-download icon"></i>
				</div>
                <div class="conB_content">
					<h3>편리한 공용 파일함</h3>
					<p>필요한 파일이 있으면<br> 언제든지</p>
				</div>
			</div>
		</div>
	</div>
	
	<div style="position: relative; height:0; padding-bottom: 50.25%;
	background-image : 
	url('${pageContext.request.contextPath}/resources/dist_main/img/main_youtube_background.png');">
		<div class="conB_title">
			<br>
			<h1>Ants 데모영상</h1>
		</div>
		
		<iframe width="50%" height="520px" src="https://www.youtube.com/embed/7EUgq6Qle4M" 
			frameborder="0" allow="accelerometer; autoplay; 
			clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
			allowfullscreen style="margin-left : 25%;">
		</iframe>
		
	</div>
	
	<div class="content" style="float : bottom;">
		<div class="conB_title">
			<h1>한 눈에 볼 수 있는 프로젝트 진행도</h1>
		</div>
		
		<div class="content-text-left">
			<img class="img" id="statisticsImg" alt="간트차트 페이지" src="${pageContext.request.contextPath }/resources/dist_main/img/mainIntroImg/GANTT.png">
		</div>
		
		<div class="content-text-right introText" id="statistics">
       		월별 관리부터 현재 프로젝트의 진행 상황 등 GANTT 차트와<br> 
           	다양한 통계를 통해 프로젝트를 보다 효과적으로 관리할 수 있습니다.
		</div>
		
	</div>
	<br>
	
	<div class="content" style="float : bottom; ">
		<div class="conB_title">
			<h1>팀원 간 대화를 간편하게</h1>
		</div>

		<div class="content-text-left introText" id="chatting">
			메신저를 사용하지 않아도 프로젝트를 진행하면서<br>
			간편하게 팀원 간 메시지를 주고 받을 수 있습니다.
		</div>
		
		<div class="content-text-right">
			<img class="img" style="width : 100%;" id="chattingImg" alt="메시지 이미지" src="${pageContext.request.contextPath }/resources/dist_main/img/mainIntroImg/chatting.png">
		</div>
		
	</div>
	<br>
	
	<div class="content" style="float : bottom; ">
		<div class="conB_title">
			<h1>간편한 일정 공유</h1>
		</div>

		<div class="content-text-left introText" id="calendar">
			공용 캘린더를 통해 팀원 간의 일정을 <br>
			손쉽게 확인할 수 있습니다.
		</div>
		
		<div class="content-text-right">
			<img class="img" id="calendarImg" alt="캘린더 이미지" src="${pageContext.request.contextPath }/resources/dist_main/img/mainIntroImg/calendar.png">
		</div>
	</div>
	<br>
	
	<div class="content" style="float : bottom; ">
		<div class="conB_title">
			<h1>편리한 공용 파일함</h1>
		</div>

		<div class="content-text-left">
			<img class="img" id="fileHamImg" alt="파일함 이미지" src="${pageContext.request.contextPath }/resources/dist_main/img/mainIntroImg/fileHam.png">
		</div>
		
		<div class="content-text-right introText" id="fileHam">
			외부 드라이브 서비스를 이용하지 않아도<br>
			서로 파일을 쉽게 주고받을 수 있습니다.
		</div>
		
	</div>
	<br>
	
	<div style="height : 400px; 
			background-image : 
			url('${pageContext.request.contextPath}/resources/dist_main/img/main_background.png');">
			<div class="text-focus-in" style=" font-size: 3em; padding-top : 170px; text-align : center; color : white;">
			지금 바로 Ants를 사용해 보세요 !
			</div>
	</div>
	
	<div style="height: 90px; background-color: #000000;color:#FFFFFF ; text-align: center;" >
		<div style="padding-top: 20px">
			ANTS
		</div>
		© 2020-2021 Ants, Inc. (주)개미 | 대전광역시 중구 중앙로 76 | 대덕인재개발원 | 404호
	</div>
</div>